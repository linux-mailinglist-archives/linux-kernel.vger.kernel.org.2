Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726D044F2F6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 12:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhKML7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 06:59:12 -0500
Received: from mout.gmx.net ([212.227.15.15]:49757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234811AbhKML7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 06:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636804577;
        bh=zUDY16dno0OblhQQJnG+UW42NaMyIa32YNDV15nwW8s=;
        h=X-UI-Sender-Class:Subject:From:To:Date;
        b=fVe/6an0hakhow+KY62MnbS4gUI3J+zWBcJh9zKw/97Bf7xVbj+oizjxtsQnTNINt
         xvvXfcYBANzvZeF16TkT8NvQTdkutNXUnb7AB4AP9lCNShVXWqybxtovfM4xP8ih/k
         RTPDrgmiRcDJYJHzKoxd3FFydcFuDCZNsjA5N1VA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([212.114.172.107]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1n7wrw39DU-00M0Ki; Sat, 13
 Nov 2021 12:56:16 +0100
Message-ID: <66694d6f17e21f8b2766052c76d25344a60d10dc.camel@gmx.de>
Subject: i2c: algo: bit, drm, nouveau -  34ms readbytes() induced RT wakeup
 latency hit
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Date:   Sat, 13 Nov 2021 12:56:16 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FWeAcom7qSLE+Tm9X2WqEN0SRIGBMJ+YzQCd7pyCRnW5GylxmWP
 35EER6KYv3k/mWU9HbQl7oGpfoqtBsLN5NXgu95HnejfnkL4MNPT0bkeDWJpxqpHdGGOoJ/
 bqmC6QopbOrY9sXuNBeoY7dqm8eX9tPGDYkumNwsQOPYZvryUUWWeWKgSJZX/j1/QZP2zRn
 +OTHPFZGB0X5VD2Pm1sOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:un91G3r/p1A=:Wx/wAk79leQDHdokHHQL6f
 MvfXFzXnX1NPbV05WH1URXIELQV7dR9bOvItXSkvUdBiA+lm0bzhrzZmPJuftPKeeN5pVtQT6
 slfiQb1x1sqibwO8NsiZfmI1zVRnKwwJZze4nAReQa4knknklmfJ0ghA1P7js4SUv1DkyMl6k
 YFalD80ObbTU7HreXNHK6V3bv35b0PTzwHjlzN5PN70YcPvRUQwq/jiY/LeMvzyRmVwtVYxR3
 Vj2xFtYyyTQjraa5N7xgB5aDCS5yfAOZ+sXM5ZdwyFe6mI+oziwZIIYCHHGCLNNpCdk47ElMl
 Tr95ZulBNzJYFM8Db8pxvOMWS/RdFdt9KYW6LCJh8gkxw3O8sFiocJkSwIcd5aWJOS8GKPMzx
 M6jNmIFmXtKQERJEQp0K1ZY6j+u0uwofogEUOpLsjpJCXxYUxIPcj/MyZ1pkVt+V6exd1vLeD
 HaEl4b0/BolLJUws3DHPadOIIJJDjvBDpxSyPTJMQnKInlX8Nbn/JjjJYcU/N9dCRYNk/ilIA
 ve8niZK0SkYDhPXWc5BD7ZoihuGcOo5Rkj8qfOx7HQba+X2GQe+LWRNwR8Ii8q5zGnfiuIBZU
 zApx3h+QXVefbJU4w0o8OTbs9UhEBvPr9kYLW2toh3IIpUEv/QFsy4pB1JMBQWvePl+WxKMxe
 1nkG0LC9c6gxdHmKk34GiZ39Gbhx6CPMkJLzwE6wRtlbcKTRMZtkwiQpLm2wUgOJCopaQQWcY
 z67rP+UP5hPohNOxN0DnkBapYAwpGt2gQexmea5vgZ6ttP/fRFliebhWvbRYDBQl77Z9S2ucl
 ZZnn8Pyed0GYrROT8h36xJ0qgpR4XowxlZw1+vvUtypBov2mSrfkhroISLiaTlrUbgTXl1urt
 OyCstHQSdpMLcEZsUyS7ZRJAQb7Rgrsn3BiC3dDN29fF5Mpha4Vf3qek0Pe9NWQq7LWo/RI0n
 sCK0X49Z9Kjy7k3eP+2HGW3X7Q256mC4Swi6QPvUMQRjkkV9fpLcV8KGTn2isPHBmwPSd8GuQ
 oVn25V0LjWzT3s1cDjoT0eWVJsg5vatbllPlduVxPsWrwP+RotuxkAWtEtP0/n/4ALCZLsrCA
 b0J30Ge4P3+sf8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Below please find a heavily trimmed trace of a repeatable >30ms RT
wakeup latency hit and what I did to.. make it stop doing the bad
thing.  All I have to do to reproduce this is to poke any ole icon on
KDE's task manager bar, cyclictest latency spike follows.

=2D--
 drivers/i2c/algos/i2c-algo-bit.c |    1 +
 1 file changed, 1 insertion(+)

=2D-- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -462,6 +462,7 @@ static int readbytes(struct i2c_adapter
 			if (inval < 0)
 				return inval;
 		}
+		cond_resched();
 	}
 	return rdcount;
 }

