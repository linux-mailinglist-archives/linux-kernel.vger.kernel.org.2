Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687B44264FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhJHHAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhJHHAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633676298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aI4nwKARGEbvTEFymRsL3ZXfgTjGbvu+ar8bq0K6ijQ=;
        b=c8z6/NDVgLbHk2Z8VTpPHsV5tdiB4ezzl23dNXCKkjCzGx5umU1ar4X2iHP0HCVesHDqBS
        5EkhA8+21/wLIkqzTyTpapiuINgiYr3cQCghP9fVilOai9oarWRKPaVtOOhcA81hfzan35
        NrvbKF7QZpCqN4oP211xT4bAGZnk4tI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-0WxPLgDqMkuH7AapdkmSoA-1; Fri, 08 Oct 2021 02:58:07 -0400
X-MC-Unique: 0WxPLgDqMkuH7AapdkmSoA-1
Received: by mail-ed1-f72.google.com with SMTP id x5-20020a50f185000000b003db0f796903so8247853edl.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 23:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aI4nwKARGEbvTEFymRsL3ZXfgTjGbvu+ar8bq0K6ijQ=;
        b=RApAe0kLS33q9FfLVECoBiZ653K4zAx5dAALkJ3NDiGDcgPAfFxzold2mCNm94SlJS
         ESYCq1s639E+7HGc+3c5jdeXXnF/80NCIkumaSvKmg/ksPwMNFWhljTMv6nKdSr3MP8q
         JoZs39bjREzyVhX1bjID2L2IF/aMkL3OJ4VK59vJUcTDmTV1Ga46rA+hRHXWEIdxjC1+
         SaBeILE3KVNt0f16fu9Yt+tD/UGXARq0wBLT4WFpcz+fJHH7/E5MkJVKlTcVYxgC1KrQ
         q29syFPb6hJnBJti6gqR8zgSZRuerUqK9/2Hm6taHdyN8kDbvdWSIxkFqGQjL5BERo0I
         fhzA==
X-Gm-Message-State: AOAM530hJahEvvo6ScSYWfZP+B91qobAhMLgxbrDhEUSgDHayStJHb9L
        Vo1RRWM5T9tcVSg95s/XVa395524HWWzzdx4QzOBC5071GmXK7J2NIKHixCSEKgeG+lfBP3VG7H
        GEmYGF4AJAi15J8NDqALi6cwE
X-Received: by 2002:a17:906:2405:: with SMTP id z5mr2061241eja.170.1633676285901;
        Thu, 07 Oct 2021 23:58:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeC6KR+gOcp2kQfl1dTb0ZgOmh0btbu+Aj1h1Kg0Em8bXhY+QdiRMPdPOCr3ZVxnicxOx1WA==
X-Received: by 2002:a17:906:2405:: with SMTP id z5mr2061224eja.170.1633676285726;
        Thu, 07 Oct 2021 23:58:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id la1sm581856ejc.48.2021.10.07.23.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 23:58:05 -0700 (PDT)
Subject: Re: [PATCH 1/1] acpi: battery: Accept charges over the design
 capacity as full
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, sebastian.reichel@collabora.com,
        pgriffais@valvesoftware.com
References: <20211008030529.223682-1-andrealmeid@collabora.com>
 <20211008030529.223682-2-andrealmeid@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f0e1b4ad-92a3-5453-5110-bb0c35e13d35@redhat.com>
Date:   Fri, 8 Oct 2021 08:58:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211008030529.223682-2-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/8/21 5:05 AM, André Almeida wrote:
> Some buggy firmware and/or brand new batteries can support a charge that's
> slightly over the reported design capacity. In such cases, the kernel will
> report to userspace that the charging state of the battery is "Unknown",
> when in reality the battery charge is "Full", at least from the design
> capacity point of view. Make the fallback condition accepts capacities
> over the designed capacity so userspace knows that is full.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/acpi/battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index dae91f906cea..8afa85d6eb6a 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -169,7 +169,7 @@ static int acpi_battery_is_charged(struct acpi_battery *battery)
>  		return 1;
>  
>  	/* fallback to using design values for broken batteries */
> -	if (battery->design_capacity == battery->capacity_now)
> +	if (battery->design_capacity <= battery->capacity_now)
>  		return 1;
>  
>  	/* we don't do any sort of metric based on percentages */
> 

