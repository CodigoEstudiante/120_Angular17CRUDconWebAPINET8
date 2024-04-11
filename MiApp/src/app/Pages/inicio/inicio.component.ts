import { Component, inject } from '@angular/core';

import {MatCardModule} from '@angular/material/card';
import {MatTableModule} from '@angular/material/table';
import {MatIconModule} from '@angular/material/icon';
import {MatButtonModule} from '@angular/material/button';
import { EmpleadoService } from '../../Services/empleado.service';
import { Empleado } from '../../Models/Empleado';
import { Router } from '@angular/router';

@Component({
  selector: 'app-inicio',
  standalone: true,
  imports: [MatCardModule,MatTableModule,MatIconModule,MatButtonModule],
  templateUrl: './inicio.component.html',
  styleUrl: './inicio.component.css'
})
export class InicioComponent {

  private empleadoServicio = inject(EmpleadoService);
  public listaEmpleados:Empleado[] = [];
  public displayedColumns : string[] = ['nombreCompleto','correo','sueldo','fechaContrato','accion'];

  obtenerEmpleados(){
    this.empleadoServicio.lista().subscribe({
      next:(data)=>{
        if(data.length > 0){
          this.listaEmpleados = data;
        }
      },
      error:(err)=>{
        console.log(err.message)
      }
    })
  }

  constructor(private router:Router){

    this.obtenerEmpleados();
  }

  nuevo(){
    this.router.navigate(['/empleado',0]);
  }

  editar(objeto:Empleado){
    this.router.navigate(['/empleado',objeto.idEmpleado]);
  }
  eliminar(objeto:Empleado){
    if(confirm("Desea eliminar el empleado" + objeto.nombreCompleto)){
      this.empleadoServicio.eliminar(objeto.idEmpleado).subscribe({
        next:(data)=>{
          if(data.isSuccess){
            this.obtenerEmpleados();
          }else{
            alert("no se pudo eliminar")
          }
        },
        error:(err)=>{
          console.log(err.message)
        }
      })
    }
  }

}
