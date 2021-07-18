Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52BF3CC955
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 15:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhGRNbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 09:31:32 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:16732 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhGRNbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 09:31:31 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 16IDSL8j001468
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 22:28:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 16IDSL8j001468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1626614901;
        bh=YHSiAnz6Je5fuj8dGcu+SNF81bL0OsgiFPsyXkM2Yo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IlnBKFaPQijcy8UMi/ddzFZEgDKmjmACLSGegCjRo44y74vt3vRguIRH+aAwGmc8m
         RUd2XCKkzZRljrWjnSZqMJrMC6VVg+wgoVxPph0E5asm1z3GqEU7eNr3/rzGCVaEgE
         sdDqjfHLbQWiBd+qkZ+szW9jy6UIOjEpkQaqBQoPYmGlZy+zVSRbvvRQiCWChXPRmR
         5Z7T/5fIiLK++Na/1eRDKlqdBSoDzzJMPpUiyS9QHfSoTnwo0AhclJZDBaKCVwPK1z
         LYUVMu357hRan+zxZzNVijsqs3qOqdMBwAJOkWn3AwUFhxCCICg821O7FCBhZlvBEz
         brQu6vbwH9Wgw==
X-Nifty-SrcIP: [209.85.216.43]
Received: by mail-pj1-f43.google.com with SMTP id p9so9646072pjl.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 06:28:21 -0700 (PDT)
X-Gm-Message-State: AOAM531yfmNCI/I1yKcwPHzLjS+4FuDfHwefDaQ8Yu12GuB3rmPYGxAC
        hgPWfEtQHOZ2wcf60e70NJNd33L6AeXBZ90ryKQ=
X-Google-Smtp-Source: ABdhPJzACnn+XtZ229M87+xlRA/X1EiKrya+Q+Egd8GXnTniie3jvjteVJ9gFACIaSKiFDtQkKWvTSkbMVSQCtLQZco=
X-Received: by 2002:a17:90b:11d4:: with SMTP id gv20mr23838852pjb.87.1626614900913;
 Sun, 18 Jul 2021 06:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2107120957300.14207@file01.intranet.prod.int.rdu2.redhat.com>
 <YOyGrUvA4LjydcP3@kroah.com> <alpine.LRH.2.02.2107121502380.8445@file01.intranet.prod.int.rdu2.redhat.com>
 <YOyVH3qD9O3qsNUL@kroah.com> <alpine.LRH.2.02.2107121528270.11724@file01.intranet.prod.int.rdu2.redhat.com>
 <87tukzgrkg.fsf@ungleich.ch> <alpine.LRH.2.02.2107130454430.3795@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK7LNAQkZSyNjoxVfrKr2goP7rNB0OAPXS6B-p24=8QjDcYWFA@mail.gmail.com>
In-Reply-To: <CAK7LNAQkZSyNjoxVfrKr2goP7rNB0OAPXS6B-p24=8QjDcYWFA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 18 Jul 2021 22:27:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATTKZgTLqe87t=qBKBcvd+GW9boOQQjSRk_ES4+Lb+eug@mail.gmail.com>
Message-ID: <CAK7LNATTKZgTLqe87t=qBKBcvd+GW9boOQQjSRk_ES4+Lb+eug@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/setlocalversion: fix a bug when LOCALVERSION
 is empty
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 8:54 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Jul 13, 2021 at 5:59 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> >
> > On Mon, 12 Jul 2021, Nico Schottelius wrote:
> >
> > >
> > > Sorry to say, but I am not convinced by the patch.
> > >
> > > While yes, we might have changed the behaviour slightly, reading
> > > something on the line of
> > >
> > > if [ -z ... ]
> > >
> > > is significantly more simple, elegant and easier to maintain, than
> > > a rather atypical special case for setting a variable to empty,
> > > using
> > >
> > > if [ "${LOCALVERSION+set}" != "set" ] ..
> > >
> > > *and* because it is so atypical, adding a long comment for it, too.
> > >
> > > Additonally, -z should be correct if the variable *is* truly empty. I
> > > assume it actually isn't and contains whitespace, which is not the same
> > > as being set and empty.
> > >
> > > Instead of re-adding complexity, could you consider changing the build
> > > flow so that LOCALVERSION is either unset or empty?
> > >
> > > Nico
> >
> > I set LOCALVERSION to an empty string (with "export LOCALVERSION="). This
> > prevented the kernel from adding a "+" sign to the kernel version. Since
> > the commit 042da426f8eb, it no longer works and the kernel adds a "+" sign
> > if LOCALVERSION is set and empty.
> >
> > If you don't like "if [ "${LOCALVERSION+set}" != "set" ]", then please
> > provide some other way how to test if the variable is set.
>
> if [ -z "${LOCALVERSION+set}" ]
>
> is the alternative way I came up with, but
> I am OK with your v3.
>
>
> I will pick it up for -rc2.
>
>

Applied to linux-kbuild.
Thanks.




-- 
Best Regards
Masahiro Yamada
