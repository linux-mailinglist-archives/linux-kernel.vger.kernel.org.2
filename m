Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6402240678B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhIJHPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhIJHPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:15:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E47C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:13:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so645746wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0HmQUd2KFMJEUhws1btEzIXD8SogYEoR7cwxsEQ/d6w=;
        b=jdPuxmjy08rSzwXtmZx/XTAI9uH4HxbXAnSV/Hq6aPO/H7xBYiSLSCTqkiNk8wsofJ
         uTQ5grueyzXzWjL8djwIpGBNIf/sY9ApXK2H6raOQk7V94X42VGp64NWOxUgHDNBukZw
         u1lXF2fZoHuf/2tSWtnv1c9OGJPxHP3CUL30HfCGLhmuas0El7bNFlQYD2B7x6YK69l1
         BvtPnGptVm7fH42fGoQrIacGuabyR7I0OGW3B7peEjVPhP7kNFWdcLHDl2JzCLLRu5qm
         KIuURzQMpwKO2+NTQFrUqZ7Nr5hctLeWe4dIOlPiNHsOxllxUM8k2bgeT5BMrLtjep6M
         3ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0HmQUd2KFMJEUhws1btEzIXD8SogYEoR7cwxsEQ/d6w=;
        b=DBjrulLLjBy2V8cQTSTW3VgRYYjR7R8c0Vxj8fDnGEBrCDURD71U+EF85b6aJAhOYu
         6z2zPOuURkJLR1IbjFaxnoJLQxPELY2c5owRSVEzv9f9c3n/RpxIxIN5QJb/CZPnD+kW
         2gt6KRi8o9TLmASdW+LEfturyjYK27KAszQNr218GQfYx1xnHg2kftwat0zF3GyLuuC8
         o5syjv7gbb3Ji8IXyjmlDpbH//SJ9CG+d9/AvEXGUjgwx4dRKXEoFNhqINp6xL7CUXPY
         PzdqZBKSFRBYOSimY4a2rCpd4sGY5DpwA5k30eeHHfpYFOLw6Or+PRoU/lDCrPLcWM0j
         OrUQ==
X-Gm-Message-State: AOAM533sFC4BgDOIzf8YJaK+WvvTrVmWEmhfxIWBJ8WJ+0pdPD4i+gKL
        +oru9glCmdrEgQcKt0kmp74=
X-Google-Smtp-Source: ABdhPJynZwaseLpYV2D4ecNg2N/sWyj0LTKW65c2436tejIYwDoIb/EhOV2mWNTEWmJTVuMTZl3Yaw==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr6784575wmb.86.1631258037361;
        Fri, 10 Sep 2021 00:13:57 -0700 (PDT)
Received: from agape.jhs ([5.171.81.87])
        by smtp.gmail.com with ESMTPSA id n14sm3680829wrx.10.2021.09.10.00.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 00:13:57 -0700 (PDT)
Date:   Fri, 10 Sep 2021 09:13:54 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     kernel test robot <lkp@intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: extcon-axp288: use low level P-Unit semaphore
 lock for axp288 register accesses
Message-ID: <20210910071354.GB1437@agape.jhs>
References: <20210909151820.5303-1-fabioaiuto83@gmail.com>
 <202109100823.X6Isdxi1-lkp@intel.com>
 <3ecef801-7484-95ed-3e76-e7770146e626@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ecef801-7484-95ed-3e76-e7770146e626@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Fri, Sep 10, 2021 at 09:03:42AM +0200, Hans de Goede wrote:
> Hi,

<snip>

> >            ^
> >    6 errors generated.
> 
> Ah yes, I should have caught this, we had the same issue with a similar patch to
> the axp288-fuel-gauge driver.
> 
> The fix is this:
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index c69d40ae5619..aab87c9b35c8 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -23,7 +23,7 @@ config EXTCON_ADC_JACK
>  
>  config EXTCON_AXP288
>  	tristate "X-Power AXP288 EXTCON support"
> -	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
> +	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI && IOSF_MBI
>  	select USB_ROLE_SWITCH
>  	help
>  	  Say Y here to enable support for USB peripheral detection
> 
> The new depends on is fine since all boards which use the AXP288 should
> always have IOSF_MBI enabled anyways.
> 
> Fabio, can you send a v2 with this Kconfig change added please ?
> 
> (and please also add my earlier Reviewed-by and Tested-by to the v2)

sure will fix and resend

> 
> 
> > 
> > 

thank you,

fabio
