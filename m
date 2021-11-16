Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9B34535F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbhKPPmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhKPPmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:42:06 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3359C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:39:08 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso2755203wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8ONwyLBOB69hQK2qwvft0gtEgWs8RDsTXs/OpX4lKrc=;
        b=CWAfOjkZO32JmYYnPX9zVNj77QIM/0a8llJaM5pg0Fj69pGHYNTQTFo/oVyyxkxF0y
         LMVGMMxKiloUBcB2/XcuIZms995u3HLEQ3pnGsJ3zerILce3iU4CeyVl4XoR0paGW/f9
         X/5PhjANneoke2B4TK8HS2ngJWVw+TnUsnHK+k1nnkBeIOndpjb0YyeWrBOpOgFOGuAW
         9FfTuMr9D4l/xAh7VWLh7br3P004qOMMc6JEYlGTni9fBCoAK3bQZsfYzkWcOTgFcqCr
         7FKwVNUgthrP+2KbXsKs1N2wjgCOHeUl2LDcmsrgbNod1srkbFXbWoDFRKpFGfaRNZe+
         DwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8ONwyLBOB69hQK2qwvft0gtEgWs8RDsTXs/OpX4lKrc=;
        b=gdHeie9LVhXHgJGizoyMIDpWFj3s3GJWGW/xssKKDEj1uDsThgWkdEgCR2bhC6btmC
         vFhOTxQBeM/8YbETkuAEjj6iPs1ONnoKmSKZWFcoLGNEdlbqhPvMmmDgZnrjAXltNXBP
         MQbeG9BFFzrBorLvlIhreI5fPDhRs4NZ8kegvaJlHtCLu6WUI1cC4XugKTYQatFCxIMl
         INIjG/FEqxjwub63dTT6zHjIuob5EFenZFgs8K+FasUSEDbhlM4JovLHKVWukyk0/gyx
         F+GmDVC8ytS1kWQmHVNZ36Z3Q2tBAOvfwjgrdsgNPtk85z+xQXh9fGsvSt3ubVY14KlG
         ht9Q==
X-Gm-Message-State: AOAM532vZx+4dXwFjzCEHqW2jxFuDCEmV1/T3QIPj1iNLiT3tkRzyRCN
        MHlhfGSfK6q0aa/u4uVqzFXMew==
X-Google-Smtp-Source: ABdhPJxUtoaK2Rb2DAn6hpFnPt85zPpn1h1ta78pmSUJtewz5tzMcVQTzPIBYXWfga87FZFD3OHLqQ==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr8919919wmc.89.1637077147235;
        Tue, 16 Nov 2021 07:39:07 -0800 (PST)
Received: from google.com ([95.148.6.231])
        by smtp.gmail.com with ESMTPSA id e8sm13847093wrr.26.2021.11.16.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 07:39:06 -0800 (PST)
Date:   Tue, 16 Nov 2021 15:39:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Li, Meng" <Meng.Li@windriver.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: altera-sysmgr: enable raw spinlock feature for
 preempt-rt kernel
Message-ID: <YZPQmDJ1PI+TlG7C@google.com>
References: <20211116105424.12685-1-Meng.Li@windriver.com>
 <CAK8P3a241g2vQrfiEf_YcQ0=t5fhN0R0CrzQE5DK7XQgAGxKYg@mail.gmail.com>
 <PH0PR11MB5191FEE6D75B558D629D517AF1999@PH0PR11MB5191.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB5191FEE6D75B558D629D517AF1999@PH0PR11MB5191.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021, Li, Meng wrote:

> 
> 
> > -----Original Message-----
> > From: Arnd Bergmann <arnd@arndb.de>
> > Sent: Tuesday, November 16, 2021 8:02 PM
> > To: Li, Meng <Meng.Li@windriver.com>
> > Cc: thor.thayer@linux.intel.com; Lee Jones <lee.jones@linaro.org>; Arnd
> > Bergmann <arnd@arndb.de>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>
> > Subject: Re: [PATCH] mfd: altera-sysmgr: enable raw spinlock feature for
> > preempt-rt kernel
> > 
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > 
> > On Tue, Nov 16, 2021 at 11:54 AM Meng Li <Meng.Li@windriver.com> wrote:
> > > diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
> > > index 5d3715a28b28..27271cec5d53 100644
> > > --- a/drivers/mfd/altera-sysmgr.c
> > > +++ b/drivers/mfd/altera-sysmgr.c
> > > @@ -83,6 +83,9 @@ static struct regmap_config altr_sysmgr_regmap_cfg =
> > {
> > >         .fast_io = true,
> > >         .use_single_read = true,
> > >         .use_single_write = true,
> > > +#ifdef CONFIG_PREEMPT_RT
> > > +       .use_raw_spinlock = true,
> > > +#endif
> > 
> > I think you should remove the #ifdef here: if PREEMPT_RT is disabled, the
> > flag has no effect because spinlock behaves the same way as raw_spinlock. If
> > anything else starts requiring the use of raw spinlocks, then we probably
> > want the flag to be set  here as well.
> > 
> 
> Thanks for your suggestion, and I also agree with the spinlock action when PREEMPT_RT is disabled.
> But please allow me to explain why I keep the "ifdef"
> 1. although I send this patch to mainline upstream, I only want to fix this issue in RT kernel.
>     Moreover, the commit 67021f25d952("regmap: teach regmap to use raw spinlocks if requested in the config ") is also for RT kernel even if it doesn't use "ifdef CONFIG_PREEMPT_RT" 
>     My ideal is that if this patch is merged into mainline, Linux-rt maintainer will not spend extra effort to focus on this patch. After all, this fixing is more related with driver.
>     In addition, I found out there are other patches with "ifdef CONFIG_PREEMPT_RT" merged by mainline, so I also send this patch to mainline, not Linux-rt.
> 
> 2. I check regmap.c code that is related with use_raw_spinlock. If PREEMPT_RT is disabled and use_raw_spinlock is set as true, the else case will not be entered any longer.
>     In other words, in mainline standard kernel, if use_raw_spinlock is set as true, raw spinlock will be used forever, and the code in else case will become useless.
>     I feel it is a little unreasonable. So, I keep the "ifdef"
> 	if ((bus && bus->fast_io) ||
> 		    config->fast_io) {
> 			if (config->use_raw_spinlock) {
> 				raw_spin_lock_init(&map->raw_spinlock);
> 				map->lock = regmap_lock_raw_spinlock;
> 				map->unlock = regmap_unlock_raw_spinlock;
> 				lockdep_set_class_and_name(&map->raw_spinlock,
> 							   lock_key, lock_name);
> 			} else {
> 				spin_lock_init(&map->spinlock);
> 				map->lock = regmap_lock_spinlock;
> 				map->unlock = regmap_unlock_spinlock;
> 				lockdep_set_class_and_name(&map->spinlock,
> 							   lock_key, lock_name);
> 			}
> 		} else {
> 			mutex_init(&map->mutex);
> 			map->lock = regmap_lock_mutex;
> 			map->unlock = regmap_unlock_mutex;
> 			map->can_sleep = true;
> 			lockdep_set_class_and_name(&map->mutex,
> 						   lock_key, lock_name);
> 		}
> 

I dislike #ifery as a general rule.  So with that in mind - if it's
not required, I'd prefer that it's removed.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