# tracer: wakeup_rt
#
# wakeup_rt latency trace v1.1.5 on 5.15.0.g66f4bea-master
# --------------------------------------------------------------------
# latency: 34260 us, #19617/19617, CPU#6 | (M:desktop VP:0, KP:0, SP:0 HP:=
0 #P:8)
#    -----------------
#    | task: cyclictest-4301 (uid:0 nice:0 policy:1 rt_prio:99)
#    -----------------
#
#                    _------=3D> CPU#
#                   / _-----=3D> irqs-off
#                  | / _----=3D> need-resched
#                  || / _---=3D> hardirq/softirq
#                  ||| / _--=3D> preempt-depth
#                  |||| / _-=3D> migrate-disable
#                  ||||| /     delay
#  cmd     pid     |||||| time  |   caller
#     \   /        ||||||  \    |    /
       X-2193      6dNh4.    0us+:     2193:120:R   + [006]    4301:  0:R =
cyclictest
       X-2193      6dNh4.   23us : <stack trace>
 =3D> __ftrace_trace_stack+0x12f/0x160
 =3D> probe_wakeup+0x285/0x310
 =3D> ttwu_do_wakeup+0x111/0x180
 =3D> try_to_wake_up+0x3e6/0x4a0
 =3D> hrtimer_wakeup+0x1e/0x30
 =3D> __hrtimer_run_queues+0xfc/0x260
 =3D> hrtimer_interrupt+0xe5/0x240
 =3D> __sysvec_apic_timer_interrupt+0x57/0x110
 =3D> sysvec_apic_timer_interrupt+0x4b/0x90
 =3D> asm_sysvec_apic_timer_interrupt+0x12/0x20
 =3D> ioread32+0x19/0x30
 =3D> gf119_i2c_bus_drive_scl+0x2a/0x50 [nouveau]
 =3D> sclhi+0x18/0x80 [i2c_algo_bit]
 =3D> i2c_outb+0x4b/0x100 [i2c_algo_bit]
 =3D> bit_xfer+0x30e/0x510 [i2c_algo_bit]
 =3D> __i2c_transfer+0x169/0x4d0
 =3D> i2c_transfer+0x4f/0x110
 =3D> drm_do_probe_ddc_edid+0xa7/0x110 [drm]
 =3D> drm_do_get_edid_base_block+0x6a/0x100 [drm]
 =3D> drm_do_get_edid+0x49/0x230 [drm]
 =3D> drm_get_edid+0x32/0x70 [drm]
 =3D> nouveau_connector_detect+0x144/0x450 [nouveau]
 =3D> drm_helper_probe_detect+0x85/0xa0 [drm_kms_helper]
 =3D> drm_helper_probe_single_connector_modes+0x67b/0x7d0 [drm_kms_helper]
 =3D> drm_mode_getconnector+0x3dc/0x470 [drm]
 =3D> drm_ioctl_kernel+0x90/0x120 [drm]
 =3D> drm_ioctl+0x2e6/0x390 [drm]
 =3D> nouveau_drm_ioctl+0x56/0xb0 [nouveau]
 =3D> __x64_sys_ioctl+0x73/0xb0
 =3D> do_syscall_64+0x37/0x80
 =3D> entry_SYSCALL_64_after_hwframe+0x44/0xae
       X-2193      6dNh4.   23us : 0
       X-2193      6dNh3.   23us : task_woken_rt+0x0/0x60 <-ttwu_do_wakeup=
+0x48/0x180
       X-2193      6dNh2.   23us : _raw_spin_unlock_irqrestore+0x0/0x20 <-=
try_to_wake_up+0x411/0x4a0
       X-2193      6dNh..   24us : _raw_spin_lock_irq+0x0/0x26 <-__hrtimer=
_run_queues+0x10e/0x260
       X-2193      6dNh1.   24us : hrtimer_update_next_event+0x0/0x50 <-hr=
timer_interrupt+0xed/0x240
       X-2193      6dNh1.   24us : __hrtimer_get_next_event+0x0/0x70 <-hrt=
imer_update_next_event+0x24/0x50
       X-2193      6dNh1.   24us : __hrtimer_next_event_base+0x0/0xe0 <-__=
hrtimer_get_next_event+0x60/0x70
       X-2193      6dNh1.   24us : __hrtimer_get_next_event+0x0/0x70 <-hrt=
imer_update_next_event+0x38/0x50
       X-2193      6dNh1.   24us : __hrtimer_next_event_base+0x0/0xe0 <-hr=
