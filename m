Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BE040C1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhIOI2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:28:52 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46808
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236764AbhIOI2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:28:30 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B6764028C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 08:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631694430;
        bh=c0ktSqPBV6zrAWdMe5+J2g1bcwqmTCFhZ2hdgWxJG/Q=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=r8z8RovoeCkO2JbRfHjXP0FCMtPrffDtyK/YKArA4RNKv9X+tUex4nMncfSYubhYx
         4i+k3wYdI/c14QzbINMdMVb7lp4NU36PE5ZQ/irLVGi7Rq00CLDQy719FQX2S+LCiY
         kksJG/J2QTGUjE+7JybzRzbl4N4aM4u1pXXpP64EpxV7jWEOfKnWE0S2SEKVkZpvO3
         P6WXCEhrZbstUv0vAr2hQzZLFqDhlMcCJIX9JENw8Le6xuljL23aY6tjfeXWMih7QC
         vi2fCVELZPau9AJxA7JNyqjGm/TTiU7KH/T5BFdKI29hj8amdWQzj+IWkpngR8FMAx
         oHYaKNheB0NBQ==
Received: by mail-ed1-f71.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so1153409edy.14
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c0ktSqPBV6zrAWdMe5+J2g1bcwqmTCFhZ2hdgWxJG/Q=;
        b=P/E7qc1hZeGhNtIN/wbBL9t7wFTyvag0cYnD4ygcpKATFZYv2AdtIIyEUQn/MAS9su
         t+KTry0N6X9XzsAVSIePVy1rOKyY16leb9FGq5k1bCPOf2MDGSgtHJVVgxrLUAryIvQO
         LUqIehrTPaU5yN9mDfWrE/IT+xLndkgYGULdBpmCReZALulAnKZ7o58K3bVy5+GJALkX
         AqElvqQYF9QQJdCGTgKy2SLinexFHBuI+t6EmAXHZqBc9P3lB6BbWEwsINCyR2JOmT4e
         FRuoDV5F2XKOZUqvgFCtTk+VLP8eCLn0Bj0YO3i+PkWey5CJY5u/gkEPI2T2ND4/6mzQ
         /RqQ==
X-Gm-Message-State: AOAM532kObwFpq3fEXPu1c904XHHKouQ/goyJWKt4WHZNK87c8YhPghR
        FDJ2RdarTf4s/en/84hNOTD3qWZ/Zpx25F79Jfx+7pgGe3AYk97dA+SEZwhlD9YApfnRm4CinS9
        mLudcmYYFTb2jwvb+QrMhznPilZbfbgb1P8FldqCPvQ==
X-Received: by 2002:a05:6402:42d4:: with SMTP id i20mr18825598edc.348.1631694429908;
        Wed, 15 Sep 2021 01:27:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJujQjYVHel2sNKzotlRkaiyjwxk4PvbAgB7ek3KN7SaHfnHfWRFV7KrDrr/6Z5D4w/Nh3Zw==
X-Received: by 2002:a05:6402:42d4:: with SMTP id i20mr18825590edc.348.1631694429780;
        Wed, 15 Sep 2021 01:27:09 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id l22sm4804830eds.58.2021.09.15.01.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 01:27:09 -0700 (PDT)
Subject: Re: [PATCH 4/6] dt-bindings: clock: Add bindings definitions for
 Exynos850 CMU
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Ryu Euiyoul <ryu.real@samsung.com>, Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20210914155607.14122-1-semen.protsenko@linaro.org>
 <20210914155607.14122-5-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <396f1761-567f-0407-7d95-acd7bbd38de9@canonical.com>
Date:   Wed, 15 Sep 2021 10:27:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914155607.14122-5-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2021 17:56, Sam Protsenko wrote:
> Clock controller driver is designed to have separate instances for each
> particular CMU. So clock IDs in this bindings header also start from 1
> for each CMU.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/dt-bindings/clock/exynos850.h | 72 +++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 include/dt-bindings/clock/exynos850.h
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
