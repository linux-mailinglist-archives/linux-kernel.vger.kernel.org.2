Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE9F32D570
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhCDOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:37:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231697AbhCDOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614868526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wQdAv9dqu3ihNNDosTCrUef7IjrV7jjJSl91dhkxJnE=;
        b=YkEMsurc8x+a8VbmWYrTfgut2ddaZ552pvLKOGqrQRDHjMpn3eCu41dYu25SlLm7lvtJdd
        FMECRAD8mNh59QpucKW2duMGIf2jQr5R+PLRW10q2XHAbnntAtgYp8ZznglSydf5glT4/3
        u44fikwwcfxkxMGnRf9pqsV4BpoR0OU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-8Tnb-s9kMu-SSbbnmb3s5Q-1; Thu, 04 Mar 2021 09:35:24 -0500
X-MC-Unique: 8Tnb-s9kMu-SSbbnmb3s5Q-1
Received: by mail-ej1-f70.google.com with SMTP id rl7so6869717ejb.16
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 06:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wQdAv9dqu3ihNNDosTCrUef7IjrV7jjJSl91dhkxJnE=;
        b=uH2hCDcfOjEkIGG3QBMlLJE7w4F645u45Jf6SWTfWeFcg/Od3Agr0/rkTwViDHee6l
         z7668une2ElyAKifXFxc0LoIZjPbMFsUjnz736m9+twklEOrGRhRLYuJc2sPQPCNipVC
         EycYbMjVwLucO1nBdQa4AL7y8WCFTj42y+gor3HSJoa7Qcm9B6G1hAqzxhlRF3tCVNri
         uHqi27kKWjXTxIzMApMLf2sCortGp2/9AqWd0jdl7aVTiu3+OpzqTJCL4u+sc+YCDRsx
         g35cCTiXeF3irn0w+kqUT8V5mf6XHDooYfJ3nrs6CJeOltw9jyf7AlY+mMTfi6cmWzS3
         KQAQ==
X-Gm-Message-State: AOAM530HAAteyjkqV9pr9m0nXgqgI/oSC8feWgOjw8IoQvshq9n9rySW
        e6a5yqHq+Ve9oFhMCcmsFOjSPWamdK9aK0dftpIBB2K93rdTSVIPQclLY7PcZhfRoJp5rgOveLC
        UHT2lU/dSO7Zoeh0Gjfbr6996fLoaQy/5cvq3brtRpUAMaYWkDuIiGMMDun35QH8LV/A5a6XH5B
        C5
X-Received: by 2002:a17:906:1457:: with SMTP id q23mr4508886ejc.43.1614868523164;
        Thu, 04 Mar 2021 06:35:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/m/4pak71VMA+lhDsQUxoTU6Jn9KvocqxwMH+AgtYyMjtnCXrXhDbUsBh951EbKBIsrbWhA==
X-Received: by 2002:a17:906:1457:: with SMTP id q23mr4508682ejc.43.1614868520976;
        Thu, 04 Mar 2021 06:35:20 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id n25sm2592851edq.55.2021.03.04.06.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 06:35:20 -0800 (PST)
Subject: Re: [PATCH] WMI: asus: Reduce G14 and G15 match to min product name
To:     Luke D Jones <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc:     corentin.chary@gmail.com, mgross@linux.intel.com,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20210227102010.65429-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <94e01965-1511-c687-1c20-fe1f01041ac3@redhat.com>
Date:   Thu, 4 Mar 2021 15:35:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210227102010.65429-1-luke@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/27/21 11:20 AM, Luke D Jones wrote:
> This patch reduces the product match for GA401 series laptops to
> the minimum string required.
> 
> The GA401 series of laptops has a lengthy list of product
> variations in the 2020 series and the 2021 series refresh
> is using the same base product ID of GA401.
> 
> The same is also true for the GA502 series, and the new GA503
> series which is added in this patch as a variant of the G15.

Thank you for your patch.

I msut say that I find it very strange that 2021 series laptops need
to use the Asus vendor specific WMI interface for backlight control.

