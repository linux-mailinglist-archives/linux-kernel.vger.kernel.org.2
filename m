Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD18E43DC91
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhJ1IBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 04:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbhJ1IBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 04:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635407920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ssfsrlUnUncXSG3OdwN60TRyrIXMk8wx4UyML93w3Ak=;
        b=OBhd/FSwGXXpU0VYHyYR75159p8igeIpFnKAKo3BChcvgFUZZGktULqp+A8RXqNqJhd74f
        nEgrNSnj7JRRvZ4tSTaC83qs0M7XHPgM6IWtvES4XD7tJU1SPi6lUnTbmsFVsBOn+oaQZx
        0qXymvnKxnR5fPmx98o6TgzWdhGROEE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-BK9dYZDBPl6iKe1lNtvebw-1; Thu, 28 Oct 2021 03:58:39 -0400
X-MC-Unique: BK9dYZDBPl6iKe1lNtvebw-1
Received: by mail-ed1-f71.google.com with SMTP id q6-20020a056402518600b003dd81fc405eso4820219edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 00:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ssfsrlUnUncXSG3OdwN60TRyrIXMk8wx4UyML93w3Ak=;
        b=hJSTLOKEeMan7/5i8POQO1/M5jmQb0J7BwnnVw0xAL5P4KAzlXviqN6UDy1vz21AER
         tmayxdW2BqptNba1nPm160Vh7cLSmVbw7T5ZQjcZxHz+NSjI6HWm7/oz5cKKar9tCjby
         dF2FKDkkfw6zuuUf9C/K4Ux2GBBi7UwiMftV2FaHWMpVX4Y05CulkkM8XCe/0CkQQF+v
         rQR5rJQz87aMFxFPAdvAaTgoxwDVifBazmpApxHKtrSCT8gjIATzPPgQYqrZFfBw2PyR
         9raJ+w1mrzHNdJOCGSWS00/c3X5HoCQDuvQtXUiqK6mOwFTDyavlZF9FSM6N3A8BOqm5
         BR5A==
X-Gm-Message-State: AOAM530i2dBAgx4dpN3fOsjCgEhvYQqws6F1bJ/HdVAfbbNop2X2N4HW
        tSOhT2GiM5mrfPBz8K6ujhJhzXV3F/s6kVO0M9XsaF5mT13mV1hRyz1N6lTwIgk0bIUIks3hyCl
        ZE2CNhhjHVQbO+tAC+XPTz82q
X-Received: by 2002:aa7:cb59:: with SMTP id w25mr4013809edt.309.1635407918068;
        Thu, 28 Oct 2021 00:58:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3FCD5EBCZHOsd4tzrmApbRmN4CGccT0ac7DTwb/YZp1flrRDuAeATtlZDfxeJkjyyC59Zfw==
X-Received: by 2002:aa7:cb59:: with SMTP id w25mr4013793edt.309.1635407917911;
        Thu, 28 Oct 2021 00:58:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s12sm1200055edj.82.2021.10.28.00.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 00:58:37 -0700 (PDT)
Message-ID: <f7ac5427-b03a-2d3a-3255-e37ba9b15dcd@redhat.com>
Date:   Thu, 28 Oct 2021 09:58:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] platform/surface: aggregator_registry: Add initial
 support for Surface Pro 8
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org
References: <20211028012845.1887219-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211028012845.1887219-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maximilian,

On 10/28/21 03:28, Maximilian Luz wrote:
> Add preliminary support for the Surface Pro 8 to the Surface Aggregator
> registry. This includes battery/charger status and platform profile
> support.
> 
> In contrast to earlier Surface Pro generations, the keyboard cover is
> now also connected via the Surface Aggregator Module (whereas it was
> previously connected via USB or HID-over-I2C). To properly support the
> HID devices of that cover, however, more changes regarding hot-removal
> of Surface Aggregator client devices as well as a new device hub driver
> are required. We will address those things in a follow-up series, so do
> not add any HID device IDs just yet.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Since it is just device-id additions I can still pick this up for
5.16 if you want / if this is useful.

Do you want me to pick this up for 5.16 ? 

Regards,

Hans



> ---
>  .../platform/surface/surface_aggregator_registry.c   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
> index 2e0d3a808d47..ce2bd88feeaa 100644
> --- a/drivers/platform/surface/surface_aggregator_registry.c
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
> @@ -228,6 +228,15 @@ static const struct software_node *ssam_node_group_sp7[] = {
>  	NULL,
>  };
>  
> +static const struct software_node *ssam_node_group_sp8[] = {
> +	&ssam_node_root,
> +	&ssam_node_bat_ac,
> +	&ssam_node_bat_main,
> +	&ssam_node_tmp_pprof,
> +	/* TODO: Add support for keyboard cover. */
> +	NULL,
> +};
> +
>  
>  /* -- Device registry helper functions. ------------------------------------- */
>  
> @@ -520,6 +529,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
>  	/* Surface Pro 7+ */
>  	{ "MSHW0119", (unsigned long)ssam_node_group_sp7 },
>  
> +	/* Surface Pro 8 */
> +	{ "MSHW0263", (unsigned long)ssam_node_group_sp8 },
> +
>  	/* Surface Book 2 */
>  	{ "MSHW0107", (unsigned long)ssam_node_group_gen5 },
>  
> 

