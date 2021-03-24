Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8162347B05
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhCXOpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbhCXOoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:44:54 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9842C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:44:53 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id v26so21767261iox.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o6Ne1DOKut/gFcsE+ZWDCYBIkt/suIOC8sMXwNq3Kcs=;
        b=I0PQCZ/7r0cets66AjRQyZf3d5YnT9U5Ge9ga7hrAam+5cdiiHwqh2NdotTfXQVqvM
         RkbX5H8jw+b/TFb/6cwxW8Et2MbX7WERN/4fdcL2nY2/OQdgo9XsT6jEgkp3seoHyF8H
         K2hKQC6lxb5YdoJfACGSf8rqDJoHdS1njc87lR57z0IzfNbYxmZo1BMwy9TNhozQG/ru
         fuubiuPzCh67Ko0ySVuU7aleTYd3iBDFdv/tVYMMiHVKaDgF4YzzDktwjQOhyKT9r7bC
         Y72D+AADEODD8MTPg3T4E/UABQ+4pClmTiQ9D9v1Ypq3Tyyfjqs/mYJ3xW5oCoGiI93t
         3D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o6Ne1DOKut/gFcsE+ZWDCYBIkt/suIOC8sMXwNq3Kcs=;
        b=Pm39jBYLqNUo4JH7k8QCp3FdYCLVygNMwbYn3O3RsEzoM1d8PxeYJsgtF2YaMAZXDe
         cAAXCM6Pnc8a6XNcHcYNfzFP+85l44YrUXfNvx4gEMY1SYRB0vAccyJhHb3p+jx6uMby
         flAnC0SLxdLj+7RUWLvTFKNa0V6hyYYflqsPX3z/xS/6SuLzTAu52JHjeIsGOYFkzTGm
         IlhAHp+0K2kLPkD3GGBqAsf7puimMOPQPYrpDoEIcawtRcIbKqgqR3QNGYdtoG+UQFLo
         zaGAI2GsrvyJRnPKk5IrPPOFUYsH5twEvxDb9X58T4sOaU294x/UKCXMrnu9E6+AWTuC
         nEDw==
X-Gm-Message-State: AOAM5323uILoeinO1q0HgLkiQuU06erVyJWOSQPXNghq+8mdu23JgUvj
        4GlEohBrO4kUFYPco7xbIdQ6w1cQ++8mFTLOcKZjRQ==
X-Google-Smtp-Source: ABdhPJzKkHne3Pc4XmemvT8Tn8Y3vim+fDQ0oO/Qb7eFr0Xq77ggTnSlAEe+xxY9czxZZFU++BqFUZVUE2VO1t/Lniw=
X-Received: by 2002:a02:7419:: with SMTP id o25mr3182025jac.100.1616597093098;
 Wed, 24 Mar 2021 07:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
 <20210308134957.23852-1-youling257@gmail.com> <CAAYoRsXec2eq=t-pSn5TOqNt0G6kfZCKkDuEhCnX5SgL0zgkBg@mail.gmail.com>
 <20210308161548.GA37664@chenyu-desktop> <CAAYoRsVkrHberSgM42dqYjdVwz8vumURJ1_DGeV1R5-=LMdjVA@mail.gmail.com>
 <20210312134114.GA21436@chenyu-desktop> <CAOzgRdYZM53OC-7DwnmKr3WBOAkKmqstvvs36cMVTOQUZ8qrUg@mail.gmail.com>
In-Reply-To: <CAOzgRdYZM53OC-7DwnmKr3WBOAkKmqstvvs36cMVTOQUZ8qrUg@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Wed, 24 Mar 2021 07:44:46 -0700
Message-ID: <CAAYoRsX-WJFEJQVve=fmZqh37uYSX5v5EAFsy=hBRc=V4GCG9g@mail.gmail.com>
Subject: Re: [3/3,v3] tools/power turbostat: Enable accumulate RAPL display
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Christian Kastner <ckk@debian.org>,
        Kurt Garloff <kurt@garloff.de>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Bingsong Si <owen.si@ucloud.cn>, erwanaliasr1@gmail.com,
        Len Brown <lenb@kernel.org>, rjw@rjwysocki.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        youling 257 <youling257@gmail.com>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just resending to previously missed people who should also test this.
