Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBDF4237E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJFGYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJFGYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:24:44 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6757FC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 23:22:52 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id d18so1777358vsh.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 23:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5M1lKXzCAevCnJXkbf4NwsAbh1QPYVIEAXqtcY9ETg=;
        b=oCY1Pp689eQWCt/Xc4kXq/k85qLk92RhG8x7hO4bd/krN11fjbqwlXr37TCnlzQyXT
         5ft0GGHnWf0kHEh59/id8mns94xfAkoDfLojytqQ1vsKcZ+Fjl1XhSj0KYQjGYpFZ3hc
         su0LbvuWnKYgxxqN5gvln2VOXXKVdDKb4/tGVePY5tRx1Vxs/HkHjzmzf4pQUBjsmmFZ
         m8rwzlEtFlMYEThFtXjL3D+p7ohLjUA4NM/lNH62OoOniddKfeMrZEfFqDoQ+TkNnvPy
         I6qB68VnDTQmZcYExqhBvvTqAj35psztf4rA0NvVYzSHRXXt3Z9vxCSkpnxTwuHFka9U
         pJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5M1lKXzCAevCnJXkbf4NwsAbh1QPYVIEAXqtcY9ETg=;
        b=kWd0L299O8zjcxv1/fDF62F80YVu6/B5l7hgCqYJT7aDNX3R9OM7PlJl7PjPNzye5T
         tq1Lf0NjuufVKtwqrXqVCS4SnUj6VuB4/kbjRZHGG2KWH0jD+jxGZRo89e9xmZQ1Ygof
         rOcMVupqSl1OoZdKL4XbiaQKldRib5YZs0SIE+HVgBNU2M27G7w/PA4ZkPtqeYvWOTua
         8c8zftJ5/qSuBvKl/WzDiAKREzpiky3MLWJKYqdAYYdTLNy7ut6zx5Ku4cJOFaMFP92w
         V2tAn05jgeGSEB8NRL0f6f6XROym67WhYFXS/55lGJ69FUpZwMSM7dfLKt4cdBd9/eJP
         ODEg==
X-Gm-Message-State: AOAM530XyuPXyTok98AqM0P6VbEhsCB+z58HjvwkLQ6DVEKP+v1UXxcl
        sf3dJ5Uf/bGgf8FKyZ0CeKY1aq/K6/oghDyqwDzOtQ==
X-Google-Smtp-Source: ABdhPJytIChJKX4un7eBh4F/t328wWU7GGPwMuL52sxc9V2ea/so1N/4JLZvtFLrzqy09IlECcVQZtaLwwDwc4qI8Ck=
X-Received: by 2002:a67:e916:: with SMTP id c22mr22706728vso.1.1633501371269;
 Tue, 05 Oct 2021 23:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
 <87ee9pa6xw.fsf@disp2133> <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
 <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
 <878rzw77i3.fsf@disp2133> <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
 <20210929173611.fo5traia77o63gpw@example.org> <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
 <20210930130640.wudkpmn3cmah2cjz@example.org> <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com>
 <20211006021219.2010-1-hdanton@sina.com>
