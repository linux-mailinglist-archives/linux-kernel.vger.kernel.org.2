Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99F940CB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhIORQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIORP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:15:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197E1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:14:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w6so2054453pll.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y/UjUbeHNyWAXNAAqLF9HMPvvId44F3B0leq0r2R0E8=;
        b=SPoBlIw5g40ITyxAu+RPIPM0LEdSVBj0k6bXHe2ZXphNGKDPB71zbnWYKRm6rSWgZR
         BQWwOHsImNMrPFsQ8KoogToOK6x4DDzWf6BCHnjXBwV6HWJG90vC0fJHGUi2h67j90oH
         hLwsiCadbY9nZO1HJJWVP8rtQhhhzad4hE1rIY319m8WSl6TWcT6/oD9hYFj8gbShhOg
         6YMWrFbLh/TgLJcOO83cv1ne6SFCzRSFSlCWtuIq7iR/UaU14zbqbPdR4VfEXbFss+Bj
         iWEpjrUnZw1kdQwwuSsQkDTodhLgMT3qCEBa3pG4LLHXgKSsEg3p9kTnecz2aLSLNmL1
         mPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y/UjUbeHNyWAXNAAqLF9HMPvvId44F3B0leq0r2R0E8=;
        b=ixsIvLTWqchshWPyikSInlh507+ApF8/FV4tNKZDHMpzT3lmPqGOx7Y5id8JYBGvVv
         ISbGCbwFDImmAjlqP9qS3H0LvJIN635vmO3Kc/IOgNA8KVLeBLD0OFJrYQJ/ZpkQkIiB
         8DU7+OiOFOjXijsNCeD2ZPIh6i3uVOKqySUAI/pkwlfqjUV8Br1PF86FVVcnyCiiT30/
         diXvmlxz6GBvoR4SL6FtsGk1CsIXLCmyYAZBZJhUFqDwkils9+/oG+KU8iR/dOqYPiPC
         CpHuD6djSQOHf/khiOgXq4PqKY5tlzx3Q1PK9lBgm5Jd78gtUqg2hPmVdkus6i5Sk6rU
         iZEg==
X-Gm-Message-State: AOAM533EHVo8gJRv1jXPiXRexWIiM19JszMtj1pEe1bAu+Lot1oAEIzU
        7JEcuL77igHJzub+mNy81uKQval9sME=
X-Google-Smtp-Source: ABdhPJweVG9tFNRFr3mgcI8mNCmuPMxj/AUcR5QEI7h2CVUPxMWxY2+S46Gtz82FrWPHisNYz4MA6Q==
X-Received: by 2002:a17:90b:17d0:: with SMTP id me16mr896298pjb.49.1631726079013;
        Wed, 15 Sep 2021 10:14:39 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id i10sm479637pfk.87.2021.09.15.10.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 10:14:38 -0700 (PDT)
Subject: Re: [PATCH v2] extcon: extcon-axp288: use low level P-Unit semaphore
 lock for axp288 register accesses
To:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20210910073440.2190-1-fabioaiuto83@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <95e1aed4-944e-9e8e-f7b5-dcefb6e39147@gmail.com>
Date:   Thu, 16 Sep 2021 02:14:35 +0900
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

If not critical, you better to write the patch title within 75 char.

Regards,
Chanwoo Choi

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
