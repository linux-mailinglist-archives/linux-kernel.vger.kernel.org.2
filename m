Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458CD4028C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbhIGM3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:29:42 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37508
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344558AbhIGM3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:29:35 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 643F14079B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017708;
        bh=pBLtjph6RQEau8atPQFYfe8U7ef+hzqhMpxfWP4Bq6k=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=FqEMy8Nk1COLUHZVDEFulNjtck01XygNXLlgqpnHo2sJIUhk4Qxnv4r5dEGW4trDO
         xORISRWYXGcBcq22f1dvugsBX+q+j1SHYlttD56O5Xb/mQOhGjjp+sFVLH7Dio8z4j
         lX8n1kU6j65224tTodDntqIM3H6/dvXLCgdnSW64v1/a0YgkC/NH4O7BTtUWFnKthG
         IGwkoQVfp/iU5ui2RnJISn6fx6EeGVM1+HXuJpkSHSAvGvPLtcQZKkQUE25m1MA0tb
         jHnNACIngEPXsoWnVEasb3iPmVwWZFptHDlkRJeTPsyDusArqiAiIPStKfMGszm33k
         +zAaCZ/ECLo6A==
Received: by mail-wm1-f69.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so3331388wmj.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pBLtjph6RQEau8atPQFYfe8U7ef+hzqhMpxfWP4Bq6k=;
        b=HBt6pYHZxmHdKCVfO2zypqQV9C2j8Uob9JqnX1WI5oUDFkquUIT88+vtb0TCiMyB4q
         DzGwH8lzTkR2k0Tgu+3P43drKuP0gRfM0ktARDB9CO1P+llDGIQVfyqaBDflyhPq+9dG
         J1kXx0LVGVuv3XuovFGn7waYOVJusUJ2MRjo7gQ/mxY5eFGy/gX0Dr6POviXQJZ6EKby
         pIH6RB91HuFjJFBKJ18FIn9a1qDU2G7dz7vhsxorjdbZP6bfPPJvv5vjY1lDL1MHDaEE
         njkYi3FEVc0/EbpF5ZYVbkTcrZA6MB9HK4YJ7NC4tAK1nEKMHjY6rUagHlCamSFCuJm2
         kUdg==
X-Gm-Message-State: AOAM533JcWgJ6hNUAttu+8Zv5kMFC4KwAPj3dvsCtHTUf6nH9qwNGP9x
        NBkS13o5pJ8zBNobC/iwsqc4SlYXo/YRP3DeUU5BAobKg0tPtPLifZsZydfqWQrntjNd9H/bWEB
        CL90n9HhbPVMs+Vqjjz+b5Qf3qoQpxOVRkfEZ1eemww==
X-Received: by 2002:a05:6000:22d:: with SMTP id l13mr18433478wrz.410.1631017707042;
        Tue, 07 Sep 2021 05:28:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH8YGCnEpGP0h3+3v8fKMRKYSjBRI4kwHx1x58weU/Q149zGxzzjPZjvUPLf2ay8j3CaTMaQ==
X-Received: by 2002:a05:6000:22d:: with SMTP id l13mr18433468wrz.410.1631017706939;
        Tue, 07 Sep 2021 05:28:26 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.188])
        by smtp.gmail.com with ESMTPSA id l16sm8515158wrh.44.2021.09.07.05.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:28:26 -0700 (PDT)
Subject: Re: [PATCH] clk: samsung: exynos5433: Make use of the helper function
 devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210907085115.4254-1-caihuoqing@baidu.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ea98e7c6-641f-5db0-6bf8-76072cfe17aa@canonical.com>
Date:   Tue, 7 Sep 2021 14:28:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907085115.4254-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2021 10:51, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
