Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA953BD8FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhGFOyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:54:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:64052 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhGFOym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:54:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="209171867"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="xz'?scan'208";a="209171867"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 07:52:03 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="xz'?scan'208";a="486294256"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 07:52:00 -0700
Date:   Tue, 6 Jul 2021 23:10:39 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: [sched/core]  f1a0a376ca: BUG:KASAN:stack-out-of-bounds_in_vsnprintf
Message-ID: <20210706151039.GA13363@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674 ("sched/core: Initialize the idle task with preemption disabled")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: locktorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug

test-description: This torture test consists of creating a number of kernel threads which acquire the lock and hold it for specific amount of time, thus simulating different critical region behaviors.
test-url: https://www.kernel.org/doc/Documentation/locking/locktorture.txt


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[  227.905035] BUG: KASAN: stack-out-of-bounds in vsnprintf+0x1823/0x1a80
[  227.905062] Read of size 8 at addr ffffc9000010ff00 by task swapper/1/0
[  227.905084] 
[  227.905102] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.13.0-rc1-00108-gf1a0a376ca0c #1
[  227.905133] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  227.905157] Call Trace:
[  227.905171]  dump_stack+0x198/0x247
[  227.905190]  print_address_description.cold+0x5/0x32d
[  227.905212]  ? vsnprintf+0x1823/0x1a80
[  227.905229]  kasan_report.cold+0x7c/0xd8
[  227.905246]  ? vsnprintf+0x1823/0x1a80
[  227.905263]  vsnprintf+0x1823/0x1a80
[  227.905279]  ? pointer+0x780/0x780
[  227.905295]  ? sched_clock_cpu+0x38/0x220
[  227.905312]  vprintk_store+0x14d/0xa80
[  227.905330]  ? __ia32_sys_syslog+0xc0/0xc0
[  227.905348]  ? ftrace_likely_update+0xa4/0x180
[  227.905367]  ? pvclock_clocksource_read+0x2dd/0x5a0
[  227.905386]  ? write_comp_data+0x2a/0x80
[  227.905404]  ? __sanitizer_cov_trace_pc+0x1d/0x60
[  227.905423]  vprintk_emit+0x144/0x600
[  227.905439]  vprintk+0xac/0x1e0
[  227.905453]  printk+0xa3/0xc1
[  227.905470]  ? stress_reorder_work.cold+0x2a/0x2a
[  227.905489]  ? slow_virt_to_phys+0x15b/0x340
[  227.905507]  ? ftrace_likely_update+0xa4/0x180
[  227.905526]  start_secondary+0x4a/0x280
[  227.905544]  secondary_startup_64_no_verify+0xb0/0xbb
[  227.905561] 
[  227.905572] 
[  227.905592] addr ffffc9000010ff00 is located in stack of task swapper/1/0 at offset 120 in frame:
[  227.905619]  printk+0x0/0xc1
[  227.905633] 
[  227.905646] this frame has 1 object:
[  227.905664]  [32, 56) 'args'
[  227.905678] 
[  227.905694] Memory state around the buggy address:
[  227.905718]  ffffc9000010fe00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  227.905746]  ffffc9000010fe80: 00 f1 f1 f1 f1 00 00 00 f3 f3 f3 f3 f3 00 00 00
[  227.905775] >ffffc9000010ff00: f3 f3 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  227.905799]                    ^
[  227.905820]  ffffc9000010ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  227.905848]  ffffc90000110000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[  227.905876] ==================================================================
[  227.905902] Disabling lock debugging due to kernel taint
[  227.974158] smpboot: CPU 1 is now offline
[  231.067528] x86: Booting SMP configuration:
[  231.068838] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  231.090360] kvm-clock: cpu 1, msr 8a01041, secondary cpu clock
[  231.090509] masked ExtINT on CPU#1
[  231.117328] kvm-guest: stealtime: cpu 1, msr 3aebf8080
[  237.501337] smpboot: CPU 1 is now offline
[  240.667721] x86: Booting SMP configuration:
[  240.669915] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  240.672831] kvm-clock: cpu 1, msr 8a01041, secondary cpu clock
[  240.672991] masked ExtINT on CPU#1
[  240.713721] kvm-guest: stealtime: cpu 1, msr 3aebf8080

