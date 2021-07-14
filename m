Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A27B3C7DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 07:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbhGNFGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 01:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhGNFGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 01:06:40 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36D1C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 22:03:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f30so1430237lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 22:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTuVEphYGt/YG2LcKDrOchB/Dk+EVAhqx0QyLXps/0g=;
        b=gvJh8+vey3w75pjEhgJKeIWuWzOSoTh+5BJZWDgDp5Pd84oWsx0F07RdlKxAhFI/aI
         /x7+weirB+7RD8fbD4TNzuQzewRdIxmaKK68aeo2udfgwtvh2UfBkfpWeVZitBi0z8UY
         Bd8KU/b4BDVfLMD0iaW8/bLUxb/NnIYGeW2B4zasZ83nYiQbwRfS3/GLd5NuQBLO9eio
         9VomgFr6R44kwxNFEKf0VgRPCKHPJVIucee5jox4avHxwczVBDZdvhIupOxSfYe7vtuh
         8AYnBSuufMajZzzjO1WZLwjtZ7xckNJwLMJNHnnR8yiLZuM3XxOGdTn/myAwoWVTNciK
         fTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTuVEphYGt/YG2LcKDrOchB/Dk+EVAhqx0QyLXps/0g=;
        b=q47/rcKE09i8znR0v1vD826vt5uHoVL25l5vC+yqv+bB3NW354+H4TOSElHTgOlGhn
         prJuHBMicd227sufk8MhXZ32GQrCTrW6/SmoGQHZ7VJ9Zvf9XJcsb2padnj9MTT5SOum
         /YhHND+Uy1Gt93WtfA+LCuN1e8zy2uBgESKfjehRR0fVD6AQuz2+McErcMgzs9v1OiHh
         JWbkXqYtMtVJqBQeWI2G22GsLmhrT+b62hmXUiD26ULHX1MWSGv87KNumxVmIkot37b3
         2oN/jHfRrH1wII14zjhbFjgdeBu6q/oAr0aWNKnjqugUJGkfb8uGRnbnHHFH2bMP0FAH
         lovQ==
X-Gm-Message-State: AOAM530LJfs3k/r/QBCHVwmxN56g+LXLtFH7eVv7aEcEFsQaMTdbDqFB
        KSJE8ZIPzc06ws9jLBvJDcvIeu9vqr+vQL1CrsShXw==
X-Google-Smtp-Source: ABdhPJydrOOQhPrApP8nB/aQKjBoFxdhbG4/w3eb3JR2bRClfRoBhBa3ir3YpPTLcBD9ocQsV9JDL6JWxlY7j2bW7As=
X-Received: by 2002:a05:6512:511:: with SMTP id o17mr6651295lfb.396.1626239026149;
 Tue, 13 Jul 2021 22:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210708122447.3880803-1-sumit.garg@linaro.org>
 <CAD=FV=UhL32e7spQjr38Lwng0D7mUK+R7iGnmBah=tXzzXsO5g@mail.gmail.com>
 <CAFA6WYN4gMv9Hkuq=3v_UKg+Y1OvFfbOqgZxt7yGSd2RnVBdJw@mail.gmail.com>
 <CAD=FV=X9w_eY9cSkJLsF57bqL=FQFNcybG+P6tYT5mWTnG3TJA@mail.gmail.com>
 <20210713151032.hvsbufswijxt6uxk@maple.lan> <CAD=FV=Wb_utQLP+U9Nv4=PUTdY49acRG03_Pxk31f4dR3673SQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Wb_utQLP+U9Nv4=PUTdY49acRG03_Pxk31f4dR3673SQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 14 Jul 2021 10:33:33 +0530
Message-ID: <CAFA6WYOMMGxoVg-WezjwAUhPjsu-dfKi=1DY-RDJjyiEA9P7QA@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Get rid of custom debug heap allocator
To:     Doug Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2021 at 20:42, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Jul 13, 2021 at 8:10 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Tue, Jul 13, 2021 at 06:45:52AM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Tue, Jul 13, 2021 at 4:24 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > > >  int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
> > > > > >  {
> > > > > >         int ret = 0;
> > > > > >         unsigned long symbolsize = 0;
> > > > > >         unsigned long offset = 0;
> > > > > > -#define knt1_size 128          /* must be >= kallsyms table size */
> > > > > > -       char *knt1 = NULL;
> > > > > > +       static char namebuf[KSYM_NAME_LEN];
> > > > >
> > > > > I guess this also ends up fixing a bug too, right? My greps show that
> > > > > "KSYM_NAME_LEN" is 512
> > > >
> > > > I can see "KSYM_NAME_LEN" defined as 128 here [1]. Are you looking at
> > > > any other header file?
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kallsyms.h#n18
> > >
> > > Ah ha, it's recent! See commit f2f6175186f4 ("kallsyms: increase
> > > maximum kernel symbol length to 512")
> >
> > Ineed. So recent that I think it hasn't been merged to mainline yet!
> >
> > This patch is part of the rust patch set. IIUC it is in linux-next for
> > wider testing but I'd be surprised if it gets merged to mainline anytime
> > soon (and even more amazed if it is merged without being rebased and
> > given a new hash value ;-) ).
>
> Ah, good point. Yeah, I should have mentioned that I was looking at
> linuxnext. I guess maybe the right compromise is just to mention that
> we'll be more robust in case that other #define changes. ;-)
>

Okay, I will update the commit description accordingly.

-Sumit

> -Doug