In-Reply-To: <20211006021219.2010-1-hdanton@sina.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 6 Oct 2021 00:22:39 -0600
Message-ID: <CAOUHufaaPoTOCML+v8FomeWtN_PncmaHT9d6-XJG8RPzTcFZug@mail.gmail.com>
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
To:     Hillf Danton <hdanton@sina.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "containers\\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 8:12 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, 30 Sep 2021 16:27:34 -0600 Yu Zhao wrote:
> >On Thu, Sep 30, 2021 at 7:06 AM Alexey Gladkov <legion@kernel.org> wrote:
> >>
> >> On Wed, Sep 29, 2021 at 09:39:06PM +0000, Jordan Glover wrote:
> >> > > I'm still investigating, but I would like to rule out one option.
> >> > >
> >> > > Could you check out the patch?
> >> >
> >> >
> >> > Thx, I added it to my kernel and will report in few days.
> >> > Does this patch try to fix the issue or make it easier to track?
> >>
> >> I suspect the error is caused by a race between allow_ucounts() and
> >> put_ucounts(). I think this patch could solve the problem.
> >
> >Thanks for your help. Still can reproduce the problem with the change suggested.
> >
> >[ 7761.885966] ==================================================================
> >[ 7761.893462] BUG: KASAN: use-after-free in dec_ucount+0x50/0xd8
> >[ 7761.899491] Write of size 8 at addr ffffff80c537b140 by task
> >kworker/u16:3/10303
> >[ 7761.907110]
> >[ 7761.908668] CPU: 0 PID: 10303 Comm: kworker/u16:3 Not tainted
> >5.14.0-lockdep+ #1
> >[ 7761.916289] Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
> >[ 7761.923021] Workqueue: netns cleanup_net
> >[ 7761.927106] Call trace:
> >[ 7761.929648]  dump_backtrace+0x0/0x42c
> >[ 7761.933442]  show_stack+0x24/0x30
> >[ 7761.936878]  dump_stack_lvl+0xd0/0x100
> >[ 7761.940763]  print_address_description+0x30/0x304
> >[ 7761.945628]  kasan_report+0x190/0x1d8
> >[ 7761.949418]  kasan_check_range+0x1ac/0x1bc
> >[ 7761.953655]  __kasan_check_write+0x44/0x54
> >[ 7761.957891]  dec_ucount+0x50/0xd8
> >[ 7761.961334]  cleanup_net+0x630/0x718
> >[ 7761.965036]  process_one_work+0x7b4/0x10ec
> >[ 7761.969274]  worker_thread+0x800/0xcf4
> >[ 7761.973152]  kthread+0x2a8/0x358
> >[ 7761.976496]  ret_from_fork+0x10/0x18
> >[ 7761.980201]
> >[ 7761.981761] Allocated by task 4840:
> >[ 7761.985366]  kasan_save_stack+0x38/0x68
> >[ 7761.989342]  __kasan_kmalloc+0x9c/0xb8
> >[ 7761.993222]  kmem_cache_alloc_trace+0x2a4/0x370
> >[ 7761.997905]  alloc_ucounts+0x150/0x374
> >[ 7762.001787]  set_cred_ucounts+0x198/0x248
> >[ 7762.005935]  __sys_setresuid+0x31c/0x4f8
> >[ 7762.009993]  __arm64_sys_setresuid+0x84/0x98
> >[ 7762.014410]  invoke_syscall+0xd4/0x2c8
> >[ 7762.018292]  el0_svc_common+0x124/0x200
> >[ 7762.022265]  do_el0_svc_compat+0x54/0x64
> >[ 7762.026325]  el0_svc_compat+0x24/0x34
> >[ 7762.030124]  el0t_32_sync_handler+0xc0/0xf0
> >[ 7762.034451]  el0t_32_sync+0x19c/0x1a0
> >[ 7762.038241]
> >[ 7762.039799] Freed by task 0:
> >[ 7762.042778]  kasan_save_stack+0x38/0x68
> >[ 7762.046747]  kasan_set_track+0x28/0x3c
> >[ 7762.050625]  kasan_set_free_info+0x28/0x4c
> >[ 7762.054857]  ____kasan_slab_free+0x118/0x164
> >[ 7762.059277]  __kasan_slab_free+0x18/0x28
> >[ 7762.063339]  kfree+0x2f8/0x500
> >[ 7762.066505]  put_ucounts+0x11c/0x134
> >[ 7762.070209]  put_cred_rcu+0x1bc/0x35c
> >[ 7762.074006]  rcu_core+0xa68/0x1b20
> >[ 7762.077538]  rcu_core_si+0x1c/0x28
> >[ 7762.081061]  __do_softirq+0x4bc/0xedc
> >[ 7762.084851]
> >[ 7762.086401] The buggy address belongs to the object at ffffff80c537b100
> >[ 7762.086401]  which belongs to the cache kmalloc-256 of size 256
> >[ 7762.099267] The buggy address is located 64 bytes inside of
> >[ 7762.099267]  256-byte region [ffffff80c537b100, ffffff80c537b200)
> >[ 7762.111248] The buggy address belongs to the page:
> >[ 7762.116185] page:fffffffe0314de00 refcount:1 mapcount:0
> >mapping:0000000000000000 index:0xffffff80c537ad00 pfn:0x145378
> >[ 7762.127180] head:fffffffe0314de00 order:3 compound_mapcount:0
> >compound_pincount:0
> >[ 7762.134881] flags: 0x8000000000010200(slab|head|zone=2)
> >[ 7762.140286] raw: 8000000000010200 fffffffe02799408 fffffffe02020808
> >ffffff808000c980
> >[ 7762.148263] raw: ffffff80c537ad00 0000000000200004 00000001ffffffff
> >0000000000000000
> >[ 7762.156228] page dumped because: kasan: bad access detected
> >[ 7762.161974]
> >[ 7762.163532] Memory state around the buggy address:
> >[ 7762.168475]  ffffff80c537b000: fc fc fc fc fc fc fc fc fc fc fc fc
> >fc fc fc fc
> >[ 7762.175915]  ffffff80c537b080: fc fc fc fc fc fc fc fc fc fc fc fc
> >fc fc fc fc
> >[ 7762.183346] >ffffff80c537b100: fa fb fb fb fb fb fb fb fb fb fb fb
> >fb fb fb fb
> >[ 7762.190774]                                            ^
> >[ 7762.196258]  ffffff80c537b180: fb fb fb fb fb fb fb fb fb fb fb fb
> >fb fb fb fb
> >[ 7762.203689]  ffffff80c537b200: fc fc fc fc fc fc fc fc fc fc fc fc
> >fc fc fc fc
> >[ 7762.211125] ==================================================================
>
> Could you please check if it is due to count underflow? Given nothing wrong
> on the other side based on the efforts
> "We looked through the users of put_ucounts and we don't see any obvious buggy
> users that would be freeing the data structure early."

