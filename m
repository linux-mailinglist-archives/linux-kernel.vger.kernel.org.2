Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959B8339DFF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 13:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhCMMIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 07:08:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230380AbhCMMHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 07:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615637250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8fRlwpZMxCpP6SfCb4KtSjSpn9aOFnkT138tspXGQg=;
        b=a7BiO+M5p4c78Huo2G3VKpPV62ApNLLaWzlgz4Z9kAxB5ITIFM7JQq+5+EvQnrAosjq1Xq
        2MPJcsdC9rMo2R7YK0q43swhFpV3hRCjx1ayaBTUuDnemfBXudmbM45F3ZtLOMc+oGczyF
        PO8WSyrYJ0Keiob2CMNycEKE15F0Ccw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-sLQPyLDYOa-pq4KzHIWAkw-1; Sat, 13 Mar 2021 07:07:28 -0500
X-MC-Unique: sLQPyLDYOa-pq4KzHIWAkw-1
Received: by mail-ed1-f70.google.com with SMTP id h5so13088525edf.17
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 04:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J8fRlwpZMxCpP6SfCb4KtSjSpn9aOFnkT138tspXGQg=;
        b=UdH0ZBFzdO9Rhb3Hy2yC25SKb6b2xbMIOcp0ZVISvmmcWEdOgtNhf3XCfX7hM94MRp
         h66LqItIyA5x6ToX0FUnJozRkKGfu1O0+ulTRvrsgR5xrA3LwMQpUrfSnEqlaPaNSVy3
         6Vi3bCUuhZuvW0C4l9ACbkKlURuu0L5e41xDpBx3/XoZ98LLY8bh9O0fUHCKQyrhUlxH
         xZIxvkYao3+8J8cmWm6LbD6hWqcu6f0S0+26CY7gB7Y8puxD1dLyFrVZaUjuaU7sjQjh
         AiLtm2TJIbEmfGEtCtnEmrgBirz619lF4vOUVJTvpx/d4TmYQ7vgIIvUPLtkiPUBomXI
         BN0w==
X-Gm-Message-State: AOAM532qI4x4cOPxgPohAp1cTUk9sh35/Rl30ITf9F5K2g32BTkmJDBa
        9JtOrJq8+i0y/lZ0S9l/AAiZUP/scRxvjOtuSTGGRr+MPeCn6OwyY3vbw2IWLB1aUYBIK+G07E1
        SzbCck6W8wFh1U7OOASUaGDdfa3TR4rj1Dzh1xbdEcQI8UAhgV4RoJMW2qBaFhr19wwg5OqXaWn
        1C
X-Received: by 2002:a17:906:489:: with SMTP id f9mr13363206eja.428.1615637247310;
        Sat, 13 Mar 2021 04:07:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziitgAP7Sysc+qmE9B/FQJ+p0vDJWp2A2Jxduls9RUQjaNdQjrMJmzFAFaD4Ha92l8u2OUog==
X-Received: by 2002:a17:906:489:: with SMTP id f9mr13363195eja.428.1615637247155;
        Sat, 13 Mar 2021 04:07:27 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u17sm4356196edr.0.2021.03.13.04.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Mar 2021 04:07:26 -0800 (PST)
Subject: Re: [PATCH 1/2] ata: delete redundant printing of return value
To:     Wang Qing <wangqing@vivo.com>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1615621617-1343-1-git-send-email-wangqing@vivo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <90604319-c111-2070-54bc-038e6a487150@redhat.com>
Date:   Sat, 13 Mar 2021 13:07:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1615621617-1343-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/13/21 8:46 AM, Wang Qing wrote:
> platform_get_irq() has already checked and printed the return value, 
> the printing here is nothing special, it is not necessary at all.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/ata/libahci_platform.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index de638da..2e7ea75
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -582,11 +582,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
>  	int i, irq, n_ports, rc;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		if (irq != -EPROBE_DEFER)
> -			dev_err(dev, "no irq\n");
> +	if (irq <= 0)
>  		return irq;
> -	}
>  
>  	hpriv->irq = irq;
>  
> 

