Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0427F43740A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhJVI5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:57:02 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:44336
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232180AbhJVI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:57:01 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5593B40019
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634892883;
        bh=Carl7Pe6UmGLChoOIKcp8s0kxXVp6AfE+vBYtcnHbFY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=JufsuybBEhwKQE9NftAXZCx9A9/4YjcT4fEtR4uneBC9aOWvBLD4TGJZSlSvL16I3
         p7V5SYXm0zqOuMDM8S46qnVP5XHFY/MrCcqTftSvfwzGqitLQ0oXIKyoxjCviJwm1m
         rDoYfhbdjuMuoklh1vpM/ii3uB/nC3JCgV4f090BvIfVPyQdWlcbXK1UXMEg5uP8jm
         yWl0/Ai5TiHHHlWXWygo/SXjDP4wZQenzc0AuuM8OUu6ZWtCCqCv5Z4Q8c2eUw8/m3
         nB9pyfid9X6+qOe2vufyDtt/cHq0U9lDMOCN/z0/qNaztaCIIFSrhc2rAaoVJ2JNfo
         L1Bnz3q/QaA2w==
Received: by mail-lf1-f71.google.com with SMTP id m16-20020a056512115000b003fdb79f743fso1435696lfg.16
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Carl7Pe6UmGLChoOIKcp8s0kxXVp6AfE+vBYtcnHbFY=;
        b=4SiNiKIlFVoG0YQPME6ueAyRJNVUql2C5x34sT+9gwxmA6SmH2QA0P4BwziALjV0HU
         Y6KFNonleDRX4hL4vz0ImKLTQv/NVolbImU+3NpKKDuWVqITfGE7Pa0KYWKacF7qge+M
         OCsQcpdCwpapVCMMGK47KvGAiB6GZfCwCIFTvJoDsLn+78vIivji13jqnOHOH/P9e6hM
         an7D7lCT8u3wG67n2hyQqeaJ66CYy05bHrDKrwz9gD5jmQUtRzqF/Pa6iiMcfHQMs0LZ
         6o4jV1wl2Qm0VSocaO2oR1ppvY8foQ83xWPo1I55Q8mXCXHog9zjvXlQKYmPrEtWwOEm
         Ntuw==
X-Gm-Message-State: AOAM533mZArFTC8TeuCdUcwviK/FuNcwsJRZt4CAuwuvjEsFJ8K/pIt3
        tP4htscQcmoNgavFMxXqNM4xRo7ymPF/llf/rHyctP+pq/1jDnXCruh8rbNSNejj11VfWlGCMAW
        U/MHmCYSvAh+Q4PC12SwjfpdN1bVQaXhAWXkUalwNgw==
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr10077221lfu.637.1634892882585;
        Fri, 22 Oct 2021 01:54:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5wXH8lLMcrlGOHByO1io8mqLUATcdtW9OlmDbgC+tn9pMODi48vzpNaBtkjOvs2FFTEUCjQ==
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr10077200lfu.637.1634892882331;
        Fri, 22 Oct 2021 01:54:42 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v5sm676876lfo.49.2021.10.22.01.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 01:54:41 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] rtc: s3c: Add time range
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211021202256.28517-1-semen.protsenko@linaro.org>
 <20211021202256.28517-4-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f3c2d2cd-1099-5997-3516-e48f43e3cf94@canonical.com>
Date:   Fri, 22 Oct 2021 10:54:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021202256.28517-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2021 22:22, Sam Protsenko wrote:
> This RTC driver starts counting from 2000 to avoid Y2K problem. Also it
> only supports 100 years range for all RTCs.  Provide that info to RTC
> framework. Also remove check for 100 years range in s3c_rtc_settime(),
> as RTC core won't pass any invalid values to the driver, now that
> correct range is set.
> 
> Here is the rationale on 100 years range limitation. Info on different
> Samsung RTCs (credit goes to Krzysztof Kozlowski):
>   - All S3C chips have only 8-bit wide year register (can store 100
>     years range in BCD format)
>   - S5Pv210 and Exynos chips have 12-bit year register (can store 1000
>     years range in BCD format)
> 
> But in reality we usually can't make use of those 12 bits either:
>   - RTCs might think that both 2000 and 2100 years are leap years. So
>     when the YEAR register is 0, RTC goes from 28 Feb to 29 Feb, and
>     when the YEAR register is 100, RTC also goes from 28 Feb to 29 Feb.
>     This is of course incorrect: RTC breaks leap year criteria, which
>     breaks the time contiguity, which leads to inability to use the RTC
>     after year of 2099. It was found for example on Exynos850 SoC.
>   - Despite having 12 bits for holding the year value, RTC might
>     overflow the year value internally much earlier. For example, on
>     Exynos850 the RTC overflows when YEAR=159, making the next YEAR=0.
>     This way RTC actually has range of 160 years, not 1000 as one may
>     think.
> 
> All that said, there is no sense in trying to increase the time range
> for more than 100 years on RTCs that seem capable of that. It also
> doesn't have too much practical value -- current hardware will be
> probably obsolete by 2100.
> 
> Tested manually on Exynos850 RTC:
> 
>     $ date -s "1999-12-31 23:59:50"
>     $ hwclock -w -f /dev/rtc0
>     $ date -s "2100-01-01 00:00:00"
>     $ hwclock -w -f /dev/rtc0
>     $ date -s "2000-01-01 00:00:00"
>     $ hwclock -w -f /dev/rtc0
>     $ hwclock -r -f /dev/rtc0
>     $ date -s "2099-12-31 23:59:50"
>     $ hwclock -w -f /dev/rtc0
>     $ hwclock -r -f /dev/rtc0
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Removed check for 100 years range in s3c_rtc_settime()
>   - Improved the commit message
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
