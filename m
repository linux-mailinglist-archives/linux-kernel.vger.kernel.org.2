Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131B341E3EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 00:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348740AbhI3W3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 18:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348795AbhI3W3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 18:29:30 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE932C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 15:27:46 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id i30so9151701vsj.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7AkoGqsmMf1bcb4xx6vhfRDG4XLnSKyf9SR4cII9+s=;
        b=fm317/U9hpBZKSB4HhiCWCJcVRUHgrYwGAoKoJqtcHiwmTvBvSF003E5vhg9RZq1ed
         9NOz9pX2Et7RctkSQcuX1RdT4pIgs3AYG/RNFbtFLBna+l9NxX2EcRrNSMelU8OOUDLi
         pdIcrRetBb1ebBYInNrqRZYxdR319pMmjWTB2q2NEsM/hg7WCiPGfe+E/bHxKzenAhW2
         RByL+bUANqU/QfYFOb7R+cp+4S5J14QEv2p5G2JNlnuUamS96eEcGonEpUHrvOuIeFEh
         FVKE9/mC5ZPUFocwYdUZo5wGMrPXhJAae4vJ6FQTXYrvSTXp7mX8ERBGPLQFeYLeIMu9
         LvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7AkoGqsmMf1bcb4xx6vhfRDG4XLnSKyf9SR4cII9+s=;
        b=lmiFggFLHFx8EKliMJpH1hUuIRmJ5Y1mK7RYoqW2HxH3CJHMD4A3XP46APSSj9MXLq
         tzcOLC5mUd5fk3aBT8lMy82k7pTJhC7zoHSdCKGDiZWricFmtnHiHiyM58tjNBEpZ4Rw
         pIQBUPPIhsZIrg00aGUvaL6DuT5R2FLwRPaaHWai1c9wxvjpvqMKf1fhy/NoNPNgX+Ln
         pdO7+6zQDkjb1JX6XxCKEzy1IUsvJzehLBtckwDg5dFy8eElXiZAMqQHotyJnPGNx02+
         NI6M5F+75qSBbA3omVDucuw1ipnUjxr6hzJP0wvziTp72R6hNkCqjOuCZGlnJ41bhzB/
         pALg==
X-Gm-Message-State: AOAM5322YZT4XbvGQ2dKCJffG3FS5yw5Jp4VpAoYynukZ/2AqdVcl3RR
        hx0tdBHUeyNTIldeCtbXFf6f9nxodOdVEACzXQ2XzA==
X-Google-Smtp-Source: ABdhPJwb9ziNWxSGsvnmRddHBrdgs4meuDScJlLDVS5skTxyoUn9dzovy2jBf0wmOTp1KR1WdkwU2fgsNNOQVgn1EBY=
X-Received: by 2002:a67:ea83:: with SMTP id f3mr1886378vso.39.1633040865985;
 Thu, 30 Sep 2021 15:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
 <87ee9pa6xw.fsf@disp2133> <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
 <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
 <878rzw77i3.fsf@disp2133> <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
 <20210929173611.fo5traia77o63gpw@example.org> <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
 <20210930130640.wudkpmn3cmah2cjz@example.org>
In-Reply-To: <20210930130640.wudkpmn3cmah2cjz@example.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 30 Sep 2021 16:27:34 -0600
Message-ID: <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com>
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        ebiederm@xmission.com, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, containers@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 7:06 AM Alexey Gladkov <legion@kernel.org> wrote:
>
> On Wed, Sep 29, 2021 at 09:39:06PM +0000, Jordan Glover wrote:
> > > I'm still investigating, but I would like to rule out one option.
> > >
> > > Could you check out the patch?
> >
> >
> > Thx, I added it to my kernel and will report in few days.
> > Does this patch try to fix the issue or make it easier to track?
>
> I suspect the error is caused by a race between allow_ucounts() and
> put_ucounts(). I think this patch could solve the problem.

Thanks for your help. Still can reproduce the problem with the change suggested.

