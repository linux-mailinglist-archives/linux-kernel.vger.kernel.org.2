Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42C640D832
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 13:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhIPLOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 07:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236992AbhIPLOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631790776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9verg55oAC3y7r31Y35Yfl0rK4slWxClxNt2hQjqRY=;
        b=B+prDMnDBUXSN+36M60YIEyXHEuvVFohKSaYJhdlBkPftWJOLOTa8xScLplrqAx/a6Fzk/
        znEiE4xPNJ8+DXqg8wefuZA1T9hj9O7vtgR4y8k+35karfylsSB2BsMplov0R99QjOA6Fv
        XK3k9o1J9Pv2h6C1y2EEnSNxkSboOrY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-eupZtqv9PLu0cz7txf0pGA-1; Thu, 16 Sep 2021 07:12:55 -0400
X-MC-Unique: eupZtqv9PLu0cz7txf0pGA-1
Received: by mail-ed1-f70.google.com with SMTP id y17-20020a50e611000000b003d051004603so5045058edm.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 04:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w9verg55oAC3y7r31Y35Yfl0rK4slWxClxNt2hQjqRY=;
        b=Eu7k1mYY0Q99PNEaWraakCZ+QIyWyOiMofv1k+6sGus3zAMFk6YfssUnXOOhzmUHS5
         C8wB3HXTXrBjxP66aqgy2y3JgdpM/Xp6TMT0H3/zdUbvqkg0SZS8E32kNqiRPMA2eO7b
         idNztZhRTonwRps8rgh9PeXGbfPRFjHW+6RxlCVZjSZcCdcaRt2oueWtsz4wUHnipziC
         bCxJV7lxeP5od3WilLPruyhfF4ryBQ1kbGgfrTPCowc75sXIJ91DFg05XSQsOJvbRwGN
         ANiBs2+xMSzBPGW6IwOL651km7iYdgMvPM9ix2z3PF/PQD/Grs8Zay5m7Zx4zdRoKFUR
         yUvg==
X-Gm-Message-State: AOAM530GFBYQwf2yiRNZtaTW4yzO5brM7laMEMAuBFi9CP5/njGPMpbo
        ZYJWQ2mkTerM3NxcIO6Q+PHY7tH2ZVInj00xb6vc0NNRihvNnmZNbvObpnMrsAvEKkGHWOskHhG
        KmjZO//NEMP4bKf/1bM8ZbaoXKX4FX2Q2kJkaHJytEWuMoEINR+AKWrP4O5LJoWfWfEfsbIQsyJ
        wq
X-Received: by 2002:a17:906:718e:: with SMTP id h14mr5329001ejk.365.1631790774416;
        Thu, 16 Sep 2021 04:12:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFYgK2rw1N5sAsJjFxSYA480E3iMJhVsVfPPAvZk9SMmCTXmWTID+fLAzawJKylnEQAzLiLQ==
X-Received: by 2002:a17:906:718e:: with SMTP id h14mr5328975ejk.365.1631790774136;
        Thu, 16 Sep 2021 04:12:54 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id l11sm1233323edv.67.2021.09.16.04.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 04:12:53 -0700 (PDT)
Subject: Re: [PATCH v2] extcon: extcon-axp288: use P-Unit semaphore lock for
 register accesses
To:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
References: <20210916071255.2572-1-fabioaiuto83@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a755b46a-5561-0fae-b7b3-d0bc1906f79e@redhat.com>
Date:   Thu, 16 Sep 2021 13:12:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916071255.2572-1-fabioaiuto83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/16/21 9:12 AM, Fabio Aiuto wrote:
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


Actually your last version was v2, so this one should have
been v3 (no need to resend it just for that).

Other then that remark this looks good, thank you.

Regards,

Hans


> 
>  drivers/extcon/Kconfig         |  2 +-
>  drivers/extcon/extcon-axp288.c | 31 +++++++++++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 3 deletions(-)
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
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index fdb31954cf2b..7c6d5857ff25 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -24,6 +24,7 @@
>  
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
> +#include <asm/iosf_mbi.h>
>  
>  /* Power source status register */
>  #define PS_STAT_VBUS_TRIGGER		BIT(0)
> @@ -215,6 +216,10 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>  	unsigned int cable = info->previous_cable;
>  	bool vbus_attach = false;
>  
> +	ret = iosf_mbi_block_punit_i2c_access();
> +	if (ret < 0)
> +		return ret;
> +
>  	vbus_attach = axp288_get_vbus_attach(info);
>  	if (!vbus_attach)
>  		goto no_vbus;
> @@ -253,6 +258,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>  	}
>  
>  no_vbus:
> +	iosf_mbi_unblock_punit_i2c_access();
> +
>  	extcon_set_state_sync(info->edev, info->previous_cable, false);
>  	if (info->previous_cable == EXTCON_CHG_USB_SDP)
>  		extcon_set_state_sync(info->edev, EXTCON_USB, false);
> @@ -275,6 +282,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>  	return 0;
>  
>  dev_det_ret:
> +	iosf_mbi_unblock_punit_i2c_access();
> +
>  	if (ret < 0)
>  		dev_err(info->dev, "failed to detect BC Mod\n");
>  
> @@ -305,13 +314,23 @@ static irqreturn_t axp288_extcon_isr(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static void axp288_extcon_enable(struct axp288_extcon_info *info)
> +static int axp288_extcon_enable(struct axp288_extcon_info *info)
>  {
> +	int ret = 0;
> +
> +	ret = iosf_mbi_block_punit_i2c_access();
> +	if (ret < 0)
> +		return ret;
> +
>  	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
>  						BC_GLOBAL_RUN, 0);
>  	/* Enable the charger detection logic */
>  	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
>  					BC_GLOBAL_RUN, BC_GLOBAL_RUN);
> +
> +	iosf_mbi_unblock_punit_i2c_access();
> +
> +	return ret;
>  }
>  
>  static void axp288_put_role_sw(void *data)
> @@ -384,10 +403,16 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	ret = iosf_mbi_block_punit_i2c_access();
> +	if (ret < 0)
> +		return ret;
> +
>  	info->vbus_attach = axp288_get_vbus_attach(info);
>  
>  	axp288_extcon_log_rsi(info);
>  
> +	iosf_mbi_unblock_punit_i2c_access();
> +
>  	/* Initialize extcon device */
>  	info->edev = devm_extcon_dev_allocate(&pdev->dev,
>  					      axp288_extcon_cables);
> @@ -441,7 +466,9 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Start charger cable type detection */
> -	axp288_extcon_enable(info);
> +	ret = axp288_extcon_enable(info);
> +	if (ret < 0)
> +		return ret;
>  
>  	device_init_wakeup(dev, true);
>  	platform_set_drvdata(pdev, info);
> 

