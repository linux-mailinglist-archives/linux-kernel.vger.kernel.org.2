Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDDB3417A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhCSIkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbhCSIjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:39:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9991FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:39:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ce10so8334227ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AqM64yDo/DtfJ/5GOmFdN1tRpMpD2g8L6hDaVcB81Fs=;
        b=bsrFZg7mJuj8GFeU8dJARg5Iwfc14TrVcaFVRxKAxu40vRDtc7cTnWZHGYfdaJz2on
         Wke7MNf+HmRLWj7yTjhy/KTUPJGZhvj3t4UcBRSxYLktOAZIvC+tXjDCyVvTg5MNfyEr
         d9cFiZwQakAqxvj4JpDNY6lX7hG0NwT1omIY7UZPv2CkqGtVcSp9rCDDg5gg44lbd5Ch
         IKAfKKNqSmMQJavwzT4FP2WJu+q3l0RXvFCjfV2U/T5VZMr/Kgsx3tZava2TumrLUO2n
         fJiStQm8nLSU9s71OyeU+pAoRHbHZ9Jn9kd/qyQNuwCVrZMVCze0T5lT87XcjZiVRpyy
         YywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AqM64yDo/DtfJ/5GOmFdN1tRpMpD2g8L6hDaVcB81Fs=;
        b=lfdH/F3yBooZYcNJv3XqDnfKAtCpl9VSRFZR4t1d+uYOlc2GB8mN1SWPAyK/BjmymQ
         E8HtNjjP0JepoXA/K2PhqqMInON1ZNq/Z0Bu6LV0t3v4qVVoPV+g4MV57KISeRkugiJA
         lyS+Jk2fWEPvI/9pCwmR3xTZceKSlz+VHsC9se05Zz7vWD1FJIJkeFmvW+vxGiivV1hx
         vCXykCKxUH3XGV87Zn0oLe4GJu0ERyZQApfSvDPtCHAUy2kF74kNE0DZGxaF2iaEtZRS
         JbEP0ir25mioIZ+HdNj1W/P+g4aVNTcHteBI7kgPeEcldlp/DBZVlVk//OvZkO83fIZN
         mRIQ==
X-Gm-Message-State: AOAM5327jjO/DlFfSJaB26ouAQNwYt4qAIvo3DJYxi4VI+zLzdB/DBXI
        BpecbhGSesIDdoscLD64uM+cAg==
X-Google-Smtp-Source: ABdhPJwpG4z0Nw4iWsZcPopkbXDhUUWfRx60x8t6tO/grwTn5ZnQYKmBwwePd8PmzrRSYt9A61qaEw==
X-Received: by 2002:a17:906:3b99:: with SMTP id u25mr3004557ejf.277.1616143179359;
        Fri, 19 Mar 2021 01:39:39 -0700 (PDT)
Received: from dell ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id c20sm3292498eja.22.2021.03.19.01.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:39:39 -0700 (PDT)
Date:   Fri, 19 Mar 2021 08:39:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] mfd: intel_quark_i2c_gpio: revert "Constify
 static struct resources"
Message-ID: <20210319083937.GH2916463@dell>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
 <YD6nF1oJVMeCzn6R@rikard>
 <YFNNVHZeKIMHco+a@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFNNVHZeKIMHco+a@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021, Andy Shevchenko wrote:

> On Tue, Mar 02, 2021 at 09:59:03PM +0100, Rikard Falkeborn wrote:
> > On Tue, Mar 02, 2021 at 03:56:16PM +0200, Andy Shevchenko wrote:
> > > The structures are used as place holders, so they are modified at run-time.
> > > Obviously they may not be constants.
> > > 
> > >   BUG: unable to handle page fault for address: d0643220
> > >   ...
> > >   CPU: 0 PID: 110 Comm: modprobe Not tainted 5.11.0+ #1
> > >   Hardware name: Intel Corp. QUARK/GalileoGen2, BIOS 0x01000200 01/01/2014
> > >   EIP: intel_quark_mfd_probe+0x93/0x1c0 [intel_quark_i2c_gpio]
> > > 
> > > This partially reverts the commit c4a164f41554d2899bed94bdcc499263f41787b4.
> > > 
> > > While at it, add a comment to avoid similar changes in the future.
> > > 
> > > Fixes: c4a164f41554 ("mfd: Constify static struct resources")
> > > Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/mfd/intel_quark_i2c_gpio.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
> > > index 55a9e017edee..124c0ee84169 100644
> > > --- a/drivers/mfd/intel_quark_i2c_gpio.c
> > > +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> > > @@ -72,7 +72,8 @@ static const struct dmi_system_id dmi_platform_info[] = {
> > >  	{}
> > >  };
> > >  
> > > -static const struct resource intel_quark_i2c_res[] = {
> > > +/* This is used as a place holder and will be modified at run-time */
> > > +static struct resource intel_quark_i2c_res[] = {
> > >  	[INTEL_QUARK_IORES_MEM] = {
> > >  		.flags = IORESOURCE_MEM,
> > >  	},
> > > @@ -85,7 +86,8 @@ static struct mfd_cell_acpi_match intel_quark_acpi_match_i2c = {
> > >  	.adr = MFD_ACPI_MATCH_I2C,
> > >  };
> > >  
> > > -static const struct resource intel_quark_gpio_res[] = {
> > > +/* This is used as a place holder and will be modified at run-time */
> > > +static struct resource intel_quark_gpio_res[] = {
> > >  	[INTEL_QUARK_IORES_MEM] = {
> > >  		.flags = IORESOURCE_MEM,
> > >  	},
> > 
> > Sorry about that :(
> > 
> > Reviewed-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> 
> Thanks for review!
> 
> Lee, this series has a critical bug fix, should I do something or you is going
> to apply this soon?

It's on my to-review list.

I can prioritise bug fixes though - can it be applied by itself?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