timer_update_next_event+0x38/0x50
       X-2193      6dNh1.   24us : _raw_spin_unlock_irqrestore+0x0/0x20 <-=
hrtimer_interrupt+0x105/0x240
       X-2193      6dNh..   24us : tick_program_event+0x0/0x70 <-hrtimer_i=
nterrupt+0x113/0x240
       X-2193      6dNh..   25us : clockevents_program_event+0x0/0x100 <-h=
rtimer_interrupt+0x113/0x240
       X-2193      6dNh..   25us : ktime_get+0x0/0xa0 <-clockevents_progra=
m_event+0x8c/0x100
       X-2193      6dNh..   25us : lapic_next_deadline+0x0/0x40 <-clockeve=
nts_program_event+0xc9/0x100
       X-2193      6dNh..   25us : irq_exit_rcu+0x0/0xb0 <-sysvec_apic_tim=
er_interrupt+0x50/0x90
       X-2193      6dN...   25us : idle_cpu+0x0/0x40 <-irq_exit_rcu+0x3b/0=
xb0
       X-2193      6.N...   25us : nvkm_i2c_bus_getscl+0x0/0x20 [nouveau] =
<-sclhi+0x4e/0x80 [i2c_algo_bit]
       X-2193      6.N...   26us : gf119_i2c_bus_sense_scl+0x0/0x30 [nouve=
au] <-sclhi+0x4e/0x80 [i2c_algo_bit]
       X-2193      6.N...   28us : __udelay+0x0/0x10 <-sclhi+0x5e/0x80 [i2=
c_algo_bit]
       X-2193      6.N...   28us : __const_udelay+0x0/0x50 <-sclhi+0x5e/0x=
80 [i2c_algo_bit]
       X-2193      6.N...   28us : delay_tsc+0x0/0x80 <-sclhi+0x5e/0x80 [i=
2c_algo_bit]
       X-2193      6.N...   39us : nvkm_i2c_bus_setscl+0x0/0x20 [nouveau] =
<-i2c_outb+0x5e/0x100 [i2c_algo_bit]
       X-2193      6.N...   39us : gf119_i2c_bus_drive_scl+0x0/0x50 [nouve=
au] <-i2c_outb+0x5e/0x100 [i2c_algo_bit]
       X-2193      6.N...   41us : __udelay+0x0/0x10 <-i2c_outb+0x78/0x100=
 [i2c_algo_bit]
       X-2193      6.N...   41us : __const_udelay+0x0/0x50 <-i2c_outb+0x78=
/0x100 [i2c_algo_bit]
       X-2193      6.N...   41us : delay_tsc+0x0/0x80 <-i2c_outb+0x78/0x10=
0 [i2c_algo_bit]
       X-2193      6.N...   46us : nvkm_i2c_bus_setsda+0x0/0x20 [nouveau] =
<-i2c_outb+0x29/0x100 [i2c_algo_bit]
       X-2193      6.N...   46us : gf119_i2c_bus_drive_sda+0x0/0x50 [nouve=
au] <-i2c_outb+0x29/0x100 [i2c_algo_bit]
       X-2193      6.N...   48us : __udelay+0x0/0x10 <-i2c_outb+0x43/0x100=
 [i2c_algo_bit]
       X-2193      6.N...   48us : __const_udelay+0x0/0x50 <-i2c_outb+0x43=
/0x100 [i2c_algo_bit]
       X-2193      6.N...   49us : delay_tsc+0x0/0x80 <-i2c_outb+0x43/0x10=
0 [i2c_algo_bit]
       X-2193      6.N...   54us : sclhi+0x0/0x80 [i2c_algo_bit] <-i2c_out=
b+0x4b/0x100 [i2c_algo_bit]
       X-2193      6.N...   54us : nvkm_i2c_bus_setscl+0x0/0x20 [nouveau] =
<-sclhi+0x18/0x80 [i2c_algo_bit]
       X-2193      6.N...   54us : gf119_i2c_bus_drive_scl+0x0/0x50 [nouve=
au] <-sclhi+0x18/0x80 [i2c_algo_bit]
       X-2193      6.N...   56us : nvkm_i2c_bus_getscl+0x0/0x20 [nouveau] =
<-sclhi+0x4e/0x80 [i2c_algo_bit]
       X-2193      6.N...   56us : gf119_i2c_bus_sense_scl+0x0/0x30 [nouve=
au] <-sclhi+0x4e/0x80 [i2c_algo_bit]
       X-2193      6.N...   58us : __udelay+0x0/0x10 <-sclhi+0x5e/0x80 [i2=
c_algo_bit]
       X-2193      6.N...   58us : __const_udelay+0x0/0x50 <-sclhi+0x5e/0x=
80 [i2c_algo_bit]
       X-2193      6.N...   58us : delay_tsc+0x0/0x80 <-sclhi+0x5e/0x80 [i=
2c_algo_bit]

