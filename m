Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29773E2B87
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbhHFNiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344120AbhHFNiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628257110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/1ERJ3ikPtd7jbQkJKjNQFBl4bQ6myErCA7cprevbw=;
        b=cT7JWxbFyvXZBnbv1mEKV+fyS239wEm5B2ox4E9qL9NKsPj5Lkc0bSyGmqEtLrW/kv1btP
        GAEC5r1XZTrX0gqCOvr07YVx15fqcbT4Hd4ttKZGucJ38Xmt/KQeN6uKUwqQ97hqDF5ox0
        wXTqueix1MjshhZpytqAl7SuFq04jeo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-hyUFk2c6N16epjHfu3ujVA-1; Fri, 06 Aug 2021 09:38:28 -0400
X-MC-Unique: hyUFk2c6N16epjHfu3ujVA-1
Received: by mail-ej1-f69.google.com with SMTP id z20-20020a1709069454b0290595651dca8eso3134118ejx.23
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 06:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N/1ERJ3ikPtd7jbQkJKjNQFBl4bQ6myErCA7cprevbw=;
        b=sYoNKUqqjD4qK+SY/iZOCbVA+y5XbrkITvmau+DeBQWrPW5Opsan9cbTqsslxsICGa
         RNzOAEgXigC1yCD1mATObvisiriYUrQQaDgk7BL8S3dA22m+rOX5JjnX5s6wmwTLWyM7
         DKPwvuoQZzo4Unnku/KjiE4uvxCheVjwbhV1TrmdvO0TLleITTVFsVll2B7a2cYrhQq1
         0WkTDLDX9NrsDCTsC7ogpNpivV5OmbBllSNbNt+22Tm+hJ/KHUcHgRowSAaD0r0GXu6L
         OpmZ9rEVroCuLoJwJiKSm4Q21DlimVsN2pdYrZtAZgtaBQiYsd2zC42MHkJBzMpSdq8y
         /3XA==
X-Gm-Message-State: AOAM532OPrvLnr0gadfehUDjtahmgitWNT8hWPqXQod23c8pWoNCYyfr
        0OoZWEWq+lQDrC2dbWCzQqDdodpSDYSbw8501LzRP2LFgt5FBZbJqOOIZ5ZVIa4nPknt2PV+kyI
        X6+yVjNHTsmrSLDzBO3B2VACG
X-Received: by 2002:a17:906:2990:: with SMTP id x16mr9623669eje.554.1628257107260;
        Fri, 06 Aug 2021 06:38:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg72QNJtYoafjptIvMkFJ8PPCCK3QiR4nn8AN/qCiJQJKvy6Dqc7q61DLbV1Sm9cC9EUZa9A==
X-Received: by 2002:a17:906:2990:: with SMTP id x16mr9623650eje.554.1628257107119;
        Fri, 06 Aug 2021 06:38:27 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u9sm747033edt.60.2021.08.06.06.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 06:38:26 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] platform/surface: aggregator: Use y instead of
 objs in Makefile
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
References: <20210803192524.67031-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <342c0563-ebe8-2981-c5d6-22463175a88c@redhat.com>
Date:   Fri, 6 Aug 2021 15:38:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803192524.67031-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/3/21 9:25 PM, Andy Shevchenko wrote:
> The 'objs' is for user space tools, for the kernel modules
> we should use 'y'.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

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
> v2: fixed typo, annihilated ifeq, added Rb tag (Maximilian)
>  drivers/platform/surface/aggregator/Makefile | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/Makefile b/drivers/platform/surface/aggregator/Makefile
> index c8498c41e758..c0d550eda5cd 100644
> --- a/drivers/platform/surface/aggregator/Makefile
> +++ b/drivers/platform/surface/aggregator/Makefile
> @@ -6,12 +6,9 @@ CFLAGS_core.o = -I$(src)
>  
>  obj-$(CONFIG_SURFACE_AGGREGATOR) += surface_aggregator.o
>  
> -surface_aggregator-objs := core.o
> -surface_aggregator-objs += ssh_parser.o
> -surface_aggregator-objs += ssh_packet_layer.o
> -surface_aggregator-objs += ssh_request_layer.o
> -surface_aggregator-objs += controller.o
> -
> -ifeq ($(CONFIG_SURFACE_AGGREGATOR_BUS),y)
> -surface_aggregator-objs += bus.o
> -endif
> +surface_aggregator-y := core.o
> +surface_aggregator-y += ssh_parser.o
> +surface_aggregator-y += ssh_packet_layer.o
> +surface_aggregator-y += ssh_request_layer.o
> +surface_aggregator-$(CONFIG_SURFACE_AGGREGATOR_BUS) += bus.o
> +surface_aggregator-y += controller.o
> 

