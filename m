Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9753A9CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhFPODK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233325AbhFPODJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623852063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99mp808GTvoHtUOVOhzwcf4Ti8HJLQlZI3YGbg3T2Vk=;
        b=GS4o4ZxjXLXnFYpsFFpPESwNLlVWKYrY19SSRZMzQ2NsynMyLN19CT4E2CQz4Pi3ctJkCn
        uegGFnV+rAq27yNJEE+gCF9JqiZiRFbhInVgqqRWkzW6HAhxN3e5du/36G7ShGEZGcChsa
        DwZf37F8413z0b5+vv+CQpHQvvLfuX0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-dE1HYDK8PNeBqMHIVh9TPw-1; Wed, 16 Jun 2021 10:01:02 -0400
X-MC-Unique: dE1HYDK8PNeBqMHIVh9TPw-1
Received: by mail-ed1-f72.google.com with SMTP id y16-20020a0564024410b0290394293f6816so1068707eda.20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=99mp808GTvoHtUOVOhzwcf4Ti8HJLQlZI3YGbg3T2Vk=;
        b=H1vhJhCMaIMhyy5IT9FD865xJ3OIUk4eDTAeZbsOBzZJ7iCAOY9vC80Zk18hPyjWLK
         v+qghBe77SBypeMV3phKzpdX31e0SrB9CZD9qrY163ptVA4nFVoYr6ZXPhOTrDD4VPXb
         5hIcXtdxKRbId1Oqlt8Fim6pZ8VlMh9OMIPJFqIzZHbqXpLggfxsMl3kdGN7O9fbchyf
         +G281Fa4ZZEwSIpM5iooQbISTe7aSflefTbFUTrkFRrUZB3Kqq0b/grJ0XUrYDSD7aaz
         d2BYqtlZ/2yVnCTghSyoPd/TgMgdmBeJisr/jPvNDp3ZmRNXp1smsSrwKFXeJbcP6r/x
         f5VQ==
X-Gm-Message-State: AOAM530W3qk9MuWw7YqMNdmLC8ewLD18FAjujbnfdKL/eE6SylbMExoT
        29dzV/usQiIElp2Z9rDC5SE6/V5WvlJ0k3/4hF3KuQqgnFNcENkjuXVz724dwhd7MY8UJjk2AOT
        ITBdeis6EWshVnBRABprrmizskGV3PYfMTKXJ+fy/D79ptbwDjXbdqiemEu7abGG6yGT+dDWLCg
        jU
X-Received: by 2002:a17:906:ece7:: with SMTP id qt7mr3219675ejb.194.1623852060613;
        Wed, 16 Jun 2021 07:01:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyiHJnn+VnmvzClXr9YrSuDj59DDjAwycqmkFlcAAOI9OhNogx9ksmilxCyBJvXTPSihgkRQ==
X-Received: by 2002:a17:906:ece7:: with SMTP id qt7mr3219642ejb.194.1623852060406;
        Wed, 16 Jun 2021 07:01:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id n2sm1867491edi.32.2021.06.16.07.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:01:00 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Update IRC link for Surface System
 Aggregator subsystem
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210614194635.1681519-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4ef00d02-98a5-af51-8ba2-5f322f802004@redhat.com>
Date:   Wed, 16 Jun 2021 16:00:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210614194635.1681519-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/14/21 9:46 PM, Maximilian Luz wrote:
> We have moved to libera.chat. Update the link accordingly.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

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
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 142d4baa4f0f..7e38764f778c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12190,7 +12190,7 @@ M:	Maximilian Luz <luzmaximilian@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  W:	https://github.com/linux-surface/surface-aggregator-module
> -C:	irc://chat.freenode.net/##linux-surface
> +C:	irc://irc.libera.chat/linux-surface
>  F:	Documentation/driver-api/surface_aggregator/
>  F:	drivers/platform/surface/aggregator/
>  F:	drivers/platform/surface/surface_acpi_notify.c
> 

