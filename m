Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D700C4339E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhJSPPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229803AbhJSPPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634656371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4j3wRsr1R6JKs8smo/Oo3M1fEsNmOxTZQ5lxtVnqk0o=;
        b=G4JIFgnuB/pLl79+afP34Lg3l/DGtdZ/kT4QJQt+C5eyEc7aBkweOfIzF+MI3zX6eAo7we
        LGfQABh65lNFs3HIkrgl9URZJD6jvi6TS6uC/HAGzJ18LbKALAa4h1yIywh++g424kzTUH
        v1aYFwqnwA0DYoBjKvAc1GezuvCpU04=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-Tx_1Ps4ENPifSAR7cTwuuA-1; Tue, 19 Oct 2021 11:12:50 -0400
X-MC-Unique: Tx_1Ps4ENPifSAR7cTwuuA-1
Received: by mail-ed1-f70.google.com with SMTP id x5-20020a50f185000000b003db0f796903so17904523edl.18
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4j3wRsr1R6JKs8smo/Oo3M1fEsNmOxTZQ5lxtVnqk0o=;
        b=h6IsPE6cq7ZLiOq4XLjlMuL8+702/r12fDRGFMJvlkik9AYzCmZh2wmcS86Hm+ew1/
         Yqh2w6pFVndjg08OrkuWCbPQhxffh4zoSqsuEGdBreV/SQ4jMtywv+TmZNKDyVppTj3C
         f6p2Ug82lOvYPgRwSF3I3n7GXEuLwXY+5oUyO8xRAjLz3Zg1RFPOQO9fpKXLE0WL6mxv
         0jHhGwf0Cp2deykYNB5kA3n/pKT02gsjS+u4YhXihLba5M9m+CJ/Kb1OVAwgiHi8pDSG
         /aZZw6SlbS8bvSAPTsPcdh3k3ZOIJzjJuUjuWlDFbAs+/i56A/0OKKtjBG0h3mva9hUD
         Lc2A==
X-Gm-Message-State: AOAM532oJk75ys34yT4kfX4W2r9G1+6zdpDzoI1/EUtEJry3LiM5l6gY
        A8db9a8rXin48KsB+s0KNHGyqP/o23f80EDx18pcfroajH89gy3IaAghMxfdytGwP7CUQNyMjpN
        vG5sc/qX2rJPBtK7teLPGcSUO
X-Received: by 2002:a05:6402:2808:: with SMTP id h8mr54956650ede.394.1634656368693;
        Tue, 19 Oct 2021 08:12:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6fHAJCy08NR0UGEaoWC6/TzaHL3Eet5KuB0gtlqgsRb6zgR79RYzhLtsIFvPephqGs5b44g==
X-Received: by 2002:a05:6402:2808:: with SMTP id h8mr54956616ede.394.1634656368434;
        Tue, 19 Oct 2021 08:12:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z4sm13822604edd.46.2021.10.19.08.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 08:12:48 -0700 (PDT)