I see that the GA401 GA502 and GA503 models are all models with
AMD 4000/5000 series CPUs + Nvidia 2060 series GPUs.
So I guess it may be possible that this is the right thing
to do, and I do realize that we are already doing this for the
listed models. But it seems weird.

Modern laptops almost always use the native backlight control
build into the drm/kms driver. And in some special cases
(hybrid GPU setups) they might use the good old ACPI-video
interface. But using vendor specific interfaces sounds very
wrong to me. That is something which was typically done on
pre Windows XP era hardware.

Have you tried passing acpi_backlight=video on the kernel commandline?

What is the output of ls /sys/class/backlight before and after this
patch?

What is the output of ls /sys/class/backlight when using
acpi_backlight=video on the kernel commandline?

If the ls output shows multiple interfaces have you tried using all
listed interfaces directly from sysfs / the commandline ?

(perhaps userspace is picking the wrong interface in the case there
are multiple interfaces?)

Note what you are doing now is the equivalent of passing
acpi_backlight=vendor, which again is a weird thing to do on
recent / new hardware.

Also your commit message seems to lack a lot of details like:

1. Do you own an effected or multiple affected models yourself on
which you tested this?

2. Was this tested by others on other models of these series?

3. I assume this was discussed with others in some mailinglist /
forum discussion please provide links to this discussion.

4. Has this been tested with with both the nouveau and the
nvidia binary driver or only with the nvidia binary driver ?

5. What were the symptoms / problems noticed before making this change
and how do things work after making the change?

Regards,

Hans





> 
> Signed-off-by: Luke D Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-nb-wmi.c | 57 ++++--------------------------
>  1 file changed, 6 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index d41d7ad14be0..f4db67c3eba2 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -427,73 +427,28 @@ static const struct dmi_system_id asus_quirks[] = {
>  	},
>  	{
>  		.callback = dmi_matched,
> -		.ident = "ASUSTeK COMPUTER INC. GA401IH",
> +		.ident = "ASUSTeK COMPUTER INC. GA401",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "GA401IH"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "GA401"),
>  		},
>  		.driver_data = &quirk_asus_vendor_backlight,
>  	},
>  	{
>  		.callback = dmi_matched,
> -		.ident = "ASUSTeK COMPUTER INC. GA401II",
> +		.ident = "ASUSTeK COMPUTER INC. GA502",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "GA401II"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "GA502"),
>  		},
>  		.driver_data = &quirk_asus_vendor_backlight,
>  	},
>  	{
>  		.callback = dmi_matched,
> -		.ident = "ASUSTeK COMPUTER INC. GA401IU",
> +		.ident = "ASUSTeK COMPUTER INC. GA503",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "GA401IU"),
> -		},
> -		.driver_data = &quirk_asus_vendor_backlight,
> -	},
> -	{
> -		.callback = dmi_matched,
> -		.ident = "ASUSTeK COMPUTER INC. GA401IV",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "GA401IV"),
> -		},
> -		.driver_data = &quirk_asus_vendor_backlight,
> -	},
> -	{
> -		.callback = dmi_matched,
> -		.ident = "ASUSTeK COMPUTER INC. GA401IVC",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "GA401IVC"),
> -		},
> -		.driver_data = &quirk_asus_vendor_backlight,
> -	},
> -		{
> -		.callback = dmi_matched,
> -		.ident = "ASUSTeK COMPUTER INC. GA502II",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "GA502II"),
> -		},
> -		.driver_data = &quirk_asus_vendor_backlight,
> -	},
> -	{
> -		.callback = dmi_matched,
> -		.ident = "ASUSTeK COMPUTER INC. GA502IU",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "GA502IU"),
> -		},
> -		.driver_data = &quirk_asus_vendor_backlight,
> -	},
> -	{
> -		.callback = dmi_matched,
> -		.ident = "ASUSTeK COMPUTER INC. GA502IV",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "GA502IV"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "GA503"),
>  		},
>  		.driver_data = &quirk_asus_vendor_backlight,
>  	},
> 

