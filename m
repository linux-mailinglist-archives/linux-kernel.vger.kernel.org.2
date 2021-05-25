Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0372D38FEEE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhEYKVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhEYKVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:21:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D9176128D;
        Tue, 25 May 2021 10:19:48 +0000 (UTC)
Date:   Tue, 25 May 2021 12:19:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Cedric Le Goater <clg@fr.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>, stable@kernel.org
Subject: Re: [PATCH] pid: take a reference when initializing `cad_pid`
Message-ID: <20210525101945.aadtqagjy4zy3imi@wittgenstein>
References: <20210524172230.38715-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210524172230.38715-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 06:22:30PM +0100, Mark Rutland wrote:
> During boot, kernel_init_freeable() initializes `cad_pid` to the init
> task's struct pid. Later on, we may change `cad_pid` via a sysctl, and
> when this happens proc_do_cad_pid() will increment the refcount on the
> new pid via get_pid(), and will decrement the refcount on the old pid
> via put_pid(). As we never called get_pid() when we initialized
> `cad_pid`, we decrement a reference we never incremented, can therefore
> free the init task's struct pid early. As there can be dangling
> references to the struct pid, we can later encounter a use-after-free
> (e.g. when delivering signals).
> 
> This was spotted when fuzzing v5.13-rc3 with Syzkaller, but seems to
> have been around since the conversion of `cad_pid` to struct pid in
> commit:
> 
>   9ec52099e4b8678a ("[PATCH] replace cad_pid by a struct pid")
> 
> ... from the pre-KASAN stone age of v2.6.19.
> 
> Fix this by getting a reference to the init task's struct pid when we
> assign it to `cad_pid`.
> 
> Full KASAN splat below.
> 
> ==================================================================
> BUG: KASAN: use-after-free in ns_of_pid include/linux/pid.h:153 [inline]
> BUG: KASAN: use-after-free in task_active_pid_ns+0xc0/0xc8 kernel/pid.c:509
> Read of size 4 at addr ffff23794dda0004 by task syz-executor.0/273
> 
> CPU: 1 PID: 273 Comm: syz-executor.0 Not tainted 5.12.0-00001-g9aef892b2d15 #1
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x0/0x4a8 arch/arm64/kernel/stacktrace.c:105
>  show_stack+0x34/0x48 arch/arm64/kernel/stacktrace.c:191
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x1d4/0x2a0 lib/dump_stack.c:120
>  print_address_description.constprop.11+0x60/0x3a8 mm/kasan/report.c:232
>  __kasan_report mm/kasan/report.c:399 [inline]
>  kasan_report+0x1e8/0x200 mm/kasan/report.c:416
>  __asan_report_load4_noabort+0x30/0x48 mm/kasan/report_generic.c:308
>  ns_of_pid include/linux/pid.h:153 [inline]
>  task_active_pid_ns+0xc0/0xc8 kernel/pid.c:509
>  do_notify_parent+0x308/0xe60 kernel/signal.c:1950
>  exit_notify kernel/exit.c:682 [inline]
>  do_exit+0x2334/0x2bd0 kernel/exit.c:845
>  do_group_exit+0x108/0x2c8 kernel/exit.c:922
>  get_signal+0x4e4/0x2a88 kernel/signal.c:2781
>  do_signal arch/arm64/kernel/signal.c:882 [inline]
>  do_notify_resume+0x300/0x970 arch/arm64/kernel/signal.c:936
>  work_pending+0xc/0x2dc
> 
> Allocated by task 0:
>  kasan_save_stack+0x28/0x58 mm/kasan/common.c:38
>  kasan_set_track mm/kasan/common.c:46 [inline]
>  set_alloc_info mm/kasan/common.c:427 [inline]
>  __kasan_slab_alloc+0x88/0xa8 mm/kasan/common.c:460
>  kasan_slab_alloc include/linux/kasan.h:223 [inline]
>  slab_post_alloc_hook+0x50/0x5c0 mm/slab.h:516
>  slab_alloc_node mm/slub.c:2907 [inline]
>  slab_alloc mm/slub.c:2915 [inline]
>  kmem_cache_alloc+0x1f4/0x4c0 mm/slub.c:2920
>  alloc_pid+0xdc/0xc00 kernel/pid.c:180
>  copy_process+0x2794/0x5e18 kernel/fork.c:2129
>  kernel_clone+0x194/0x13c8 kernel/fork.c:2500
>  kernel_thread+0xd4/0x110 kernel/fork.c:2552
>  rest_init+0x44/0x4a0 init/main.c:687
>  arch_call_rest_init+0x1c/0x28
>  start_kernel+0x520/0x554 init/main.c:1064
>  0x0
> 
> Freed by task 270:
>  kasan_save_stack+0x28/0x58 mm/kasan/common.c:38
>  kasan_set_track+0x28/0x40 mm/kasan/common.c:46
>  kasan_set_free_info+0x28/0x50 mm/kasan/generic.c:357
>  ____kasan_slab_free mm/kasan/common.c:360 [inline]
>  ____kasan_slab_free mm/kasan/common.c:325 [inline]
>  __kasan_slab_free+0xf4/0x148 mm/kasan/common.c:367
>  kasan_slab_free include/linux/kasan.h:199 [inline]
>  slab_free_hook mm/slub.c:1562 [inline]
>  slab_free_freelist_hook+0x98/0x260 mm/slub.c:1600
>  slab_free mm/slub.c:3161 [inline]
>  kmem_cache_free+0x224/0x8e0 mm/slub.c:3177
>  put_pid.part.4+0xe0/0x1a8 kernel/pid.c:114
>  put_pid+0x30/0x48 kernel/pid.c:109
>  proc_do_cad_pid+0x190/0x1b0 kernel/sysctl.c:1401
>  proc_sys_call_handler+0x338/0x4b0 fs/proc/proc_sysctl.c:591
>  proc_sys_write+0x34/0x48 fs/proc/proc_sysctl.c:617
>  call_write_iter include/linux/fs.h:1977 [inline]
>  new_sync_write+0x3ac/0x510 fs/read_write.c:518
>  vfs_write fs/read_write.c:605 [inline]
>  vfs_write+0x9c4/0x1018 fs/read_write.c:585
>  ksys_write+0x124/0x240 fs/read_write.c:658
>  __do_sys_write fs/read_write.c:670 [inline]
>  __se_sys_write fs/read_write.c:667 [inline]
>  __arm64_sys_write+0x78/0xb0 fs/read_write.c:667
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
>  el0_svc_common.constprop.1+0x16c/0x388 arch/arm64/kernel/syscall.c:129
>  do_el0_svc+0xf8/0x150 arch/arm64/kernel/syscall.c:168
>  el0_svc+0x28/0x38 arch/arm64/kernel/entry-common.c:416
>  el0_sync_handler+0x134/0x180 arch/arm64/kernel/entry-common.c:432
>  el0_sync+0x154/0x180 arch/arm64/kernel/entry.S:701
> 
> The buggy address belongs to the object at ffff23794dda0000
>  which belongs to the cache pid of size 224
> The buggy address is located 4 bytes inside of
>  224-byte region [ffff23794dda0000, ffff23794dda00e0)
> The buggy address belongs to the page:
> page:(____ptrval____) refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4dda0
> head:(____ptrval____) order:1 compound_mapcount:0
> flags: 0x3fffc0000010200(slab|head)
> raw: 03fffc0000010200 dead000000000100 dead000000000122 ffff23794d40d080
> raw: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff23794dd9ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff23794dd9ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff23794dda0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffff23794dda0080: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>  ffff23794dda0100: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
> ==================================================================
> 
> Fixes: 9ec52099e4b8678a ("[PATCH] replace cad_pid by a struct pid")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Cedric Le Goater <clg@fr.ibm.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: stable@kernel.org
> ---

Andrew's already picked this up (I'm down with a proper
regular case of a cold right on time for summer.) but fwiw:
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
