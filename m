Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E3F405AAE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhIIQWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:22:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234735AbhIIQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631204453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oy5MUcl8JbqTf0QdT6t6Z2vn0XEfX3OeBac2GaUJDQA=;
        b=bhfEDB7CH8GdKmtL8fLZz5azhrYxqIPSNQiedK/Y6+E/N5fbvzb060Y9X9ty7gCcZhn9tj
        Av3l3Xb8dxYKHpEyOSRvXRZcW5yjdMgGWLkhbTGVwe1ZAh53zhA3hCgU/w53DL3ZdsYH9U
        SPdnYPvCjPjVlLHmg2T9p2JMG6ObHU0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-DFVj_0pvP0CBCugNTGWIuw-1; Thu, 09 Sep 2021 12:20:52 -0400
X-MC-Unique: DFVj_0pvP0CBCugNTGWIuw-1
Received: by mail-ej1-f69.google.com with SMTP id r21-20020a1709067055b02904be5f536463so1096495ejj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 09:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oy5MUcl8JbqTf0QdT6t6Z2vn0XEfX3OeBac2GaUJDQA=;
        b=2oXNrDi1cjTJ/9QHZzjweuAFDK0/wBpxIMJ1iDWOUv9Z0T/tIEZGeBDT0cr/k9ZMnL
         PmpsmdnlVytMgv4IpfDss5q6J8n2wTW4sGiwUHvXnSrOuaIStk/XahJNk1VCKO9JMiMu
         La7tAJrr97jYwsYaMJViql96BedCyA3W+UO2sCxnGArfr+/MPyP9i7Kelfs8nPYIuCam
         CwGo0lHQW+RHIw9zjnw5T+eXZA2ORd8lHIT1qqGvSmPPzwF+vMj4AqBLWZzddT6Y6tKD
         HCk7PEUtDEOzQp0yJ1RopUb8m9sn7KbLACqRsafiNQo3PkTQMfBYJvvsQU6UJvpt0Bu2
         XDRw==
X-Gm-Message-State: AOAM5336FahEl2sSE7peqVT4J1JLQY2Hmyyp+iK+avm/Fkc85QskPZN1
        z+97GCXu6uV0SekMkjzZYeZvYi50C8Xu+lLG5oeqfG71Iv1NYpZp+NCBbkSq7TKQkL5UeaYMvdV
        jHOfxpD5hwxVwCY8Ayy7lAjxj8by8lWQEBWWZZNtdr/eBfAMVF6xvmPJXmdhSQOBzKbDJJKgrdN
        e4
X-Received: by 2002:a17:906:304e:: with SMTP id d14mr4332592ejd.170.1631204450558;
        Thu, 09 Sep 2021 09:20:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6pqFRgUsCH+Sr5qHDfNMWmemJbEXrernopFG75XnQIO2FTDmJC4Ihoys8RiTDXhFtZWy5Uw==
X-Received: by 2002:a17:906:304e:: with SMTP id d14mr4332567ejd.170.1631204450288;
        Thu, 09 Sep 2021 09:20:50 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r16sm1336146edt.15.2021.09.09.09.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 09:20:49 -0700 (PDT)
Subject: Re: [PATCH] extcon: extcon-axp288: use low level P-Unit semaphore
 lock for axp288 register accesses
To:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
References: <20210909151820.5303-1-fabioaiuto83@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5737f0f9-4ace-cb74-5ab2-5a871b8796da@redhat.com>
Date:   Thu, 9 Sep 2021 18:20:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210909151820.5303-1-fabioaiuto83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 9/9/21 5:18 PM, Fabio Aiuto wrote:
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
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I've also given it a test run on a Chuwi Hibook which uses this PMIC:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/extcon/extcon-axp288.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index fdb31954cf2b..460402b14ef2 100644
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
> @@ -215,6 +216,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>  	unsigned int cable = info->previous_cable;
>  	bool vbus_attach = false;
>  
> +	iosf_mbi_block_punit_i2c_access();
> +
>  	vbus_attach = axp288_get_vbus_attach(info);
>  	if (!vbus_attach)
>  		goto no_vbus;
> @@ -253,6 +256,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>  	}
>  
>  no_vbus:
> +	iosf_mbi_unblock_punit_i2c_access();
> +
>  	extcon_set_state_sync(info->edev, info->previous_cable, false);
>  	if (info->previous_cable == EXTCON_CHG_USB_SDP)
>  		extcon_set_state_sync(info->edev, EXTCON_USB, false);
> @@ -275,6 +280,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>  	return 0;
>  
>  dev_det_ret:
> +	iosf_mbi_unblock_punit_i2c_access();
> +
>  	if (ret < 0)
>  		dev_err(info->dev, "failed to detect BC Mod\n");
>  
> @@ -307,11 +314,14 @@ static irqreturn_t axp288_extcon_isr(int irq, void *data)
>  
>  static void axp288_extcon_enable(struct axp288_extcon_info *info)
>  {
> +	iosf_mbi_block_punit_i2c_access();
>  	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
>  						BC_GLOBAL_RUN, 0);
>  	/* Enable the charger detection logic */
>  	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
>  					BC_GLOBAL_RUN, BC_GLOBAL_RUN);
> +
> +	iosf_mbi_unblock_punit_i2c_access();
>  }
>  
>  static void axp288_put_role_sw(void *data)
> @@ -384,10 +394,14 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	iosf_mbi_block_punit_i2c_access();
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
> 

