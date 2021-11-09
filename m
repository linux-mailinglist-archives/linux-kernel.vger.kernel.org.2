Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA46C44A739
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 08:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbhKIHDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 02:03:35 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15375 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243408AbhKIHDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 02:03:33 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HpJlf2KCQz90w0
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 15:00:30 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 15:00:43 +0800
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 15:00:43 +0800
Message-ID: <4213090e-2455-7c22-9d19-419d5dce44d1@huawei.com>
Date:   Tue, 9 Nov 2021 15:00:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
From:   "liaoyu (E)" <liaoyu15@huawei.com>
Subject: [Question]: 'WARNING in timer_wait_running'
To:     <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>,
        <liwei391@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Sorry to disturb you. I used syzkaller to find a WARNING in 
timer_wait_running. Get the following Calltrace in syzkaller test.

[  354.327925] ------------[ cut here ]------------
[  354.330364] WARNING: CPU: 0 PID: 1830 at 
kernel/time/posix-timers.c:849 timer_wait_running+0x94/0xa0
[  354.331466] Modules linked in:
[  354.333592] CPU: 0 PID: 1830 Comm: syz-executor.2 Not tainted 
5.10.0-02190-ge9a844e2c44c-dirty #11
[  354.334629] Hardware name: linux,dummy-virt (DT)
[  354.335722] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[  354.336643] pc : timer_wait_running+0x94/0xa0
[  354.337345] lr : timer_wait_running+0x94/0xa0
[  354.337940] sp : ffff800014e53d70
[  354.338504] x29: ffff800014e53d70 x28: ffff0000ce7c8f00
[  354.339675] x27: 0000000000000000 x26: 0000000000000000
[  354.340459] x25: 0000000000000001 x24: ffff800011dc1938
[  354.341269] x23: 0000000000000000 x22: 0000000000000000
[  354.342016] x21: ffff8000116d9ab8 x20: ffff800014e53df0
[  354.342753] x19: ffff0000c9414700 x18: 0000000000000000
[  354.343451] x17: 0000000000000000 x16: 0000000000000000
[  354.344227] x15: 0000000000000000 x14: 0000000000000000
[  354.344828] x13: 0000000000000000 x12: 0000000000000000
[  354.345686] x11: 0000000000000000 x10: 0000000000000000
[  354.346531] x9 : ffff800014e53d70 x8 : 696e6e7572207469
[  354.347116] x7 : 61772072656d6974 x6 : ffff800012eab23f
[  354.347771] x5 : 20c49ba5e353f7cf x4 : 0000000000000000
[  354.348515] x3 : ffff800010000000 x2 : ffff8000116c0000
[  354.349186] x1 : ffff0000ce7c8f00 x0 : 0000000000000000
[  354.350299] Call trace:
[  354.350817]  timer_wait_running+0x94/0xa0
[  354.351343]  __arm64_sys_timer_settime+0x18c/0x210
[  354.351998]  do_el0_svc+0xa4/0x218
[  354.352387]  el0_svc+0x20/0x30
[  354.352750]  el0_sync_handler+0x110/0x170
[  354.353419]  el0_sync+0x140/0x180
[  354.354360] Kernel panic - not syncing: panic_on_warn set ...
[  354.355459] CPU: 0 PID: 1830 Comm: syz-executor.2 Not tainted 
5.10.0-02190-ge9a844e2c44c-dirty #11
[  354.356225] Hardware name: linux,dummy-virt (DT)
[  354.356954] Call trace:
[  354.357523]  dump_backtrace+0x0/0x2c0
[  354.357965]  show_stack+0x30/0x80
[  354.358623]  dump_stack+0x110/0x174
[  354.359052]  panic+0x1d0/0x494+
[  354.359437]  __warn+0x108/0x1a0
[  354.359958]  report_bug+0x18c/0x200
[  354.360505]  bug_handler+0x28/0x80
[  354.360961]  call_break_hook+0xa8/0xf0
[  354.361413]  brk_handler+0x2c/0x80
[  354.361926]  do_debug_exception+0xa4/0x158
[  354.362548]  el1_dbg+0x38/0x50
[  354.362925]  el1_sync_handler+0x88/0x130
[  354.363348]  el1_sync+0x7c/0x100
[  354.363848]  timer_wait_running+0x94/0xa0
[  354.364415]  __arm64_sys_timer_settime+0x18c/0x210
[  354.364940]  do_el0_svc+0xa4/0x218
[  354.365467]  el0_svc+0x20/0x30
[  354.365947]  el0_sync_handler+0x110/0x170
[  354.366428]  el0_sync+0x140/0x180
[  354.367723] SMP: stopping secondary CPUs
[  354.369591] Dumping ftrace buffer:
[  354.370775]    (ftrace buffer empty)
[  354.371883] Kernel Offset: disabled
[  354.372885] CPU features: 0x0240022,61006082
[  354.373598] Memory Limit: none
[  354.375034] Rebooting in 1 seconds..

Syzkaller reproducer is as follows:
timer_create(0x2, &(0x7f00000000c0)={0x0, 0x21, 0x0, @thr={0x0, 0x0}}, 
&(0x7f0000000100))
timer_settime(0x0, 0x1, &(0x7f0000000340)={{0x0, 0x989680}, {0x0, 
0x989680}}, 0x0)

This is what I think. Syz-executor created a timer whose clockid is 
CLOCK_PROCESS_CPUTIME_ID, and glibc changed the clockid to -6 which 
means the created timer's kclock field points to clock_posix_cpu. In 
some cases, posix_cpu_timer_set called by timer_settime returns 
TIMER_RETRY, and then calls timer_wait_running. It leads to warning in 
WARN_ON_ONCE(!kc->timer_wait_running) because the timer_wait_running 
field of clock_posix_cpu is NULL.

I found your patchset: 
https://lore.kernel.org/lkml/156652633800.11667.5499751485130399187.tip-bot2@tip-bot2/.You 
mentioned that "This does not yet cover posix CPU timers because they 
need more special treatment on PREEMPT_RT". Has this been fixed or do we 
have any other alternative solution?

Thanks,
Yu

