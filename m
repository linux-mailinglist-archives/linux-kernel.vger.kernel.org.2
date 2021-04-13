Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6797735E2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhDMPai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245641AbhDMPaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:30:23 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D483C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:30:03 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c6so13013858qtc.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=geviKhSpp//SLXloa5I/OkRgIMxwnyZYsap+HJuZfKg=;
        b=tsaXa40xXjUJ+ECUNLS1Vjb/6gmW5ywwlC727R2j4T55qqe+g90prZhJO7P2tklA/m
         N4QlBn0cR/kXPx0wM/4uprjs1+iSE4GyIEWEpxk5TLLf1EdHwgPSmmYiCPztb7yp5GYk
         O0jbxwMJREceS3jAySaLL/2GxNXik+QxnTGMFNss8endBNMTi5uRyf0SFTdGvi8vni60
         jX17AUHVGuhWUO8h5Dgeqi80A9Gqj9FM50DG5qRc25weODTFH1447/Dqc/RpNv3n4jfX
         20IsOin9wmxRQ9ndNkYVjX9562YUmxHJm9WGkcDZobS/utzwT6RHY0p0gYm9pefsUMik
         vnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=geviKhSpp//SLXloa5I/OkRgIMxwnyZYsap+HJuZfKg=;
        b=rZiZ3MTqEzhLoHHsLHkQ1n2IEwxh2J5H66AQmYZPxZ0Smqo3H6uaUCM3DIWN6L2ETg
         FWsR9Qda7+xyD9+/9IQFDMtgCUnnET+intVT8qHgrhVwhn/iRRWPskBnlchYWuhSC0sF
         htM6YT6J3WXJWnSPgkxy9bQZTv0meFNild9xxGoDOCaVTc5ye/DlZIO846U+1m1bOzmT
         t/8t+FqSv3WSLDQNFBya8hN3B5ktmo7DR89H51HWRUQpdIwhC+WhN8L2idQf/89NOKxF
         vgx32BhY4L2gBjg/b4pcH3c8poip+uFlO8bRQsu7q9iyzM4FUA/bB5qecJByOM+L/T1o
         Iq3Q==
X-Gm-Message-State: AOAM5334sbcXgH0hux740XPmkKsmBtuHmKnYr92jZLIDCegUm9Mkw+bF
        gsbJLKdqowKS8F9Rzaw9NspLu8ldycnArPVhDFQVjYP490Vt7Q==
X-Google-Smtp-Source: ABdhPJwiEWoXK8/V/AEjVuXGaJP3X+oGs+cZzfMgMzr+icjEp/ZsVM8rUzSpB5VrZblxe+Dw1k80rtf/1LFjVfPakGw=
X-Received: by 2002:ac8:768c:: with SMTP id g12mr15536745qtr.67.1618327802617;
 Tue, 13 Apr 2021 08:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR11MB4193DBB0DE4AF424DE235892FF769@BY5PR11MB4193.namprd11.prod.outlook.com>
In-Reply-To: <BY5PR11MB4193DBB0DE4AF424DE235892FF769@BY5PR11MB4193.namprd11.prod.outlook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Apr 2021 17:29:51 +0200
Message-ID: <CACT4Y+bsOhKnv2ikR1fTb7KhReGfEeAyxCOyvCu7iS37Lm0vnw@mail.gmail.com>
Subject: Re: Question on KASAN calltrace record in RT
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 10:26 AM Zhang, Qiang <Qiang.Zhang@windriver.com> wr=
ote:
>
> Hello everyone
>
> In RT system,   after  Andrew test,   found the following calltrace ,
> in KASAN, we record callstack through stack_depot_save(), in this functio=
n, may be call alloc_pages,  but in RT, the spin_lock replace with
> rt_mutex in alloc_pages(), if before call this function, the irq is disab=
led,
> will trigger following calltrace.
>
> maybe  add array[KASAN_STACK_DEPTH] in struct kasan_track to record calls=
tack  in RT system.
>
> Is there a better solution =EF=BC=9F

Hi Qiang,

Adding 2 full stacks per heap object can increase memory usage too much.
The stackdepot has a preallocation mechanism, I would start with
adding interrupts check here:
https://elixir.bootlin.com/linux/v5.12-rc7/source/lib/stackdepot.c#L294
and just not do preallocation in interrupt context. This will solve
the problem, right?


> Thanks
> Qiang
>
> BUG: sleeping function called from invalid context at kernel/locking/rtmu=
tex.c:951
> [   14.522262] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 640=
, name: mount
> [   14.522304] Call Trace:
> [   14.522306]  dump_stack+0x92/0xc1
> [   14.522313]  ___might_sleep.cold.99+0x1b0/0x1ef
> [   14.522319]  rt_spin_lock+0x3e/0xc0
> [   14.522329]  local_lock_acquire+0x52/0x3c0
> [   14.522332]  get_page_from_freelist+0x176c/0x3fd0
> [   14.522543]  __alloc_pages_nodemask+0x28f/0x7f0
> [   14.522559]  stack_depot_save+0x3a1/0x470
> [   14.522564]  kasan_save_stack+0x2f/0x40
> [   14.523575]  kasan_record_aux_stack+0xa3/0xb0
> [   14.523580]  insert_work+0x48/0x340
> [   14.523589]  __queue_work+0x430/0x1280
> [   14.523595]  mod_delayed_work_on+0x98/0xf0
> [   14.523607]  kblockd_mod_delayed_work_on+0x17/0x20
> [   14.523611]  blk_mq_run_hw_queue+0x151/0x2b0
> [   14.523620]  blk_mq_sched_insert_request+0x2ad/0x470
> [   14.523633]  blk_mq_submit_bio+0xd2a/0x2330
> [   14.523675]  submit_bio_noacct+0x8aa/0xfe0
> [   14.523693]  submit_bio+0xf0/0x550
> [   14.523714]  submit_bio_wait+0xfe/0x200
> [   14.523724]  xfs_rw_bdev+0x370/0x480 [xfs]
> [   14.523831]  xlog_do_io+0x155/0x320 [xfs]
> [   14.524032]  xlog_bread+0x23/0xb0 [xfs]
> [   14.524133]  xlog_find_head+0x131/0x8b0 [xfs]
> [   14.524375]  xlog_find_tail+0xc8/0x7b0 [xfs]
> [   14.524828]  xfs_log_mount+0x379/0x660 [xfs]
> [   14.524927]  xfs_mountfs+0xc93/0x1af0 [xfs]
> [   14.525424]  xfs_fs_fill_super+0x923/0x17f0 [xfs]
> [   14.525522]  get_tree_bdev+0x404/0x680
> [   14.525622]  vfs_get_tree+0x89/0x2d0
> [   14.525628]  path_mount+0xeb2/0x19d0
> [   14.525648]  do_mount+0xcb/0xf0
> [   14.525665]  __x64_sys_mount+0x162/0x1b0
> [   14.525670]  do_syscall_64+0x33/0x40
> [   14.525674]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   14.525677] RIP: 0033:0x7fd6c15eaade
