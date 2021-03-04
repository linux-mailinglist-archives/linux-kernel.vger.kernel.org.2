Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5025B32D426
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 14:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241279AbhCDN2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 08:28:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241273AbhCDN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614864385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OIAoO0m20JO/JcrsDigzaLhR/DprzftkeX4MMponqo0=;
        b=NY8jjwExIkr4Txwnt8Gn+YfTjl+2mqJie9W+zJal8t2BP2omQHuSVomGal1p4XP/MEHRuC
        C3rh5Qp073/kTfdpEatNKP0oqktf5i1ICZ7WQDFMaEnDfODIQPuHtN8r+HNb6TOPSCjgh8
        jb6JBL0GWcvFdSADZLbIIqh29WyhGtg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-XJcTUuMZMN-WAyrEBe97aw-1; Thu, 04 Mar 2021 08:26:23 -0500
X-MC-Unique: XJcTUuMZMN-WAyrEBe97aw-1
Received: by mail-ej1-f69.google.com with SMTP id 7so12096854ejh.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 05:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OIAoO0m20JO/JcrsDigzaLhR/DprzftkeX4MMponqo0=;
        b=K15V1FgbGN8fYz6Z467DPS6rsSAoMcExDmBjpVyOrXOrz+Uc3qTa8sNMNxmndn8kdS
         531Ioqypky8aXODkKhKSaZeEXBXZdzwZPAPJDzUoHLHxeQIbvRwInP6pregYK0AmUMv0
         CpYWUG6Cylw2Cz2y0KWY4QPg3CEo0mR8GlLmiORBOp7g6kdBwBXIlR0wUbB+5BK4Xglw
         Vv6m58jm1gIf0dEN7daPgI1jNRHjiWZ+4+mvLFv1X9A99J9qnjRKkNGBAAdAKwZN94RG
         ZGFAnPTdwhtqn0WOp2QKtrJT+19T6KIsQ2Nh5e0UrXULS9jmOXc5TssfS0DiWPIH8aLF
         3oAw==
X-Gm-Message-State: AOAM530XTElZ2lzFMCIYXO1Jk485w64PJ2ulUaqv5bMz9KIRvQdrG9Ht
        JUv2mLsIR62a5EkJ4Bp+4efujfI9+ZqgdqTgJWclkuRBXEGgtBKpOpHlH3vjSZybD1UoPrGSyqB
        1UNbPhrjnhep/ydf1uCz2vo3Vy2UuzaWjuXj8ZNmdl/74Rj23BYtmbotofTcJzk7zmBSFNlb9yP
        6o
X-Received: by 2002:a17:906:719:: with SMTP id y25mr4156523ejb.180.1614864381499;
        Thu, 04 Mar 2021 05:26:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIrtmR5Mep4xXyAK0fSjTcl1jQ/YxpnqllGttPA25ksLe8WqhZzZ/+Dz056cHaVpp69EUz0Q==
X-Received: by 2002:a17:906:719:: with SMTP id y25mr4156505ejb.180.1614864381310;
        Thu, 04 Mar 2021 05:26:21 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e26sm9342136edj.29.2021.03.04.05.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 05:26:19 -0800 (PST)
Subject: Re: [PATCH 1/2] platform/x86: hp-wmi: rename "thermal policy" to
 "thermal profile"
To:     Elia Devito <eliadevito@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210221210256.68198-1-eliadevito@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e31a5de6-b446-8d73-7200-8bbbde6341a2@redhat.com>
Date:   Thu, 4 Mar 2021 14:26:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210221210256.68198-1-eliadevito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/21/21 10:02 PM, Elia Devito wrote:
> rename "thermal policy" with the more appropriate term "thermal profile"
> 
> Signed-off-by: Elia Devito <eliadevito@gmail.com>

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
>  drivers/platform/x86/hp-wmi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index e94e59283ecb..6d7b91b8109b 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -85,7 +85,7 @@ enum hp_wmi_commandtype {
>  	HPWMI_FEATURE2_QUERY		= 0x0d,
>  	HPWMI_WIRELESS2_QUERY		= 0x1b,
>  	HPWMI_POSTCODEERROR_QUERY	= 0x2a,
> -	HPWMI_THERMAL_POLICY_QUERY	= 0x4c,
> +	HPWMI_THERMAL_PROFILE_QUERY	= 0x4c,
>  };
>  
>  enum hp_wmi_command {
> @@ -869,19 +869,19 @@ static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
>  	return err;
>  }
>  
> -static int thermal_policy_setup(struct platform_device *device)
> +static int thermal_profile_setup(struct platform_device *device)
>  {
>  	int err, tp;
>  
> -	tp = hp_wmi_read_int(HPWMI_THERMAL_POLICY_QUERY);
> +	tp = hp_wmi_read_int(HPWMI_THERMAL_PROFILE_QUERY);
>  	if (tp < 0)
>  		return tp;
>  
>  	/*
> -	 * call thermal policy write command to ensure that the firmware correctly
> +	 * call thermal profile write command to ensure that the firmware correctly
>  	 * sets the OEM variables for the DPTF
>  	 */
> -	err = hp_wmi_perform_query(HPWMI_THERMAL_POLICY_QUERY, HPWMI_WRITE, &tp,
> +	err = hp_wmi_perform_query(HPWMI_THERMAL_PROFILE_QUERY, HPWMI_WRITE, &tp,
>  							   sizeof(tp), 0);
>  	if (err)
>  		return err;
> @@ -900,7 +900,7 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>  	if (hp_wmi_rfkill_setup(device))
>  		hp_wmi_rfkill2_setup(device);
>  
> -	thermal_policy_setup(device);
> +	thermal_profile_setup(device);
>  
>  	return 0;
>  }
> 

