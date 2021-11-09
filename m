Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A2344AA8E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 10:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244858AbhKIJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 04:28:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244806AbhKIJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636449967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+QQlB4mEIMgWLA4xpaMYxJTm2+I9eYnL0fykYkPn+g=;
        b=LTcGWwPnesHAWLk9UhZzvjh/AqS85TX1ARY4GjgnUJZGizPI8VLLFro8tszwX3X8c7f4vB
        X95+IcIm9qN8X17KWYiNHpEsf1yx8MQVc/FnD0iDE3tnXNBiWRM/E/izVFAmLoeBFhsQK2
        Nou7TTon5crgxh9NSgOdl86hkxBly+8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-gHJxlOhyMmuoOpkVHC9pAA-1; Tue, 09 Nov 2021 04:26:04 -0500
X-MC-Unique: gHJxlOhyMmuoOpkVHC9pAA-1
Received: by mail-ed1-f70.google.com with SMTP id i22-20020a05640242d600b003e28aecc0afso17400277edc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 01:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J+QQlB4mEIMgWLA4xpaMYxJTm2+I9eYnL0fykYkPn+g=;
        b=drVu0+JjW/CCbhoGUbjxgDQaa5ADVedZ/jEeFfSwZRzBySYC7pIEnZffPteIST1cUg
         NOsVnq4eJIdqPt+ndrDlgnBQ53PvCAZAp69qntEb7n2vASdyICULDMxgnHsH7GbZmW6r
         YyUJTctfKL+mqrcjfKeAAzaDBPgvAlOhpEQEyOCS+aM9PEpVTGbv3ix/bBr2Ws/F0HyK
         fJhusQPxhzgIeWMmAgSt4LA2HbxelY2oJtcqt+vkK+q6ethxIBAQnKpE58CajAxt39C9
         pK0sAB/T3qK06Cu1N9R264WHxbdjLqyGVsFV09N6s8+DsEgOuC8Q9nUKluLOQvNGL00g
         yKFw==
X-Gm-Message-State: AOAM532NE6SHCXLFBsyx6IInLirpt0JRKIUF22YuQ4/sQiqTT44gwIdT
        8OLLJBb5NDjzelExlorVKC7scS2imBEXyyK0jq9rpjDImwJ9k/Fk357XZvj+11KVOCFoU3Vb6rC
        IjwpBd6qSUAVjMzvr355T2gbS
X-Received: by 2002:a17:906:ad89:: with SMTP id la9mr7661042ejb.178.1636449963111;
        Tue, 09 Nov 2021 01:26:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwV3lAQ7ceBM6/iSGdjPmt1FkQx02L/6F0D/9fEsTcklwFBo2OyIgK6AYtahgFKcvIDs3UCHA==
X-Received: by 2002:a17:906:ad89:: with SMTP id la9mr7661014ejb.178.1636449962899;
        Tue, 09 Nov 2021 01:26:02 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id hr11sm3700167ejc.108.2021.11.09.01.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 01:26:02 -0800 (PST)
Message-ID: <ecface31-f21e-23f4-6400-7555465fc3cd@redhat.com>
Date:   Tue, 9 Nov 2021 10:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] platform/x86: think-lmi: Abort probe on analyze failure
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>,
        markpearson@lenovo.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <163639463588.1330483.15850167112490200219.stgit@omen>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <163639463588.1330483.15850167112490200219.stgit@omen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/8/21 19:03, Alex Williamson wrote:
> A Lenovo ThinkStation S20 (4157CTO BIOS 60KT41AUS) fails to boot on
> recent kernels including the think-lmi driver, due to the fact that
> errors returned by the tlmi_analyze() function are ignored by
> tlmi_probe(), where  tlmi_sysfs_init() is called unconditionally.
> This results in making use of an array of already freed, non-null
> pointers and other uninitialized globals, causing all sorts of nasty
> kobject and memory faults.
> 
> Make use of the analyze function return value, free a couple leaked
> allocations, and remove the settings_count field, which is incremented
> but never consumed.
> 
> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I'll send this to Linus in my first fixes pull-req for 5.16
(once 516-rc1 is out)

Regards,

Hans



> ---
>  drivers/platform/x86/think-lmi.c |   13 ++++++++++---
>  drivers/platform/x86/think-lmi.h |    1 -
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 9472aae72df2..c4d9c45350f7 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -888,8 +888,10 @@ static int tlmi_analyze(void)
>  			break;
>  		if (!item)
>  			break;
> -		if (!*item)
> +		if (!*item) {
> +			kfree(item);
>  			continue;
> +		}
>  
>  		/* It is not allowed to have '/' for file name. Convert it into '\'. */
>  		strreplace(item, '/', '\\');
> @@ -902,6 +904,7 @@ static int tlmi_analyze(void)
>  		setting = kzalloc(sizeof(*setting), GFP_KERNEL);
>  		if (!setting) {
>  			ret = -ENOMEM;
> +			kfree(item);
>  			goto fail_clear_attr;
>  		}
>  		setting->index = i;
> @@ -916,7 +919,6 @@ static int tlmi_analyze(void)
>  		}
>  		kobject_init(&setting->kobj, &tlmi_attr_setting_ktype);
>  		tlmi_priv.setting[i] = setting;
> -		tlmi_priv.settings_count++;
>  		kfree(item);
>  	}
>  
> @@ -983,7 +985,12 @@ static void tlmi_remove(struct wmi_device *wdev)
>  
>  static int tlmi_probe(struct wmi_device *wdev, const void *context)
>  {
> -	tlmi_analyze();
> +	int ret;
> +
> +	ret = tlmi_analyze();
> +	if (ret)
> +		return ret;
> +
>  	return tlmi_sysfs_init();
>  }
>  
> diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/think-lmi.h
> index f8e26823075f..2ce5086a5af2 100644
> --- a/drivers/platform/x86/think-lmi.h
> +++ b/drivers/platform/x86/think-lmi.h
> @@ -55,7 +55,6 @@ struct tlmi_attr_setting {
>  struct think_lmi {
>  	struct wmi_device *wmi_device;
>  
> -	int settings_count;
>  	bool can_set_bios_settings;
>  	bool can_get_bios_selections;
>  	bool can_set_bios_password;
> 
> 

