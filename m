Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708BE35EE26
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346993AbhDNHHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhDNHHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:07:50 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67A4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:07:28 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id j7so14746410qtx.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P6hiw8keT+mJ14/6B/ZNNtm4SRsN+Z+zw9UvJ6sbBIE=;
        b=Srj6zP6ShQPr5gpjT0x9UJMnLHH0cORzUpvS4tjX2ZmguGZKxmWXLwBW4kfaxeriCx
         nQAOiJXgfwzofsyKVOzaMt9Uh5cHLExnL+uFhSKGB+XILYWP4HYyUCnn+TBJ95xq09qQ
         uond4boU/uu7efn0DwBLtnc1Cfdfzi7sr+mYgGWXiSQkek5tgxeEmGOfTopDDr8JVwsU
         2GeDt2HWYH1lm6RQnQErP698w0xRZvUutTT2V86qjwnDBC8qllVT+64xxe46vzMqgK1P
         f4jUq1yf/Sjs1gY65sXhTZeB475ymjpBmk2a9v2mjhFc+wRC4ttoZZKavmu4wZo+gq/e
         oO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P6hiw8keT+mJ14/6B/ZNNtm4SRsN+Z+zw9UvJ6sbBIE=;
        b=RLzrqAtG//AI9NfiknxGkhj/jmZXiz+TF9U0uS6dhlvzk+uhobRWLuGMBsqFwZ/1GL
         b1jMeJou3Obha2Oy+p90lxRQZA8XtnIGotX/kqW5YASaqvKIOmMDXh31I93C4c4XFwFQ
         On8BWkKxaZiNqANWat9EOZlqrZaPkwRVmMQUfFiuPz2b8LzSEMsak2hwKmmyql5vwB6+
         /jI10MWH7ChUXamOoRfwElw1WccR5ZcIjCf5xunOA2aGsCdx5ejuoRT0p/2VZzjax7n0
         DWslNTIH+sUUn7v0rVh3y0v07jBRfGv/A2qpP6A2QlWrcEuHa21fF2YVlvH3RGuAceLM
         WQUw==
X-Gm-Message-State: AOAM530MeSKmDv1kCfrNTMMpKei8UOeyE/u/7RXFN2mIcgfiEXIK00xH
        YvrnpviURSLU+lOQAcjrkcFqQGZttKTbx/ivVfLTdw==
X-Google-Smtp-Source: ABdhPJxwsd2CCyqAlud4x9Bsl+7DPGRCAMgfkxeZ28cliway7Jkl7daGOC9QRqag9G+GSci8qG64ox32/4cUGuCx63s=
X-Received: by 2002:ac8:110d:: with SMTP id c13mr33564230qtj.337.1618384047727;
 Wed, 14 Apr 2021 00:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR11MB4193DBB0DE4AF424DE235892FF769@BY5PR11MB4193.namprd11.prod.outlook.com>
 <CACT4Y+bsOhKnv2ikR1fTb7KhReGfEeAyxCOyvCu7iS37Lm0vnw@mail.gmail.com> <DM6PR11MB420213907FE92BF6B6B5EB44FF4E9@DM6PR11MB4202.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB420213907FE92BF6B6B5EB44FF4E9@DM6PR11MB4202.namprd11.prod.outlook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 14 Apr 2021 09:07:16 +0200
Message-ID: <CACT4Y+Z5i+MOc+in9DuFj0b6cyyuHur5fpgu4e9-_6i4Luiygw@mail.gmail.com>
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

