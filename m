Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E6740CB7A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhIORNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhIORNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:13:49 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CCFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:12:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j16so3306477pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pOMEGIUJGUdr+F99bUVzOfHRQbFP9f2mrAaV6VC/UnQ=;
        b=j0DrfL0nMmB78LgWUu4l9iTsHBx9UZn1ZyLq5Qiq+XON2BpN7CVefK+ila51c3a4xt
         viYvkFRe5k8BGQ0TBphd+nowGIrEqhxHuGpNvHd5nETcVukxpyUYtSAyeosA6u3Y3sox
         qfS88Kl8+QC1H9L1n1ce0dsqhU9Vlrms0XeYQzLhNw5FFNfjMO/DzyajsG7xAOjJob+2
         OZqRBmRNJL64y0Gomq/mJyCVTWhVtw/XwYu5IQMCLtGVA8AM2qqhxsGCAKi/m2xpZZ8x
         uzI2JS1Kldyj/FljNHCynsAz8zW9/hqxKPoR9L/oHRWF2eP1XyhMbdw6GZTcfaham6W6
         hf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pOMEGIUJGUdr+F99bUVzOfHRQbFP9f2mrAaV6VC/UnQ=;
        b=RhuUBFk1d+V4kxPmvzqfHbwMWbD/Xx6ZReDc6OjaD88xWSvd7j/t5txHOR0qzLs0Fy
         ugc/rcxdyNPdf9qcH9XrziN5677Wsqy6kyymtBXVfMLU6a4vSkY3Qoct/7fB9emCyOEL
         6VjUJa/tGeYrL87z4FPwlvpRkkURkhQ340GEEUzA9Qog+6mQh+jZZ0D/mUKYh6SfsKBm
         d+8R23nuz5PVi8HEixJXiM821iOUa98+TeIDTpAUAfchkQtL1p0DrArSSM1hWSokJWt1
         QtAJzyXJDHwqz0nHoe+K7N5FLlxXiTc69rz2m2yslrGvU1sMX9H3vrZ1BBBnXIbU5fN/
         nPLw==
X-Gm-Message-State: AOAM530Lg4IlsF8izKlV1XXVUi0gphU/rd9KygNzO9FNU2ypaprs6d2k
        n/zEasC77bLIdOuqS5B8wZ9zlFGc9VU=
X-Google-Smtp-Source: ABdhPJyOzTFR7nzhvE8zE7qndnhzcMxMdTshWqGMm+bWNEjCaXps4+1+sKjwRF0nmzxEIah1FH9rpQ==
X-Received: by 2002:a63:ea44:: with SMTP id l4mr768506pgk.210.1631725949581;
        Wed, 15 Sep 2021 10:12:29 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id d10sm467583pfq.205.2021.09.15.10.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 10:12:29 -0700 (PDT)
Subject: Re: [PATCH v2] extcon: extcon-axp288: use low level P-Unit semaphore
 lock for axp288 register accesses
To:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20210910073440.2190-1-fabioaiuto83@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <db4648a4-291c-2941-8f76-29a328eaf25e@gmail.com>
Date:   Thu, 16 Sep 2021 02:12:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910073440.2190-1-fabioaiuto83@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21. 9. 10. 오후 4:34, Fabio Aiuto wrote:
> use low level P-Unit semaphore lock for axp288 register
> accesses directly and for more than one access a time,
> to reduce the number of times this semaphore is locked
> and released which is an expensive operation.
> 
> i2c-bus to the XPower is shared between the kernel and the
> SoCs P-Unit. The P-Unit has a semaphore wich the kernel must
> lock for axp288 register accesses. When the P-Unit semaphore
> is locked CPU and GPU power states cannot change or the system
> will freeze.
> 
> The P-Unit semaphore lock is already managed inside the regmap
> access logic, but for each access the semaphore is locked and
> released. So use directly iosf_mbi_(un)block_punit_i2c_access(),
> we are safe in doing so because nested calls to the same
> semaphore are turned to nops.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
> Changes in v2:
> 	- add a new depends on in Kconfig
> 	- add Tested-by Reviewed-by tags
>   
>   drivers/extcon/Kconfig         |  2 +-
>   drivers/extcon/extcon-axp288.c | 14 ++++++++++++++
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index c69d40ae5619..aab87c9b35c8 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -23,7 +23,7 @@ config EXTCON_ADC_JACK
>   
>   config EXTCON_AXP288
>   	tristate "X-Power AXP288 EXTCON support"
> -	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
> +	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI && IOSF_MBI
>   	select USB_ROLE_SWITCH
>   	help
>   	  Say Y here to enable support for USB peripheral detection
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index fdb31954cf2b..460402b14ef2 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -24,6 +24,7 @@
>   
>   #include <asm/cpu_device_id.h>
>   #include <asm/intel-family.h>
> +#include <asm/iosf_mbi.h>
>   
>   /* Power source status register */
>   #define PS_STAT_VBUS_TRIGGER		BIT(0)
> @@ -215,6 +216,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>   	unsigned int cable = info->previous_cable;
>   	bool vbus_attach = false;
>   
> +	iosf_mbi_block_punit_i2c_access();

You have to check the return value of iosf_mbi_block_punit_i2c_access()

> +
>   	vbus_attach = axp288_get_vbus_attach(info);
>   	if (!vbus_attach)
>   		goto no_vbus;
> @@ -253,6 +256,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>   	}
>   
>   no_vbus:
> +	iosf_mbi_unblock_punit_i2c_access();
> +
>   	extcon_set_state_sync(info->edev, info->previous_cable, false);
>   	if (info->previous_cable == EXTCON_CHG_USB_SDP)
>   		extcon_set_state_sync(info->edev, EXTCON_USB, false);
> @@ -275,6 +280,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>   	return 0;
>   
>   dev_det_ret:
> +	iosf_mbi_unblock_punit_i2c_access();
> +
>   	if (ret < 0)
>   		dev_err(info->dev, "failed to detect BC Mod\n");
>   
> @@ -307,11 +314,14 @@ static irqreturn_t axp288_extcon_isr(int irq, void *data)
>   
>   static void axp288_extcon_enable(struct axp288_extcon_info *info)
>   {
> +	iosf_mbi_block_punit_i2c_access();

ditto.

>   	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
>   						BC_GLOBAL_RUN, 0);
>   	/* Enable the charger detection logic */
>   	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
>   					BC_GLOBAL_RUN, BC_GLOBAL_RUN);
> +
> +	iosf_mbi_unblock_punit_i2c_access();
>   }
>   
>   static void axp288_put_role_sw(void *data)
> @@ -384,10 +394,14 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> +	iosf_mbi_block_punit_i2c_access();

ditto.

> +
>   	info->vbus_attach = axp288_get_vbus_attach(info);
>   
>   	axp288_extcon_log_rsi(info);
>   
> +	iosf_mbi_unblock_punit_i2c_access();
> +
>   	/* Initialize extcon device */
>   	info->edev = devm_extcon_dev_allocate(&pdev->dev,
>   					      axp288_extcon_cables);
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
