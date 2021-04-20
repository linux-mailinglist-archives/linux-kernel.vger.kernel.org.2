Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C28836561B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 12:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhDTKZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 06:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhDTKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:25:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95846C06174A;
        Tue, 20 Apr 2021 03:24:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id mh2so35908324ejb.8;
        Tue, 20 Apr 2021 03:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iDi8cUbiyndOqXYkEBTxg8CyIbOjMD0ycEy+x60xpsw=;
        b=roQeYFmx2/icGD6lUKMbke4T1HvYGH1yyx5REXyF+rwL+KV/sRbiHhLPwydnKtaa/G
         KeVBfpvYns1GKX1IsuCTdfS4uaFzyFP0mwYAWoW4rqKgf6K5BtNm3GkhWUFM7vndYvle
         rt2MefYLMF4K8GpKHs244d1OE1NGarkBLo8hnOr+l5j9zJ/OmeohyXo+HJS/upqwOyiZ
         we2+9j/V/6enS3qdXCPpv5O/lyJe6whuTejnhfMYkUquXgOp+8jQ6lAwBstl2s7k4RPx
         Kz8yJVv4sG3wL2/YJPvl22nNrh/HG8qeAmGxyf4iSStVjr2TkT+GUB3sR/9swBM5BXOJ
         5VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iDi8cUbiyndOqXYkEBTxg8CyIbOjMD0ycEy+x60xpsw=;
        b=KmOM0xAerjm44lsnFDHG87uBfgXfOdX2zu6/hUtZg9YU7XTHSrG0UrNRKq+0lI4NX0
         bDoau11+N0ElAVQW1LGcO+BgZCX4PVAon2Bb1ULpcRwy29sdHkv+4nRJycunkm/4a3Oi
         U+FTUhPizORHyuqnOTXdKStl+rLchn9VR6jU8eJOaOviGuiusRTZMFdcuzoHmkx/Y/ej
         nSkfwKugZOvSya7xwaJ32q/ePLY9nbrqjSSjpknJ7Xha/HzwiqcV5r0UeNxLIx1ZHqCH
         6gAjvwXn/XgY8JpXjqrAvYP7UQnV/BlH4UoPjmqpdD1uuPtt5nxQZB51U8CdmRqt6qgq
         SZIw==
X-Gm-Message-State: AOAM530ThWOp3bkuCBAvLGyLMPEwSJtV1rPyUGdWbbHKoENKIL8DC+2d
        wR+zoJLrspvzaSFXXOCjoO+gnld/eLQ=
X-Google-Smtp-Source: ABdhPJwv7sEOGcS4T4d7yVxSjB+KHHDSNOEyOEcNORPWzZwaI2xwQnNKXS/ajg8NGQ5NgwEogrWhnw==
X-Received: by 2002:a17:907:9485:: with SMTP id dm5mr26830144ejc.194.1618914279049;
        Tue, 20 Apr 2021 03:24:39 -0700 (PDT)
Received: from [10.18.0.21] ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id e11sm12362807ejn.100.2021.04.20.03.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 03:24:38 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: aggregator: fix a bit test
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <YH6UUhJhGk3mk13b@mwanda>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <7352fbf8-6773-99e6-1baa-3daea8523bc7@gmail.com>
Date:   Tue, 20 Apr 2021 12:24:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YH6UUhJhGk3mk13b@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/21 10:44 AM, Dan Carpenter wrote:
> The "funcs" variable is a u64.  If "func" is more than 31 then the
> BIT() shift will wrap instead of testing the high bits.
> 
> Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/aggregator/controller.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
> index 00e38284885a..69e86cd599d3 100644
> --- a/drivers/platform/surface/aggregator/controller.c
> +++ b/drivers/platform/surface/aggregator/controller.c
> @@ -1040,7 +1040,7 @@ static int ssam_dsm_load_u32(acpi_handle handle, u64 funcs, u64 func, u32 *ret)
>   	union acpi_object *obj;
>   	u64 val;
>   
> -	if (!(funcs & BIT(func)))
> +	if (!(funcs & BIT_ULL(func)))
>   		return 0; /* Not supported, leave *ret at its default value */
>   
>   	obj = acpi_evaluate_dsm_typed(handle, &SSAM_SSH_DSM_GUID,
> 
