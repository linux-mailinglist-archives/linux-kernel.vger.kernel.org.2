Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA893E8509
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhHJVQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhHJVQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:16:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEF1C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:15:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k2so23042577plk.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RGyN6B+oepLK5COlIQIu0Zg6xm5eWTbyTPOp1hx9GWk=;
        b=qroWg+lyQTF5da3CrND6OLNSNWVz6DyWAF8VgL1fo2SJHuwXB9YWKauFqcX85LOkmy
         8RVT2SbtEeyj86T+BYpGrorwejhONijGBfF5Um2s5pWADhIRA4Pm7Cg41m/qwitli0Yb
         1CJHatNT0IhskHx9iJH8qfrmUSheZNF1QUNWk4sTlYDGzVVDSTiCgGRJgWLdeLm3i92y
         9g+28RHSbvrWvWGLYZoIlrdsc0Yv741/j2sC5seihl0fLGS+xz/csEri2x5YveEoazvl
         F1ok1vfOagpdqz0MaSXXmBlljyp7n8hHCD9j2Pq5Qk4TM3XqwXa9KZsyP2/kFI0JVCET
         dv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RGyN6B+oepLK5COlIQIu0Zg6xm5eWTbyTPOp1hx9GWk=;
        b=KzvZYJ44I45Z5J40v40sRqZvD4W7asOXTh4GbUEFzDgkNjqL5TyDrPTieiZ/qflGhk
         rEChPZ+EF/TMM/eP5ENP/yWZwm5Yx9w6pnbqeT/7+/RKq/r1xEMK5FRMZSQy7Ammz3Pu
         ctc8ogGn9vlM3T5ZBYXm9DLISuMNkD/YE3BFGRKE2KHT0N1vlOY9aowD5JvGG9CMvVj3
         80Yl5QeA/Z0QyshZ/6KPL45tIuKnzyTzADNDStiwqv0k8alqWm/rn5bES/feuuHv85cO
         QxiRhBzeFh5PqKFIpSOmZBeKdwMJO0HqpA3LJfh+cQlhCH86VJrOleBs38aWZydpC3yR
         Lofg==
X-Gm-Message-State: AOAM533iBMnkVptOElhSG6oTjAEnSx6P8Zwa1OwPqGpFlRKTIj+oXOCJ
        ZIUt1Fc+0do0XfQLGEf4ulQ=
X-Google-Smtp-Source: ABdhPJyqemEnliLO65WklVw8TWQK4RO38BF68T6O14/5adEk0Fu0g4RN1erX9WU3VuiDs7YsMlf7KA==
X-Received: by 2002:a17:90b:609:: with SMTP id gb9mr33751834pjb.156.1628630145855;
        Tue, 10 Aug 2021 14:15:45 -0700 (PDT)
Received: from localhost (g195.61-45-49.ppp.wakwak.ne.jp. [61.45.49.195])
        by smtp.gmail.com with ESMTPSA id j187sm24731451pfb.132.2021.08.10.14.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 14:15:45 -0700 (PDT)
Date:   Wed, 11 Aug 2021 06:15:43 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        kernel test robot <lkp@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2] openrisc: Fix compiler warnings in setup
Message-ID: <YRLsf2VyGTQVapuV@antec>
References: <20210808135437.3640549-1-shorne@gmail.com>
 <8a830ab7-6b66-1ca9-bd73-fc1551def648@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a830ab7-6b66-1ca9-bd73-fc1551def648@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 10:51:01AM -0700, Randy Dunlap wrote:
> On 8/8/21 6:54 AM, Stafford Horne wrote:
> > This was pointed out with the recent name change of or32_early_setup to
> > or1k_early_setup.  Investigating the file I found a few other warnings
> > so cleaning them up here.
> > 
> >      arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
> >        220 | void __init or1k_early_setup(void *fdt)
> > 	  |             ^~~~~~~~~~~~~~~~
> > 
> > Fix this the missing or1k_early_setup prototype warning by adding an
> > asm/setup.h file to define the prototype.
> > 
> >      arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
> >        246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
> > 	  |             ^~~~~~~~~~~~~~~~~~
> > 
> > The function detect_unit_config is not used, just remove it.
> > 
> >      arch/openrisc/kernel/setup.c:221: warning: Function parameter or member 'fdt' not described in 'or1k_early_setup'
> > 
> > Add @fdt docs to the function comment to suppress this warning.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.

Thank you.

> > ---
> > 
> > Changes since v1:
> >   - Add #include <linux/init.h> to fix compile failure.  Pointed out by robot and
> >     randy.
> > 
> >   arch/openrisc/include/asm/setup.h | 15 +++++++++++++++
> >   arch/openrisc/kernel/setup.c      | 16 +---------------
> >   2 files changed, 16 insertions(+), 15 deletions(-)
> >   create mode 100644 arch/openrisc/include/asm/setup.h
> > 
> > diff --git a/arch/openrisc/include/asm/setup.h b/arch/openrisc/include/asm/setup.h
> > new file mode 100644
> > index 000000000000..9acbc5deda69
> > --- /dev/null
> > +++ b/arch/openrisc/include/asm/setup.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2021 Stafford Horne
> > + */
> > +#ifndef _ASM_OR1K_SETUP_H
> > +#define _ASM_OR1K_SETUP_H
> > +
> > +#include <linux/init.h>
> > +#include <asm-generic/setup.h>
> > +
> > +#ifndef __ASSEMBLY__
> > +void __init or1k_early_setup(void *fdt);
> > +#endif
> > +
> > +#endif /* _ASM_OR1K_SETUP_H */
> > diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> > index 7eddcac0ef2f..0cd04d936a7a 100644
> > --- a/arch/openrisc/kernel/setup.c
> > +++ b/arch/openrisc/kernel/setup.c
> > @@ -210,6 +210,7 @@ void __init setup_cpuinfo(void)
> >   /**
> >    * or1k_early_setup
> > + * @fdt: pointer to the start of the device tree in memory or NULL
> >    *
> >    * Handles the pointer to the device tree that this kernel is to use
> >    * for establishing the available platform devices.
> > @@ -243,21 +244,6 @@ static inline unsigned long extract_value(unsigned long reg, unsigned long mask)
> >   	return mask & reg;
> >   }
> > -void __init detect_unit_config(unsigned long upr, unsigned long mask,
> > -			       char *text, void (*func) (void))
> > -{
> > -	if (text != NULL)
> > -		printk("%s", text);
> > -
> > -	if (upr & mask) {
> > -		if (func != NULL)
> > -			func();
> > -		else
> > -			printk("present\n");
> > -	} else
> > -		printk("not present\n");
> > -}
> > -
> >   /*
> >    * calibrate_delay
> >    *
> > 
> 
> 
> -- 
> ~Randy
> 