ka-snip...

       X-2193      6.N... 34205us : sclhi+0x0/0x80 [i2c_algo_bit] <-i2c_st=
op+0x36/0x60 [i2c_algo_bit]
       X-2193      6.N... 34205us : nvkm_i2c_bus_setscl+0x0/0x20 [nouveau]=
 <-sclhi+0x18/0x80 [i2c_algo_bit]
       X-2193      6.N... 34205us : gf119_i2c_bus_drive_scl+0x0/0x50 [nouv=
eau] <-sclhi+0x18/0x80 [i2c_algo_bit]
       X-2193      6.N... 34207us : nvkm_i2c_bus_getscl+0x0/0x20 [nouveau]=
 <-sclhi+0x4e/0x80 [i2c_algo_bit]
       X-2193      6.N... 34207us : gf119_i2c_bus_sense_scl+0x0/0x30 [nouv=
eau] <-sclhi+0x4e/0x80 [i2c_algo_bit]
       X-2193      6.N... 34209us : __udelay+0x0/0x10 <-sclhi+0x5e/0x80 [i=
2c_algo_bit]
       X-2193      6.N... 34209us : __const_udelay+0x0/0x50 <-sclhi+0x5e/0=
x80 [i2c_algo_bit]
       X-2193      6.N... 34210us : delay_tsc+0x0/0x80 <-sclhi+0x5e/0x80 [=
i2c_algo_bit]
       X-2193      6.N... 34220us : nvkm_i2c_bus_setsda+0x0/0x20 [nouveau]=
 <-i2c_stop+0x44/0x60 [i2c_algo_bit]
       X-2193      6.N... 34220us : gf119_i2c_bus_drive_sda+0x0/0x50 [nouv=
eau] <-i2c_stop+0x44/0x60 [i2c_algo_bit]
       X-2193      6.N... 34222us : __udelay+0x0/0x10 <-bit_xfer+0x21d/0x5=
10 [i2c_algo_bit]
       X-2193      6.N... 34222us : __const_udelay+0x0/0x50 <-bit_xfer+0x2=
1d/0x510 [i2c_algo_bit]
       X-2193      6.N... 34222us : delay_tsc+0x0/0x80 <-bit_xfer+0x21d/0x=
510 [i2c_algo_bit]
       X-2193      6.N... 34232us : nvkm_i2c_bus_post_xfer+0x0/0x10 [nouve=
au] <-bit_xfer+0x22c/0x510 [i2c_algo_bit]
       X-2193      6.N... 34232us : nvkm_i2c_bus_release+0x0/0x50 [nouveau=
] <-bit_xfer+0x22c/0x510 [i2c_algo_bit]
       X-2193      6.N... 34232us : nvkm_i2c_pad_release+0x0/0x50 [nouveau=
] <-nvkm_i2c_bus_release+0x20/0x50 [nouveau]
       X-2193      6.N... 34233us : nvkm_i2c_pad_mode_locked+0x0/0x70 [nou=
veau] <-nvkm_i2c_pad_release+0x24/0x50 [nouveau]
       X-2193      6.N... 34233us : mutex_unlock+0x0/0x20 <-nvkm_i2c_bus_r=
elease+0x20/0x50 [nouveau]
       X-2193      6.N... 34233us : mutex_unlock+0x0/0x20 <-bit_xfer+0x22c=
/0x510 [i2c_algo_bit]
       X-2193      6.N... 34233us : i2c_adapter_unlock_bus+0x0/0x10 <-i2c_=
transfer+0x65/0x110
       X-2193      6.N... 34233us : rt_mutex_unlock+0x0/0xf0 <-i2c_transfe=
r+0x65/0x110
       X-2193      6.N... 34233us : drm_edid_block_valid+0x0/0x1f0 [drm] <=
-drm_do_get_edid_base_block+0x7f/0x100 [drm]
       X-2193      6.N... 34234us : drm_connector_update_edid_property+0x0=
/0x110 [drm] <-drm_get_edid+0x40/0x70 [drm]
       X-2193      6.N... 34234us : drm_add_display_info+0x0/0xb60 [drm] <=
-drm_connector_update_edid_property+0x3e/0x110 [drm]
       X-2193      6.N... 34234us : drm_reset_display_info+0x0/0x90 [drm] =
<-drm_add_display_info+0x7e/0xb60 [drm]
       X-2193      6.N... 34235us : drm_for_each_detailed_block.part.8+0x0=
/0x120 [drm] <-drm_add_display_info+0xc4/0xb60 [drm]
       X-2193      6.N... 34235us : get_monitor_range+0x0/0x40 [drm] <-drm=
_for_each_detailed_block.part.8+0x30/0x120 [drm]
       X-2193      6.N... 34235us : get_monitor_range+0x0/0x40 [drm] <-drm=
_for_each_detailed_block.part.8+0x30/0x120 [drm]
       X-2193      6.N... 34235us : get_monitor_range+0x0/0x40 [drm] <-drm=
