Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F76E45C8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243740AbhKXPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243427AbhKXPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:43:23 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04350C061714
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:40:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r8so4940238wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cEs6Rb945NvkqFV0ptJhlHRTxwHKCUWFbI7nndGNLik=;
        b=AHoVsXgYk/xvqnb6m9hTlEeikd4NWTm7ipwzWxJj1hE0KMLzKQcbJj+q7mwgv+iKa9
         CMG6U6yn1dZ8rjwAB50szVQKYrgYCLKYJhh24GHOnlO9bRjKoMVOEmOIyIbxTIZW0tXR
         bqrtNWcaXmCe7LTYyDkZ1LOXdSjW7NW99Z8ORLM+6vCIKTwdGHdB232wFYwoMO6Bikyt
         87FUt0GriixP1qxwM6g6ZmZwgJdHFsz7hFGdegA7ZiPGk/+medhr9kavE9uzruLXdHm8
         mObfQZM4hUvW303+3jizBvU9pGBKCV5SCjgkSnBj0IVBnTH44Rb7K6Mm/TXSYbKSoIsJ
         N6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cEs6Rb945NvkqFV0ptJhlHRTxwHKCUWFbI7nndGNLik=;
        b=NqeTWcqH6WuB71O8lnUNY3YbgzIdLTfGf4TcRYBckAS94nVFlny5tV5j/IELLAhbU4
         wPH4O6G+uhd/SYlrVlIewZuaby6Z+KFU6EeOop0oneoFraZkrjY/de88ipCrm0lKkCIJ
         GKz6g3BU2UpHtbmtyhcJRlAk0dx2u3lnbENLmZPKRKEz+1PV0oPerZkpqZQKNWK1O69E
         SDd5QRWgej8yo7O/8Cqq4238hdpDPn95nzmvOixjCDlZz6gdMCTKtrtBviTm49ZPNyG7
         OcGtVlHu1WLkokUG6ry4SnceaFBzYOZVT9BVRC78zZA2p3WL9BfTT9xFs0u5QVUHvuu5
         Ef3g==
X-Gm-Message-State: AOAM530yRj2AmBB07GmEsN4d6YUr6yUHHK9pkDn5m4XRx1sdZQsaqBLm
        4B1tbRiGsVhMWDfMM0hZlKXw8g==
X-Google-Smtp-Source: ABdhPJxvM1EpMsZU9I79xtWeZG5TSUrQVj/n3H60GMBpom1AaPcyEUdyF6R3h8qmP57wtak4BlFhvQ==
X-Received: by 2002:a5d:508d:: with SMTP id a13mr19836543wrt.41.1637768412574;
        Wed, 24 Nov 2021 07:40:12 -0800 (PST)
Received: from google.com ([2.31.167.61])
        by smtp.gmail.com with ESMTPSA id 138sm4981047wma.17.2021.11.24.07.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:40:12 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:40:00 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] mfd: Kconfig: change INTEL_SOC_PMIC_CHTDC_TI to bool
Message-ID: <YZ5c0LO5Ocaq+B7c@google.com>
References: <f12ed3dea697e6fdcfcaf9b6cc862ffa7aac005b.1635490923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f12ed3dea697e6fdcfcaf9b6cc862ffa7aac005b.1635490923.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021, Mauro Carvalho Chehab wrote:

> The INTEL_SOC_PMIC_CHTDC_TI should be initialized early, before
> loading the fbcon driver, as otherwise the i915 driver will
> fail to configure pwm:
> 
> [   13.674287] fb0: switching to inteldrmfb from EFI VGA
> [   13.682380] Console: switching to colour dummy device 80x25
> [   13.682468] i915 0000:00:02.0: vgaarb: deactivate vga console
> [   13.682686] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [   13.685773] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [   13.686219] i915 0000:00:02.0: [drm] *ERROR* Failed to configure the pwm chip
> [   13.699572] [drm] Initialized i915 1.6.0 20200313 for 0000:00:02.0 on minor 0
> [   13.739044] fbcon: i915drmfb (fb0) is primary device
> [   14.037792] intel_soc_pmic_exec_mipi_pmic_seq_element: No PMIC registered
> ...
> [   24.621403] intel_pmic_install_opregion_handler: Ask to register OpRegion for bus ID=PMI2, HID=INT33F5
> [   24.630540] intel_pmic_install_opregion_handler: OpRegion registered
> 
> (some extra debug printk's were added to the above)
> 
> As suggested by Hans, this patch also addresses an issue with
> the dependencies, as, for this driver to be a bool, it also
> need the I2C core and the I2C_DESIGNWARE driver to be builtin.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/mfd/Kconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index ca0edab91aeb..f9092c79c4e8 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -632,7 +632,7 @@ config INTEL_SOC_PMIC_CHTWC
>  config INTEL_SOC_PMIC_CHTDC_TI
>  	tristate "Support for Intel Cherry Trail Dollar Cove TI PMIC"
>  	depends on GPIOLIB
> -	depends on I2C
> +	depends on I2C = y && I2C_DESIGNWARE_PLATFORM=y

The lack of formatting consistency here is eating me up inside!

>  	depends on ACPI
>  	depends on X86
>  	select MFD_CORE
> @@ -642,6 +642,10 @@ config INTEL_SOC_PMIC_CHTDC_TI
>  	  Select this option for supporting Dollar Cove (TI version) PMIC
>  	  device that is found on some Intel Cherry Trail systems.
>  
> +	  This option is a bool as it provides an ACPI OpRegion which must be
> +	  available before any devices using it are probed. This option also
> +	  needs the designware-i2c driver to be builtin for the same reason.

Is there no way around this?

We do have early module loading available.

>  config INTEL_SOC_PMIC_MRFLD
>  	tristate "Support for Intel Merrifield Basin Cove PMIC"
>  	depends on GPIOLIB

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
