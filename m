Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE77C381373
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhENV5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhENV5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:57:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABBBC06174A;
        Fri, 14 May 2021 14:56:34 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id df21so197557edb.3;
        Fri, 14 May 2021 14:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=61B9WevOpoQNzFK6pLWh/9kRzelEclfMSAISHfMU93Y=;
        b=RNmz0J1aLaw8+M7+c0F7byA0Y4WlTDkH0/GVNq2A2Dcl+2DeFi+G/+OMM0BmVHFnKY
         B6SHXMfoOkj2fT144kQMOmuRYumhpWpohYe0rfxh7mhuFrAwfTPHgcu2l2dzrrE8NvJh
         Pyw6/fhUwH+s7nnvCVFOUfVawcw1p370VQE1ddLdi1lySoEies2jRVZopAvnQ0HzI1Fx
         B8kfmr9/H7LkWyJSdKZq5B1/KAiEKYkCsZ53YpJpojnkqMfmZul6YGXR4/xSc4YEkfRI
         7fN2b226XTAtJlDDWPPjwZfdwG44yl7Y/8ihzf08V+3C+0qJeWSQDVxD0hbMJ8615sNZ
         IEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=61B9WevOpoQNzFK6pLWh/9kRzelEclfMSAISHfMU93Y=;
        b=c54TOzAIS67uetgWwsiTjkQ0le2WItMSC7VLEYlPqTUE3g/r6b0DpIasAZPaEvDV3y
         5pugV9eC0Whu6NKL5TGg2pSO1I6ooavRFcLelZYVmkEP01QFkDvWDDgE7SYa9b5yYd7Y
         ZnM/0NQEmTIlxC5Yj6Zj0TNhi++E67V0TeT8fpsburR5/gYfNuxnAFsN0iXRZPj0C550
         Gc37N48lnbNEwd2A6lspe5FT7RfXHpqQgFWdk2blpKDGxURzwPopQFi/xMtFqyQfhl0N
         kLG+Ci3cbK/gTM7XXFQ+9Pg1giLVUSTvAkNmDbbYQZN1ifzRjm1TWf2v4a66YNQCHDEY
         1cJQ==
X-Gm-Message-State: AOAM531RdCzDZBHhTmG0K8xRrjzlC/mCH/xSfBCpveEiucTBFA8wEsPz
        8FVXGlcl97sXqQENBOElIkc=
X-Google-Smtp-Source: ABdhPJz4iScXn2Q2hae1/SahmSllSASR+nHYWuz5p+ANV4IxJzRhWjtlIJyXTPmFWDyjFWUKjjFGLw==
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr59525984eds.291.1621029392754;
        Fri, 14 May 2021 14:56:32 -0700 (PDT)
Received: from [192.168.2.120] (pd9e5a369.dip0.t-ipconnect.de. [217.229.163.105])
        by smtp.gmail.com with ESMTPSA id d25sm4220668ejd.59.2021.05.14.14.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 14:56:32 -0700 (PDT)
Subject: Re: [PATCH] [v2] platform/surface: aggregator: avoid clang
 -Wconstant-conversion warning
To:     Arnd Bergmann <arnd@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210514200453.1542978-1-arnd@kernel.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <aa141212-ce68-5f07-c656-8489ff9e7b5f@gmail.com>
Date:   Fri, 14 May 2021 23:56:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514200453.1542978-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2021 22:04, Arnd Bergmann wrote:
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
> before checking whether this assignment is reached. Replace the ?:
> operator with a __builtin_choose_expr() invocation that avoids the
> warning for the untaken part.
> 
> Fixes: eb0e90a82098 ("platform/surface: aggregator: Add dedicated bus and device type")
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks! This looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
> v2: use __builtin_choose_expr() instead of a cast to shut up the warning
> ---
>   include/linux/surface_aggregator/device.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
> index 4441ad667c3f..6ff9c58b3e17 100644
> --- a/include/linux/surface_aggregator/device.h
> +++ b/include/linux/surface_aggregator/device.h
> @@ -98,9 +98,9 @@ struct ssam_device_uid {
>   		     | (((fun) != SSAM_ANY_FUN) ? SSAM_MATCH_FUNCTION : 0),	\
>   	.domain   = d,								\
>   	.category = cat,							\
> -	.target   = ((tid) != SSAM_ANY_TID) ? (tid) : 0,			\
> -	.instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,			\
> -	.function = ((fun) != SSAM_ANY_FUN) ? (fun) : 0				\
> +	.target   = __builtin_choose_expr((tid) != SSAM_ANY_TID, (tid), 0),	\
> +	.instance = __builtin_choose_expr((iid) != SSAM_ANY_IID, (iid), 0),	\
> +	.function = __builtin_choose_expr((fun) != SSAM_ANY_FUN, (fun), 0)
>   
>   /**
>    * SSAM_VDEV() - Initialize a &struct ssam_device_id as virtual device with
> 
