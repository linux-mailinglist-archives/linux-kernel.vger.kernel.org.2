Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2D140C475
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbhIOLlA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Sep 2021 07:41:00 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:39894 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhIOLk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:40:59 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E451772C8B1;
        Wed, 15 Sep 2021 14:39:37 +0300 (MSK)
Received: from example.org (ip-94-112-79-42.net.upcbroadband.cz [94.112.79.42])
        by imap.altlinux.org (Postfix) with ESMTPSA id 256314A46EF;
        Wed, 15 Sep 2021 14:39:37 +0300 (MSK)
Date:   Wed, 15 Sep 2021 13:39:36 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     "Si, Beibei" <beibei.si@intel.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: d646969055: WARNING:at_kernel/ucount.c:#dec_rlimit_ucounts
Message-ID: <20210915113936.kiagbhqriordfadz@example.org>
References: <20210913140246.GA13622@xsang-OptiPlex-9020>
 <20210913193938.xsoowmrqgbg6cb7k@example.org>
 <69b3f6aee4ac4d259ac250dc1bd5fa1c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <69b3f6aee4ac4d259ac250dc1bd5fa1c@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 01:54:09AM +0000, Si, Beibei wrote:
> Hi, legion
> 
> > -----Original Message-----
> > From: Alexey Gladkov <legion@kernel.org>
> > Sent: Tuesday, September 14, 2021 3:40 AM
> > To: Sang, Oliver <oliver.sang@intel.com>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>; LKML <linux-
> > kernel@vger.kernel.org>; lkp@lists.01.org; lkp <lkp@intel.com>
> > Subject: Re: d646969055: WARNING:at_kernel/ucount.c:#dec_rlimit_ucounts
> > 
> > On Mon, Sep 13, 2021 at 10:16:54PM +0800, kernel test robot wrote:
> > >
> > >
> > > Greeting,
> > >
> > > FYI, we noticed the following commit (built with gcc-9):
> > >
> > > commit: d64696905554e919321e31afc210606653b8f6a4 ("Reimplement
> > > RLIMIT_SIGPENDING on top of ucounts")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > >
> > > in testcase: trinity
> > > version: trinity-i386
> > > with following parameters:
> > >
> > > 	number: 99999
> > > 	group: group-02
> > >
> > > test-description: Trinity is a linux system call fuzz tester.
> > > test-url: http://codemonkey.org.uk/projects/trinity/
> > >
> > >
> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp
> > > 2 -m 16G
> > >
> > > caused below changes (please refer to attached dmesg/kmsg for entire
> > log/backtrace):
> > >
> > >
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > >
> > >
> > > [ 558.756672][ T2642] WARNING: CPU: 0 PID: 2642 at kernel/ucount.c:268
> > > dec_rlimit_ucounts (kernel/ucount.c:268 (discriminator 1)) [
> > > 558.758020][ T2642] Modules linked in: uvesafb cfbfillrect cfbimgblt
> > > cfbcopyarea fb fbdev ppdev crc32_pclmul input_leds led_class intel_agp
> > > intel_gtt parport_pc parport qemu_fw_cfg [  558.766247][ T2642] CPU: 0
> > > PID: 2642 Comm: trinity-main Not tainted 5.12.0-gd64696905554 #1 [
> > > 558.767543][ T2642] Hardware name: QEMU Standard PC (i440FX + PIIX,
> > > 1996), BIOS 1.12.0-1 04/01/2014 [ 558.772150][ T2642] EIP:
> > dec_rlimit_ucounts (kernel/ucount.c:268 (discriminator 1)) [ 558.772945][ T2642]
> > Code: 68 73 6c c3 01 83 15 6c 73 6c c3 00 85 c0 0f 94 c0 83 c4 04 5b 5e 5f 5d c3
> > 8d 76 00 83 05 50 73 6c c3 01 83 15 54 73 6c c3 00 <0f> 0b 83 05 58 73 6c c3 01
> > 83 15 5c 73 6c c3 00 eb 9d 8d b4 26 00 All code ========
> > >    0:	68 73 6c c3 01       	pushq  $0x1c36c73
> > >    5:	83 15 6c 73 6c c3 00 	adcl   $0x0,-0x3c938c94(%rip)        #
> > 0xffffffffc36c7378
> > >    c:	85 c0                	test   %eax,%eax
> > >    e:	0f 94 c0             	sete   %al
> > >   11:	83 c4 04             	add    $0x4,%esp
> > >   14:	5b                   	pop    %rbx
> > >   15:	5e                   	pop    %rsi
> > >   16:	5f                   	pop    %rdi
> > >   17:	5d                   	pop    %rbp
> > >   18:	c3                   	retq
> > >   19:	8d 76 00             	lea    0x0(%rsi),%esi
> > >   1c:	83 05 50 73 6c c3 01 	addl   $0x1,-0x3c938cb0(%rip)        #
> > 0xffffffffc36c7373
> > >   23:	83 15 54 73 6c c3 00 	adcl   $0x0,-0x3c938cac(%rip)        #
> > 0xffffffffc36c737e
> > >   2a:*	0f 0b                	ud2    		<-- trapping instruction
> > >   2c:	83 05 58 73 6c c3 01 	addl   $0x1,-0x3c938ca8(%rip)        #
> > 0xffffffffc36c738b
> > >   33:	83 15 5c 73 6c c3 00 	adcl   $0x0,-0x3c938ca4(%rip)        #
> > 0xffffffffc36c7396
> > >   3a:	eb 9d                	jmp    0xffffffffffffffd9
> > >   3c:	8d                   	.byte 0x8d
> > >   3d:	b4 26                	mov    $0x26,%ah
> > > 	...
> > >
> > > Code starting with the faulting instruction
> > > ===========================================
> > >    0:	0f 0b                	ud2
> > >    2:	83 05 58 73 6c c3 01 	addl   $0x1,-0x3c938ca8(%rip)        #
> > 0xffffffffc36c7361
> > >    9:	83 15 5c 73 6c c3 00 	adcl   $0x0,-0x3c938ca4(%rip)        #
> > 0xffffffffc36c736c
> > >   10:	eb 9d                	jmp    0xffffffffffffffaf
> > >   12:	8d                   	.byte 0x8d
> > >   13:	b4 26                	mov    $0x26,%ah
> > > 	...
> > > [  558.779398][ T2642] EAX: f63271e0 EBX: f63271e0 ECX: 00000001 EDX:
> > > ffffffff [  558.781206][ T2642] ESI: 0000003c EDI: ffffffff EBP:
> > > f62e3eac ESP: f62e3e9c [  558.782613][ T2642] DS: 007b ES: 007b FS:
> > > 0000 GS: 0033 SS: 0068 EFLAGS: 00010246 [  558.783747][ T2642] CR0:
> > > 80050033 CR2: 08082ff0 CR3: 362b0000 CR4: 00040690 [  558.792353][ T2642]
> > Call Trace:
> > > [ 558.793036][ T2642] ? release_task (include/linux/rcupdate.h:654
> > > kernel/exit.c:191) [ 558.793936][ T2642] release_task
> > > (kernel/exit.c:191) [ 558.794818][ T2642] wait_task_zombie
> > > (kernel/exit.c:1107) [ 558.800667][ T2642] wait_consider_task
> > > (kernel/exit.c:1334) [ 558.801693][ T2642] ? _raw_read_lock
> > > (include/linux/rwlock_api_smp.h:149 kernel/locking/spinlock.c:223) [
> > > 558.802645][ T2642] do_wait (kernel/exit.c:1399 kernel/exit.c:1468) [
> > > 558.803462][ T2642] kernel_wait4 (kernel/exit.c:1630) [ 558.806901][
> > > T2642] ? kill_orphaned_pgrp (kernel/exit.c:1422) [ 558.808347][ T2642]
> > > __ia32_sys_waitpid (kernel/exit.c:1675 kernel/exit.c:1673
> > > kernel/exit.c:1673) [ 558.809338][ T2642] do_int80_syscall_32
> > > (arch/x86/entry/common.c:77 arch/x86/entry/common.c:94) [ 558.810319][
> > > T2642] entry_INT80_32 (arch/x86/entry/entry_32.S:1064) [  558.811254][
> > > T2642] EIP: 0x809b132 [ 558.815723][ T2642] Code: 89 c8 c3 90 8d 74 26
> > > 00 85 c0 c7 01 01 00 00 00 75 d8 a1 6c 94 a8 08 eb d1 66 90 66 90 66 90 66 90
> > 66 90 66 90 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 10 a3
> > 94 94 a8 08 85 All code ========
> > >    0:	89 c8                	mov    %ecx,%eax
> > >    2:	c3                   	retq
> > >    3:	90                   	nop
> > >    4:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
> > >    8:	85 c0                	test   %eax,%eax
> > >    a:	c7 01 01 00 00 00    	movl   $0x1,(%rcx)
> > >   10:	75 d8                	jne    0xffffffffffffffea
> > >   12:	a1 6c 94 a8 08 eb d1 	movabs 0x9066d1eb08a8946c,%eax
> > >   19:	66 90
> > >   1b:	66 90                	xchg   %ax,%ax
> > >   1d:	66 90                	xchg   %ax,%ax
> > >   1f:	66 90                	xchg   %ax,%ax
> > >   21:	66 90                	xchg   %ax,%ax
> > >   23:	66 90                	xchg   %ax,%ax
> > >   25:	66 90                	xchg   %ax,%ax
> > >   27:	90                   	nop
> > >   28:	cd 80                	int    $0x80
> > >   2a:*	c3                   	retq   		<-- trapping instruction
> > >   2b:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
> > >   31:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
> > >   38:	8b 10                	mov    (%rax),%edx
> > >   3a:	a3                   	.byte 0xa3
> > >   3b:	94                   	xchg   %eax,%esp
> > >   3c:	94                   	xchg   %eax,%esp
> > >   3d:	a8 08                	test   $0x8,%al
> > >   3f:	85                   	.byte 0x85
> > >
> > > Code starting with the faulting instruction
> > > ===========================================
> > >    0:	c3                   	retq
> > >    1:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
> > >    7:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
> > >    e:	8b 10                	mov    (%rax),%edx
> > >   10:	a3                   	.byte 0xa3
> > >   11:	94                   	xchg   %eax,%esp
> > >   12:	94                   	xchg   %eax,%esp
> > >   13:	a8 08                	test   $0x8,%al
> > >   15:	85                   	.byte 0x85
> > > [  558.820109][ T2642] EAX: ffffffda EBX: 00000f0f ECX: bfb23394 EDX:
> > > 0000000b [  558.821480][ T2642] ESI: 00000002 EDI: 08a890fc EBP:
> > > 08a89034 ESP: bfb23364 [  558.822693][ T2642] DS: 007b ES: 007b FS:
> > > 0000 GS: 0033 SS: 007b EFLAGS: 00000246 [  558.828056][ T2642] irq
> > > event stamp: 1348273 [ 558.828922][ T2642] hardirqs last enabled at
> > > (1348281): console_unlock (kernel/printk/printk.c:2605 (discriminator
> > > 1)) [ 558.830629][ T2642] hardirqs last disabled at (1348288):
> > > console_unlock (kernel/printk/printk.c:2520 (discriminator 1)) [
> > > 558.833190][ T2642] softirqs last enabled at (1348240): __do_softirq
> > > (kernel/softirq.c:372) [ 558.834715][ T2642] softirqs last disabled at
> > > (1348231): do_softirq_own_stack (arch/x86/kernel/irq_32.c:60
> > > arch/x86/kernel/irq_32.c:149) [  558.840026][ T2642] ---[ end trace
> > > 6bbb25560ce8d9b6 ]---
> > >
> > >
> > > To reproduce:
> > >
> > >         # build kernel
> > > 	cd linux
> > > 	cp config-5.12.0-gd64696905554 .config
> > > 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare
> > > modules_prepare bzImage
> > >
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         bin/lkp qemu -k <bzImage> job-script # job-script is attached
> > > in this email
> > 
> > I am unable to run the test following this instruction.
>  
> After double check, we can reproduce this issue, could you kindly offer your full log and the reproducing steps?

