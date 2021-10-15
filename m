Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403D842EE98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbhJOKRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:17:03 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46298
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237918AbhJOKQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:16:57 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 24EAE40000
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634292891;
        bh=mNH6ovSrsZzXaFK7GnPEbneieuXh4e/GszJJRRWO4tU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=RKx0pNqPnX+U61iYiDssXqvNqqKe3xVnp+krm5OWh5RGmzDBy7Trk7aLUAd8UrTqD
         7AYYGtVJn8wydS0b3+Mf6TxvbzmUI6XappBatS+q9SaalmxRW+sL24SHsGP/mBXndZ
         9qNA+Jh7SnPVTNk5wvAhtA44aPsqOqH5d+N/Cc6K2ohPDL8ve1+F7r8qgrybBqH/oq
         vZ0ygwV0tZjVc51FWh8u18PHILE7VxrTCZDXawktv4TyFU2qKjBu4/OdpR4AavKORG
         JluuBBGEfjesxx2iRxNWHu4vRieyjPhe+o9ADQB9fldqZkKFCvmYlYqkJucYtJ/nAX
         mtNlZI+BoyJkQ==
Received: by mail-lf1-f70.google.com with SMTP id m16-20020a056512115000b003fdb79f743fso3950257lfg.16
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 03:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mNH6ovSrsZzXaFK7GnPEbneieuXh4e/GszJJRRWO4tU=;
        b=DWH8coNLkGX8ysDkm13o4Z/V94oVtue5a4mrQfVa3Kiuc9jOkwQEd+1vtDSHM38gf0
         qImtU8zOkDSiWknp3kbA/hLvqBnGQJcB8nAokzusqhxlwdvmy7d3ZslmwLTV3IlsG1TU
         FGrafJ7S/Ukf5wk/LKXCKWDd0YCV9SKjOYsJp2bonu9HZS3QxebJj6gUwVFSRHMqOFcG
         Z1lu3et8eeTKDSOF0L7cuNJGVj+nkHiGWA1n20rSnxBtF1PLlDgMQdIoFT1OSIGLhh9n
         1qgI/ViasFaETVGv9D7P43mtx29ERxMlTjHlpETVhVrzgdORyFBpCCjrvZwSiSq/OAD9
         6fJQ==
X-Gm-Message-State: AOAM5319dsE7/jY9qjztCmGrj3xU2hGl03zXgstCe1md7jYbscUkXkxX
        +iwFd3HLOUfhiJtbjJAtf2Gt71Xo3Jgd2qbe7vfGFgfEOPnjarPbEbP3F+2rvqgPqRY0GgqUaSw
        AhNJ0aG2S2v3r0v7lPM5I1nMFiE91GE7a4QpRopQ4xg==
X-Received: by 2002:a2e:b054:: with SMTP id d20mr11430714ljl.507.1634292889125;
        Fri, 15 Oct 2021 03:14:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj8pWt+ZNhjXMi79/AJl3fIpOyA6FNnV6Krm2En23aHOzWTdTC/H+JaioClNMPNag6ble8/A==
X-Received: by 2002:a2e:b054:: with SMTP id d20mr11430687ljl.507.1634292888834;
        Fri, 15 Oct 2021 03:14:48 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id 15sm465081lfy.86.2021.10.15.03.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 03:14:48 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] [RFT] clk: samsung: exynos5433: update apollo and
 atlas clock probing
To:     Will McVicker <willmcvicker@google.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-team@android.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20211014195347.3635601-1-willmcvicker@google.com>
 <20211014195347.3635601-3-willmcvicker@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <7cd65a6c-4d6b-a287-9a12-c81eec87e9df@canonical.com>
Date:   Fri, 15 Oct 2021 12:14:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211014195347.3635601-3-willmcvicker@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2021 21:53, Will McVicker wrote:
> Use the samsung common clk driver to initialize the apollo and atlas
> clocks. This removes their custom init functions and uses the
> samsung_cmu_register_one() instead.
> 
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c | 120 +++++++++++----------------
>  1 file changed, 48 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index f203074d858b..cec66d2a4ee2 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -3675,44 +3675,32 @@ static const struct exynos_cpuclk_cfg_data exynos5433_apolloclk_d[] __initconst
>  	{  0 },
>  };


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
