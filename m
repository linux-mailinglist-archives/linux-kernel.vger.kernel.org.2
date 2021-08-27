Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115833FA01B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 21:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhH0TrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 15:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhH0TrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:47:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545C5C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 12:46:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h1so5246729pjs.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 12:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4fMrLdYeOVJ7FAKn+gTvf9DPyxEV4lP24CasHOh+wc=;
        b=MzfjLr+0zXATCfeKfj1gStH2r9/QkLKUuTwu6RXB6FF+pGTbHZMJ+BFncRZImDlMPz
         TAJyaIOa3bmr7oJZGTzsg4MpFCY+biqT7ydsHrVkpgxERshnnhRcoNCV0iZptmm9bIRG
         0kgLS4bmNoJpvCrqSocSeNlYdQEQoqk2yKatY5c8u0u+QPVi5Pkj9yN2HNOO72+x4tTY
         H++KZNGqU9Xe7riDUtun8bDsYCKjoXSKjVwMBPz9uj8QRO7qMuVJzDyOJ6Ql0Scgp2qI
         r+sd3NiWrgCnyC8/yuWqDISY9Rieufxx4HGUgjbk4EnFZVD6wFQ1Tv34UarPHE5AGl6P
         iMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4fMrLdYeOVJ7FAKn+gTvf9DPyxEV4lP24CasHOh+wc=;
        b=jHSfVAXwLvEq99iNyupCpL788bEjyTbr4moVSvVshN4gLVGOBkYOQYP0MflRrsmLWK
         tLQSD0manmtcLU2ctBnuWZ3v3tfpqNX3+ltEP9GhUC/+YZ2hQ+VcgbNVXKRExTr3qDzW
         5+nws0wPUEfv7B9rNwbApNQvd0G0Lo8M3pZJ8nEtaifCLbrmfCdMfgKjURKwB4iirJXx
         BvP6y+r/JFYatYImgyWzG4d4ig9XRWfBRZPgiS3Cczy+hCG8qErG+YxVpimx+4U4qkZs
         szKytBgIzTTrRI0+OB06ijTUWEPJLrx0h+6k4ZyxeRs5whPBsux+lvKK6ebZbUtYDsSi
         SNDQ==
X-Gm-Message-State: AOAM53376B1IoN1WrqkBKlS73uTzda1+0zwO3tXOuWUjFuyrRt7A0nyw
        07YYQA/KPcxA7KepjkLpcBOW9rhTrWB98+fPSHE=
X-Google-Smtp-Source: ABdhPJyhoGQNesFUYfNUjnr0miUtKJi4NCcP9m86s9dOXozx81QaL8eN09mRDUUHlBTmWsoqEFWqTV/mqwxuKiAo2NU=
X-Received: by 2002:a17:90a:520c:: with SMTP id v12mr10155035pjh.105.1630093583921;
 Fri, 27 Aug 2021 12:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGkw+x+B1731SL=afoSKiWwH-n-FA5YJ+WOwYdv8iyFhWk1zA@mail.gmail.com>
 <3634721.RBzQ2xsved@localhost.localdomain> <1742120.GgyQvu0Ciu@localhost.localdomain>
 <CAPGkw+yJ=V0OwFE+uqCeWWS8JbJD=YBE3+Uk-OKpmHRnvSTh+A@mail.gmail.com> <CAPGkw+w-y+iC3dMDLxi8DR3N+jf8roiJ2Vs_-uHxJ=i57eTiUA@mail.gmail.com>
In-Reply-To: <CAPGkw+w-y+iC3dMDLxi8DR3N+jf8roiJ2Vs_-uHxJ=i57eTiUA@mail.gmail.com>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Fri, 27 Aug 2021 21:46:10 +0200
Message-ID: <CAPGkw+zyj4e-m19KdrHpAN_vHksNDy=k_cPPAftSN-hNoph0=w@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I unfortunately forgot to add Greg to this thread. Doing so now. I
apologize for the confusion, if any. This patch was regarding the
staging tree's file android/ashmem.c and declaring the file_operations
struct as const as done elsewhere in the kernel, because there are no
modifications to its fields.

Warm Regards


On Fri, Aug 27, 2021 at 8:38 PM Krish Jain <krishjain02939@gmail.com> wrote:
>
> So what do you think I can do?
>
> Best Regards
>
>
> On Fri, Aug 27, 2021 at 10:50 AM Krish Jain <krishjain02939@gmail.com> wrote:
> >
> > Hi, yes, this is my first time programming at this low level. And yes,
> > I read both docs now. Furthermore the issue is that my current
> > hardware can't handle building the kernel, it barely managed to
> > survive the first build after 2 hours so I don't know how I can. If I
> > change it to static const would it fix the issue and build
> > successfully?  If not what would be the error message, then I can
> > debug. Thanks
> >
> > On Fri, Aug 27, 2021 at 9:48 AM Fabio M. De Francesco
> > <fmdefrancesco@gmail.com> wrote:
> > >
> > > On Friday, August 27, 2021 8:49:30 AM CEST Fabio M. De Francesco wrote:
> > > > On Friday, August 27, 2021 3:59:28 AM CEST Krish Jain wrote:
> > > > >  From: Krish Jain <krishjain02939@gmail.com>
> > > > >
> > > > > Declare the file_operations struct as const as done elsewhere in the
> > > > > kernel, as there are no modifications to its fields.
> > > > >
> > > > > Signed-off-by: Krish Jain <krishjain02939@gmail.com>
> > > > > ---
> > > > > []
> > > > Are you sure that it works? I wouldn't be.
> > > > You didn't build this file. Please build your changes before submitting patches.
> > > >
> > > > Furthermore, please always rebase to the current version of the staging tree.
> > > >
> > > > Finally, please use the class modifier "static" as the first keyword of a declaration/definition
> > > > as it is done everywhere in the kernel (see "grep -rn "static const" drivers/staging/" and
> > > > then switch to "const static" and read the output).
> > >
> > > Please don't misunderstand me: as far as I can see this is your first patch and
> > > (I'm pretty sure I can speak for everyone else about this) you are very welcome
> > > to staging and to kernel hacking :)
> > >
> > > However, before posting further works, you'd better read at least the following
> > > documents:
> > >
> > > https://www.kernel.org/doc/html/latest/process/4.Coding.html
> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> > >
> > > And please don't forget to always CC linux-kernel@vger.kernel.org.
> > >
> > > Have a nice time with kernel hacking.
> > >
> > > Thanks,
> > >
> > > Fabio
> > >
> > >
