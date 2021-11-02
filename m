Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7614428F4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhKBH6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:58:11 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41682
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229878AbhKBH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:58:09 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 674083F1A9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635839734;
        bh=TL9ujWaRC5QrK/omsBGAzgL+mAn1UaLwIFZhjmwNN9I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ExQCg3V+trrItHD3VZ6u7EPN285MG1j7302uaICCX+DirvLS8Qcnxusodz+LCKh/3
         euVrH+Scp5HK1zKc7hwRgOYoaID9vpyA0zW6poT8k5pNuoSDS8FFJj0WM5BMUAFVHq
         vlL90A6KAd9wKzQlyccLkbCtN0efyGwuPWhK+4zIeEVvMpNx/B+MenjIWetoBoMFyp
         Y3SdVfmM4ANZyz4K1+6aNJQMzbqX4ad+n/9XzRaC2mgpfjpOL4Iil+BOcsj81dh69h
         wNs//havHbZeS3ODg5DDVvdy8BcYzIJsrudZD3WCpKpwV0rmr/rZ3IMWlTKUiPuMsk
         qDgA4Lz+KYjkA==
Received: by mail-lf1-f70.google.com with SMTP id i1-20020a056512340100b003fdd5b951e0so6701028lfr.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 00:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TL9ujWaRC5QrK/omsBGAzgL+mAn1UaLwIFZhjmwNN9I=;
        b=x/K8HedaYTRuUyFy7tuQuqgBD4Enss8xPq8lrAQ78NYAj4i2V7ymZ7yHCEA1cAisMU
         nZeOd+tIMoUkfqC3ZIxJG6FlaCZZcoYB8vAIXMoIMXOuyqCTN/0NG1ERnJnG4aTb+88R
         6YoYsDbLHDiuaGYtj0sSEuZ5m9SG++nUfMkodoaszhaDgi0LynQDozl7SXsIA4li7WF8
         AerX03H1YDyP2cbx7soHsBhw/xFat6fLccFmtXKG6tLqyIv/aLGZCeyyzFGh+/i+hR9Y
         YnYehsKyePCzalElUr0iOorXKpt6jLTV8qeYgaBBUXCDeNp2tPEUPZwOTFH6o0Ow5hrR
         13JQ==
X-Gm-Message-State: AOAM532YACDnfnUCB7j77dyi5Pc6ATZHTItGLyhMiLuXdpUa9tlGXGdU
        vNbz1NHwEWv4I3DTF1wVhOu5TGLBahi7jt7sjlGjvV3v3jEpEzEACFL+3ArUiX1iR+wMf9NkL60
        pMuo1NFzv1fKN3ufAoIvTFjGoSs5ePlg271QgTGl27Q==
X-Received: by 2002:a05:6512:b83:: with SMTP id b3mr32712047lfv.654.1635839733925;
        Tue, 02 Nov 2021 00:55:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWfHYARD0cMK/UpHT4OBoPI1WgrZQDQUCrOlg/dE4Y6zJh9PI9MVX5Aw/N+Qh4RKsTqWkJwA==
X-Received: by 2002:a05:6512:b83:: with SMTP id b3mr32712035lfv.654.1635839733798;
        Tue, 02 Nov 2021 00:55:33 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id s1sm111943lfi.124.2021.11.02.00.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 00:55:33 -0700 (PDT)
Message-ID: <a7697cc9-1872-d466-0fb7-683df9c46af9@canonical.com>
Date:   Tue, 2 Nov 2021 08:55:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: samsung: Document Exynos7885
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211031231511.46856-1-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211031231511.46856-1-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2021 00:15, David Virag wrote:
> Document compatible string for Exynos7885 SoC.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - (none)
> 

Both patches look good, I'll take them after the merge window.


Best regards,
Krzysztof
