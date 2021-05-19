Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD09388EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353559AbhESNNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353553AbhESNNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621429946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGGZ3Ap7WMfISommx5/p4o4QgfX5H0jYWS0exbqFy2g=;
        b=S99Bv/x3V1vapwSQ8wxTm+kHXGc3eKIRTXz1jo4eRuzbniW0jrAcA8dJjwsRWFA2oUFJCq
        a5k1PvE8Ja7WhO0A/htNerZHB4BbU2XTS682pY3LnNOkMlJW7cFzhUAD8TJXV5IvKQ3QwR
        d/ewkGjsx/91bsf4vlKl6bJQTjDzXUE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-Ji42pdJlMn-hy3e4iLng_A-1; Wed, 19 May 2021 09:12:24 -0400
X-MC-Unique: Ji42pdJlMn-hy3e4iLng_A-1
Received: by mail-ej1-f72.google.com with SMTP id e1-20020a170906c001b02903d958aadd4fso2166738ejz.23
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PGGZ3Ap7WMfISommx5/p4o4QgfX5H0jYWS0exbqFy2g=;
        b=gAFbcnhiZ39CjgM1CSHz1K4g5hD9T83/qVlFDbFB/jsZDc1uAB9SNzhuinePTnlAZm
         uuvemk7UcDZzFmu/EAXUrs/crM/PXGbMHgBeInJHjbNVEihUcNZ0Y5l94qZzSzBWmTOA
         2nRpCAwoPj9LRkE+ZF6mTkUnsaRHzvZ4Ft1WJ7ZDMzrnyKLLfv1XhQltPPYkQYGyCsxe
         r2dTmgSk18l9Nzf2hvVGI9UQ6AJmdnqQ7TdxIvsN5SNc5GRTgHGlBfhKZyW2gFuSVUn8
         LA3gnq9OSVQp+yZpuxyb2SzehcsQB99qRVR/n5CYFK3ZwWY++uJFvKcpHgHWQph1rDQl
         P9zw==
X-Gm-Message-State: AOAM533CHdxrvY91x8fx5yKnlWozyZIw5OzYaES+iRsSRKtbzaDpBRl5
        ZPnhXMQOtQDILukeliObqX6f24GPZpfIuoQwLHOWA9xcJn3q5X25HjvdsyNbsGKvALLLb+S4FAU
        OPRm2v8zZdLTWdQUpfuBEya11
X-Received: by 2002:a17:906:c448:: with SMTP id ck8mr12531279ejb.497.1621429943646;
        Wed, 19 May 2021 06:12:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBDqd6onKKCnE0ChOQlrWYabgI44IDpvYziQmUdwDelp+sRWIH3kqq3NW+MLB9wNDIjb+wRw==
X-Received: by 2002:a17:906:c448:: with SMTP id ck8mr12531249ejb.497.1621429943447;
        Wed, 19 May 2021 06:12:23 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id n17sm15690961eds.72.2021.05.19.06.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:12:23 -0700 (PDT)
Subject: Re: [PATCH] [v2] platform/surface: aggregator: avoid clang
 -Wconstant-conversion warning
To:     Arnd Bergmann <arnd@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210514200453.1542978-1-arnd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <86f09344-7e88-bad0-282d-d76df5be333b@redhat.com>
Date:   Wed, 19 May 2021 15:12:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514200453.1542978-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/14/21 10:04 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Clang complains about the assignment of SSAM_ANY_IID to
> ssam_device_uid->instance:
> 
> drivers/platform/surface/surface_aggregator_registry.c:478:25: error: implicit conversion from 'int' to '__u8' (aka 'unsigned char') changes value from 65535 to 255 [-Werror,-Wconstant-conversion]
>         { SSAM_VDEV(HUB, 0x02, SSAM_ANY_IID, 0x00) },
>         ~                      ^~~~~~~~~~~~
> include/linux/surface_aggregator/device.h:71:23: note: expanded from macro 'SSAM_ANY_IID'
>  #define SSAM_ANY_IID            0xffff
>                                 ^~~~~~
> include/linux/surface_aggregator/device.h:126:63: note: expanded from macro 'SSAM_VDEV'
>         SSAM_DEVICE(SSAM_DOMAIN_VIRTUAL, SSAM_VIRTUAL_TC_##cat, tid, iid, fun)
>                                                                      ^~~
> include/linux/surface_aggregator/device.h:102:41: note: expanded from macro 'SSAM_DEVICE'
>         .instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,                        \
>                                                ^~~
> 
> The assignment doesn't actually happen, but clang checks the type limits
> before checking whether this assignment is reached. Replace the ?:
> operator with a __builtin_choose_expr() invocation that avoids the
> warning for the untaken part.
> 
> Fixes: eb0e90a82098 ("platform/surface: aggregator: Add dedicated bus and device type")
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I will also include this in the next pdx86-fixes pull-req for 5.13.

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
> v2: use __builtin_choose_expr() instead of a cast to shut up the warning
> ---
>  include/linux/surface_aggregator/device.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
> index 4441ad667c3f..6ff9c58b3e17 100644
> --- a/include/linux/surface_aggregator/device.h
> +++ b/include/linux/surface_aggregator/device.h
> @@ -98,9 +98,9 @@ struct ssam_device_uid {
>  		     | (((fun) != SSAM_ANY_FUN) ? SSAM_MATCH_FUNCTION : 0),	\
>  	.domain   = d,								\
>  	.category = cat,							\
> -	.target   = ((tid) != SSAM_ANY_TID) ? (tid) : 0,			\
> -	.instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,			\
> -	.function = ((fun) != SSAM_ANY_FUN) ? (fun) : 0				\
> +	.target   = __builtin_choose_expr((tid) != SSAM_ANY_TID, (tid), 0),	\
> +	.instance = __builtin_choose_expr((iid) != SSAM_ANY_IID, (iid), 0),	\
> +	.function = __builtin_choose_expr((fun) != SSAM_ANY_FUN, (fun), 0)
>  
>  /**
>   * SSAM_VDEV() - Initialize a &struct ssam_device_id as virtual device with
> 