Kboot worker: lkp-worker51
Elapsed time: 240

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu SandyBridge
	-kernel $kernel
	-initrd initrd-vm-snb-228.cgz
	-m 16384
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0,hostfwd=tcp::32032-:22
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	ip=::::vm-snb-228::dhcp
	root=/dev/ram0
	user=lkp
	job=/job-script
	ARCH=x86_64
	kconfig=x86_64-randconfig-a014-20210513
	branch=tip/sched/core
	commit=f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674
	BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a014-20210513/gcc-9/f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674/vmlinuz-5.13.0-rc1-00108-gf1a0a376ca0c
	vmalloc=512M
	max_uptime=2100
	RESULT_ROOT=/result/locktorture/300s-cpuhotplug/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a014-20210513/gcc-9/f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674/21
	result_service=tmpfs
	selinux=0
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0


To reproduce:

        

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='locktorture'
	export testcase='locktorture'
	export category='functional'
	export need_modules=true
	export need_memory='300MB'
	export runtime=300
	export job_origin='locktorture.yaml'
	export queue_cmdline_keys=
	export queue='int'
	export testbox='vm-snb-228'
	export tbox_group='vm-snb'
	export branch='tip/sched/core'
	export commit='f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674'
	export kconfig='x86_64-randconfig-a014-20210513'
	export nr_vm=160
	export submit_id='60a47a900b9a9364a1ec58ed'
	export job_file='/lkp/jobs/scheduled/vm-snb-228/locktorture-300s-cpuhotplug-debian-10.4-x86_64-20200603.cgz-f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674-20210519-25761-woq8s9-38.yaml'
	export id='b977acb2f978482e90666402e67ebe95878195ca'
	export queuer_version='/lkp/xsang/.src-20210519-100815'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig='CONFIG_LOCK_TORTURE_TEST=m
CONFIG_SECURITY_LOADPIN_ENABLED=n ~ "<= v4.19"
CONFIG_SECURITY_LOADPIN_ENFORCE=n ~ ">= v4.20"
CONFIG_KVM_GUEST=y'
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=512M'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export compiler='gcc-9'
	export enqueue_time='2021-05-19 10:40:16 +0800'
	export _id='60a47a920b9a9364a1ec5913'
	export _rt='/result/locktorture/300s-cpuhotplug/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a014-20210513/gcc-9/f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/locktorture/300s-cpuhotplug/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a014-20210513/gcc-9/f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674/21'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-228/locktorture-300s-cpuhotplug-debian-10.4-x86_64-20200603.cgz-f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674-20210519-25761-woq8s9-38.yaml
ARCH=x86_64
kconfig=x86_64-randconfig-a014-20210513
branch=tip/sched/core
commit=f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a014-20210513/gcc-9/f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674/vmlinuz-5.13.0-rc1-00108-gf1a0a376ca0c
vmalloc=512M
max_uptime=2100
RESULT_ROOT=/result/locktorture/300s-cpuhotplug/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a014-20210513/gcc-9/f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674/21
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-randconfig-a014-20210513/gcc-9/f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='46a1f7098976'
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-randconfig-a014-20210513/gcc-9/f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674/vmlinuz-5.13.0-rc1-00108-gf1a0a376ca0c'
	export dequeue_time='2021-05-19 10:53:29 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-228/locktorture-300s-cpuhotplug-debian-10.4-x86_64-20200603.cgz-f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674-20210519-25761-woq8s9-38.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo

	run_test test='cpuhotplug' $LKP_SRC/tests/wrapper locktorture
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='cpuhotplug' $LKP_SRC/stats/wrapper locktorture
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time locktorture.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--uAKRQypu60I7Lcqm
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AgAAAAAEWVo=

--uAKRQypu60I7Lcqm--
