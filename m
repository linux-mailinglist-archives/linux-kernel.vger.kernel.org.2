Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C3240A2D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbhINBth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbhINBte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:49:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18397C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:48:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so1507916pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=69+kLoIWVXd1+fsKO8k+Q0yG2EzPmMcPD2xbGgHYNaY=;
        b=T/VZ0ax/J5NhPE6MFpHXjVaLOrovtwivIS6H5xC++qyglo26vjEPbBsIuJsxDejo5h
         dEnrnsAqG2qeXBMyqo+YMaXh7Gpkaix4i9ocdVmoL3htZpNwksevonG3MucG8LPpEFW6
         NY1myS1Y6VghCK9gPgV8xNNLqGhDFeTOHbDQ5VYHkg3lwfoMTvmqpCR7aeXYSeTNzTJn
         +N88hn82EdXGKGksbdY5FXkNAfvYH83IEwZCGtNhhMjUfXXHXZfBMw6Z1nDlqXlFanLq
         DE9TwQkLrZtCl7Ax4bs5FWqD4k8oCV77ALzyZD8Ef37fMv1yaE299JmsECzA3d/Vzium
         V4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=69+kLoIWVXd1+fsKO8k+Q0yG2EzPmMcPD2xbGgHYNaY=;
        b=WBbPnReH1TsHMvdXdQnmPjGnOvol4m4TFjDPPCHnRdN/Wb0WfLWsboy+HL4NmCaoE4
         O3jeweh/T6x0Fj8uhiK1dIEPomBKLIkKiXG5+t/9/7XsNVlYjtC2U31enhC6K/2vtt5z
         tzBzCnyiHTK5RfFGNk6PTDJV7nwJHZldMeMgg297e8Khp9jwXx2rI4xBJ10L2JgCE4iR
         TLNcDpKKKlskZI8n38Pu01gMlBMLGwjkgqojHadOc2zucc2d43W/cijdKB/3q7Dbkndj
         TcrnUGw8mMbMradMhZBn63uA+gMW9laOkHuTe1lI4RH3hVOoL/0siGk0Fl9vaGlck2qr
         An1Q==
X-Gm-Message-State: AOAM530Ji2xcZ4eQHViLz1z39LJ0SBKxhTpd7dT3TG6Tp9Ho0fc2FAiZ
        oUzxCyh3WZOrf9Lz13+I+dHKzWdz78Ch2WqXBYad2OHY9+An
X-Google-Smtp-Source: ABdhPJztERotIacAflO9sp0wAivjJT7r1hufMxnGvcxA1CWoTkHDfkccxwNku16jAAsIf2L8cKAR74lLDJiFmxYWoPM=
X-Received: by 2002:a17:90b:124c:: with SMTP id gx12mr2751852pjb.106.1631584097387;
 Mon, 13 Sep 2021 18:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsZmvmL8FJbXeY5BkBQ33h1qYPv=15KVaVN3ZATng6_L3g@mail.gmail.com>
In-Reply-To: <CACkBjsZmvmL8FJbXeY5BkBQ33h1qYPv=15KVaVN3ZATng6_L3g@mail.gmail.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 14 Sep 2021 09:48:06 +0800
Message-ID: <CACkBjsZHRvWO2p1kAAnrd0E_ixqK=ScGirNHonOO51AGp1e+xA@mail.gmail.com>
Subject: Re: INFO: task hung in do_read_cache_page
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hao Sun <sunhao.th@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8810:10=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
>
> HEAD commit: 4b93c544e90e-thunderbolt: test: split up test cases
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1maGu7OQMMnheEq18g-XJRrSvPIRLyIae/view?us=
p=3Dsharing
> kernel config: https://drive.google.com/file/d/1c0u2EeRDhRO-ZCxr9MP2VvAtJ=
d6kfg-p/view?usp=3Dsharing
> C reproducer: https://drive.google.com/file/d/1pf2nzNzl2hUxO6EJ1Vp4uqeAmr=
9tG4Pw/view?usp=3Dsharing
> Syzlang reproducer:
> https://drive.google.com/file/d/1CZekMFes8O7FmLULOkxLnovMGWNFtI47/view?us=
p=3Dsharing
> Similar report:
> https://groups.google.com/g/syzkaller-bugs/c/mt4E4qKbC5c/m/m-gbLPjIAgAJ
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>
>

Hi

This crash can still be triggered with the same C reproducer on the
latest kernel.

