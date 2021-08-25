Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3313F723A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbhHYJtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:49:06 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51134
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236638AbhHYJtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:49:05 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ED12F4076B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629884898;
        bh=tjsHPbCfcVOmhdB0vPy9yJyr+9FoVUNnDxTLE3I81xE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=lvwmduuma/pedg+y6yz32rmcLwrz2/CbiXXqUq2hkUtSrDHb8rN4oxS5WQlPiKPdi
         LMFpPPEkRPORSHf6qma+OvVDNU1fSzoE6fAp+eCIDC5geDsbLtqgS2LP4RxjHprr4C
         NlMjOsBjvAyuoN0jOdIfeql92P4RxHGSVTkGmQAhrDadmJWB8/vSJbP/J3tI42gtfo
         jG3liZrI44AkOkzYJDTyPMlmg72ek1ujujsMcW9PBLZvfEVUULQoeRiSRB80bsHHcv
         Zfnuu5+fxB5jLaXyVXM9uY4rLQCP5StSIsS+dSZnTboKfVFwNBaEzByE9MRUgwKF7p
         kltSw1SIP1hUA==
Received: by mail-wr1-f69.google.com with SMTP id a13-20020adfed0d000000b00156fd70137aso6330421wro.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tjsHPbCfcVOmhdB0vPy9yJyr+9FoVUNnDxTLE3I81xE=;
        b=sUrOYPlBmFWRE11TGxCCPQBRdJt3b2rB4sQMe35ics/xB8TxXQq6Kz/64AB0zp5q4G
         iwT2kWjVD9/6VfAsH/M/pVGUW8Lz1AJKRGchzNtAKR2itHmPpcHpS9XvZMLb8Ra5rjuO
         bDwAhsg3GWnMAT++Myaa2AM/VRiK8g82cgVqk+0byhOemf0gdMxM3tjG+qrl5pbssbiR
         bAASttZRVCZ9jLo8Wg66c2HAYVDDZcwC3cbb6IERLC73mqujSv9LQ0W5JzOe3gLS1uhw
         wvZgJZLlpOziVh7QfsQkYS7J8kPJVk2IENlhbPj6fG/bhRlwWQULfI4VhkxUKyK3aYkR
         WbWA==
X-Gm-Message-State: AOAM531SQ2Bzoccst5vsphjsxzH6oi9OxOum8OGGanckE9hIKrxlrGlw
        EwDroi5s9IMrDMeT5MMGyls6wmlY/9FREDB+8FSObmSXUjd3sQRkp/KeYsJ+hrAWYfyBqy45ycR
        0qnmWV9nqZZyNzjNyrnqAY1rFS7spfmSpqCA9BX1gVg==
X-Received: by 2002:adf:9783:: with SMTP id s3mr23140741wrb.349.1629884898705;
        Wed, 25 Aug 2021 02:48:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1PenjOjXIGJAnUWhJyZcjt8TAxEDMXHPR1JYG4WMSGlNdWtBL2TzkTIgCVaqjD/jXij3Otg==
X-Received: by 2002:adf:9783:: with SMTP id s3mr23140718wrb.349.1629884898544;
        Wed, 25 Aug 2021 02:48:18 -0700 (PDT)
Received: from [192.168.0.103] ([79.98.113.172])
        by smtp.gmail.com with ESMTPSA id r129sm4935073wmr.7.2021.08.25.02.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 02:48:18 -0700 (PDT)
Subject: Re: [PATCH linux-next] memory:tegra30-emc: replace
 DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
To:     CGEL <cgel.zte@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210821035223.28282-1-jing.yangyang@zte.com.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <066c231d-f923-6671-12d8-8aab79482a6e@canonical.com>
Date:   Wed, 25 Aug 2021 11:48:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210821035223.28282-1-jing.yangyang@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2021 05:52, CGEL wrote:
> From: jing yangyang <jing.yangyang@zte.com.cn>
> 
> Fix the following coccicheck warning:
> ./drivers/memory/tegra/tegra30-emc.c:1322:0-23:WARNING:
> tegra_emc_debug_max_rate_fops should be defined
> with DEFINE_DEBUGFS_ATTRIBUTE
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Thanks for the patch. Same comment as with other one - where is the report?

Best regards,
Krzysztof

> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> ---
>  drivers/memory/tegra/tegra30-emc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
> index 7e21a85..80f98d7 100644
> --- a/drivers/memory/tegra/tegra30-emc.c
> +++ b/drivers/memory/tegra/tegra30-emc.c
> @@ -1289,7 +1289,7 @@ static int tegra_emc_debug_min_rate_set(void *data, u64 rate)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(tegra_emc_debug_min_rate_fops,
> +DEFINE_DEBUGFS_ATTRIBUTE(tegra_emc_debug_min_rate_fops,
>  			tegra_emc_debug_min_rate_get,
>  			tegra_emc_debug_min_rate_set, "%llu\n");
>  
> @@ -1319,7 +1319,7 @@ static int tegra_emc_debug_max_rate_set(void *data, u64 rate)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(tegra_emc_debug_max_rate_fops,
> +DEFINE_DEBUGFS_ATTRIBUTE(tegra_emc_debug_max_rate_fops,
>  			tegra_emc_debug_max_rate_get,
>  			tegra_emc_debug_max_rate_set, "%llu\n");
>  
> 