On Wed, Apr 14, 2021 at 8:58 AM Zhang, Qiang <Qiang.Zhang@windriver.com> wr=
ote:
> ________________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Dmitry Vyukov <dvyukov@google.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2021=E5=B9=B44=E6=9C=8813=E6=97=A5 =
23:29
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Zhang, Qiang
> =E6=8A=84=E9=80=81: Andrew Halaney; andreyknvl@gmail.com; ryabinin.a.a@gm=
ail.com; akpm@linux-foundation.org; linux-kernel@vger.kernel.org; kasan-dev=
@googlegroups.com
> =E4=B8=BB=E9=A2=98: Re: Question on KASAN calltrace record in RT
>
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
> On Tue, Apr 6, 2021 at 10:26 AM Zhang, Qiang <Qiang.Zhang@windriver.com> =
wrote:
> >
> > Hello everyone
> >
> > In RT system,   after  Andrew test,   found the following calltrace ,
> > in KASAN, we record callstack through stack_depot_save(), in this funct=
ion, may be call alloc_pages,  but in RT, the spin_lock replace with
> > rt_mutex in alloc_pages(), if before call this function, the irq is dis=
abled,
> > will trigger following calltrace.
> >
> > maybe  add array[KASAN_STACK_DEPTH] in struct kasan_track to record cal=
lstack  in RT system.
> >
> > Is there a better solution =EF=BC=9F
>
> >Hi Qiang,
> >
> >Adding 2 full stacks per heap object can increase memory usage too >much=
.
> >The stackdepot has a preallocation mechanism, I would start with
> >adding interrupts check here:
> >https://elixir.bootlin.com/linux/v5.12-rc7/source/lib/stackdepot.c#L294
> >and just not do preallocation in interrupt context. This will solve
> >the problem, right?
>
> It seems to be useful,  however, there are the following situations
> If there is a lot of stack information that needs to be saved in  interru=
pts,  the memory which has been allocated to hold the stack information is =
depletion,   when need to save stack again in interrupts,  there will be no=
 memory available .

Yes, this is true. This also true now because we allocate with
GFP_ATOMIC. This is deliberate design decision.
Note that a unique allocation stack is saved only once, so it's enough
to be lucky only once per stack. Also interrupts don't tend to
allocate thousands of objects. So I think all in all it should work
fine in practice.
If it turns out to be a problem, we could simply preallocate more
memory in RT config.

> Thanks
> Qiang
>
>
> > Thanks
> > Qiang
> >
> > BUG: sleeping function called from invalid context at kernel/locking/rt=
mutex.c:951
> > [   14.522262] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 6=
40, name: mount
> > [   14.522304] Call Trace:
> > [   14.522306]  dump_stack+0x92/0xc1
> > [   14.522313]  ___might_sleep.cold.99+0x1b0/0x1ef
> > [   14.522319]  rt_spin_lock+0x3e/0xc0
> > [   14.522329]  local_lock_acquire+0x52/0x3c0
> > [   14.522332]  get_page_from_freelist+0x176c/0x3fd0
> > [   14.522543]  __alloc_pages_nodemask+0x28f/0x7f0
> > [   14.522559]  stack_depot_save+0x3a1/0x470
> > [   14.522564]  kasan_save_stack+0x2f/0x40
> > [   14.523575]  kasan_record_aux_stack+0xa3/0xb0
> > [   14.523580]  insert_work+0x48/0x340
> > [   14.523589]  __queue_work+0x430/0x1280
> > [   14.523595]  mod_delayed_work_on+0x98/0xf0
> > [   14.523607]  kblockd_mod_delayed_work_on+0x17/0x20
> > [   14.523611]  blk_mq_run_hw_queue+0x151/0x2b0
> > [   14.523620]  blk_mq_sched_insert_request+0x2ad/0x470
> > [   14.523633]  blk_mq_submit_bio+0xd2a/0x2330
> > [   14.523675]  submit_bio_noacct+0x8aa/0xfe0
> > [   14.523693]  submit_bio+0xf0/0x550
> > [   14.523714]  submit_bio_wait+0xfe/0x200
> > [   14.523724]  xfs_rw_bdev+0x370/0x480 [xfs]
> > [   14.523831]  xlog_do_io+0x155/0x320 [xfs]
> > [   14.524032]  xlog_bread+0x23/0xb0 [xfs]
> > [   14.524133]  xlog_find_head+0x131/0x8b0 [xfs]
> > [   14.524375]  xlog_find_tail+0xc8/0x7b0 [xfs]
> > [   14.524828]  xfs_log_mount+0x379/0x660 [xfs]
> > [   14.524927]  xfs_mountfs+0xc93/0x1af0 [xfs]
> > [   14.525424]  xfs_fs_fill_super+0x923/0x17f0 [xfs]
> > [   14.525522]  get_tree_bdev+0x404/0x680
> > [   14.525622]  vfs_get_tree+0x89/0x2d0
> > [   14.525628]  path_mount+0xeb2/0x19d0
> > [   14.525648]  do_mount+0xcb/0xf0
> > [   14.525665]  __x64_sys_mount+0x162/0x1b0
> > [   14.525670]  do_syscall_64+0x33/0x40
> > [   14.525674]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [   14.525677] RIP: 0033:0x7fd6c15eaade
