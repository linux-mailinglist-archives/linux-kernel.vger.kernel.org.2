Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1440DDC6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhIPPTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhIPPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:19:00 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36D2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:17:39 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so8769651otf.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBnm1KnUuxtdGKyRhrgjabbAZKUXf06dsPW76/EUyyY=;
        b=ryTAILdz68SeBnV2MBGf+pL5CIn3Ex9mqX2WODAPIOkjrY/AWOOe+FhRrP52sZWquP
         DhnrQl2k6vIeYtkHPfWgC8fe90GIpbwnBkXa6jbftxNW+UgmjwUmLY9TMJZjTYAvcWOt
         WSP/RhKcDKvgorgUUKoLQU+8folRyPOyIUnuzrszKexzFU4CXKl6NP3bkyEu052Sjc1I
         A5QMIZZdaldNo+j9smdX/wW+kzwwP1Z9nkFjZVGgFsd0wkuuegs4YdL98SHoSs8lCWu9
         HGIlYkVz6+64QMXZx42H3oXJAdR1JK3UQ2XGOj6sSo1NnmuRNMRrV4R1drNzxCezO+6F
         8h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBnm1KnUuxtdGKyRhrgjabbAZKUXf06dsPW76/EUyyY=;
        b=yvqJ1qHXe+s6JvVW1CtphUSBCgf6tyu7FPtI3U4VumhfQy+aOxdbA7LwdgWWvk6EEP
         +iymsX3f8+YjlTV5woi4Ux9eUuw+363KOrvKv25a6TlS049ih3vUHMQJ7stpYzLX/3RC
         14F9UBb1vEsxdYkcFMRU+Efp3Jyj5jlkCZJZZ21dwa7D9vGVUvKeogawh5ttuUzYJnCr
         mkWaGqkmEv4Y8HherbrMUYbaHFQLITaZplsynISjSNgdJvWcfJw31LUsMjL980exKgon
         hQGJ2xXLVGy/VLmJJXX6jFMCiMm22auwO1QWhsXr9AUwrADH2k8ce6pX5C3vnJ5NjQCI
         Qc2g==
X-Gm-Message-State: AOAM533qNAoPL6QDXp+dBqmnph8lBl4NCL070fWx7nJ286lND68Ysxc3
        sr1xZd+TxdBTndaQMDT9Pcfn55bFc1s3+1SAE48zKA==
X-Google-Smtp-Source: ABdhPJyu2fcPZf9f1J1IWu4N2nRRbfaeE+o0ynvcode8xsPWpsEgNskqC469m+MUdhJG2CImcmWnipIkaw+N/APy5Qk=
X-Received: by 2002:a05:6830:34b:: with SMTP id h11mr5211766ote.319.1631805459058;
 Thu, 16 Sep 2021 08:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ffdae005cc08037e@google.com> <20210915193601.GI3544071@ziepe.ca>
 <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com>
 <20210916130459.GJ3544071@ziepe.ca> <CACT4Y+aUFbj3_+iBpeP2qrQ=RbGrssr0-6EZv1nx73at7fdbfA@mail.gmail.com>
 <CACT4Y+ZrQL3n=N2GOfJ6vLNW2_4MdiwywXvZpQ=as_NbJ8PXjw@mail.gmail.com>
 <CACT4Y+ZrXft1cMg0X48TrvbLj0moCb5nyWs1HG0WAZkpKmiBaA@mail.gmail.com> <20210916150850.GN3544071@ziepe.ca>
In-Reply-To: <20210916150850.GN3544071@ziepe.ca>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Sep 2021 17:17:27 +0200
Message-ID: <CACT4Y+bSb8ck4C-Uc2E-2xP=W_r-2i3KUSnqfHr=Z7GB46+CAg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sept 2021 at 17:08, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Sep 16, 2021 at 04:55:16PM +0200, Dmitry Vyukov wrote:
>
> > > I noticed we also had 2 KCSAN reports that mention rdma_resolve_addr.
> > >
> > > On commit 1df0d896:
> > > ==================================================================
> > > BUG: KCSAN: data-race in addr_handler / cma_check_port
> > >
> > > write to 0xffff88809fa40a1c of 4 bytes by task 21 on cpu 1:
> > >  cma_comp_exch drivers/infiniband/core/cma.c:426 [inline]
> > >  addr_handler+0x9f/0x2b0 drivers/infiniband/core/cma.c:3141
> > >  process_one_req+0x22f/0x300 drivers/infiniband/core/addr.c:645
> > >  process_one_work+0x3e1/0x9a0 kernel/workqueue.c:2269
> > >  worker_thread+0x665/0xbe0 kernel/workqueue.c:2415
> > >  kthread+0x20d/0x230 kernel/kthread.c:291
> > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
> > >
> > > read to 0xffff88809fa40a1c of 4 bytes by task 11997 on cpu 0:
> > >  cma_check_port+0xbd/0x700 drivers/infiniband/core/cma.c:3506
>
> This has since been fixed, cma_check_port() no longer reads state
>
> > > and on commit 5863cc79:
>
> I can't find this commit? Current rdma_resolve_addr should not trigger
> this KCSAN.
>
> > This does not immediately explain the use-after-free for me, but these
> > races suggest that everything is not protected by a single mutex and
> > that there may be some surprising interleavings.
> > E.g. rdma_resolve_addr checks status, and then conditionally executes
> > cma_bind_addr, but the status can change concurrently.
>
> It is true, they weren't, however I've fixed them all. These hits look
> like they all from before it got fixed up..

Then sorry for false leads.
The second commit was from https://github.com/google/ktsan.git kcsan
branch. I am not sure if it's still present or was rebased. But either
way it's even older than the first report on upstream (we used ktsan
tree before switched to upstream).
