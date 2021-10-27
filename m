Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2663443CBC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242497AbhJ0OS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242400AbhJ0OQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635344032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ly0sD9mgKwi2cWXq7KBfTQkletnFH+Zj3US/GhzOwog=;
        b=P9DJWeOaJbwWF8vGQn6e1+OVeQLjJcGHAdic7DgWHsPbEvmRwaMvbBcfjKqCLAa9Jl6FvK
        NJH1NE0pWCru4rDohQeShIxxmJto9ujTbRyIlEWGR/NGhmqm4cO5vMrn+WXjqsRgTB7ngt
        r8GAPny9D/9BAronk1Ud05vzqBW+kNA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-bMAVpT6-O0y8PYhLrVaGLA-1; Wed, 27 Oct 2021 10:13:51 -0400
X-MC-Unique: bMAVpT6-O0y8PYhLrVaGLA-1
Received: by mail-ed1-f69.google.com with SMTP id s12-20020a50dacc000000b003dbf7a78e88so2463640edj.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ly0sD9mgKwi2cWXq7KBfTQkletnFH+Zj3US/GhzOwog=;
        b=jkMabvbmxnxFvmpUcUX6784oqThIvz02gyKMwN3kZtL6RW4IocaqXim3mevCdKnO8Z
         4HGiai9Jiad5wjwJVApSeJL9P3DLVp9LZBj2KMtrIEZtkH90jeNYEhPOdWy25mMFymLe
         oJ098xQVznciWb79oexHVLGgc584yf6RRbNrD6WFviNW2LGb4+wO5p9J2Sl5Wkp1Kv4p
         Kn8/p8ThBcle+FOZ4am66BLkKyAbIgzs65XF8VwyIiuQT5RMstSIgBeV66C3ijjPxoq/
         BnXr+EOYllUmUkB4/8LI5U1sr7ysdUwycYimdk4P4bIjvD5pPNPMqFEATF62jmy40Imu
         Z+4Q==
X-Gm-Message-State: AOAM532lZWH1tdXyiY9gsQEtEhjEWXdSFZzRhO7jfV0bWMuEmtF4AB+f
        Q+VRFsmTPZpB+VCotM7RO9zouhOf8vokiGEPZVpi88czwQfwNHoa+wLvjd/+NFkeMP/4k3VPOiX
        Uk0u6GVRG+gj//iarUehWuaqi
X-Received: by 2002:a17:907:7f14:: with SMTP id qf20mr40217442ejc.110.1635344030317;
        Wed, 27 Oct 2021 07:13:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhfsndShbnezsDO1DlbWsk4fvaAvz0NLTi/X0SlJMSKLND7a07wjt2biOBqpjREWJIAkIgVA==
X-Received: by 2002:a17:907:7f14:: with SMTP id qf20mr40217423ejc.110.1635344030155;
        Wed, 27 Oct 2021 07:13:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p25sm86107edt.23.2021.10.27.07.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 07:13:49 -0700 (PDT)
Message-ID: <d14456e0-9df3-7239-7598-9181cf807215@redhat.com>
Date:   Wed, 27 Oct 2021 16:13:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: touchscreen_dmi.c Patch for Viglen Connect 10
Content-Language: en-US
To:     Mark Stamp <stamp497@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org
References: <67f9a3603a52aeb8fd1463fd5786ed544e79ed05.camel@googlemail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <67f9a3603a52aeb8fd1463fd5786ed544e79ed05.camel@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 10/27/21 04:11, Mark Stamp wrote:
> Hello. 
> 
> I previously spoke with you on a touchscreen issue
> 
> https://github.com/onitake/gsl-firmware/issues/178
> 
> With regard to that, I made a patch for touchscreen_dmi.c. It adds
> parameters for the Viglen Connect 10 tablet to get its touchscreen and
> home button working.
> 
> Signed-off-by: Mark Stamp <stamp497@googlemail.com>

Thank you for your patch.

Unfortunately your email program has wrapped some long lines:

> 
> --- touchscreen_dmi.c.orig	2021-10-27 01:26:47.842668712 +0100
> +++ touchscreen_dmi.c	2021-10-27 01:27:06.426298127 +0100
> @@ -938,6 +938,26 @@ static const struct ts_dmi_data trekstor
>  	.properties	= trekstor_surftab_wintron70_props,
>  };
>  
> +static const struct property_entry viglen_connect_10_props[] = {
> +	//PROPERTY_ENTRY_U32("touchscreen-min-x", 20),
> +	PROPERTY_ENTRY_U32("touchscreen-min-x", 0),
> +	PROPERTY_ENTRY_U32("touchscreen-min-y", 0),
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1890),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
> +	PROPERTY_ENTRY_U32("touchscrken-fuzz-x", 8),
> +	PROPERTY_ENTRY_U32("touchscreen-fuzz-y", 6),
> +	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +	PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-viglen-
> connect-10.fw"),
> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +	PROPERTY_ENTRY_BOOL("silead,home-button"),
> +	{ }
> +};
> +
> +static const struct ts_dmi_data viglen_connect_10_data = {
> +	.acpi_name	= "MSSL1680:00",
> +	.properties	= viglen_connect_10_props,
> +};
> +
>  static const struct property_entry vinga_twizzle_j116_props[] = {
>  	PROPERTY_ENTRY_U32("touchscreen-size-x", 1920),
>  	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
> @@ -1522,6 +1542,14 @@ const struct dmi_system_id touchscreen_d
>  		},
>  	},
>  	{
> +		/* Viglen Connect 10 */
> +		.driver_data = (void *)&viglen_connect_10_data,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Viglen Ltd."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Connect 10''
> Tablet PC"),

And at least for this line I'm not sure how to unwrap it (does there
need to be a space there or not ?).


> +		},
> +	},
> +	{
>  		/* Vinga Twizzle J116 */
>  		.driver_data = (void *)&vinga_twizzle_j116_data,
>  		.matches = {
> 
> 


Can you resend this using git send-email (preferred), or send the
diff as attachment instead of inlining it?

Regards,

Hans

