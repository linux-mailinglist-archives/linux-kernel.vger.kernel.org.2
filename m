Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF49321380
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhBVJ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:56:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbhBVJ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613987726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hRBICccBgEcAau0frnzIZLdNGmFu16xAVTYuVaZrsmQ=;
        b=YbaoxaDpERE0OJwgOKXV6GcM4CSEWX85w/+jJwBhRb9dP5uLnQf8KSclkU/Z+OW144s+di
        NBXlwwvE9AOJ8gE3PO79SjjTkxawZsRBKZxQ01mYxmWY2axrqPOuqzA523qxRKJo0r6yuX
        X/tq1Y+6MK0zI4cCoX8Hu2xYx3bwH6U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-JOf1fcJoNfeAfp0JLlgqdw-1; Mon, 22 Feb 2021 04:55:25 -0500
X-MC-Unique: JOf1fcJoNfeAfp0JLlgqdw-1
Received: by mail-ed1-f72.google.com with SMTP id i4so6721366edt.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hRBICccBgEcAau0frnzIZLdNGmFu16xAVTYuVaZrsmQ=;
        b=qdby2SYxvKvVJHOh8PoDSB+dQ2Y8hkb8egmlk5ScOQfinK+cZoCzKmkKbS1FCHByOg
         TICAHx51BpZys5JgczZdJXCsHrNjRc0DEQkJ4sGsCS7AcUXQhm7mvxNkmoGvZ2JhMJbn
         i0wv1Af+SmxarMuPSxLl8hZ0PgYHK8SK5YdNrGRxOkiHmoAM2ykcsbe3VZYNblDZ8Ug0
         ul8+n13tJeRXPuY2QJe/9wIVTGAaK6DXnmWOx7nr96e0yOYgt1dRa1nGLA+BqcjN6UbK
         eVMBgBvm4p4yKmP2NouYR2MQSdyH7dn5W0pYsV2wHXTceZYTfnk2WKJTsvjuUX41wzjB
         ptIg==
X-Gm-Message-State: AOAM530sB67TyddvC86uOQ7bS9c6pmovjUK7h2CmSI+JOHb00S4lx3pv
        VHWKROM2nWe9PIMtLAN5zzyyVqilGKMmKgDVWWhEG5hwtjb5Qwy8/y7ZrCNpbwQwkJXeezzeDQ6
        GnF+2xLyZa9z7iWXBRomll3L92o7Rr3Cu/RHWCh318stKymGxNacgvnsR0KrFNgflv/bKKKUHy1
        4n
X-Received: by 2002:a05:6402:1593:: with SMTP id c19mr2829597edv.274.1613987723487;
        Mon, 22 Feb 2021 01:55:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzplWvd2ZJiexdrTEF1gNnTBzIhr4LG2vPt5qZmzus9ICwwvtYFaL7eGZAVHOpxqxMqrO9Skg==
X-Received: by 2002:a05:6402:1593:: with SMTP id c19mr2829586edv.274.1613987723344;
        Mon, 22 Feb 2021 01:55:23 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id li22sm10085829ejb.29.2021.02.22.01.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 01:55:23 -0800 (PST)
Subject: Re: [PATCH 1/2] platform/x86: hp-wmi: rename "thermal policy" to
 "thermal profile"
To:     Elia Devito <eliadevito@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210221210256.68198-1-eliadevito@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <525eef3b-6534-6f3f-e8f0-338500d8023f@redhat.com>
Date:   Mon, 22 Feb 2021 10:55:22 +0100
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

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I will merge this once we are out of the merge-window / once 5.12-rc1 is out.

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

