Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CB44210B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhJDNvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbhJDNvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:51:01 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CD7C07785B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 06:22:25 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id n64so21520401oih.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkwrDD1FJIZ8Krskc1oMA80c8CWWcjOJ+Z5An/Vj078=;
        b=jopFKaAsqdTgdzYrYo2j6REJu8ify07Mn3fwmy17s06lezSkA6jBASBRKy5c7RO1hu
         q+Akda/PQSgQNzvuBIPEdL3pZz/W46fFk8YMa65LqanKt6ysmhisIgyypL/cxwwPlYUX
         pxuNNFuC8D7JaQl1cjl5vbB1H3xKClINTtbFEwFJ/VB/wxP7ELc2bcfyDO7kaDLZSI/H
         /9VvSOdnnhvNCOOWQiyasIBsK4TwWG5hcWbLPGuXamTDOcMpi/qRDo7yBkHxPKCcrBry
         66/AzvGzXQuJyozp5Wsd8I3UwpmpC2V6TN7A3Jz13R4V0XyIS/pvotwQ8SKiQrZrdYSk
         NWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkwrDD1FJIZ8Krskc1oMA80c8CWWcjOJ+Z5An/Vj078=;
        b=MFD8yt45tagrZ7vI07su8o8vFcCcqYr12bGGYjOEqOBifE8zNGOol883mohXTJyHuo
         qAAIJZy94uofjS7hk3AigRsfJsZH/w36F35ySJakZcnzn7gKQMD6N2uFnaKr4dUTcN6e
         Kc5FNVLjevh1UKW6IK2a/KClOSyH09deP7hTMOmudkFjVVUjeKAYSI5ohE5F651PIF3t
         rhcGz2UTpkf6HjVIsAj7BcJ90Tb0EritHaln+ExjxycngbhxFoIRSRbJXisc55uw7gQx
         Tzp29rE05AzzV2y0hCWbfhXFZ4s5TEZGumwTroCofB+q+zo0UbdWqrTuLMeyCfl9RicB
         0tFg==
X-Gm-Message-State: AOAM531j8uAdtXV54KQGDSWAEfPiAVvwp/0QtSFIPQB+W5g2jkQdFnkE
        NQmZYX4kFARnoP5p1If3IoAsIuXlzvl9RXc/Gw3dzg==
X-Google-Smtp-Source: ABdhPJzDHmefCrZMxs9ksdgUx9mHNveffc7D7xxAOoNxDLAgDdSB9XAruvhSVpp9RHhyM7NdKP0QcNVry0G+xtgIn+4=
X-Received: by 2002:aca:f189:: with SMTP id p131mr13557130oih.128.1633353742209;
 Mon, 04 Oct 2021 06:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005a800a05cd849c36@google.com> <CACT4Y+ZRrxmLoor53nkD54sA5PJcRjWqheo262tudjrLO2rXzQ@mail.gmail.com>
 <20211004131516.GV3544071@ziepe.ca>
In-Reply-To: <20211004131516.GV3544071@ziepe.ca>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Oct 2021 15:22:11 +0200
Message-ID: <CACT4Y+bTB3DCGnem7V2ODpwgmiQdGuJae+h93kfniYn1Pr_x2g@mail.gmail.com>
Subject: Re: [syzbot] BUG: RESTRACK detected leak of resources
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        syzbot <syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2021 at 15:15, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Oct 04, 2021 at 02:42:11PM +0200, Dmitry Vyukov wrote:
> > On Mon, 4 Oct 2021 at 12:45, syzbot
> > <syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    c7b4d0e56a1d Add linux-next specific files for 20210930
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=104be6cb300000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c9a1f6685aeb48bd
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3a992c9e4fd9f0e6fd0e
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com
> >
> > +RESTRACK maintainers
> >
> > (it would also be good if RESTRACK would print a more standard oops
> > with stack/filenames, so that testing systems can attribute issues to
> > files/maintainers).
>
> restrack certainly should trigger a WARN_ON to stop the kernel.. But I
> don't know what stack track would be useful here. The culprit is
> always the underlying driver, not the core code..

There seems to be a significant overlap between
drivers/infiniband/core/restrack.c and drivers/infiniband/sw/rxe/rxe.c
maintainers, so perhaps restrack.c is good enough approximation to
extract relevant people (definitely better then no CC at all :))


> Anyhow, this report is either rxe or rds by the look of it.
>
> Jason