[ 7761.885966] ==================================================================
[ 7761.893462] BUG: KASAN: use-after-free in dec_ucount+0x50/0xd8
[ 7761.899491] Write of size 8 at addr ffffff80c537b140 by task
kworker/u16:3/10303
[ 7761.907110]
[ 7761.908668] CPU: 0 PID: 10303 Comm: kworker/u16:3 Not tainted
5.14.0-lockdep+ #1
[ 7761.916289] Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
[ 7761.923021] Workqueue: netns cleanup_net
[ 7761.927106] Call trace:
[ 7761.929648]  dump_backtrace+0x0/0x42c
[ 7761.933442]  show_stack+0x24/0x30
[ 7761.936878]  dump_stack_lvl+0xd0/0x100
[ 7761.940763]  print_address_description+0x30/0x304
[ 7761.945628]  kasan_report+0x190/0x1d8
[ 7761.949418]  kasan_check_range+0x1ac/0x1bc
[ 7761.953655]  __kasan_check_write+0x44/0x54
[ 7761.957891]  dec_ucount+0x50/0xd8
[ 7761.961334]  cleanup_net+0x630/0x718
[ 7761.965036]  process_one_work+0x7b4/0x10ec
[ 7761.969274]  worker_thread+0x800/0xcf4
[ 7761.973152]  kthread+0x2a8/0x358
[ 7761.976496]  ret_from_fork+0x10/0x18
[ 7761.980201]
[ 7761.981761] Allocated by task 4840:
[ 7761.985366]  kasan_save_stack+0x38/0x68
[ 7761.989342]  __kasan_kmalloc+0x9c/0xb8
[ 7761.993222]  kmem_cache_alloc_trace+0x2a4/0x370
[ 7761.997905]  alloc_ucounts+0x150/0x374
[ 7762.001787]  set_cred_ucounts+0x198/0x248
[ 7762.005935]  __sys_setresuid+0x31c/0x4f8
[ 7762.009993]  __arm64_sys_setresuid+0x84/0x98
[ 7762.014410]  invoke_syscall+0xd4/0x2c8
[ 7762.018292]  el0_svc_common+0x124/0x200
[ 7762.022265]  do_el0_svc_compat+0x54/0x64
[ 7762.026325]  el0_svc_compat+0x24/0x34
[ 7762.030124]  el0t_32_sync_handler+0xc0/0xf0
[ 7762.034451]  el0t_32_sync+0x19c/0x1a0
[ 7762.038241]
[ 7762.039799] Freed by task 0:
[ 7762.042778]  kasan_save_stack+0x38/0x68
[ 7762.046747]  kasan_set_track+0x28/0x3c
[ 7762.050625]  kasan_set_free_info+0x28/0x4c
[ 7762.054857]  ____kasan_slab_free+0x118/0x164
[ 7762.059277]  __kasan_slab_free+0x18/0x28
[ 7762.063339]  kfree+0x2f8/0x500
[ 7762.066505]  put_ucounts+0x11c/0x134
[ 7762.070209]  put_cred_rcu+0x1bc/0x35c
[ 7762.074006]  rcu_core+0xa68/0x1b20
[ 7762.077538]  rcu_core_si+0x1c/0x28
[ 7762.081061]  __do_softirq+0x4bc/0xedc
[ 7762.084851]
[ 7762.086401] The buggy address belongs to the object at ffffff80c537b100
[ 7762.086401]  which belongs to the cache kmalloc-256 of size 256
[ 7762.099267] The buggy address is located 64 bytes inside of
[ 7762.099267]  256-byte region [ffffff80c537b100, ffffff80c537b200)
[ 7762.111248] The buggy address belongs to the page:
[ 7762.116185] page:fffffffe0314de00 refcount:1 mapcount:0
mapping:0000000000000000 index:0xffffff80c537ad00 pfn:0x145378
[ 7762.127180] head:fffffffe0314de00 order:3 compound_mapcount:0
compound_pincount:0
[ 7762.134881] flags: 0x8000000000010200(slab|head|zone=2)
[ 7762.140286] raw: 8000000000010200 fffffffe02799408 fffffffe02020808
ffffff808000c980
[ 7762.148263] raw: ffffff80c537ad00 0000000000200004 00000001ffffffff
0000000000000000
[ 7762.156228] page dumped because: kasan: bad access detected
[ 7762.161974]
[ 7762.163532] Memory state around the buggy address:
[ 7762.168475]  ffffff80c537b000: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 7762.175915]  ffffff80c537b080: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 7762.183346] >ffffff80c537b100: fa fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 7762.190774]                                            ^
[ 7762.196258]  ffffff80c537b180: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 7762.203689]  ffffff80c537b200: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 7762.211125] ==================================================================
