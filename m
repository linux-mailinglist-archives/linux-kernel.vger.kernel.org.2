Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E5B4191DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhI0J5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:57:41 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33552
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233768AbhI0J5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:57:40 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E000C40790
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632736559;
        bh=nIU5tLYb8kiPoNkLCvMx2HqJO/MUaTxKgEujQiXGrPI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=JSy+4eYnCTplSl+dSVzoeHu5juCEE7J6rLBOPRIxYenATLauGNMlxxpuQfEE/+aVP
         EB4BFKceHi793dN/Z7d/XUjgW6bXcXUCxHZ8ICSt7NF9s8ZcvMY1T8oQUI212Rr12f
         3LxBHNuBSsp3t6jVWu8+t65nuZOUWHWRmuWFptamtvXEDZ/6d1KiwcOR9DyVf64jsV
         uw2kSybRBUQPLLbtTDIhgxXeXjggk5fGcao2ZTmXLQ7UJYlA1EzPVeXIk1hso3z72o
         NnauAfr94+CSqNK4Psk/UZm35uuwwUmNFddEd4YcOXXonRNPSjY0AyGDVKzo5KbZ9E
         UawS+6gtvgxLA==
Received: by mail-lf1-f69.google.com with SMTP id v197-20020a1948ce000000b003fc99be7fecso15303103lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIU5tLYb8kiPoNkLCvMx2HqJO/MUaTxKgEujQiXGrPI=;
        b=00ho4dy+hnCYozZxeqfjLTfCp2L2gE1VgjG/y1F4qhhXZ415ItxdiMSuZUC5Dwb8qk
         o3i8w+dtWMe82QOVCp+sWNwQpV5jFB/g0dLWdG9VJCC2hTd63iwH3PM3HaWJkyBxq4SU
         r0sb9K3/sxhT5KKe+w9z8ZfnVW2PDxdXdlW7N9+TIvVRr2zFfm+OWe/s41xA7VIMUYXK
         QjLhCo/0ltMi1bxZKVdsH7tnohqVDiWE6kQYMS//hRP2Ljuv71Iyw5ZgzYP4IS0aiq1d
         VJaan8ne13W8q+h373d+ja4x7b62s7FGp4gsL4kWAR39m2IEweqbBOYpyRHS5el/Nwou
         otjg==
X-Gm-Message-State: AOAM531LpEeOYYnqA2TZD6OaFkLfEyrwvBFpv2sLJmuZKYiizF3JvEqW
        wQPZoop+bToaDQHd29kuY/XFqIKigCt3MLWQHJrq9x4AUEyfHYHL61uuiZwyI77eGiGl+Aw5iBr
        /JhhmHQyRAi9txaUwmol6ktw5rXyMiySDXjj6s2JNWA==
X-Received: by 2002:a05:6512:234b:: with SMTP id p11mr22993039lfu.81.1632736558905;
        Mon, 27 Sep 2021 02:55:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsQ6KVBbhaTPACnyZPmIXhjr9se2x7ZwWQTaBMxZMqHiZxJFGWKh3hO/D3QI+51qPHcHs7eQ==
X-Received: by 2002:a05:6512:234b:: with SMTP id p11mr22993025lfu.81.1632736558751;
        Mon, 27 Sep 2021 02:55:58 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br38sm1537149lfb.305.2021.09.27.02.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 02:55:58 -0700 (PDT)
Subject: Re: [PATCH] cpufreq: s3c244x: add fallthrough comments for switch
To:     Arnd Bergmann <arnd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210927095150.944127-1-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6695844c-e79d-d62e-87da-f96f8d5ca3bf@canonical.com>
Date:   Mon, 27 Sep 2021 11:55:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927095150.944127-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2021 11:51, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Apparently nobody has so far caught this warning, I hit it in randconfig
> build testing:
> 
> drivers/cpufreq/s3c2440-cpufreq.c: In function 's3c2440_cpufreq_setdivs':
> drivers/cpufreq/s3c2440-cpufreq.c:175:10: error: this statement may fall through [-Werror=implicit-fallthrough=]
>    camdiv |= S3C2440_CAMDIVN_HCLK3_HALF;
>           ^
> drivers/cpufreq/s3c2440-cpufreq.c:176:2: note: here
>   case 3:
>   ^~~~
> drivers/cpufreq/s3c2440-cpufreq.c:181:10: error: this statement may fall through [-Werror=implicit-fallthrough=]
>    camdiv |= S3C2440_CAMDIVN_HCLK4_HALF;
>           ^
> drivers/cpufreq/s3c2440-cpufreq.c:182:2: note: here
>   case 4:
>   ^~~~
> 
> Both look like the fallthrough is intentional, so add the new
> "fallthrough;" keyword.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/s3c2440-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)

I think I saw it but back then implicit-fallthrough was not an error :)

LGTM:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
