Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A5A35F99A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349252AbhDNRNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348918AbhDNRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:13:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:13:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w23so24621589edx.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hRWa134yVdeu+HkfPMiwB6/8Nw4vcn7mYJDdehe4HJ4=;
        b=oXUTj9N075M3AlDHDjkFxiWKo9+YDjdUmItJOSJ/8WXGovn+fhujMCelIQmAwBbeUh
         th8oZwubkaWxphvZjeGdwJRmOfuJqguTb+JOpx83faA0M8k5JBT65JdADFXDMW6FU48I
         NPtYDpbzZqefRsel0ur0/cP8OFMp1bGH/NDlO/bVbQha4MJWK6+/CwS/iaQYewGpN0Uz
         BlN9ttwDwJk3l4cfMOzosjKlwQFEaif/E7loCBr7WogPgPrc+MU8dCvO1LtK2T3Wu3+U
         X2prr8ECl6lgLRER48NseO815dNEZuPAAdm2bSkcsdjEUq6wX+YDxBof97Il//Ew/hai
         bdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hRWa134yVdeu+HkfPMiwB6/8Nw4vcn7mYJDdehe4HJ4=;
        b=AKWTKYVC+XkTlYjGEfCC+z530BNsJdUgz67VH1s0Bqq3/k4TlznSgjoSYsnbEcOzkO
         OOJ01Hs97xJ5DqtwckgW4OWENWZPu5WgDZ9PAI+g80AAvIESdXVP+uCYoAt3/DHRjyfd
         0VOxfrEYw62pefd5ZuvaJus+mFPIyBMBWdNK5MTK5XCRg6WI0nAg6JpT/IJ/yuHBdtRJ
         UrSUdQKOs4OdAYEnSCVYZS7FSC93xCnwq1JTRH7mZgzsZrQxQpwz93GNMT9oG+RN1iZG
         Hf4K5eWICSWXxPOJVJg36PcCjokanSR9yUxutJqzrCyd0EJCY6sIdrs47BgBDekIqzWJ
         wePQ==
X-Gm-Message-State: AOAM531bWIDRxjX0lq2Ej1TsJgmix5x0isRa02WkT/YW+R2QlnYuj3QY
        o68Xj+I85dMjrDHZQw0pyd4iDH8lNCSKtA==
X-Google-Smtp-Source: ABdhPJyA9YeM1Vnc5BKJklfSEchAh0hBEqRbFRYD8j5Dwv9WLERLmGrljF/gTyLinbHTenSgwZkkfw==
X-Received: by 2002:a05:6402:30ae:: with SMTP id df14mr41786271edb.97.1618420401827;
        Wed, 14 Apr 2021 10:13:21 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id o20sm151297eds.65.2021.04.14.10.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 10:13:21 -0700 (PDT)
Date:   Wed, 14 Apr 2021 18:13:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/1] mfd: intel_quark_i2c_gpio: Don't play dirty trick
 with const
Message-ID: <20210414171319.GQ4869@dell>
References: <20210326124842.2437-1-andriy.shevchenko@linux.intel.com>
 <20210326145129.GB2916463@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210326145129.GB2916463@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021, Lee Jones wrote:

> On Fri, 26 Mar 2021, Andy Shevchenko wrote:
> 
> > As Linus rightfully noticed, the driver plays dirty trick with const,
> > i.e. it assigns a place holder data structure to the const field
> > in the MFD cell and then drops the const by explicit casting. This is
> > not how it should be.
> > 
> > Assign local pointers of the cell and resource to the respective
> > non-const place holders in the intel_quark_i2c_setup() and
> > intel_quark_gpio_setup().
> > 
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2: eliminated bar parameter (Lee)
> >  drivers/mfd/intel_quark_i2c_gpio.c | 26 ++++++++++++--------------
> >  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> Neat.
> 
> Applied, thanks.

Am I still missing patches from you Andy?

I get:

 make --silent --keep-going --jobs=8 O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- 'CC=sccache x86_64-linux-gnu-gcc' 'HOSTCC=sccache gcc' allmodconfig
 make --silent --keep-going --jobs=8 O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- 'CC=sccache x86_64-linux-gnu-gcc' 'HOSTCC=sccache gcc'
 /builds/linux/drivers/mfd/intel_quark_i2c_gpio.c: In function 'intel_quark_i2c_setup':
 /builds/linux/drivers/mfd/intel_quark_i2c_gpio.c:181:25: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
   struct resource *res = intel_quark_i2c_res;
                          ^~~~~~~~~~~~~~~~~~~
 /builds/linux/drivers/mfd/intel_quark_i2c_gpio.c: In function 'intel_quark_gpio_setup':
 /builds/linux/drivers/mfd/intel_quark_i2c_gpio.c:203:25: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
   struct resource *res = intel_quark_gpio_res;
                          ^~~~~~~~~~~~~~~~~~~~

Link to the build (see: build.log):

  https://builds.tuxbuild.com/1rAMovpd041jvsjfQ538kW3nvYK/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