_for_each_detailed_block.part.8+0x30/0x120 [drm]
       X-2193      6.N... 34235us : get_monitor_range+0x0/0x40 [drm] <-drm=
_for_each_detailed_block.part.8+0x30/0x120 [drm]
       X-2193      6.N... 34235us : __drm_dbg+0x0/0x70 [drm] <-drm_add_dis=
play_info+0xe3/0xb60 [drm]
       X-2193      6.N... 34235us : __drm_dbg+0x0/0x70 [drm] <-drm_add_dis=
play_info+0x100/0xb60 [drm]
       X-2193      6.N... 34236us : drm_find_cea_extension+0x0/0x80 [drm] =
<-drm_add_display_info+0x130/0xb60 [drm]
       X-2193      6.N... 34236us : displayid_iter_edid_begin+0x0/0x30 [dr=
m] <-drm_find_cea_extension+0x44/0x80 [drm]
       X-2193      6.N... 34236us : __displayid_iter_next+0x0/0x190 [drm] =
<-drm_find_cea_extension+0x55/0x80 [drm]
       X-2193      6.N... 34236us : drm_find_edid_extension+0x0/0x50 [drm]=
 <-__displayid_iter_next+0xa0/0x190 [drm]
       X-2193      6.N... 34236us : displayid_iter_end+0x0/0x30 [drm] <-dr=
m_find_cea_extension+0x68/0x80 [drm]
       X-2193      6.N... 34237us : drm_update_tile_info+0x0/0x240 [drm] <=
-drm_connector_update_edid_property+0x49/0x110 [drm]
       X-2193      6.N... 34237us : displayid_iter_edid_begin+0x0/0x30 [dr=
m] <-drm_update_tile_info+0x31/0x240 [drm]
       X-2193      6.N... 34237us : __displayid_iter_next+0x0/0x190 [drm] =
<-drm_update_tile_info+0x42/0x240 [drm]
       X-2193      6.N... 34237us : drm_find_edid_extension+0x0/0x50 [drm]=
 <-__displayid_iter_next+0xa0/0x190 [drm]
       X-2193      6.N... 34237us : displayid_iter_end+0x0/0x30 [drm] <-dr=
m_update_tile_info+0x51/0x240 [drm]
       X-2193      6.N... 34237us : drm_edid_are_equal+0x0/0x50 [drm] <-dr=
m_connector_update_edid_property+0x66/0x110 [drm]
       X-2193      6.N... 34238us : drm_object_property_set_value+0x0/0x90=
 [drm] <-drm_connector_update_edid_property+0x84/0x110 [drm]
       X-2193      6.N... 34238us : drm_property_replace_global_blob+0x0/0=
xe0 [drm] <-drm_connector_update_edid_property+0xa3/0x110 [drm]
       X-2193      6.N... 34238us : drm_property_create_blob.part.3+0x0/0x=
e0 [drm] <-drm_property_replace_global_blob+0x88/0xe0 [drm]
       X-2193      6.N... 34238us : kvmalloc_node+0x0/0x80 <-drm_property_=
create_blob.part.3+0x2e/0xe0 [drm]
       X-2193      6.N... 34238us : __kmalloc+0x0/0x200 <-drm_property_cre=
ate_blob.part.3+0x2e/0xe0 [drm]
       X-2193      6.N... 34239us : kmalloc_slab+0x0/0x70 <-__kmalloc+0x27=
/0x200
       X-2193      6.N... 34239us : __might_sleep+0x0/0x60 <-__kmalloc+0x5=
8/0x200
       X-2193      6.N... 34239us : __might_resched+0x0/0x130 <-__kmalloc+=
0x58/0x200
       X-2193      6.N... 34239us : __cond_resched+0x0/0x30 <-__kmalloc+0x=
5d/0x200
       X-2193      6dN.1. 34239us : rcu_note_context_switch+0x0/0x100 <-__=
schedule+0x79/0x8f0
       X-2193      6dN.1. 34239us : rcu_qs+0x0/0x60 <-rcu_note_context_swi=
tch+0xc/0x100
       X-2193      6dN.2. 34239us : _raw_spin_lock+0x0/0x30 <-__schedule+0=
x88/0x8f0
       X-2193      6dN.2. 34240us : update_rq_clock+0x0/0x50 <-__schedule+=
0xd7/0x8f0
       X-2193      6dN.2. 34240us : balance_fair+0x0/0x30 <-__schedule+0x6=
04/0x8f0
       X-2193      6dN.2. 34240us : put_prev_task_fair+0x0/0x2c0 <-__sched=
ule+0x62c/0x8f0
       X-2193      6dN.2. 34240us : update_curr+0x0/0x180 <-put_prev_task_=
fair+0x88/0x2c0
       X-2193      6dN.2. 34240us : update_min_vruntime+0x0/0x60 <-update_=