HEAD commit: 6880fa6c5660 Linux 5.15-rc1
git tree: upstream
kernel config: https://drive.google.com/file/d/1c0u2EeRDhRO-ZCxr9MP2VvAtJd6=
kfg-p/view?usp=3Dsharing

nbd0: detected capacity change from 0 to 18
block nbd0: shutting down sockets
block nbd0: Possible stuck request ffff888018830000: control
(read@0,4096B). Runtime 30 seconds
block nbd0: Possible stuck request ffff888018830000: control
(read@0,4096B). Runtime 60 seconds
block nbd0: Possible stuck request ffff888018830000: control
(read@0,4096B). Runtime 90 seconds
block nbd0: Possible stuck request ffff888018830000: control
(read@0,4096B). Runtime 120 seconds
block nbd0: Possible stuck request ffff888018830000: control
(read@0,4096B). Runtime 150 seconds
INFO: task a.out:6658 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:a.out           state:D stack:27280 pid: 6658 ppid:  6657 flags:0x0000=
4002
Call Trace:
 __schedule+0xcd9/0x2530
 ? firmware_map_remove+0x1a0/0x1a0
 schedule+0xd3/0x270
 schedule_preempt_disabled+0xf/0x20
 __mutex_lock+0xc96/0x1680
 ? blkdev_put+0x98/0x6f0
 ? mutex_lock_io_nested+0x1470/0x1470
 ? do_raw_spin_unlock+0x171/0x260
 ? blkdev_put+0x98/0x6f0
 blkdev_put+0x98/0x6f0
 blkdev_close+0x8d/0xb0
 __fput+0x288/0x9f0
 ? blkdev_fsync+0xd0/0xd0
 task_work_run+0xe0/0x1a0
 do_exit+0xbbe/0x2dd0
 ? preempt_schedule_common+0x5e/0xc0
 ? mm_update_next_owner+0x7a0/0x7a0
 ? preempt_schedule_thunk+0x16/0x18
 do_group_exit+0x125/0x340
 __x64_sys_exit_group+0x3a/0x50
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fe9d6949618
RSP: 002b:00007ffffdd5e678 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe9d6949618
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00007fe9d6c268e0 R08: 00000000000000e7 R09: ffffffffffffff98
R10: 00007fe9d6e48260 R11: 0000000000000246 R12: 00007fe9d6c268e0
R13: 00007fe9d6c2bc20 R14: 0000000000000000 R15: 0000000000000000
INFO: task systemd-udevd:6665 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-udevd   state:D stack:26352 pid: 6665 ppid:  2993 flags:0x0000=
4000
Call Trace:
 __schedule+0xcd9/0x2530
 ? firmware_map_remove+0x1a0/0x1a0
 ? preempt_schedule_common+0x5e/0xc0
 schedule+0xd3/0x270
 io_schedule+0x17/0x70
 wait_on_page_bit_common+0x57c/0xf10
 ? filemap_get_read_batch+0xe50/0xe50
 ? end_buffer_async_write+0x5d0/0x5d0
 ? __filemap_set_wb_err+0x240/0x240
 ? __sanitizer_cov_trace_pc+0x1a/0x40
 ? __page_cache_alloc+0x110/0x3d0
 ? enable_ptr_key_workfn+0x30/0x30
 do_read_cache_page+0x911/0x1440
 read_part_sector+0xfa/0x610
 ? adfspart_check_ADFS+0x830/0x830
 adfspart_check_ICS+0x9d/0xc90
 ? pointer+0x810/0x810
 ? __alloc_pages+0x526/0x6e0
 ? __sanitizer_cov_trace_pc+0x1a/0x40
 ? __vmalloc_node_range+0x4aa/0x940
 ? adfspart_check_ADFS+0x830/0x830
 ? snprintf+0xbb/0xf0
 ? vsprintf+0x30/0x30
 ? __sanitizer_cov_trace_pc+0x1a/0x40
 ? adfspart_check_ADFS+0x830/0x830
 bdev_disk_changed+0x778/0x1140
 blkdev_get_whole+0x206/0x270
 blkdev_get_by_dev+0x456/0x900
 blkdev_open+0x154/0x2b0
 do_dentry_open+0x4c8/0x11d0
 ? blkdev_close+0xb0/0xb0
 path_openat+0x1c99/0x2710
 ? path_lookupat.isra.0+0x580/0x580
 ? lockdep_hardirqs_on_prepare+0x400/0x400
 do_filp_open+0x1c1/0x290
 ? may_open_dev+0xf0/0xf0
 ? do_raw_spin_lock+0x120/0x2d0
 ? rwlock_bug.part.0+0x90/0x90
 ? __phys_addr_symbol+0x2c/0x70
 ? __sanitizer_cov_trace_pc+0x1a/0x40
 ? _find_next_bit+0x1e3/0x260
 ? _raw_spin_unlock+0x24/0x40
 ? alloc_fd+0x4bd/0x660
 do_sys_openat2+0x61b/0x9a0
 ? rcu_read_lock_bh_held+0x14/0xb0
 ? file_open_root+0x430/0x430
 ? seccomp_notify_ioctl+0xdb0/0xdb0
 do_sys_open+0xc3/0x140
 ? filp_open+0x70/0x70
 ? __sanitizer_cov_trace_pc+0x1a/0x40
 ? __secure_computing+0x104/0x360
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8efe051840
RSP: 002b:00007ffef9fe31a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 000055a1992dd370 RCX: 00007f8efe051840
RDX: 000055a197b1afe3 RSI: 00000000000a0800 RDI: 000055a1992d1260
RBP: 00007ffef9fe3320 R08: 000055a197b1a670 R09: 0000000000000010
R10: 00007f8efddcbd70 R11: 0000000000000246 R12: 00007ffef9fe3270
R13: 000055a1992d4c20 R14: 0000000000000003 R15: 000000000000000e

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8b97e9a0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260
1 lock held by in:imklog/6245:
 #0: ffff888107d06370 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x=
