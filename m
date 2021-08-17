Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEA43EEF00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhHQPQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhHQPQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629213364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PN9GC5FOwi8vs0yGfD5XSUrgT7Hi0gY17DrwbPneHs8=;
        b=dlSHv8o6utyx/qEvGGFXCLVWGgt50rSGY6vTaBnvU2sQgv+L0RYu/kVvjelXzQduC3tjJl
        IQ7LpxGi+UaB824d2hSD9NsZACwv09bzpjy5ND9l1gk2HJup3mfDGT0Q/DgwnwwUv3UfIK
        90qWAzSEdMad2Q5RSmxQqR6RvOWQs1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-6PX7uCzmNvesXtlpcjap_g-1; Tue, 17 Aug 2021 11:15:52 -0400
X-MC-Unique: 6PX7uCzmNvesXtlpcjap_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E153802C91;
        Tue, 17 Aug 2021 15:15:50 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05ACD60916;
        Tue, 17 Aug 2021 15:15:45 +0000 (UTC)
Date:   Tue, 17 Aug 2021 17:15:42 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Christian Brauner <christian.brauner@ubuntu.com>, ldv@strace.io
Subject: Re: [PATCH 18/19] sched: prctl() core-scheduling interface
Message-ID: <20210817151542.GA1665@asgard.redhat.com>
References: <20210422120459.447350175@infradead.org>
 <20210422123309.039845339@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20210422123309.039845339@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 22, 2021 at 02:05:17PM +0200, Peter Zijlstra wrote:
> From: Chris Hyser <chris.hyser@oracle.com>
> 
> This patch provides support for setting and copying core scheduling
> 'task cookies' between threads (PID), processes (TGID), and process
> groups (PGID).

Hello.

It seems that there is some issue within the scheduler code
that can be triggered via this interface:

    # gcc -std=gnu99 -Wextra -Werror prctl-sched-core-oops-repro.c -o prctl-sched-core-oops-repro
    # ../src/strace -fvq -eprctl,clone,setsid ./prctl-sched-core-oops-repro
    clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f271f875890) = 239820
    [pid 239820] setsid()                   = 239820
    [pid 239820] +++ exited with 0 +++
    --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=239820, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
    Iteration 0 status: 0
    prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, 239816, 0x2 /* PIDTYPE_PGID */, NULL) = 0
    clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f271f875890) = 239821
    [pid 239821] setsid()                   = ?
    [pid 239821] +++ killed by SIGKILL +++
    --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_KILLED, si_pid=239821, si_uid=0, si_status=SIGKILL, si_utime=0, si_stime=0} ---
    Iteration 1 status: 0x9
    prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, 239816, 0x2 /* PIDTYPE_PGID */, NULL) = 0
    +++ exited with 0 +++

kmsg indicates that a NULL pointer dereference has occurred:

    [76195.611570] BUG: kernel NULL pointer dereference, address: 0000000000000000
    ...
    [76195.621771] RIP: 0010:do_raw_spin_trylock+0x5/0x40
    ...
    [76195.640144] Call Trace:
    [76195.640706]  _raw_spin_lock_nested+0x37/0x80
    [76195.641645]  ? raw_spin_rq_lock_nested+0x4b/0x80
    [76195.642693]  raw_spin_rq_lock_nested+0x4b/0x80
    [76195.643669]  online_fair_sched_group+0x39/0x240
    [76195.644663]  sched_autogroup_create_attach+0x9d/0x170
    [76195.645765]  ksys_setsid+0xe6/0x110
    [76195.646533]  __do_sys_setsid+0xa/0x10
    [76195.647358]  do_syscall_64+0x3b/0x90
    [76195.648219]  entry_SYSCALL_64_after_hwframe+0x44/0xae

The full kmsg excerpt and the reproducer code are attached.

There's also additional "BUG: sleeping function called from invalid
context at include/linux/percpu-rwsem.h:49" message is produced (see the
full log in the attached file "prctl-sched-core-oops-bug-dmesg.log")
when the full test case[1] is run, but I haven't been successful
so far in producing a minimal reproduced for it.

[1] https://github.com/strace/strace/commit/a90a5a56d2b76ba3ebd417472a02f40d3d6599d8
    Run with `./bootstrap && ./configure CFLAGS='-g -Og' --enable-gcc-Werror &&
    make check TESTS=prctl-sched-core--pidns-translation.gen`

--k1lZvvs/B4yU6o8G
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="prctl-sched-core-oops-repro.c"