Sure. Here is what i did:

$ grep PRETTY_NAME /etc/os-release 
PRETTY_NAME="Fedora 34 (Workstation Edition)"

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
$ cd linux

$ git describe
v5.15-rc1-19-g3ca706c189db

$ cp /tmp/config-5.12.0-gd64696905554 .config

$ make -j8 ARCH=i386 olddefconfig prepare modules_prepare bzImage
...
Kernel: arch/x86/boot/bzImage is ready  (#2)

$ git clone https://github.com/intel/lkp-tests.git
$ cd lkp-tests

$ git describe --always
64ef6f2b

$ bin/lkp qemu -k ../arch/x86/boot/bzImage ../job-script 
The approx. disk space requirements are

10M             simple boot test in rootfs openwrt
50M             simple boot test in rootfs debian
1G              plan to run a number of different tests
100G or more    IO tests

Please enter a dir with enough disk space, or simply press Enter to accept the default.
You may still symlink /home/legion/.lkp to a more suitable place in future.
/home/legion/.lkp =>
~/scm/kernel/linux/lkp-tests/pkg/lkp-src ~/scm/kernel/linux/lkp-tests
x86_64
==> Making package: lkp-src 0-1 (Ср 15 сен 2021 13:11:17 CEST)
==> Checking runtime dependencies...
==> Checking buildtime dependencies...
==> WARNING: Using existing $srcdir/ tree
==> Removing existing $pkgdir/ directory...
==> Starting build()...
make: Entering directory '/home/legion/scm/kernel/linux/lkp-tests/bin/event'
gcc -m32 -Wl,-O1,--sort-common,--as-needed,-z,relro -static -o wakeup wakeup.o
rm -f wakeup.o
strip wakeup
strip: wakeup[.gnu.build.attributes__libc_freeres_fn]: Warning: version note missing - assuming version 3
make: Leaving directory '/home/legion/scm/kernel/linux/lkp-tests/bin/event'
==> Entering fakeroot environment...
x86_64
==> Starting package()...
==> Creating package "lkp-src"...
8808 blocks
renamed '/home/legion/.lkp/cache/lkp-i386.cgz.tmp' -> '/home/legion/.lkp/cache/lkp-i386.cgz'
==> Leaving fakeroot environment.
==> Finished making: lkp-src 0-1 (Ср 15 сен 2021 13:16:19 CEST)
~/scm/kernel/linux/lkp-tests
11 blocks
result_root: /home/legion/.lkp//result/trinity/group-02-99999/vm-snb/yocto-i386-minimal-20190520.cgz/i386-randconfig-r015-20210910/gcc-9/d64696905554e919321e31afc210606653b8f6a4/0
downloading initrds ...
/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/yocto-i386-minimal-20190520.cgz -N -P /home/legion/.lkp/cache/osimage/yocto
17916 blocks
/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 https://download.01.org/0day-ci/lkp-qemu/osimage/pkg/yocto-i386-minimal-20190520.cgz/trinity-i386.cgz -N -P /home/legion/.lkp/cache/osimage/pkg/yocto-i386-minimal-20190520.cgz
46817 blocks
exec command: qemu-system-x86_64 -enable-kvm -fsdev local,id=test_dev,path=/home/legion/.lkp//result/trinity/group-02-99999/vm-snb/yocto-i386-minimal-20190520.cgz/i386-randconfig-r015-20210910/gcc-9/d64696905554e919321e31afc210606653b8f6a4/0,security_model=none -device virtio-9p-pci,fsdev=test_dev,mount_tag=9p/virtfs_mount -kernel ../arch/x86/boot/bzImage -append root=/dev/ram0 user=$(whoami) job=/lkp/jobs/scheduled/vm-snb-43/trinity-group-02-99999-yocto-i386-minimal-20190520.cgz-d64696905554e919321e31afc210606653b8f6a4-20210911-24127-1x1tp2w-8.yaml ARCH=i386 kconfig=i386-randconfig-r015-20210910 branch=trace/ftrace/core commit=d64696905554e919321e31afc210606653b8f6a4 BOOT_IMAGE=/pkg/linux/i386-randconfig-r015-20210910/gcc-9/d64696905554e919321e31afc210606653b8f6a4/vmlinuz-5.12.0-gd64696905554 vmalloc=128M initramfs_async=0 page_owner=on max_uptime=2100 RESULT_ROOT=/result/trinity/group-02-99999/vm-snb/yocto-i386-minimal-20190520.cgz/i386-randconfig-r015-20210910/gcc-9/d64696905554e919321e31afc210606653b8f6a4/8 LKP_LOCAL_RUN=1 selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw  ip=dhcp result_service=9p/virtfs_mount -initrd /home/legion/.lkp/cache/final_initrd -smp 2 -m 5390M -no-reboot -watchdog i6300esb -rtc base=localtime -device e1000,netdev=net0 -netdev user,id=net0 -display none -monitor null -serial stdio
early console in setup code
Probing EDD (edd=off to disable)... ok
[    0.000000] Linux version 5.15.0-rc1+ (legion@example.com) (gcc (GCC) 11.1.1 20210531 (Red Hat 11.1.1-3), GNU ld version 2.35.1-41.fc34) #2 SMP Wed Sep 15 13:03:08 CEST 2021
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] signal: max sigframe size: 1440
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000190dfffff] usable
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 10818001, primary cpu clock
[    0.000002] kvm-clock: using sched offset of 247343709 cycles
[    0.000856] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.003174] tsc: Detected 2593.994 MHz processor
[    0.004586] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.005496] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.006318] last_pfn = 0xbffe0 max_arch_pfn = 0x100000
[    0.007096] x86/PAT: PAT not supported by the CPU.
[    0.007789] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC
[    0.008817] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.009606] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.010348] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.014307] found SMP MP-table at [mem 0x000f5c80-0x000f5c8f]
[    0.015120]   mpc: f5c90-f5d7c
[    0.015524] initial memory mapped: [mem 0x00000000-0x10bfffff]
[    0.016384] RAMDISK: [mem 0x7f97e000-0x7fffffff]
[    0.017080] Allocated new RAMDISK: [mem 0x3617c000-0x367fdbe9]
[    0.021514] Move RAMDISK from [mem 0x7f97e000-0x7ffffbe9] to [mem 0x3617c000-0x367fdbe9]
[    0.022741] ACPI: Early table checksum verification disabled
[    0.023589] ACPI: RSDP 0x00000000000F5A60 000014 (v00 BOCHS )
[    0.024427] ACPI: RSDT 0x00000000BFFE15AB 000034 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.025704] ACPI: FACP 0x00000000BFFE1457 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.026839] ACPI: DSDT 0x00000000BFFE0040 001417 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.028102] ACPI: FACS 0x00000000BFFE0000 000040
[    0.028758] ACPI: APIC 0x00000000BFFE14CB 000080 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.029967] ACPI: HPET 0x00000000BFFE154B 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.031216] ACPI: WAET 0x00000000BFFE1583 000028 (v01 BOCHS  BXPCWAET 00000001 BXPC 00000001)
[    0.032382] ACPI: Reserving FACP table memory at [mem 0xbffe1457-0xbffe14ca]
[    0.033398] ACPI: Reserving DSDT table memory at [mem 0xbffe0040-0xbffe1456]
[    0.034362] ACPI: Reserving FACS table memory at [mem 0xbffe0000-0xbffe003f]
[    0.035370] ACPI: Reserving APIC table memory at [mem 0xbffe14cb-0xbffe154a]
[    0.036258] ACPI: Reserving HPET table memory at [mem 0xbffe154b-0xbffe1582]
[    0.037266] ACPI: Reserving WAET table memory at [mem 0xbffe1583-0xbffe15aa]
[    0.038257] mapped APIC to         ffffb000 (        fee00000)
[    0.039083] 2199MB HIGHMEM available.
[    0.039560] 871MB LOWMEM available.
[    0.040074]   mapped low ram: 0 - 367fe000
[    0.040631]   low ram: 0 - 367fe000
[    0.045476] Zone ranges:
[    0.045863]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.046766]   Normal   [mem 0x0000000001000000-0x00000000367fdfff]
[    0.047642]   HighMem  [mem 0x00000000367fe000-0x00000000bffdffff]
[    0.048551] Movable zone start for each node
[    0.049125] Early memory node ranges
[    0.049574]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.050454]   node   0: [mem 0x0000000000100000-0x00000000bffdffff]
[    0.051376] Initmem setup node 0 [mem 0x0000000000001000-0x00000000bffdffff]
[    0.052390] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.052449] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.064385] On node 0, zone HighMem: 32 pages in unavailable ranges
[    0.065265] Using APIC driver default
[    0.067043] ACPI: PM-Timer IO Port: 0x608
[    0.067641] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.068456] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.069426] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.070328] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
[    0.071352] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.072303] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
[    0.073328] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.074194] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
[    0.075147] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.076073] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
[    0.077122] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.078099] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
[    0.079079] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
[    0.080105] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
[    0.081120] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
[    0.082136] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
[    0.083165] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
[    0.084167] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
[    0.085124] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
[    0.086156] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
[    0.087124] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
[    0.088193] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
[    0.089185] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.090090] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.090862] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.091529] mapped IOAPIC to ffffa000 (fec00000)
[    0.092172] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.093235] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.094346] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.095428] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.096474] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    0.097274] Booting paravirtualized kernel on KVM
[    0.097927] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.099382] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:2 nr_node_ids:1
[    0.100454] percpu: Embedded 32 pages/cpu s99276 r0 d31796 u131072
[    0.101331] pcpu-alloc: s99276 r0 d31796 u131072 alloc=32*4096
[    0.102151] pcpu-alloc: [0] 0 [0] 1
[    0.102653] kvm-guest: stealtime: cpu 0, msr 36147a40
[    0.103411] kvm-guest: PV spinlocks disabled, no host support
[    0.104247] Built 1 zonelists, mobility grouping on.  Total pages: 784122
[    0.105201] Kernel command line: root=/dev/ram0 user=$(whoami) job=/lkp/jobs/scheduled/vm-snb-43/trinity-group-02-99999-yocto-i386-minimal-20190520.cgz-d64696905554e919321e31afc210606653b8f6a4-20210911-24127-1x1tp2w-8.yaml ARCH=i386 kconfig=i386-randconfig-r015-20210910 branch=trace/ftrace/core commit=d64696905554e919321e31afc210606653b8f6a4 BOOT_IMAGE=/pkg/linux/i386-randconfig-r015-20210910/gcc-9/d64696905554e919321e31afc210606653b8f6a4/vmlinuz-5.12.0-gd64696905554 vmalloc=128M initramfs_async=0 page_owner=on max_uptime=2100 RESULT_ROOT=/result/trinity/group-02-99999/vm-snb/yocto-i386-minimal-20190520.cgz/i386-randconfig-r015-20210910/gcc-9/d64696905554e919321e31afc210606653b8f6a4/8 LKP_LOCAL_RUN=1 selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS
[    0.105625] sysrq: sysrq always enabled.
[    0.119255] ignoring the deprecated load_ramdisk= option
[    0.120230] Unknown command line parameters: user=$(whoami) job=/lkp/jobs/scheduled/vm-snb-43/trinity-group-02-99999-yocto-i386-minimal-20190520.cgz-d64696905554e919321e31afc210606653b8f6a4-20210911-24127-1x1tp2w-8.yaml ARCH=i386 kconfig=i386-randconfig-r015-20210910 branch=trace/ftrace/core commit=d64696905554e919321e31afc210606653b8f6a4 BOOT_IMAGE=/pkg/linux/i386-randconfig-r015-20210910/gcc-9/d64696905554e919321e31afc210606653b8f6a4/vmlinuz-5.12.0-gd64696905554 max_uptime=2100 RESULT_ROOT=/result/trinity/group-02-99999/vm-snb/yocto-i386-minimal-20190520.cgz/i386-randconfig-r015-20210910/gcc-9/d64696905554e919321e31afc210606653b8f6a4/8 LKP_LOCAL_RUN=1 softlockup_panic=1 prompt_ramdisk=0 vga=normal ip=dhcp result_service=9p/virtfs_mount
[    0.129916] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.131086] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.132185] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.134089] Initializing HighMem for node 0 (000367fe:000bffe0)
[    0.216658] Initializing Movable for node 0 (00000000:00000000)
[    0.219183] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.220375] Memory: 3076340K/3145208K available (12370K kernel code, 1901K rwdata, 9072K rodata, 1076K init, 840K bss, 68868K reserved, 0K cma-reserved, 2252680K highmem)
[    0.222620] random: get_random_u32 called from __kmem_cache_create+0x23/0x540 with crng_init=0
[    0.222950] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.225214] ftrace: allocating 43733 entries in 86 pages
[    0.240068] ftrace: allocated 86 pages with 4 groups
[    0.240825] trace event string verifier disabled
[    0.241732] rcu: Hierarchical RCU implementation.
[    0.242375] rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
[    0.243319]  RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
[    0.244382]  Trampoline variant of Tasks RCU enabled.
[    0.245116]  Rude variant of Tasks RCU enabled.
[    0.245786]  Tracing variant of Tasks RCU enabled.
[    0.246507] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.247651] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.254529] NR_IRQS: 2304, nr_irqs: 440, preallocated irqs: 16
[    0.273395] Console: colour VGA+ 80x25
[    0.325543] printk: console [tty0] enabled
[    0.326385] printk: console [ttyS0] enabled
[    0.326385] printk: console [ttyS0] enabled
[    0.327855] printk: bootconsole [earlyser0] disabled
[    0.327855] printk: bootconsole [earlyser0] disabled
[    0.329521] ACPI: Core revision 20210730
[    0.330469] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.332345] APIC: Switch to symmetric I/O mode setup
[    0.333394] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.334576] masked ExtINT on CPU#0
[    0.336162] ENABLING IO-APIC IRQs
[    0.336899] init IO_APIC IRQs
[    0.337572]  apic 0 pin 0 not connected
[    0.338387] IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1 Level:0 ActiveLow:0)
[    0.339909] IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 0 Level:0 ActiveLow:0)
[    0.341474] IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3 Level:0 ActiveLow:0)
[    0.343019] IOAPIC[0]: Preconfigured routing entry (0-4 -> IRQ 4 Level:0 ActiveLow:0)
[    0.344544] IOAPIC[0]: Preconfigured routing entry (0-5 -> IRQ 5 Level:1 ActiveLow:0)
[    0.346058] IOAPIC[0]: Preconfigured routing entry (0-6 -> IRQ 6 Level:0 ActiveLow:0)
[    0.347634] IOAPIC[0]: Preconfigured routing entry (0-7 -> IRQ 7 Level:0 ActiveLow:0)
[    0.349221] IOAPIC[0]: Preconfigured routing entry (0-8 -> IRQ 8 Level:0 ActiveLow:0)
[    0.350788] IOAPIC[0]: Preconfigured routing entry (0-9 -> IRQ 9 Level:1 ActiveLow:0)
[    0.352295] IOAPIC[0]: Preconfigured routing entry (0-10 -> IRQ 10 Level:1 ActiveLow:0)
[    0.353912] IOAPIC[0]: Preconfigured routing entry (0-11 -> IRQ 11 Level:1 ActiveLow:0)
[    0.355484] IOAPIC[0]: Preconfigured routing entry (0-12 -> IRQ 12 Level:0 ActiveLow:0)
[    0.357066] IOAPIC[0]: Preconfigured routing entry (0-13 -> IRQ 13 Level:0 ActiveLow:0)
[    0.358652] IOAPIC[0]: Preconfigured routing entry (0-14 -> IRQ 14 Level:0 ActiveLow:0)
[    0.360247] IOAPIC[0]: Preconfigured routing entry (0-15 -> IRQ 15 Level:0 ActiveLow:0)
[    0.361853]  apic 0 pin 16 not connected
[    0.362661]  apic 0 pin 17 not connected
[    0.363464]  apic 0 pin 18 not connected
[    0.364250]  apic 0 pin 19 not connected
[    0.365094]  apic 0 pin 20 not connected
[    0.365915]  apic 0 pin 21 not connected
[    0.366715]  apic 0 pin 22 not connected
[    0.367519]  apic 0 pin 23 not connected
[    0.368427] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.369673] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x256412811b4, max_idle_ns: 440795306987 ns
[    0.371716] Calibrating delay loop (skipped) preset value.. 5187.98 BogoMIPS (lpj=2593994)
[    0.372714] pid_max: default: 32768 minimum: 301
[    0.373612] LSM: Security Framework initializing
[    0.373723] Yama: becoming mindful.
[    0.374724] LSM support for eBPF active
[    0.375716] landlock: Up and running.
[    0.376725] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.377715] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
Poking KASLR using RDTSC...
[    0.379760] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.380714] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.381717] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.382717] Spectre V2 : Mitigation: Full generic retpoline
[    0.383714] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.384714] Speculative Store Bypass: Vulnerable
[    0.385714] L1TF: Kernel not compiled for PAE. No mitigation for L1TF
[    0.386716] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.389800] Freeing SMP alternatives memory: 40K
[    0.390781] Using local APIC timer interrupts.
[    0.390781] calibrating APIC timer ...
[    0.494491] ... lapic delta = 6250028
[    0.494712] ... PM-Timer delta = 357953
[    0.494712] ... PM-Timer result ok
[    0.494712] ..... delta 6250028
[    0.494712] ..... mult: 268435456
[    0.494712] ..... calibration result: 1000004
[    0.494712] ..... CPU clock speed is 2593.0965 MHz.
[    0.494712] ..... host bus clock speed is 1000.0004 MHz.
[    0.494760] smpboot: CPU0: Intel QEMU Virtual CPU version 2.5+ (family: 0x6, model: 0x6, stepping: 0x3)
[    0.495822] Performance Events: PMU not available due to virtualization, using software events only.
[    0.496745] rcu: Hierarchical SRCU implementation.
[    0.497945] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.498759] smp: Bringing up secondary CPUs ...
[    0.499790] x86: Booting SMP configuration:
[    0.500715] .... node  #0, CPUs:      #1
[    0.113149] kvm-clock: cpu 1, msr 10818021, secondary cpu clock
[    0.113149] masked ExtINT on CPU#1
[    0.113149] smpboot: CPU 1 Converting physical 0 to logical die 1
[    0.504730] kvm-guest: stealtime: cpu 1, msr 36167a40
[    0.506757] smp: Brought up 1 node, 2 CPUs
[    0.507715] smpboot: Max logical packages: 2
[    0.508714] smpboot: Total of 2 processors activated (10375.97 BogoMIPS)
[    0.518115] allocated 31457280 bytes of page_ext
[    0.518781] Node 0, zone      DMA: page owner found early allocated 0 pages
[    0.521199] Node 0, zone   Normal: page owner found early allocated 8326 pages
[    0.522727] Node 0, zone  HighMem: page owner found early allocated 63 pages
[    0.523792] devtmpfs: initialized
[    0.525970] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.526718] futex hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.527763] pinctrl core: initialized pinctrl subsystem
[    0.528844] PM: RTC time: 13:16:34, date: 2021-09-15
[    0.529859] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.532088] audit: initializing netlink subsys (disabled)
[    0.532748] audit: type=2000 audit(1631704594.860:1): state=initialized audit_enabled=0 res=1
[    0.532882] thermal_sys: Registered thermal governor 'fair_share'
[    0.533716] thermal_sys: Registered thermal governor 'bang_bang'
[    0.534715] thermal_sys: Registered thermal governor 'step_wise'
[    0.535715] thermal_sys: Registered thermal governor 'user_space'
[    0.536727] cpuidle: using governor menu
[    0.539187] ACPI: bus type PCI registered
[    0.539715] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.540876] PCI: PCI BIOS revision 2.10 entry at 0xfd1b8, last bus=0
[    0.541716] PCI: Using configuration type 1 for base access
[    0.544343] Kprobes globally optimized
[    0.544778] HugeTLB registered 4.00 MiB page size, pre-allocated 0 pages
[    1.232030] cryptd: max_cpu_qlen set to 1000
[    1.236954] alg: No test for 842 (842-generic)
[    1.237743] alg: No test for 842 (842-scomp)
[    1.252185] DRBG: Continuing without Jitter RNG
[    1.282782] raid6: skip pq benchmark and using algorithm sse2x2
[    1.283719] raid6: using intx1 recovery algorithm
[    1.284764] ACPI: Added _OSI(Module Device)
[    1.285716] ACPI: Added _OSI(Processor Device)
[    1.286718] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.287715] ACPI: Added _OSI(Processor Aggregator Device)
[    1.288717] ACPI: Added _OSI(Linux-Dell-Video)
[    1.289715] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    1.290715] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    1.292174] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    1.294348] ACPI: Interpreter enabled
[    1.294728] ACPI: PM: (supports S0 S3 S4 S5)
[    1.295715] ACPI: Using IOAPIC for interrupt routing
[    1.296727] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.297810] ACPI: Enabled 2 GPEs in block 00 to 0F
[    1.300466] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.300718] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI EDR HPX-Type3]
[    1.301719] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    1.302721] acpi resource window ([0x1c0000000-0x23fffffff] ignored, not CPU addressable)
[    1.303916] acpiphp: Slot [3] registered
[    1.304731] acpiphp: Slot [4] registered
[    1.305730] acpiphp: Slot [5] registered
[    1.306489] acpiphp: Slot [6] registered
[    1.306733] acpiphp: Slot [7] registered
[    1.307733] acpiphp: Slot [8] registered
[    1.308730] acpiphp: Slot [9] registered
[    1.309730] acpiphp: Slot [10] registered
[    1.310568] acpiphp: Slot [11] registered
[    1.310730] acpiphp: Slot [12] registered
[    1.311730] acpiphp: Slot [13] registered
[    1.312730] acpiphp: Slot [14] registered
[    1.313730] acpiphp: Slot [15] registered
[    1.314723] acpiphp: Slot [16] registered
[    1.315577] acpiphp: Slot [17] registered
[    1.315732] acpiphp: Slot [18] registered
[    1.316730] acpiphp: Slot [19] registered
[    1.317730] acpiphp: Slot [20] registered
[    1.318729] acpiphp: Slot [21] registered
[    1.319526] acpiphp: Slot [22] registered
[    1.319730] acpiphp: Slot [23] registered
[    1.320737] acpiphp: Slot [24] registered
[    1.321732] acpiphp: Slot [25] registered
[    1.322732] acpiphp: Slot [26] registered
[    1.323733] acpiphp: Slot [27] registered
[    1.324750] acpiphp: Slot [28] registered
[    1.325733] acpiphp: Slot [29] registered
[    1.327716] acpiphp: Slot [30] registered
[    1.328732] acpiphp: Slot [31] registered
[    1.329725] PCI host bridge to bus 0000:00
[    1.330715] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.331715] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.332715] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.333715] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    1.334715] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.335805] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    1.337132] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    1.338223] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    1.340912] pci 0000:00:01.1: reg 0x20: [io  0xc080-0xc08f]
[    1.343171] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    1.343715] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    1.344717] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    1.345715] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    1.346958] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    1.348085] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    1.348723] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    1.349953] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    1.351733] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    1.354732] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    1.360734] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    1.362913] pci 0000:00:03.0: [1af4:1009] type 00 class 0x000200
[    1.364715] pci 0000:00:03.0: reg 0x10: [io  0xc000-0xc03f]
[    1.366715] pci 0000:00:03.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    1.370716] pci 0000:00:03.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64bit pref]
[    1.373770] pci 0000:00:04.0: [8086:100e] type 00 class 0x020000
[    1.375715] pci 0000:00:04.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    1.377982] pci 0000:00:04.0: reg 0x14: [io  0xc040-0xc07f]
[    1.383054] pci 0000:00:04.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    1.383965] pci 0000:00:05.0: [8086:25ab] type 00 class 0x088000
[    1.385991] pci 0000:00:05.0: reg 0x10: [mem 0xfebf2000-0xfebf200f]
[    1.389365] pci_bus 0000:00: on NUMA node 0
[    1.390854] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    1.392813] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    1.393809] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    1.394806] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    1.396713] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    1.398072] iommu: Default domain type: Translated
[    1.398715] iommu: DMA domain TLB invalidation policy: lazy mode
[    1.399790] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.400712] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.400716] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.401715] vgaarb: loaded
[    1.402643] SCSI subsystem initialized
[    1.403744] libata version 3.00 loaded.
[    1.404758] ACPI: bus type USB registered
[    1.405742] usbcore: registered new interface driver usbfs
[    1.406731] usbcore: registered new interface driver hub
[    1.408717] usbcore: registered new device driver usb
[    1.409750] pps_core: LinuxPPS API ver. 1 registered
[    1.410714] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.411718] PTP clock support registered
[    1.412766] EDAC MC: Ver: 3.0.0
[    1.414938] NetLabel: Initializing
[    1.415715] NetLabel:  domain hash size = 128
[    1.416714] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.417734] NetLabel:  unlabeled traffic allowed by default
[    1.418722] PCI: Using ACPI for IRQ routing
[    1.419715] PCI: pci_cache_line_size set to 64 bytes
[    1.420823] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    1.421719] e820: reserve RAM buffer [mem 0xbffe0000-0xbfffffff]
[    1.423811] hpet: 3 channels of 0 reserved for per-cpu timers
[    1.424731] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.425714] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    1.432769] clocksource: Switched to clocksource kvm-clock
[    1.450889] VFS: Disk quotas dquot_6.6.0
[    1.451842] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.453453] pnp: PnP ACPI init
[    1.454285] pnp 00:02: [dma 2]
[    1.455285] pnp: PnP ACPI: found 6 devices
[    1.491745] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.493617] NET: Registered PF_INET protocol family
[    1.494694] IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    1.496491] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
[    1.498309] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    1.499923] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    1.501431] TCP: Hash tables configured (established 8192 bind 8192)
[    1.502821] MPTCP token hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    1.504415] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[    1.505808] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
[    1.507313] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.508519] NET: Registered PF_XDP protocol family
[    1.509557] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.510849] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.512086] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.513538] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
[    1.514980] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    1.516212] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    1.517460] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    1.518761] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.520525] PCI: CLS 0 bytes, default 64
[    1.521457] Trying to unpack rootfs image as initramfs...
[    1.713192] Freeing initrd memory: 6664K
[    1.714909] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x256412811b4, max_idle_ns: 440795306987 ns
[    1.717760] Initialise system trusted keyrings
[    1.718783] Key type blacklist registered
[    1.719752] workingset: timestamp_bits=14 max_order=20 bucket_order=6
[    1.722543] zbud: loaded
[    1.723639] integrity: Platform Keyring initialized
[    1.737954] NET: Registered PF_ALG protocol family
[    1.738980] xor: measuring software checksum speed
[    1.740561]    pIII_sse        : 20542 MB/sec
[    1.741925]    prefetch64-sse  : 23982 MB/sec
[    1.742909] xor: using function: prefetch64-sse (23982 MB/sec)
[    1.744139] Key type asymmetric registered
[    1.745039] Asymmetric key parser 'x509' registered
[    1.746169] bounce: pool size: 64 pages
[    1.747094] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    1.748707] io scheduler mq-deadline registered
[    1.750002] io scheduler kyber registered
[    1.751161] io scheduler bfq registered
[    1.752394] atomic64_test: passed for i586+ platform with CX8 and with SSE
[    1.754383] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.756225] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    1.758287] ACPI: button: Power Button [PWRF]
[    1.775040] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    1.777056] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.778502] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.781332] Non-volatile memory driver v1.3
[    1.782297] Linux agpgart interface v0.103
[    1.783540] ata_piix 0000:00:01.1: version 2.13
[    1.785339] scsi host0: ata_piix
[    1.786304] scsi host1: ata_piix
[    1.787111] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc080 irq 14
[    1.788567] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc088 irq 15
[    1.790069] libphy: Fixed MDIO Bus: probed
[    1.791249] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.792615] ehci-pci: EHCI PCI platform driver
[    1.793564] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.794910] ohci-pci: OHCI PCI platform driver
[    1.795868] uhci_hcd: USB Universal Host Controller Interface driver
[    1.797245] usbcore: registered new interface driver usbserial_generic
[    1.798634] usbserial: USB Serial support registered for generic
[    1.799947] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    1.802437] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.803499] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.804623] mousedev: PS/2 mouse device common for all mice
[    1.806140] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    1.808292] rtc_cmos 00:05: RTC can wake from S4
[    1.809901] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input4
[    1.812102] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
[    1.813914] rtc_cmos 00:05: registered as rtc0
[    1.814970] rtc_cmos 00:05: setting system clock to 2021-09-15T13:16:36 UTC (1631711796)
[    1.816672] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    1.818294] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    1.820756] device-mapper: uevent: version 1.0.3
[    1.821788] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
[    1.823764] intel_pstate: CPU model not supported
[    1.824907] hid: raw HID events driver (C) Jiri Kosina
[    1.826142] usbcore: registered new interface driver usbhid
[    1.827312] usbhid: USB HID core driver
[    1.828212] drop_monitor: Initializing network drop monitor service
[    1.838572] Initializing XFRM netlink socket
[    1.839585] NET: Registered PF_INET6 protocol family
[    1.841801] Segment Routing with IPv6
[    1.842683] RPL Segment Routing with IPv6
[    1.843585] In-situ OAM (IOAM) with IPv6
[    1.844440] mip6: Mobile IPv6
[    1.845176] NET: Registered PF_PACKET protocol family
[    1.847003] IPI shorthand broadcast: enabled
[    1.848037] ... APIC ID:      00000000 (0)
[    1.849028] ... APIC VERSION: 00050014
[    1.849028] 0000000000000000000000000000000000000000000000000000000000000000
[    1.849028] 0000000000000000000000000000000000000000000000000000000000000000
[    1.849028] 0000000000000000000000000000000000000000000000000000000000001000
[    1.849028]
[    1.854384] number of MP IRQ sources: 15.
[    1.855515] number of IO-APIC #0 registers: 24.
[    1.856719] testing the IO APIC.......................
[    1.858135] IO APIC #0......
[    1.859016] .... register #00: 00000000
[    1.860108] .......    : physical APIC id: 00
[    1.861249] .......    : Delivery Type: 0
[    1.862379] .......    : LTS          : 0
[    1.863551] .... register #01: 00170011
[    1.864654] .......     : max redirection entries: 17
[    1.865673] .......     : PRQ implemented: 0
[    1.866614] .......     : IO APIC version: 11
[    1.867563] .... register #02: 00000000
[    1.868390] .......     : arbitration: 00
[    1.869295] .... IRQ redirection table:
[    1.870177] IOAPIC 0:
[    1.870810]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.872434]  pin01, enabled , edge , high, V(23), IRR(0), S(0), logical , D(0002), M(0)
[    1.874154]  pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(0001), M(0)
[    1.875823]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.877581]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.879254]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.880966]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.882650]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.884268]  pin08, enabled , edge , high, V(23), IRR(0), S(0), logical , D(0001), M(0)
[    1.885952]  pin09, enabled , level, high, V(21), IRR(0), S(0), logical , D(0002), M(0)
[    1.887693]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.889363]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.891044]  pin0c, enabled , edge , high, V(22), IRR(0), S(0), logical , D(0001), M(0)
[    1.892798]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.894462]  pin0e, enabled , edge , high, V(21), IRR(0), S(0), logical , D(0001), M(0)
[    1.896144]  pin0f, enabled , edge , high, V(22), IRR(0), S(0), logical , D(0002), M(0)
[    1.897779]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.899354]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.901063]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.902768]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.904403]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.906092]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.907805]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.909507]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    1.911204] IRQ to pin mappings:
[    1.911965] IRQ0 -> 0:2
[    1.912559] IRQ1 -> 0:1
[    1.913151] IRQ3 -> 0:3
[    1.913728] IRQ4 -> 0:4
[    1.914319] IRQ5 -> 0:5
[    1.914934] IRQ6 -> 0:6
[    1.915513] IRQ7 -> 0:7
[    1.916134] IRQ8 -> 0:8
[    1.916709] IRQ9 -> 0:9
[    1.917346] IRQ10 -> 0:10
[    1.917939] IRQ11 -> 0:11
[    1.918584] IRQ12 -> 0:12
[    1.919226] IRQ13 -> 0:13
[    1.919843] IRQ14 -> 0:14
[    1.920425] IRQ15 -> 0:15
[    1.921074] .................................... done.
[    1.922166] sched_clock: Marking stable (1809994723, 112149602)->(1997769292, -75624967)
[    1.923944] registered taskstats version 1
[    1.924877] Loading compiled-in X.509 certificates
[    1.928813] Loaded X.509 cert 'Build time autogenerated kernel key: 5f848f3a256c3033a276d466d757b9174d58558c'
[    1.931028] zswap: loaded using pool lzo/zbud
[    1.932212] Key type ._fscrypt registered
[    1.933141] Key type .fscrypt registered
[    1.933989] Key type fscrypt-provisioning registered
[    1.935399] Btrfs loaded, crc32c=crc32c-generic, zoned=yes, fsverity=yes
[    1.937362] Key type encrypted registered
[    1.938451] ima: No TPM chip found, activating TPM-bypass!
[    1.939809] Loading compiled-in module X.509 certificates
[    1.943733] Loaded X.509 cert 'Build time autogenerated kernel key: 5f848f3a256c3033a276d466d757b9174d58558c'
[    1.944780] ata2.01: NODEV after polling detection
[    1.946329] ima: Allocated hash algorithm: sha256
[    1.947837] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    1.948670] ima: No architecture policies found
[    1.951261] evm: Initialising EVM extended attributes:
[    1.952552] evm: security.selinux
[    1.953446] evm: security.SMACK64 (disabled)
[    1.954550] evm: security.SMACK64EXEC (disabled)
[    1.955734] evm: security.SMACK64TRANSMUTE (disabled)
[    1.956970] evm: security.SMACK64MMAP (disabled)
[    1.958269] evm: security.apparmor (disabled)
[    1.958297] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    1.959343] evm: security.ima
[    1.959344] evm: security.capability
[    1.959345] evm: HMAC attrs: 0x1
[    1.963315] PM:   Magic number: 5:244:281
[    1.964463] tty tty18: hash matches
[    1.983501] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    1.985182] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.003515] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    2.004946] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    2.007640] Freeing unused kernel image (initmem) memory: 1076K
[    2.013798] Write protecting kernel text and read-only data: 21444k
[    2.015796] rodata_test: all tests were successful
[    2.022763] Run /init as init process
[    2.023922]   with arguments:
[    2.024801]     /init
[    2.025447]   with environment:
[    2.026337]     HOME=/
[    2.027006]     TERM=linux
[    2.027784]     user=$(whoami)
[    2.028659]     job=/lkp/jobs/scheduled/vm-snb-43/trinity-group-02-99999-yocto-i386-minimal-20190520.cgz-d64696905554e919321e31afc210606653b8f6a4-20210911-24127-1x1tp2w-8.yaml
[    2.032415]     ARCH=i386
[    2.033140]     kconfig=i386-randconfig-r015-20210910
[    2.034457]     branch=trace/ftrace/core
[    2.035503]     commit=d64696905554e919321e31afc210606653b8f6a4
[    2.036995]     BOOT_IMAGE=/pkg/linux/i386-randconfig-r015-20210910/gcc-9/d64696905554e919321e31afc210606653b8f6a4/vmlinuz-5.12.0-gd64696905554
[    2.040147]     max_uptime=2100
[    2.041044]     RESULT_ROOT=/result/trinity/group-02-99999/vm-snb/yocto-i386-minimal-20190520.cgz/i386-randconfig-r015-20210910/gcc-9/d64696905554e919321e31afc210606653b8f6a4/8
[    2.044850]     LKP_LOCAL_RUN=1
[    2.045749]     softlockup_panic=1
[    2.046688]     prompt_ramdisk=0
[    2.047584]     vga=normal
[    2.048380]     ip=dhcp
[    2.049110]     result_service=9p/virtfs_mount
INIT: version 2.88 booting
Starting udev
[    2.073317] udevd[167]: starting version 3.2.7
[    2.074652] random: udevd: uninitialized urandom read (16 bytes read)
[    2.076331] random: udevd: uninitialized urandom read (16 bytes read)
[    2.077986] random: udevd: uninitialized urandom read (16 bytes read)
[    2.080262] udevd[167]: specified group 'kvm' unknown
[    2.082655] udevd[168]: starting eudev-3.2.7
depmod: ERROR: could not open directory /lib/modules/5.15.0-rc1+: No such file or directory
depmod: WARNING: -e needs -E or -F
depmod: ERROR: could not open directory /lib/modules/5.15.0-rc1+: No such file or directory
depmod: FATAL: could not search modules: No such file or directory
INIT: Entering runlevel: 5
Configuring network interfaces... done.
Starting syslogd/klogd: done
/etc/rc5.d/S77lkp-bootstrap: /lkp/jobs/scheduled/vm-snb-43/trinity-group-02-99999-yocto-i386-minimal-20190520.cgz-d64696905554e919321e31afc210606653b8f6a4-20210911-24127-1x1tp2w-8.sh: line 123: start: not found
/etc/rc5.d/S77lkp-bootstrap: line 75: /lkp/root/src/bin/lkp-setup-rootfs: not found
INIT: Id "S1" respawning too fast: disabled for 5 minutes

Poky (Yocto Project Reference Distro) 2.7+snapshot qemux86 /dev/ttyS0

qemux86 login:


> As the log you mentioned, below [1] shows our corresponding log, they are very similar, only we don't have depmod error, I found some solutions and add their links here, could you check if they can solve your issue? Thanks.
> 
> depmod: ERROR: could not open directory /lib/modules/5.14.0-09687-g27151f177827: No such file or directory
> depmod: FATAL: could not search modules: No such file or directory
> 
> https://stackoverflow.com/questions/28644386/kernel-install-gives-missing-module-error
> https://serverfault.com/questions/780980/error-could-not-open-directory-lib-modules-4-2-0-25-generic-no-such-file-or-d

The error occurs inside qemu. It seems that the directory with modules and
lkp-tests itself (/lkp/root/src) was not mounted from the host system.

-- 
Rgrds, legion

