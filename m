Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7115232BEBD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575469AbhCCRfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240344AbhCCOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:16:00 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1446C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:15:03 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b18so17364797wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hhgZ1o1QxDX/++S/zN0801JK46wHe1ze9HJ6vvTuFxw=;
        b=azDs5aFPDrVfWP04fiH2NPWiV+BjGFdRLo3Qq+RRF5BkVon8mdEoknOK8w32jVnIsQ
         JbQHsmDiRaczWlKtfJSniJdfBdh7ENShMTvZvv8Vhw5mxnBNELMFEEZBm6ogw1sC6awz
         HFQArGYE45JSrgDGf9UpRZfC5meuFIv73GXK1OvddIA+KL5XL1AhAxMyBEzkakRJhvjt
         gT3kjVlEOr8ILEfqMQtx9LleVuevf1vrXZkuFrFTuu+Y8CrPYEcYFUlMsTOj75qH6Iqy
         BnMzk6EwrnDuE6Yqs6b+D2g/6EqAiAlT/yBUCacaEWtmu5qkPcmbGyD6WMEYcOhVSRyJ
         6L5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hhgZ1o1QxDX/++S/zN0801JK46wHe1ze9HJ6vvTuFxw=;
        b=aafZnXvtdvXnmenNDLZjMWFFbDjDTxUYdJWNTSsHF0eGiO8z+ix7AC+RcTjdxlKrcf
         6KDQrdunNHdxLTwDweg3RMHvOOjlkWULjKJird11fLSz4su1Qg8awPQCkaJRTl17f9eL
         cXUNlxdr4saUXJ/eLJVT5ZEdJ4m0a5P1/iy5qf1C4qUFwmjWHi5XvvSpug3gowFkK+LX
         ojlELosWJijKQCvDEQEAbJMb/Wd1Nu8RZUejc3GGmIDYOQjbXuwXf5j0OOlTy4goggDJ
         gVcodFPRLOwMH69jhXjiE0mCjb2pArlaqROd0HFyHkGGvdqFMNPKhL0xKO/DJ3xmn5vq
         z3XA==
X-Gm-Message-State: AOAM530OsC1CHk8u5R6twQzU16gRBAhc7B7P+HwqdK48XYGP9seof6KI
        Efd0d11ywknjGDUuGOWiykp0MQ==
X-Google-Smtp-Source: ABdhPJzCYayGGpemAa9e/6viaTkLQAEOLRzwYYsuN1S/vemtoz85dgD7qwP/tRJpUoUIs/rzwokrSw==
X-Received: by 2002:adf:c186:: with SMTP id x6mr17965127wre.253.1614780900022;
        Wed, 03 Mar 2021 06:15:00 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id u2sm9696437wrp.12.2021.03.03.06.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:14:59 -0800 (PST)
Date:   Wed, 3 Mar 2021 14:14:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [RESEND 1/1] arch: arm: mach-at91: pm: Move prototypes to
 mutually included header
Message-ID: <20210303141457.GE2690909@dell>
References: <20210303124149.3149511-1-lee.jones@linaro.org>
 <YD+N/QVRYbm/Idp3@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YD+N/QVRYbm/Idp3@piout.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2021, Alexandre Belloni wrote:

> On 03/03/2021 12:41:49+0000, Lee Jones wrote:
> > Both the caller and the supplier's source file should have access to
> > the include file containing the prototypes.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/pinctrl/pinctrl-at91.c:1637:6: warning: no previous prototype for ‘at91_pinctrl_gpio_suspend’ [-Wmissing-prototypes]
> >  1637 | void at91_pinctrl_gpio_suspend(void)
> >  | ^~~~~~~~~~~~~~~~~~~~~~~~~
> >  drivers/pinctrl/pinctrl-at91.c:1661:6: warning: no previous prototype for ‘at91_pinctrl_gpio_resume’ [-Wmissing-prototypes]
> >  1661 | void at91_pinctrl_gpio_resume(void)
> >  | ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> I'm pretty sure you had my ack on v3 ;)
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> or again, alternatively, I can apply it with Linus' ack

That would be my preference, thanks.

> > ---
> >  arch/arm/mach-at91/pm.c        | 19 ++++++++-----------
> >  drivers/pinctrl/pinctrl-at91.c |  2 ++
> >  include/soc/at91/pm.h          | 16 ++++++++++++++++
> >  3 files changed, 26 insertions(+), 11 deletions(-)
> >  create mode 100644 include/soc/at91/pm.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