(See other e-mail: Re: turbostat: Fix Pkg Power on Zen)

On Sat, Mar 13, 2021 at 5:49 AM youling 257 <youling257@gmail.com> wrote:
>
> test this patch, turbostat can work.
>
> 2021-03-12 21:41 GMT+08:00, Chen Yu <yu.c.chen@intel.com>:
> > Hi Youling, Bas, and Bingsong,
> > On Wed, Mar 10, 2021 at 04:03:31PM -0800, Doug Smythies wrote:
> >> Hi Yu,
> >>
> >> I am just resending your e-mail, adjusting the "To:" list to
> >> include the 3 others that have submitted similar patches.
> >>
> >> ... Doug
> >>
> > Could you please help check if the following combined patch works?
> >
> > Thanks,
> > Chenyu
> >
> >
> > From 00e0622b1b693a5c7dc343aeb3aa51614a9e125e Mon Sep 17 00:00:00 2001
> > From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Date: Fri, 12 Mar 2021 21:27:40 +0800
> > Subject: [PATCH] tools/power/turbostat: Fix turbostat for AMD Zen CPUs
> >
> > It was reported that on Zen+ system turbostat started exiting,
> > which was tracked down to the MSR_PKG_ENERGY_STAT read failing because
> > offset_to_idx wasn't returning a non-negative index.
> >
> > This patch combined the modification from Bingsong Si and
> > Bas Nieuwenhuizen and addd the MSR to the index system as alternative for
> > MSR_PKG_ENERGY_STATUS.
> >
> > Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL
> > display")
> > Reported-by: youling257 <youling257@gmail.com>
> > Co-developed-by: Bingsong Si <owen.si@ucloud.cn>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  tools/power/x86/turbostat/turbostat.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/power/x86/turbostat/turbostat.c
> > b/tools/power/x86/turbostat/turbostat.c
> > index a7c4f0772e53..a7c965734fdf 100644
> > --- a/tools/power/x86/turbostat/turbostat.c
> > +++ b/tools/power/x86/turbostat/turbostat.c
> > @@ -297,7 +297,10 @@ int idx_to_offset(int idx)
> >
> >       switch (idx) {
> >       case IDX_PKG_ENERGY:
> > -             offset = MSR_PKG_ENERGY_STATUS;
> > +             if (do_rapl & RAPL_AMD_F17H)
> > +                     offset = MSR_PKG_ENERGY_STAT;
> > +             else
> > +                     offset = MSR_PKG_ENERGY_STATUS;
> >               break;
> >       case IDX_DRAM_ENERGY:
> >               offset = MSR_DRAM_ENERGY_STATUS;
> > @@ -326,6 +329,7 @@ int offset_to_idx(int offset)
> >
> >       switch (offset) {
> >       case MSR_PKG_ENERGY_STATUS:
> > +     case MSR_PKG_ENERGY_STAT:
> >               idx = IDX_PKG_ENERGY;
> >               break;
> >       case MSR_DRAM_ENERGY_STATUS:
> > @@ -353,7 +357,7 @@ int idx_valid(int idx)
> >  {
> >       switch (idx) {
> >       case IDX_PKG_ENERGY:
> > -             return do_rapl & RAPL_PKG;
> > +             return do_rapl & (RAPL_PKG | RAPL_AMD_F17H);
> >       case IDX_DRAM_ENERGY:
> >               return do_rapl & RAPL_DRAM;
> >       case IDX_PP0_ENERGY:
> > --
> > 2.25.1
> >
> >
