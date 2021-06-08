Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC043A0501
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 22:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhFHUPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 16:15:23 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35701 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhFHUPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:15:20 -0400
Received: by mail-wr1-f54.google.com with SMTP id m18so22927873wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZP3aBzUi/5cQACwp3bX0PrMjlyKsunXb6wYJH3vRGbM=;
        b=cVlV7YESKjEz/22UoQ7sPPpRmY0zwU9x4R2c45rMfrxVoRTilcZYD9/doU0lzJw7vl
         zM1m22VE2zKpRyPWehEYCXKtNsYMwgI3rJ22ri1PUgHzshyeswF/8JFbBvnzPHo5oApx
         bgcdDfWy/T9RapCwVfzKHf6vkc1fqwUE0ZdEFpw3h+Ycj8+qF7qiQV42Bkf08GqD2SnX
         tRMzLQIsjCeTwIJhhaVKoDCFDltEpLaA2SH2dajL2qM2w/oo6DfvtYRkXoWMRmL/8wV4
         rMGrlYdDF2d9neM0AQtybapX4ddEOG46Y+/pimE59hDb50Fv/NRhBjBdbCbBD7Kr375V
         EACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZP3aBzUi/5cQACwp3bX0PrMjlyKsunXb6wYJH3vRGbM=;
        b=mR9nngyKKN4Eg/MMhLwqlBY9L7tgzZlp3FUt4K/x9S4131BmRRAduniKdmoFHZDtNs
         DpFMsomDGKQu6UMcn404HkaQY4YYCapd1FVBRyPKdrjDj2vv5a0tlYdaEclyRhBZ0auB
         p5Lvk4jaVmOhf+RlCBd8gl7IANmnLr3JW/wRJ6h0WHgDaA5OSPJOYwK4/qxD/WgSo9+1
         LdTtsRSzH9vkLAKoBvffmXhxf9pf1SwQ0142r0pStJT+U5uHu68lI1uF95wRCOBe5NVp
         xmyAJ0jDUhlXpIPHM+103c5VREabyveCgZf3kUO+hJrd3TW46BzhsIeOLh4GfoMHAX9h
         BvVA==
X-Gm-Message-State: AOAM532gKGVjuiF7LNGN6OC0hJ0hMOYwT5bRNA1AQzNMN7+P7OSRfd00
        ju91dX/a5pobM+kV1hJ7MxM=
X-Google-Smtp-Source: ABdhPJxhnK3pWqjpRD+CzHWOMYvCHvcGoUUvTjbPjVpJpbVfWkc5YZ1Nf5FPZogAkZ7DXAZnYqPSWg==
X-Received: by 2002:a5d:64a4:: with SMTP id m4mr13760986wrp.185.1623183145959;
        Tue, 08 Jun 2021 13:12:25 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id a15sm25599756wrs.63.2021.06.08.13.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 13:12:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: kernel: cpu: resctrl: Fix kernel-doc in pseudo_lock.c
Date:   Tue, 08 Jun 2021 22:12:23 +0200
Message-ID: <1711024.RBxhUqbo4a@linux.local>
In-Reply-To: <017e9a77-d17e-effd-5639-72a06abc4fc3@intel.com>
References: <20210602222326.7765-1-fmdefrancesco@gmail.com> <017e9a77-d17e-effd-5639-72a06abc4fc3@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 8, 2021 1:30:34 AM CEST Reinette Chatre wrote:
> Hi Fabio,
>
Hi Reinette,
> 
> Thank you very much for catching these. I am curious what your goal is
> because when I ran a kernel-doc check on the resctrl area there were
> many more warnings than are not addressed in this patch. Also, while
> this patch claims to fix the kernel-doc in pseudo_lock.c there seems to
> be a few more that are not addressed.
>
Actually this patch was just a preliminary test for checking if my 
contributions to this subsystem would be taken into consideration or 
completely ignored. That is the real reason why I just started with trying to 
fix only a couple of kernel-doc issues in pseudo_lock.c.
> 
> Are you planning to submit more
> patches to do a cleanup of kernel-doc or are these the only ones
> bothering you for some reason?
>
I'd like to submit more cleanup patches of kernel-doc, because I always read 
carefully the kernel-doc above the functions I want to understand. I have a 
long term plan to study the Linux code and try to contribute the better I can. 
I'm into Linux developing since about two months, so I'm a newcomer and I 
still have a lot to learn.
> 
> Could you please fixup the subject to conform to this area:
> "x86/resctrl: Fix kernel-doc in pseudo_lock.c"
> 
Sure. I was inadvertently using the drivers/staging convention I've used for 
the patches I've submitted there.
>
> For this subject to be accurate though it should fix all the kernel-doc
> warnings found in pseudo_lock.c - or if not it would be helpful to
> explain what the criteria for fixes are. I tested this by running:
> $ scripts/kernel-doc -v -none arch/x86/kernel/cpu/resctrl/*
> 
I've just run the above script and I see that there are a lot more warnings 
that I was expecting.

I want to fix as much as I can. Unfortunately I'm pretty sure I won't be able 
to fix them all, just because the inner working and the purpose of some 
functions are a bit obscure to me (at least until I get more knowledge of x86 
architecture - it may take a lot of time because I'm also studying other 
subsystems at the same time).

> On 6/2/2021 3:23 PM, Fabio M. De Francesco wrote:
> > Fixed sparse warnings about the descriptions of some function
> > parameters.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> >   arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> > b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c index 
f6451abddb09..c3629db90570 100644
> > --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> > +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> > @@ -520,7 +520,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
> > 
> >   /**
> >   
> >    * rdtgroup_monitor_in_progress - Test if monitoring in progress
> > 
> > - * @r: resource group being queried
> > + * @rdtgrp: resource group being queried
> > 
> >    *
> >    * Return: 1 if monitor groups have been created for this resource
> >    * group, 0 otherwise.
> > 
> > @@ -1140,6 +1140,8 @@ static int measure_l3_residency(void *_plr)
> > 
> >   /**
> >   
> >    * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked 
region
> > 
> > + * @rdtgrp: resource group to which the pseudo-locked region belongs
> > + * @sel: cache level selector
> 
> This is not correct. A more accurate description could be:
> "select which measurement to perform on pseudo-locked region"
>
Here it is an example of my lack of knowledge/experience. Obviously, I'll 
rewrite it according to your review.

To summarize: as soon as possible I'll submit a v2 patch with the kernel-doc 
fixes that I think I can understand. I am pretty sure that some fixes will not 
be to your standards and that for what regards some others I will not even be 
able to attempt to fix them :(

Thanks you very much for your kind reply,

Fabio
> 
> >    *
> >    * The measurement of latency to access a pseudo-locked region should be
> >    * done from a cpu that is associated with that pseudo-locked region.
> 
> Reinette