curr+0x6b/0x180
       X-2193      6dN.2. 34240us : __enqueue_entity+0x0/0x70 <-put_prev_t=
ask_fair+0xcb/0x2c0
       X-2193      6dN.2. 34240us : __update_load_avg_se+0x0/0x310 <-put_p=
rev_task_fair+0xfe/0x2c0
       X-2193      6dN.2. 34241us : __accumulate_pelt_segments+0x0/0xa0 <-=
__update_load_avg_se+0x286/0x310
       X-2193      6dN.2. 34241us : __update_load_avg_cfs_rq+0x0/0x2d0 <-p=
ut_prev_task_fair+0x205/0x2c0
       X-2193      6dN.2. 34241us : __accumulate_pelt_segments+0x0/0xa0 <-=
__update_load_avg_cfs_rq+0x251/0x2d0
       X-2193      6dN.2. 34241us : sugov_update_single_freq+0x0/0x190 <-p=
ut_prev_task_fair+0x246/0x2c0
       X-2193      6dN.2. 34241us : sugov_iowait_boost+0x0/0x60 <-sugov_up=
date_single_freq+0x20/0x190
       X-2193      6dN.2. 34241us : cpufreq_this_cpu_can_update+0x0/0x40 <=
-sugov_update_single_freq+0x63/0x190
       X-2193      6dN.2. 34241us : sugov_get_util+0x0/0x70 <-sugov_update=
_single_freq+0x92/0x190
       X-2193      6dN.2. 34242us : effective_cpu_util+0x0/0x80 <-sugov_ge=
t_util+0x5e/0x70
       X-2193      6dN.2. 34242us : sugov_iowait_apply+0x0/0x60 <-sugov_up=
date_single_freq+0x9d/0x190
       X-2193      6dN.2. 34242us : get_next_freq+0x0/0x50 <-sugov_update_=
single_freq+0xad/0x190
       X-2193      6dN.2. 34242us : tick_nohz_get_idle_calls_cpu+0x0/0x20 =
<-sugov_update_single_freq+0xb8/0x190
       X-2193      6dN.2. 34242us : pick_next_task_stop+0x0/0x70 <-__sched=
ule+0x674/0x8f0
       X-2193      6d..2. 34242us : enter_lazy_tlb+0x0/0x20 <-__schedule+0=
x6c6/0x8f0
       X-2193      6d..2. 34243us : save_fpregs_to_fpstate+0x0/0x50 <-__sw=
itch_to+0x2c4/0x400
migratio-42        6d..2. 34243us : __switch_to_xtra+0x0/0x5d0 <-__switch_=
to+0x1dc/0x400
migratio-42        6d..2. 34243us : finish_task_switch+0x0/0x2d0 <-__sched=
ule+0x2aa/0x8f0
migratio-42        6...1. 34244us : kthread_should_stop+0x0/0x30 <-smpboot=
_thread_fn+0x50/0x1d0
migratio-42        6...1. 34244us : kthread_should_park+0x0/0x30 <-smpboot=
_thread_fn+0x5d/0x1d0
migratio-42        6...1. 34244us : cpu_stop_should_run+0x0/0x50 <-smpboot=
_thread_fn+0x103/0x1d0
migratio-42        6...1. 34244us : _raw_spin_lock_irqsave+0x0/0x30 <-cpu_=
stop_should_run+0x2a/0x50
migratio-42        6d..2. 34245us : _raw_spin_unlock_irqrestore+0x0/0x20 <=
-cpu_stop_should_run+0x38/0x50
migratio-42        6..... 34245us : cpu_stopper_thread+0x0/0x120 <-smpboot=
_thread_fn+0x130/0x1d0
migratio-42        6..... 34245us : _raw_spin_lock_irq+0x0/0x26 <-cpu_stop=
per_thread+0x30/0x120
migratio-42        6...1. 34245us : active_load_balance_cpu_stop+0x0/0x2f0=
 <-cpu_stopper_thread+0x96/0x120
