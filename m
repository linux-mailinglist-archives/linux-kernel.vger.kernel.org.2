Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A422A410AEE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 11:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhISJfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 05:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbhISJfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 05:35:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790F1C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 02:33:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so10527253pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 02:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Molecvvfb2ReCeU7roxyRTuWjWkUVYEjp8G6FhVA14=;
        b=T5hWy86pNt0hF9Iu0pzm4G2y/8WSBkw7UJLvVZYK8H7uSrL/4BhGph1XXgXVXM+8et
         7wMqskIpQ8gvUOU5fnVIOxEUq3zrWqAVbPvHbaeVrGgpBJCBbq4/eRmliw7avwt1T5m1
         o4uEamZ+dxaSMBXWBP22xLBai7hUdgt+x1JvGp9+OFGDtlFQO9qcjCk62SHfjU6ISjNr
         FXBB+t5P/NXaQMNaA29dgimoa9Oan4RUVuFR61UIx45JuXD5z0cYEOnyYOvxFcMjo0Q8
         ECjBDFX5xj5EjffRhVk0FlMcbPUTPJE6txJupBMOq69aJBbf+e6arO62KCzLsZ7OX5yD
         baiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Molecvvfb2ReCeU7roxyRTuWjWkUVYEjp8G6FhVA14=;
        b=pyXpx1SDg0vZDmIXtF/NaP43i8YEz5jrjh0Z7ZNiMgfH1219A0eZZYQ3SoWyt+P8Cr
         G+op8eXTQ/JyzhuMIYBm1P32xZkU5lHWwKBkYXX957STbWgA3LnF/eG+1/M9rKleTVfz
         fD46nm01WGlxVNiS5KZ2VwKYztPDDrYeLjmpeLUljB/i+mDuceyOxz22hjvU3oFVzhMs
         k+YO+lI6xVL2AoieJKbtqq1aGcc3UT5dlQCK/Y0NK2fxNcg5IHXRiLpEqTl59QA7qZyT
         162RjKHBEnFGE7UdTDNM5IbcdQD67VpJ5ECGc8cwFa3/7uXf34CuF7TfovMYUgje1k9o
         o1vQ==
X-Gm-Message-State: AOAM5320zqgd9VQPk0fI5EEWrWA+OBVQ/tHCfpUEcI9JyX4oA5hrKC6/
        uB7MV5lAs49RhQO/S2hKzWkNlM0jpHE=
X-Google-Smtp-Source: ABdhPJxBnH0nSBgI+9mlxYg0ifBnQETxTH+Wp3Fsd8Q7/J+WsvW2IpOmBZ1svEj7/KZEINwkmDys0A==
X-Received: by 2002:a17:90a:3fca:: with SMTP id u10mr7704573pjm.95.1632044031288;
        Sun, 19 Sep 2021 02:33:51 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id g4sm11682679pgs.42.2021.09.19.02.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 02:33:50 -0700 (PDT)
Subject: Re: [PATCH v2] extcon: extcon-axp288: use P-Unit semaphore lock for
 register accesses
To:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20210916071255.2572-1-fabioaiuto83@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <77beb286-09fb-3d9c-f212-91c1633dbd10@gmail.com>
Date:   Sun, 19 Sep 2021 18:33:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210916071255.2572-1-fabioaiuto83@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 9. 16. 오후 4:12, Fabio Aiuto wrote:
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
> 	- shortened patch title within 75 char
> 	- added return value check in function
> 	  iosf_mbi_lock_punit_i2c_access() calls
> 
>   drivers/extcon/Kconfig         |  2 +-
>   drivers/extcon/extcon-axp288.c | 31 +++++++++++++++++++++++++++++--
>   2 files changed, 30 insertions(+), 3 deletions(-)
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
> index fdb31954cf2b..7c6d5857ff25 100644
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
> @@ -215,6 +216,10 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>   	unsigned int cable = info->previous_cable;
>   	bool vbus_attach = false;
>   
> +	ret = iosf_mbi_block_punit_i2c_access();
> +	if (ret < 0)
> +		return ret;
> +
>   	vbus_attach = axp288_get_vbus_attach(info);
>   	if (!vbus_attach)n
>   		goto no_vbus;
> @@ -253,6 +258,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>   	}
>   
>   no_vbus:
> +	iosf_mbi_unblock_punit_i2c_access();
> +
>   	extcon_set_state_sync(info->edev, info->previous_cable, false);
>   	if (info->previous_cable == EXTCON_CHG_USB_SDP)
>   		extcon_set_state_sync(info->edev, EXTCON_USB, false);
> @@ -275,6 +282,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>   	return 0;
>   
>   dev_det_ret:
> +	iosf_mbi_unblock_punit_i2c_access();
> +
>   	if (ret < 0)
>   		dev_err(info->dev, "failed to detect BC Mod\n");
>   
> @@ -305,13 +314,23 @@ static irqreturn_t axp288_extcon_isr(int irq, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> -static void axp288_extcon_enable(struct axp288_extcon_info *info)
> +static int axp288_extcon_enable(struct axp288_extcon_info *info)
>   {
> +	int ret = 0;
> +
> +	ret = iosf_mbi_block_punit_i2c_access();
> +	if (ret < 0)
> +		return ret;
> +
>   	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
>   						BC_GLOBAL_RUN, 0);
>   	/* Enable the charger detection logic */
>   	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
>   					BC_GLOBAL_RUN, BC_GLOBAL_RUN);
> +
> +	iosf_mbi_unblock_punit_i2c_access();
> +
> +	return ret;
>   }
>   
>   static void axp288_put_role_sw(void *data)
> @@ -384,10 +403,16 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> +	ret = iosf_mbi_block_punit_i2c_access();
> +	if (ret < 0)
> +		return ret;
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
> @@ -441,7 +466,9 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>   	}
>   
>   	/* Start charger cable type detection */
> -	axp288_extcon_enable(info);
> +	ret = axp288_extcon_enable(info);
> +	if (ret < 0)
> +		return ret;
>   
>   	device_init_wakeup(dev, true);
>   	platform_set_drvdata(pdev, info);
> 

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
