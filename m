Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44983748D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 21:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhEETrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 15:47:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36831 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhEETrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 15:47:39 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1leNTm-0003Sn-90
        for linux-kernel@vger.kernel.org; Wed, 05 May 2021 19:46:42 +0000
Received: by mail-qv1-f70.google.com with SMTP id h17-20020a0cb4d10000b02901c51890529dso2447504qvf.18
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 12:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lkpUTCzONKczERA2MujskvwtonF4g3uvpRrfwyRJotc=;
        b=P6i2umRlsZJgNDyeWdUCBQKQwyftsqYQ6ptePh9o0+3E9kZpTzbhQrxJz6HfzT3epp
         LdZtWPDqOJRBeQyN/E/U7Y/33FYnkYxbLqZ1FRaPkPQj5OXmPGgM6oO79P/5dNIJBeD1
         gGpjKcmp6gEkC2ddbtmBZ6H55TB/joUn1Yx5FfxjaXzrh4zY+6tzXqhxp9eV9J71n6YK
         rVYA5MW/pQEUPhCwgJfttBkeNZ11Uc4KkxjJvMWkz278ZiI2gVQAXcmhpUlX4CRaM+2S
         vBurkLz9gSuFdNOt8pTIZVeWvEjSaD2C8ujFsTIv9OebC0US3BLxerOnv2oZ5eu28xR4
         mGOQ==
X-Gm-Message-State: AOAM530oAM/LYnzQVFowd0asQdJmE9QPNQSHtv5I6k3JGimoOFlfwdz/
        tVVoTrXqKLJxYZbI5SX+r47P/fuYPbP8WPYSJ0/v20mR0Q5/sxrITgCdvbc/Q97YxDBzkB3l66O
        tXW+MV9KLypfrpca7YTw3mpTNB17EiNNYnd9yc1gvog==
X-Received: by 2002:a05:6214:c2e:: with SMTP id a14mr692626qvd.34.1620244001060;
        Wed, 05 May 2021 12:46:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo54am7dCSTCUr1Fbs7xBAu8XLuOcYBZXQNDB/ZmBfA2ofYNrXpFqpSQZWtXpuBGcTtVkATQ==
X-Received: by 2002:a05:6214:c2e:: with SMTP id a14mr692615qvd.34.1620244000913;
        Wed, 05 May 2021 12:46:40 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.49.2])
        by smtp.gmail.com with ESMTPSA id r16sm211492qtx.36.2021.05.05.12.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 12:46:40 -0700 (PDT)
Subject: Re: [PATCH v3] hwrng: exynos - Fix runtime PM imbalance on error
To:     =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Bart=c5=82omiej_=c5=bbolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <CGME20210505182918eucas1p18a11263e5d214e3356ac65d79504e430@eucas1p1.samsung.com>
 <20210505182914.13394-1-l.stelmach@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <5c6702a0-dd9e-dc76-6f8b-449d52fea210@canonical.com>
Date:   Wed, 5 May 2021 15:46:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210505182914.13394-1-l.stelmach@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2021 14:29, Łukasz Stelmach wrote:
> pm_runtime_resume_and_get() wraps around pm_runtime_get_sync() and
> decrements the runtime PM usage counter in case the latter function
> fails and keeps the counter balanced.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
> Changes in v3:
>   - use pm_runtime_resume_and_get()
> 
> Changes in v2:
>   - removed Change-Id from the commit message
> 
>  drivers/char/hw_random/exynos-trng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
