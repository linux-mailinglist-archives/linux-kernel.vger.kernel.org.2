Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930FE380BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhENOXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhENOW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:22:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315AEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:21:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so1553440wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W6EGw5FDEXhr6iHG779poa/gfRiLcSiy2g55pqc2Xpo=;
        b=bCub7K+FdNA9MjxtaR/gNqonadOvGhwZNxdrc4cDQ+NZ8EZRge3q4dqVQXTFP2Dd1z
         fSHVB6J48f8y+YARIuygZNkPCbC2zJy8hiwR9agb1VKo3kHzAXluIjoKT7XZ33NFq6rV
         PwBxJCV7cOpbiSa3N+1eb+Aa2zYc7LBnSbPM5qxH7bw+/006ZR/1jYdulfJh6/HMuEuI
         AnJFghTnlqG8oXm025XReNYUGRceCWAPQW9+rpdcFlo4ijX9DNYeXGL+/COftWmTtjWE
         W4Ubmy7gyzlOZT9DkhpCUVi13RRqqG9m1vYFY87A6Nsz02DZKqvm58SyRC5nDj+egtTW
         fwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W6EGw5FDEXhr6iHG779poa/gfRiLcSiy2g55pqc2Xpo=;
        b=Y+nXN2iNfaCB2rs4IXVtG+rrkFnUwIN8OpxHpbpV0Vk4M8J8XDHwtk8sLKa4SKZKQd
         bVfY9lfzL2mgrknDRhgGL6UQhC4XBJxSE8TcfJEIs4hvtGe3MJNeEj2fqYxjojdwUFej
         ei0wZELDpwO0IzA5UhTDe4+o/54Yl3DMukZVdWEsRWgsscqYVdzDA/oyKGyvKaLsC7Eq
         Ss45VuR4z7w2/UgndKzceePNRaUD352iK7Wk1ZNGNHnWq+fyB6tesXpgYr0pUWDAF9T9
         OA+PkuehyMyV0Ag7xx9Oc7L1JlBEWGnkehqAQ8XrB7x6ARUzez34POso2esUjc33ECvY
         xSCQ==
X-Gm-Message-State: AOAM531oJelCRvQtQL319LifVQzk1MgY18YZojmhm/1P2Mb22bUJ3QnM
        cEDLNKI+bnDKeoyRsgLbJRBHLT8636Y=
X-Google-Smtp-Source: ABdhPJyGaRT8oJ3Ocd7v9vC8Cbi1xYxc63mhysOC3cB31owKV5WkGsZBIFmpfzORUozpoY+JWW9luA==
X-Received: by 2002:a05:600c:198a:: with SMTP id t10mr8954234wmq.97.1621002104925;
        Fri, 14 May 2021 07:21:44 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a369.dip0.t-ipconnect.de. [217.229.163.105])
        by smtp.gmail.com with ESMTPSA id v18sm7747958wro.18.2021.05.14.07.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 07:21:44 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: aggregator: shut up clang
 -Wconstantn-conversion warning
To:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210514140556.3492544-1-arnd@kernel.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <219848ed-e0ce-634a-29c2-caca813b054c@gmail.com>
Date:   Fri, 14 May 2021 16:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514140556.3492544-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 4:05 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Clang complains about the assignment of SSAM_ANY_IID to
> ssam_device_uid->instance:
> 
> drivers/platform/surface/surface_aggregator_registry.c:478:25: error: implicit conversion from 'int' to '__u8' (aka 'unsigned char') changes value from 65535 to 255 [-Werror,-Wconstant-conversion]
>          { SSAM_VDEV(HUB, 0x02, SSAM_ANY_IID, 0x00) },
>          ~                      ^~~~~~~~~~~~
> include/linux/surface_aggregator/device.h:71:23: note: expanded from macro 'SSAM_ANY_IID'
>   #define SSAM_ANY_IID            0xffff
>                                  ^~~~~~
> include/linux/surface_aggregator/device.h:126:63: note: expanded from macro 'SSAM_VDEV'
>          SSAM_DEVICE(SSAM_DOMAIN_VIRTUAL, SSAM_VIRTUAL_TC_##cat, tid, iid, fun)
>                                                                       ^~~
> include/linux/surface_aggregator/device.h:102:41: note: expanded from macro 'SSAM_DEVICE'
>          .instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,                        \
>                                                 ^~~
> 
> The assignment doesn't actually happen, but clang checks the type limits
> before checking whether this assignment is reached. Shut up the warning
> using an explicit type cast.

I'm not too happy about this fix as (I believe) it will also shut up any
valid GCC error message in case those macros are used with non-u8 (and
non-SSAM_ANY_xxx) values.

I'll let others judge and decide what's preferred, however.

In case you're deciding to apply this, feel free to add:

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

Thanks,
Max

> Fixes: eb0e90a82098 ("platform/surface: aggregator: Add dedicated bus and device type")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   include/linux/surface_aggregator/device.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
> index 4441ad667c3f..90df092ed565 100644
> --- a/include/linux/surface_aggregator/device.h
> +++ b/include/linux/surface_aggregator/device.h
> @@ -98,9 +98,9 @@ struct ssam_device_uid {
>   		     | (((fun) != SSAM_ANY_FUN) ? SSAM_MATCH_FUNCTION : 0),	\
>   	.domain   = d,								\
>   	.category = cat,							\
> -	.target   = ((tid) != SSAM_ANY_TID) ? (tid) : 0,			\
> -	.instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,			\
> -	.function = ((fun) != SSAM_ANY_FUN) ? (fun) : 0				\
> +	.target   = ((tid) != SSAM_ANY_TID) ? (u8)(tid) : 0,			\
> +	.instance = ((iid) != SSAM_ANY_IID) ? (u8)(iid) : 0,			\
> +	.function = ((fun) != SSAM_ANY_FUN) ? (u8)(fun) : 0			\
>   
>   /**
>    * SSAM_VDEV() - Initialize a &struct ssam_device_id as virtual device with
> 