#include <stdio.h>
#include <linux/prctl.h>
#include <sys/prctl.h>
#include <sys/wait.h>
#include <unistd.h>

int main()
{
	int pid;
	int pgid = getpgid(0);

	for (size_t i = 0; i < 2; i++) {
		if ((pid = fork())) {
			int status;

			wait(&status);
			printf("Iteration %d status: %#x\n", i, status);
		} else {
			setsid();

			return 0;
		}

		prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pgid, 0x2 /* PIDTYPE_PGID */, NULL);
	}

	return 0;
}


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="prctl-sched-core-oops-dmesg.log"

[76195.611570] BUG: kernel NULL pointer dereference, address: 0000000000000000
[76195.613059] #PF: supervisor read access in kernel mode
[76195.614174] #PF: error_code(0x0000) - not-present page
[76195.615329] PGD 800000005f27e067 P4D 800000005f27e067 PUD 3f7a3067 PMD 0 
[76195.616801] Oops: 0000 [#67] SMP PTI
[76195.617586] CPU: 2 PID: 239821 Comm: prctl-sched-cor Tainted: G      D W        --------- ---  5.14.0-0.rc5.20210813gitf8e6dfc64f61.46.fc36.x86_64 #1
[76195.620374] Hardware name: HP ProLiant BL480c G1, BIOS I14 10/04/2007
[76195.621771] RIP: 0010:do_raw_spin_trylock+0x5/0x40
[76195.622821] Code: c6 a4 12 5f 9f 48 89 ef e8 c8 fe ff ff eb a9 89 c6 48 89 ef e8 0c f5 ff ff 66 90 eb a9 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <8b> 07 85 c0 75 28 ba 01 00 00 00 f0 0f b1 17 75 1d 65 8b 05 fb 98
[76195.626797] RSP: 0018:ffffa366014abe58 EFLAGS: 00010086
[76195.627936] RAX: 0000000000000001 RBX: 0000000000000004 RCX: 0000000000000000
[76195.629470] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[76195.631048] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[76195.632585] R10: 0000000000000000 R11: ffff98292b21ad48 R12: 0000000000000018
[76195.634078] R13: 0000000000000000 R14: ffff98292b7ef940 R15: ffff982813938e00
[76195.635621] FS:  00007f271f8755c0(0000) GS:ffff98292b200000(0000) knlGS:0000000000000000
[76195.637354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[76195.638606] CR2: 0000000000000000 CR3: 000000000fdd0000 CR4: 00000000000006e0
[76195.640144] Call Trace:
[76195.640706]  _raw_spin_lock_nested+0x37/0x80
[76195.641645]  ? raw_spin_rq_lock_nested+0x4b/0x80
[76195.642693]  raw_spin_rq_lock_nested+0x4b/0x80
[76195.643669]  online_fair_sched_group+0x39/0x240
[76195.644663]  sched_autogroup_create_attach+0x9d/0x170
[76195.645765]  ksys_setsid+0xe6/0x110
[76195.646533]  __do_sys_setsid+0xa/0x10
[76195.647358]  do_syscall_64+0x3b/0x90
[76195.648219]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[76195.649401] RIP: 0033:0x7f271f7496cb
[76195.650241] Code: 73 01 c3 48 8b 0d 5d a7 11 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 70 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2d a7 11 00 f7 d8 64 89 01 48
[76195.654522] RSP: 002b:00007ffed2ea9888 EFLAGS: 00000206 ORIG_RAX: 0000000000000070
[76195.656275] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f271f7496cb
[76195.657934] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
[76195.659566] RBP: 00007ffed2ea98b0 R08: 0000000000000000 R09: 00007f271f8755c0
[76195.661227] R10: 00007f271f67ca60 R11: 0000000000000206 R12: 00007ffed2ea99e8
[76195.662869] R13: 0000000000401176 R14: 00007f271f8adc00 R15: 0000000000403e18
[76195.664510] Modules linked in: rfkill iTCO_wdt intel_pmc_bxt iTCO_vendor_support kvm_intel gpio_ich kvm snd_pcsp snd_pcm snd_timer ipmi_ssif irqbypass snd soundcore lpc_ich acpi_ipmi e1000e tg3 hpilo ipmi_si bnx2 i5000_edac ipmi_devintf i5k_amb ipmi_msghandler fuse zram ip_tables xfs radeon i2c_algo_bit drm_ttm_helper ttm drm_kms_helper cec drm hpsa serio_raw hpwdt scsi_transport_sas
[76195.672185] CR2: 0000000000000000
[76195.672973] ---[ end trace ab4b5b9489802ac5 ]---
[76195.674050] RIP: 0010:__lock_acquire+0x5c1/0x1e00
[76195.675146] Code: 00 00 83 f8 2f 0f 87 59 05 00 00 3b 05 cc 46 f6 02 41 bd 01 00 00 00 0f 86 03 01 00 00 89 05 ba 46 f6 02 e9 f8 00 00 00 31 c9 <48> 81 3f 20 8e cc a0 41 0f 45 c8 83 fe 01 0f 87 6f fa ff ff 89 f0
[76195.679386] RSP: 0018:ffffa36602d5fd40 EFLAGS: 00010046
[76195.680606] RAX: 0000000000000046 RBX: 0000000000000001 RCX: 0000000000000000
[76195.682239] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000018
[76195.683881] RBP: 0000000000000018 R08: 0000000000000001 R09: 0000000000000001
[76195.685554] R10: 0000000000000001 R11: 0000000000000000 R12: ffff98285fad33c0
[76195.687197] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[76195.688840] FS:  00007f271f8755c0(0000) GS:ffff98292b200000(0000) knlGS:0000000000000000
[76195.690690] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[76195.692034] CR2: 0000000000000000 CR3: 000000000fdd0000 CR4: 00000000000006e0
[76195.693677] note: prctl-sched-cor[239821] exited with preempt_count 2

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="prctl-sched-core-oops-bug-dmesg.log"

[31148.057893] BUG: kernel NULL pointer dereference, address: 0000000000000000
[31148.059390] #PF: supervisor read access in kernel mode
[31148.060530] #PF: error_code(0x0000) - not-present page
[31148.061601] PGD 800000005f693067 P4D 800000005f693067 PUD 114fe067 PMD 0 
[31148.063082] Oops: 0000 [#21] SMP PTI
[31148.063880] CPU: 0 PID: 214019 Comm: prctl-sched-cor Tainted: G      D W        --------- ---  5.14.0-0.rc5.20210813gitf8e6dfc64f61.46.fc36.x86_64 #1
[31148.067019] Hardware name: HP ProLiant BL480c G1, BIOS I14 10/04/2007
[31148.068536] RIP: 0010:do_raw_spin_trylock+0x5/0x40
[31148.069629] Code: c6 a4 12 5f 9f 48 89 ef e8 c8 fe ff ff eb a9 89 c6 48 89 ef e8 0c f5 ff ff 66 90 eb a9 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <8b> 07 85 c0 75 28 ba 01 00 00 00 f0 0f b1 17 75 1d 65 8b 05 fb 98
[31148.073601] RSP: 0018:ffffa366030ffe58 EFLAGS: 00010086
[31148.074740] RAX: 0000000000000001 RBX: 0000000000000004 RCX: 0000000000000000
[31148.076235] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[31148.077770] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[31148.079264] R10: 0000000000000000 R11: 000000000121ee36 R12: 0000000000000018
[31148.080752] R13: 0000000000000000 R14: ffff98292b7ef940 R15: ffff98280d75da00
[31148.082295] FS:  00007f1aefadc600(0000) GS:ffff98292ae00000(0000) knlGS:0000000000000000
[31148.084029] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[31148.085282] CR2: 0000000000000000 CR3: 00000000013be000 CR4: 00000000000006f0
[31148.086770] Call Trace:
[31148.087286]  _raw_spin_lock_nested+0x37/0x80
[31148.088212]  ? raw_spin_rq_lock_nested+0x4b/0x80
[31148.089180]  raw_spin_rq_lock_nested+0x4b/0x80
[31148.090189]  online_fair_sched_group+0x39/0x240
[31148.091185]  sched_autogroup_create_attach+0x9d/0x170
[31148.092310]  ksys_setsid+0xe6/0x110
[31148.093073]  __do_sys_setsid+0xa/0x10
[31148.093881]  do_syscall_64+0x3b/0x90
[31148.094678]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[31148.095783] RIP: 0033:0x7f1aef9b06cb
[31148.096579] Code: 73 01 c3 48 8b 0d 5d a7 11 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 70 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2d a7 11 00 f7 d8 64 89 01 48
[31148.100758] RSP: 002b:00007fff4b7eef78 EFLAGS: 00000206 ORIG_RAX: 0000000000000070
[31148.102535] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1aef9b06cb
[31148.104188] RDX: 0000000000000010 RSI: 0000000000406230 RDI: 0000000000000003
[31148.105859] RBP: 00000000ffffffff R08: 0000000000000000 R09: 00007f1aefadc600
[31148.107523] R10: 00007f1aef8e3a60 R11: 0000000000000206 R12: 0000000000000001
[31148.109155] R13: 0000000000401326 R14: 00007f1aefb14c00 R15: 0000000000405e18
[31148.110819] Modules linked in: rfkill iTCO_wdt intel_pmc_bxt iTCO_vendor_support kvm_intel gpio_ich kvm snd_pcsp snd_pcm snd_timer ipmi_ssif irqbypass snd soundcore lpc_ich acpi_ipmi e1000e tg3 hpilo ipmi_si bnx2 i5000_edac ipmi_devintf i5k_amb ipmi_msghandler fuse zram ip_tables xfs radeon i2c_algo_bit drm_ttm_helper ttm drm_kms_helper cec drm hpsa serio_raw hpwdt scsi_transport_sas
[31148.118454] CR2: 0000000000000000
[31148.119246] ---[ end trace ab4b5b9489802a97 ]---
[31148.120379] RIP: 0010:__lock_acquire+0x5c1/0x1e00
[31148.121475] Code: 00 00 83 f8 2f 0f 87 59 05 00 00 3b 05 cc 46 f6 02 41 bd 01 00 00 00 0f 86 03 01 00 00 89 05 ba 46 f6 02 e9 f8 00 00 00 31 c9 <48> 81 3f 20 8e cc a0 41 0f 45 c8 83 fe 01 0f 87 6f fa ff ff 89 f0
[31148.125694] RSP: 0018:ffffa36602d5fd40 EFLAGS: 00010046
[31148.126907] RAX: 0000000000000046 RBX: 0000000000000001 RCX: 0000000000000000
[31148.128546] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000018
[31148.130195] RBP: 0000000000000018 R08: 0000000000000001 R09: 0000000000000001
[31148.131853] R10: 0000000000000001 R11: 0000000000000000 R12: ffff98285fad33c0
[31148.133493] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[31148.135168] FS:  00007f1aefadc600(0000) GS:ffff98292ae00000(0000) knlGS:0000000000000000
[31148.137018] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[31148.138352] CR2: 0000000000000000 CR3: 00000000013be000 CR4: 00000000000006f0
[31148.139984] note: prctl-sched-cor[214019] exited with preempt_count 2
[31148.141470] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
[31148.143494] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 214019, name: prctl-sched-cor
[31148.145497] INFO: lockdep is turned off.
[31148.146422] irq event stamp: 0
[31148.147195] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[31148.148640] hardirqs last disabled at (0): [<ffffffff9e0e4e9f>] copy_process+0x7cf/0x1fb0
[31148.150511] softirqs last  enabled at (0): [<ffffffff9e0e4e9f>] copy_process+0x7cf/0x1fb0
[31148.152384] softirqs last disabled at (0): [<0000000000000000>] 0x0
[31148.153825] CPU: 0 PID: 214019 Comm: prctl-sched-cor Tainted: G      D W        --------- ---  5.14.0-0.rc5.20210813gitf8e6dfc64f61.46.fc36.x86_64 #1
[31148.156852] Hardware name: HP ProLiant BL480c G1, BIOS I14 10/04/2007
[31148.158338] Call Trace:
[31148.158945]  dump_stack_lvl+0x57/0x72
[31148.159859]  ___might_sleep.cold+0xb6/0xc6
[31148.160822]  exit_signals+0x1c/0x2d0
[31148.161668]  do_exit+0xbf/0xc10
[31148.162419]  ? ksys_setsid+0xe6/0x110
[31148.163228]  rewind_stack_do_exit+0x17/0x20
[31148.164203] RIP: 0033:0x7f1aef9b06cb
[31148.165043] Code: 73 01 c3 48 8b 0d 5d a7 11 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 70 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2d a7 11 00 f7 d8 64 89 01 48
[31148.169275] RSP: 002b:00007fff4b7eef78 EFLAGS: 00000206 ORIG_RAX: 0000000000000070
[31148.171019] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1aef9b06cb
[31148.172700] RDX: 0000000000000010 RSI: 0000000000406230 RDI: 0000000000000003
[31148.174343] RBP: 00000000ffffffff R08: 0000000000000000 R09: 00007f1aefadc600
[31148.175994] R10: 00007f1aef8e3a60 R11: 0000000000000206 R12: 0000000000000001
[31148.177638] R13: 0000000000401326 R14: 00007f1aefb14c00 R15: 0000000000405e18

--k1lZvvs/B4yU6o8G--

