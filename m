Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797AF3F7230
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbhHYJqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:46:48 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56392
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236768AbhHYJqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:46:47 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DDBA4406F4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629884759;
        bh=ZKJrI2d7Kv4sG35EVY46Fq8Zkkqpb2VHIDHfjL5pSXs=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=KsAOzZKl4IHxl6bDKVz8/un5xxQjFJ2hTob4JehAk5OLpX+sqY7DKWCn0E3pHoOF3
         WC6NSoTnFfdsINAT1c6DHxl4uTvLOxFF2JSD8ibRXUadLkEkdVxYaumTMItbR2Hzim
         40jn8KMuUFQXU5Jh1ID7vOrvcOiReeLLFKEI0gzh4VSRvUPdc8A19vaPDlkJWwcCtu
         BEAjk9LOKEjClVJQWiV7lXuUb7ACsagNwsfai3x9mEU928VLwBGOoduds8f/GFtbXG
         Kj4Cjhf4QN/Vj2xPSPtYufQERVAjAnnyL1uZeGG7u+93t152IU6a9BSioT9cv3KEkF
         cGbuQAwe0wbPw==
Received: by mail-wm1-f69.google.com with SMTP id m33-20020a05600c3b2100b002e87a0542efso1099510wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZKJrI2d7Kv4sG35EVY46Fq8Zkkqpb2VHIDHfjL5pSXs=;
        b=h5gtz01HNIpomL8MHqMOd2yRgL3dj+BhJsLCf1XpaokSImkxN8My8zeSmMs7XGQBBK
         sv6Y/41A/4B6WlJDGFhcUI+fqvu5stqwZTJNERxMzlCLzmMz8TCJkrLzNwmzY2TDqnh2
         pdQRWnX+UdKJmr44ReyIEOKXR9++ItWizQ9EYoJmh/xuh90KWPaxB3+OmTuSpTA9uITg
         o/dm7+s9aLXCU4OOUmvTO1O5m4eI8Qg7fi5CiO8yYK75GOHjkDUGK2LcMeIkIjmoZX0f
         a+08p0w518hysIgpZffY01Aw2NpdQw/Ph8vv2pMFvNCKh0pDZxO742hWpMgHSvmJ36TZ
         OIdw==
X-Gm-Message-State: AOAM532vWDXT+wWBjpmwbayFvtIWb7sPZi4+M7ALWnJFqxVahR7YoTnj
        6bAdjZ/rtY+KsjKKCawKU1A7+DJaomsLM8pK35ICpfGQ92cBBOumqutob2uu/jAVCTkpuHzbbex
        CimOx+WGbLGyPem1Hfl4HQe3h2k3UV+ljMg4PIjTNWw==
X-Received: by 2002:a5d:460a:: with SMTP id t10mr19281700wrq.147.1629884759429;
        Wed, 25 Aug 2021 02:45:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi1Ef7zjNIHRCkcaWZFpqJGa6Dbk4j07l8Fn4wmElE0lvaSyGoFBY+FREyB0j+C6Z0qYWiQA==
X-Received: by 2002:a5d:460a:: with SMTP id t10mr19281686wrq.147.1629884759281;
        Wed, 25 Aug 2021 02:45:59 -0700 (PDT)
Received: from [192.168.0.103] ([79.98.113.31])
        by smtp.gmail.com with ESMTPSA id h11sm16195677wrx.9.2021.08.25.02.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 02:45:58 -0700 (PDT)
Subject: Re: [PATCH linux-next] memory:tegra210-emc-core: replace
 DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
To:     CGEL <cgel.zte@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210825063739.70260-1-deng.changcheng@zte.com.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <344b7b12-4134-883c-1e0a-cdab7800067f@canonical.com>
Date:   Wed, 25 Aug 2021 11:45:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825063739.70260-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2021 08:37, CGEL wrote:
> From: Jing Yangyang <jing.yangyang@zte.com.cn>
> 
> Fix the following coccicheck warning:
> ./drivers/memory/tegra/tegra210-emc-core.c:1665:0-23:WARNING
> tegra210_emc_debug_min_rate_fops should be defined
>  with DEFINE_DEBUGFS_ATTRIBUTE
> ./drivers/memory/tegra/tegra210-emc-core.c:1726:0-23:WARNING
> tegra210_emc_debug_temperature_fops should be defined
>  with DEFINE_DEBUGFS_ATTRIBUTE

Thanks for the patch.

One error message is enough. They are the same.

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Where is the report? We work here in a public, so if there is a report I
assume we can reach it? In case the report does not exist, anyone can
run checkpatch, coccinelle, smatch and sparse, so how does this differs
from me running checkpatch?


> Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
> ---
>  drivers/memory/tegra/tegra210-emc-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/tegra/tegra210-emc-core.c
> index 06c0f17..3b8284c 100644
> --- a/drivers/memory/tegra/tegra210-emc-core.c
> +++ b/drivers/memory/tegra/tegra210-emc-core.c
> @@ -1692,7 +1692,7 @@ static int tegra210_emc_debug_max_rate_set(void *data, u64 rate)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(tegra210_emc_debug_max_rate_fops,
> +DEFINE_DEBUGFS_ATTRIBUTE(tegra210_emc_debug_max_rate_fops,
>  			tegra210_emc_debug_max_rate_get,
>  			tegra210_emc_debug_max_rate_set, "%llu\n");
>  
> @@ -1723,7 +1723,7 @@ static int tegra210_emc_debug_temperature_set(void *data, u64 temperature)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(tegra210_emc_debug_temperature_fops,
> +DEFINE_DEBUGFS_ATTRIBUTE(tegra210_emc_debug_temperature_fops,
>  			tegra210_emc_debug_temperature_get,
>  			tegra210_emc_debug_temperature_set, "%llu\n");
>  
> 


Best regards,
Krzysztof