migratio-42        6d..1. 34245us : raw_spin_rq_lock_nested+0x0/0x20 <-act=
ive_load_balance_cpu_stop+0x45/0x2f0
migratio-42        6d..2. 34245us : _raw_spin_lock+0x0/0x30 <-raw_spin_rq_=
lock_nested+0x11/0x20
migratio-42        6d..3. 34245us : update_rq_clock+0x0/0x50 <-active_load=
_balance_cpu_stop+0x13f/0x2f0
migratio-42        6d..3. 34245us : update_rq_clock.part.126+0x0/0xb0 <-ac=
tive_load_balance_cpu_stop+0x13f/0x2f0
migratio-42        6d..3. 34246us : kthread_is_per_cpu+0x0/0x30 <-active_l=
oad_balance_cpu_stop+0x165/0x2f0
migratio-42        6d..3. 34246us : can_migrate_task.part.105+0x0/0x1e0 <-=
active_load_balance_cpu_stop+0x176/0x2f0
migratio-42        6d..3. 34246us : deactivate_task+0x0/0xc0 <-active_load=
_balance_cpu_stop+0x18c/0x2f0
migratio-42        6d..3. 34246us : dequeue_task_fair+0x0/0x650 <-active_l=
oad_balance_cpu_stop+0x18c/0x2f0
migratio-42        6d..3. 34246us : update_curr+0x0/0x180 <-dequeue_task_f=
air+0x1bd/0x650
migratio-42        6d..3. 34246us : __update_load_avg_se+0x0/0x310 <-deque=
ue_task_fair+0x1f8/0x650
migratio-42        6d..3. 34246us : __update_load_avg_cfs_rq+0x0/0x2d0 <-d=
equeue_task_fair+0x21d/0x650
migratio-42        6d..3. 34247us : clear_buddies+0x0/0xb0 <-dequeue_task_=
fair+0x274/0x650
migratio-42        6d..3. 34247us : update_min_vruntime+0x0/0x60 <-dequeue=
_task_fair+0x33c/0x650
migratio-42        6d..3. 34247us : hrtick_update+0x0/0x70 <-active_load_b=
alance_cpu_stop+0x18c/0x2f0
migratio-42        6d..3. 34247us : set_task_cpu+0x0/0x140 <-active_load_b=
alance_cpu_stop+0x198/0x2f0
migratio-42        6d..3. 34247us : migrate_task_rq_fair+0x0/0x70 <-set_ta=
sk_cpu+0x63/0x140
migratio-42        6d..3. 34248us : detach_entity_cfs_rq+0x0/0x350 <-migra=
te_task_rq_fair+0x66/0x70
migratio-42        6d..3. 34248us : __update_load_avg_se+0x0/0x310 <-detac=
h_entity_cfs_rq+0x62/0x350
migratio-42        6d..3. 34248us : __update_load_avg_cfs_rq+0x0/0x2d0 <-d=
etach_entity_cfs_rq+0x177/0x350
migratio-42        6d..3. 34248us : sugov_update_single_freq+0x0/0x190 <-d=
etach_entity_cfs_rq+0x288/0x350
migratio-42        6d..3. 34248us : sugov_iowait_boost+0x0/0x60 <-sugov_up=
date_single_freq+0x20/0x190
migratio-42        6d..3. 34248us : cpufreq_this_cpu_can_update+0x0/0x40 <=
-sugov_update_single_freq+0x63/0x190
migratio-42        6d..3. 34248us : sugov_get_util+0x0/0x70 <-sugov_update=
_single_freq+0x92/0x190
migratio-42        6d..3. 34248us : effective_cpu_util+0x0/0x80 <-sugov_ge=
t_util+0x5e/0x70
migratio-42        6d..3. 34249us : sugov_iowait_apply+0x0/0x60 <-sugov_up=
date_single_freq+0x9d/0x190
migratio-42        6d..3. 34249us : get_next_freq+0x0/0x50 <-sugov_update_=
single_freq+0xad/0x190
migratio-42        6d..3. 34249us : tick_nohz_get_idle_calls_cpu+0x0/0x20 =
<-sugov_update_single_freq+0xb8/0x190
migratio-42        6d..2. 34249us : raw_spin_rq_unlock+0x0/0x20 <-active_l=
oad_balance_cpu_stop+0x22a/0x2f0
migratio-42        6d..1. 34249us : raw_spin_rq_lock_nested+0x0/0x20 <-act=
ive_load_balance_cpu_stop+0x239/0x2f0
migratio-42        6d..2. 34249us : _raw_spin_lock+0x0/0x30 <-raw_spin_rq_=
lock_nested+0x11/0x20
migratio-42        6d..2. 34249us : update_rq_clock+0x0/0x50 <-active_load=
_balance_cpu_stop+0x265/0x2f0
migratio-42        6d..2. 34249us : update_rq_clock.part.126+0x0/0xb0 <-ac=
tive_load_balance_cpu_stop+0x265/0x2f0
migratio-42        6d..2. 34250us : attach_task+0x0/0x40 <-active_load_bal=
ance_cpu_stop+0x270/0x2f0
migratio-42        6d..2. 34250us : activate_task+0x0/0x90 <-attach_task+0=
x2e/0x40
migratio-42        6d..2. 34250us : enqueue_task_fair+0x0/0x9e0 <-activate=
_task+0x37/0x90
migratio-42        6d..2. 34250us : update_curr+0x0/0x180 <-enqueue_task_f=
air+0x7b3/0x9e0
migratio-42        6d..2. 34250us : __update_load_avg_cfs_rq+0x0/0x2d0 <-e=
nqueue_task_fair+0x3ea/0x9e0
migratio-42        6d..2. 34250us : attach_entity_load_avg+0x0/0x190 <-enq=
ueue_task_fair+0x40f/0x9e0
migratio-42        6d..2. 34250us : sugov_update_single_freq+0x0/0x190 <-a=
ttach_entity_load_avg+0x127/0x190
migratio-42        6d..2. 34251us : sugov_iowait_boost+0x0/0x60 <-sugov_up=
date_single_freq+0x20/0x190
migratio-42        6d..2. 34251us : cpufreq_this_cpu_can_update+0x0/0x40 <=
-sugov_update_single_freq+0x63/0x190
migratio-42        6d..2. 34251us : __enqueue_entity+0x0/0x70 <-enqueue_ta=
sk_fair+0x70d/0x9e0
migratio-42        6d..2. 34251us : hrtick_update+0x0/0x70 <-activate_task=
+0x37/0x90
migratio-42        6d..2. 34251us : check_preempt_curr+0x0/0x60 <-active_l=
oad_balance_cpu_stop+0x270/0x2f0
migratio-42        6d..2. 34251us : resched_curr+0x0/0xb0 <-check_preempt_=
curr+0x4f/0x60
migratio-42        6d..2. 34251us : raw_spin_rq_unlock+0x0/0x20 <-active_l=
oad_balance_cpu_stop+0x278/0x2f0
migratio-42        6..... 34252us : _raw_spin_lock_irq+0x0/0x26 <-cpu_stop=
per_thread+0x30/0x120
migratio-42        6...1. 34252us : kthread_should_stop+0x0/0x30 <-smpboot=
_thread_fn+0x50/0x1d0
migratio-42        6...1. 34252us : kthread_should_park+0x0/0x30 <-smpboot=
_thread_fn+0x5d/0x1d0
migratio-42        6...1. 34252us : cpu_stop_should_run+0x0/0x50 <-smpboot=
_thread_fn+0x103/0x1d0
migratio-42        6...1. 34252us : _raw_spin_lock_irqsave+0x0/0x30 <-cpu_=
stop_should_run+0x2a/0x50
migratio-42        6d..2. 34252us : _raw_spin_unlock_irqrestore+0x0/0x20 <=
-cpu_stop_should_run+0x38/0x50
migratio-42        6..... 34253us : schedule+0x0/0xc0 <-smpboot_thread_fn+=
0x1c1/0x1d0
migratio-42        6d..1. 34253us : rcu_note_context_switch+0x0/0x100 <-__=
schedule+0x79/0x8f0
migratio-42        6d..1. 34253us : rcu_qs+0x0/0x60 <-rcu_note_context_swi=
tch+0xc/0x100
migratio-42        6d..2. 34253us : _raw_spin_lock+0x0/0x30 <-__schedule+0=
x88/0x8f0
migratio-42        6d..2. 34253us : update_rq_clock+0x0/0x50 <-__schedule+=
0xd7/0x8f0
migratio-42        6d..2. 34253us : update_rq_clock.part.126+0x0/0xb0 <-__=
schedule+0xd7/0x8f0
migratio-42        6d..2. 34253us : dequeue_task_stop+0x0/0x60 <-__schedul=
e+0x4a6/0x8f0
migratio-42        6d..2. 34254us : balance_stop+0x0/0x20 <-__schedule+0x6=
04/0x8f0
migratio-42        6d..2. 34254us : balance_dl+0x0/0x90 <-__schedule+0x604=
/0x8f0
migratio-42        6d..2. 34254us : balance_rt+0x0/0xa0 <-__schedule+0x604=
/0x8f0
migratio-42        6d..2. 34254us : put_prev_task_stop+0x0/0x130 <-__sched=
ule+0x62c/0x8f0
migratio-42        6d..2. 34255us : pick_next_task_stop+0x0/0x70 <-__sched=
ule+0x674/0x8f0
migratio-42        6d..2. 34255us : pick_next_task_dl+0x0/0x50 <-__schedul=
e+0x674/0x8f0
migratio-42        6d..2. 34255us : pick_next_task_rt+0x0/0x1a0 <-__schedu=
le+0x674/0x8f0
migratio-42        6d..2. 34255us : _pick_next_task_rt+0x0/0x50 <-pick_nex=
t_task_rt+0x1f/0x1a0
migratio-42        6d..2. 34255us : update_rt_rq_load_avg+0x0/0x2b0 <-pick=
_next_task_rt+0xc6/0x1a0
migratio-42        6d..3. 34255us : __schedule+0x365/0x8f0
migratio-42        6d..3. 34255us :       42:  0:S =3D=3D> [006]    4301: =
 0:R cyclictest
migratio-42        6d..3. 34260us : <stack trace>
 =3D> __ftrace_trace_stack+0x12f/0x160
 =3D> probe_wakeup_sched_switch+0x1fe/0x2a0
 =3D> __schedule+0x365/0x8f0
 =3D> schedule+0x41/0xc0
 =3D> smpboot_thread_fn+0x1c1/0x1d0
 =3D> kthread+0x16d/0x190
 =3D> ret_from_fork+0x1f/0x30