Message-ID: <0c1a4b5a-bfeb-4ad2-99cd-fa65b96c8346@redhat.com>
Date:   Tue, 19 Oct 2021 17:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] x86: replace snprintf in show functions with sysfs_emit
Content-Language: en-US
To:     Qing Wang <wangqing@vivo.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1634280641-4862-1-git-send-email-wangqing@vivo.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1634280641-4862-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/15/21 08:50, Qing Wang wrote:
> show() must not use snprintf() when formatting the value to be
> returned to user space.
> 
> Fix the coccicheck warnings:
> WARNING: use scnprintf or sprintf.
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/panasonic-laptop.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
> index d4f4444..37850d0 100644
> --- a/drivers/platform/x86/panasonic-laptop.c
> +++ b/drivers/platform/x86/panasonic-laptop.c
> @@ -470,7 +470,7 @@ static ssize_t numbatt_show(struct device *dev, struct device_attribute *attr,
>  	if (!acpi_pcc_retrieve_biosdata(pcc))
>  		return -EIO;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_NUM_BATTERIES]);
> +	return sysfs_emit(buf, "%u\n", pcc->sinf[SINF_NUM_BATTERIES]);
>  }
>  
>  static ssize_t lcdtype_show(struct device *dev, struct device_attribute *attr,
> @@ -482,7 +482,7 @@ static ssize_t lcdtype_show(struct device *dev, struct device_attribute *attr,
>  	if (!acpi_pcc_retrieve_biosdata(pcc))
>  		return -EIO;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_LCD_TYPE]);
> +	return sysfs_emit(buf, "%u\n", pcc->sinf[SINF_LCD_TYPE]);
>  }
>  
>  static ssize_t mute_show(struct device *dev, struct device_attribute *attr,
> @@ -494,7 +494,7 @@ static ssize_t mute_show(struct device *dev, struct device_attribute *attr,
>  	if (!acpi_pcc_retrieve_biosdata(pcc))
>  		return -EIO;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_MUTE]);
> +	return sysfs_emit(buf, "%u\n", pcc->sinf[SINF_MUTE]);
>  }
>  
>  static ssize_t mute_store(struct device *dev, struct device_attribute *attr,
> @@ -524,7 +524,7 @@ static ssize_t sticky_key_show(struct device *dev, struct device_attribute *attr
>  	if (!acpi_pcc_retrieve_biosdata(pcc))
>  		return -EIO;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sticky_key);
> +	return sysfs_emit(buf, "%u\n", pcc->sticky_key);
>  }
>  
>  static ssize_t sticky_key_store(struct device *dev, struct device_attribute *attr,
> @@ -566,7 +566,7 @@ static ssize_t eco_mode_show(struct device *dev, struct device_attribute *attr,
>  		result = -EIO;
>  		break;
>  	}
> -	return snprintf(buf, PAGE_SIZE, "%u\n", result);
> +	return sysfs_emit(buf, "%u\n", result);
>  }
>  
>  static ssize_t eco_mode_store(struct device *dev, struct device_attribute *attr,
> @@ -625,7 +625,7 @@ static ssize_t ac_brightness_show(struct device *dev, struct device_attribute *a
>  	if (!acpi_pcc_retrieve_biosdata(pcc))
>  		return -EIO;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_AC_CUR_BRIGHT]);
> +	return sysfs_emit(buf, "%u\n", pcc->sinf[SINF_AC_CUR_BRIGHT]);
>  }
>  
>  static ssize_t ac_brightness_store(struct device *dev, struct device_attribute *attr,
> @@ -655,7 +655,7 @@ static ssize_t dc_brightness_show(struct device *dev, struct device_attribute *a
>  	if (!acpi_pcc_retrieve_biosdata(pcc))
>  		return -EIO;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_DC_CUR_BRIGHT]);
> +	return sysfs_emit(buf, "%u\n", pcc->sinf[SINF_DC_CUR_BRIGHT]);
>  }
>  
>  static ssize_t dc_brightness_store(struct device *dev, struct device_attribute *attr,
> @@ -685,7 +685,7 @@ static ssize_t current_brightness_show(struct device *dev, struct device_attribu
>  	if (!acpi_pcc_retrieve_biosdata(pcc))
>  		return -EIO;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_CUR_BRIGHT]);
> +	return sysfs_emit(buf, "%u\n", pcc->sinf[SINF_CUR_BRIGHT]);
>  }
>  
>  static ssize_t current_brightness_store(struct device *dev, struct device_attribute *attr,
> @@ -710,7 +710,7 @@ static ssize_t current_brightness_store(struct device *dev, struct device_attrib
>  static ssize_t cdpower_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%d\n", get_optd_power_state());
> +	return sysfs_emit(buf, "%d\n", get_optd_power_state());
>  }
>  
>  static ssize_t cdpower_store(struct device *dev, struct device_attribute *attr,
> 