Thanks, Hillf.

Still can reproduce the problem without triggering the warning.

[ 7965.795189] ==================================================================
[ 7965.802642] BUG: KASAN: use-after-free in dec_ucount+0x50/0xd8
[ 7965.808653] Write of size 8 at addr ffffff8090294920 by task kworker/7:0/7002
[ 7965.815990]
[ 7965.817536] CPU: 7 PID: 7002 Comm: kworker/7:0 Not tainted 5.14.0-lockdep+ #2
[ 7965.824870] Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
[ 7965.831576] Workqueue: events free_user_ns
[ 7965.835810] Call trace:
[ 7965.838338]  dump_backtrace+0x0/0x42c
[ 7965.842119]  show_stack+0x24/0x30
[ 7965.845540]  dump_stack_lvl+0xd0/0x100
[ 7965.849401]  print_address_description+0x30/0x304
[ 7965.854248]  kasan_report+0x190/0x1d8
[ 7965.858016]  kasan_check_range+0x1ac/0x1bc
[ 7965.862236]  __kasan_check_write+0x44/0x54
[ 7965.866463]  dec_ucount+0x50/0xd8
[ 7965.869876]  free_user_ns+0x1b0/0x288
[ 7965.873645]  process_one_work+0x7b4/0x10ec
[ 7965.877871]  worker_thread+0x800/0xcf4
[ 7965.881729]  kthread+0x2a8/0x358
[ 7965.885057]  ret_from_fork+0x10/0x18
[ 7965.888746]
[ 7965.890288] Allocated by task 19167:
[ 7965.893976]  kasan_save_stack+0x38/0x68
[ 7965.897923]  __kasan_kmalloc+0x9c/0xb8
[ 7965.901782]  __kmalloc+0x2c8/0x3c0
[ 7965.905287]  kvmalloc_node+0x64/0x104
[ 7965.909065]  v4l2_ctrl_new+0x478/0xc6c
[ 7965.912923]  v4l2_ctrl_new_std+0x280/0x374
[ 7965.917136]  venc_ctrl_init+0x4c4/0x7c8 [venus_enc]
[ 7965.922170]  venc_open+0x218/0x668 [venus_enc]
[ 7965.926748]  v4l2_open+0x158/0x234
[ 7965.930255]  chrdev_open+0x17c/0x37c
[ 7965.933942]  do_dentry_open+0x504/0xa44
[ 7965.937889]  vfs_open+0x84/0x98
[ 7965.941124]  path_openat+0x1980/0x1fac
[ 7965.944991]  do_filp_open+0x19c/0x2c0
[ 7965.948767]  do_sys_openat2+0xb8/0x298
[ 7965.952628]  do_sys_open+0x124/0x15c
[ 7965.956309]  __arm64_compat_sys_openat+0xa4/0xbc
[ 7965.961060]  invoke_syscall+0xd4/0x2c8
[ 7965.964920]  el0_svc_common+0x124/0x200
[ 7965.968873]  do_el0_svc_compat+0x54/0x64
[ 7965.972915]  el0_svc_compat+0x24/0x34
[ 7965.976688]  el0t_32_sync_handler+0xc0/0xf0
[ 7965.980999]  el0t_32_sync+0x19c/0x1a0
[ 7965.984781]
[ 7965.986330] Last potentially related work creation:
[ 7965.991342]  kasan_save_stack+0x38/0x68
[ 7965.995294]  kasan_record_aux_stack+0xdc/0x108
[ 7965.999866]  insert_work+0x60/0x22c
[ 7966.003458]  __queue_work+0xae8/0xe74
[ 7966.007223]  queue_work_on+0x100/0x148
[ 7966.011076]  drm_atomic_helper_commit+0x18c/0x1f4
[ 7966.015917]  drm_atomic_nonblocking_commit+0xc4/0xdc
[ 7966.021018]  drm_mode_atomic_ioctl+0x89c/0xaa0
[ 7966.025590]  drm_ioctl_kernel+0x15c/0x260
[ 7966.029720]  drm_ioctl+0x460/0x828
[ 7966.033229]  drm_compat_ioctl+0x1bc/0x230
[ 7966.037370]  __arm64_compat_sys_ioctl+0x1b0/0x1c4
[ 7966.042216]  invoke_syscall+0xd4/0x2c8
[ 7966.046071]  el0_svc_common+0x124/0x200
[ 7966.050015]  do_el0_svc_compat+0x54/0x64
[ 7966.054053]  el0_svc_compat+0x24/0x34
[ 7966.057819]  el0t_32_sync_handler+0xc0/0xf0
[ 7966.062119]  el0t_32_sync+0x19c/0x1a0
[ 7966.065884]
[ 7966.067424] Second to last potentially related work creation:
[ 7966.073329]  kasan_save_stack+0x38/0x68
[ 7966.077271]  kasan_record_aux_stack+0xdc/0x108
[ 7966.081837]  insert_work+0x60/0x22c
[ 7966.085434]  __queue_work+0xae8/0xe74
[ 7966.089202]  queue_work_on+0x100/0x148
[ 7966.093060]  drm_atomic_helper_commit+0x18c/0x1f4
[ 7966.097900]  drm_atomic_nonblocking_commit+0xc4/0xdc
[ 7966.103000]  drm_mode_atomic_ioctl+0x89c/0xaa0
[ 7966.107572]  drm_ioctl_kernel+0x15c/0x260
[ 7966.111697]  drm_ioctl+0x460/0x828
[ 7966.115200]  drm_compat_ioctl+0x1bc/0x230
[ 7966.119323]  __arm64_compat_sys_ioctl+0x1b0/0x1c4
[ 7966.124161]  invoke_syscall+0xd4/0x2c8
[ 7966.128016]  el0_svc_common+0x124/0x200
[ 7966.131962]  do_el0_svc_compat+0x54/0x64
[ 7966.135993]  el0_svc_compat+0x24/0x34
[ 7966.139762]  el0t_32_sync_handler+0xc0/0xf0
[ 7966.144067]  el0t_32_sync+0x19c/0x1a0
[ 7966.147837]
[ 7966.149374] The buggy address belongs to the object at ffffff8090294900
[ 7966.149374]  which belongs to the cache kmalloc-256 of size 256
[ 7966.162218] The buggy address is located 32 bytes inside of
[ 7966.162218]  256-byte region [ffffff8090294900, ffffff8090294a00)
[ 7966.174174] The buggy address belongs to the page:
[ 7966.179101] page:fffffffe0240a400 refcount:1 mapcount:0
mapping:0000000000000000 index:0xffffff8090294900 pfn:0x110290
[ 7966.190079] head:fffffffe0240a400 order:3 compound_mapcount:0
compound_pincount:0
[ 7966.197760] flags: 0x8000000000010200(slab|head|zone=2)
[ 7966.203137] raw: 8000000000010200 fffffffe002f3c08 fffffffe023f9008
ffffff808000c980
[ 7966.211086] raw: ffffff8090294900 0000000000200005 00000001ffffffff
0000000000000000
[ 7966.219034] page dumped because: kasan: bad access detected
[ 7966.224763]
[ 7966.226300] Memory state around the buggy address:
[ 7966.231228]  ffffff8090294800: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 7966.238641]  ffffff8090294880: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 7966.246055] >ffffff8090294900: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 7966.253466]                                ^
[ 7966.257849]  ffffff8090294980: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 7966.265267]  ffffff8090294a00: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 7966.272678] ==================================================================