100
1 lock held by a.out/6658:
 #0: ffff8880187f2118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x98/=
0x6f0
1 lock held by systemd-udevd/6665:
 #0: ffff8880187f2118 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev+0x3c1/0x900

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 5.15.0-rc1 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 dump_stack_lvl+0xcd/0x134
 nmi_cpu_backtrace.cold+0x47/0x144
 ? lapic_can_unplug_cpu+0x80/0x80
 nmi_trigger_cpumask_backtrace+0x1e1/0x220
 watchdog+0xcc8/0x1010
 ? reset_hung_task_detector+0x30/0x30
 kthread+0x3e5/0x4d0
 ? set_kthread_struct+0x130/0x130
 ret_from_fork+0x1f/0x30
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2986 Comm: systemd-journal Not tainted 5.15.0-rc1 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:do_faccessat+0x2/0x850
Code: 84 00 00 00 25 e3 7f ff ff 0d 00 00 20 00 89 83 84 00 00 00 31
c0 5b c3 e8 2b 99 f5 ff eb df 66 0f 1f 84 00 00 00 00 00 41 57 <41> 56
41 55 41 54 55 89 cd 53 89 d3 48 83 c4 80 41 89 dc 48 8d 44
RSP: 0018:ffffc9000185ff30 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00005560fae709a3 RDI: 00000000ffffff9c
RBP: ffffc9000185ff48 R08: ffffffff81c88ffd R09: 0000000000000000
R10: 0000000000000001 R11: ffffed1003425582 R12: ffffc9000185ff58
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f792748f8c0(0000) GS:ffff888135c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f79247d3000 CR3: 0000000107cde000 CR4: 0000000000350ee0
Call Trace:
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f792674b9c7
Code: 83 c4 08 48 3d 01 f0 ff ff 73 01 c3 48 8b 0d c8 d4 2b 00 f7 d8
64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 15 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d a1 d4 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe4c6ab808 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00007ffe4c6ae720 RCX: 00007f792674b9c7
RDX: 00007f79271bca00 RSI: 0000000000000000 RDI: 00005560fae709a3
RBP: 00007ffe4c6ab840 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000069 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffe4c6ae720 R15: 00007ffe4c6abd30
Kernel panic - not syncing: hung_task: blocked tasks
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 5.15.0-rc1 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 dump_stack_lvl+0xcd/0x134
 panic+0x2b0/0x6dd
 ? print_oops_end_marker.cold+0x15/0x15
 ? lapic_can_unplug_cpu+0x80/0x80
 ? preempt_schedule_thunk+0x16/0x18
 ? watchdog.cold+0x5/0x168
 watchdog.cold+0x16/0x168
 ? reset_hung_task_detector+0x30/0x30
 kthread+0x3e5/0x4d0
 ? set_kthread_struct+0x130/0x130
 ret_from_fork+0x1f/0x30
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..
