Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81A4389363
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355159AbhESQOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:14:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35922 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241485AbhESQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:14:34 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ljOos-0008PB-8Q
        for linux-kernel@vger.kernel.org; Wed, 19 May 2021 16:13:14 +0000
Received: by mail-qt1-f199.google.com with SMTP id s11-20020ac85ecb0000b02901ded4f15245so10148137qtx.22
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eS+z7fWf9ik7UiPFy0EbImNsC/jTSa8AjK2vvxy5tQE=;
        b=D44fNwz2ofRkAdLSisAV/3ohVOYlf/map39vsGdq/Qgoto//KyqdJhv/ZGBRyzVFsa
         HcTOfZbFn0GF+OF88y9/eLDhEpyJ2pAmqTg47FJaX72KBnBUjOUORluureq0V85ixyAN
         hRC/JOfU04jSaEm0MTmRNFSjRxNCf85mEw80Kh6qgojZI2XtQYibvfR5jHrM6dgGtJZC
         oZxMLuypkN49vV2I0K0twPzHps/rFGABZc/Yp7Iy3W1w46vdbegIxDGMx49mpslPnLK2
         yvlEMTM1eZH9LL4SDCFqNR8Wegox947vflFDyyt1nJ7MHUhGK6PGGBbh6/McjUB4TqJK
         Jz0g==
X-Gm-Message-State: AOAM53271+bzZhSxb3kKYu0hXBuUgwWy7OxyFbAqlwsePlTBEvH+dqoA
        ulULa3n+JRC75+Rr11OPRAtAujpo24ctCBG3nMlKLJkp7KKHL7dSCUSpdpU98gpPGA+ldEHoPOs
        1trPVojLrFHuzj6HmvBVqB7FpMN+AubkmH3wHU2IlWQ==
X-Received: by 2002:a05:620a:13a6:: with SMTP id m6mr77875qki.370.1621440793085;
        Wed, 19 May 2021 09:13:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUghUkKBDIuGvqx1Nu07luWzepugYJj1I5VtklAhOR9KibnL6Cutz0I3Szhxs1G5QJhQj6OA==
X-Received: by 2002:a05:620a:13a6:: with SMTP id m6mr77852qki.370.1621440792900;
        Wed, 19 May 2021 09:13:12 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id f1sm83218qkl.93.2021.05.19.09.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 09:13:12 -0700 (PDT)
Subject: Re: [linux-nfc] [PATCH v2 2/2] nfc: s3fwrn5: i2c: Enable optional
 clock from device tree
To:     Stephan Gerhold <stephan@gerhold.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20210519091613.7343-1-stephan@gerhold.net>
 <20210519091613.7343-2-stephan@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <86461091-617b-62ec-a9e5-2aec337d69ce@canonical.com>
Date:   Wed, 19 May 2021 12:13:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519091613.7343-2-stephan@gerhold.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2021 05:16, Stephan Gerhold wrote:
> S3FWRN5 depends on a clock input ("XI" pin) to function properly.
> Depending on the hardware configuration this could be an always-on
> oscillator or some external clock that must be explicitly enabled.
> 
> So far we assumed that the clock is always-on.
> Make the driver request an (optional) clock from the device tree
> and make sure the clock is running before starting S3FWRN5.
> 
> Note: S3FWRN5 asserts "GPIO2" whenever it needs the clock input to
> function correctly. On some hardware configurations, GPIO2 is
> connected directly to an input pin of the external clock provider
> (e.g. the main PMIC of the SoC). In that case, it can automatically
> AND the clock enable bit and clock request from S3FWRN5 so that
> the clock is actually only enabled when needed.
> 
> It is also conceivable that on some other hardware configuration
> S3FWRN5's GPIO2 might be connected as a regular GPIO input
> of the SoC. In that case, follow-up patches could extend the
> driver to request the GPIO, set up an interrupt and only enable
> the clock when requested by S3FWRN5.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> This allows NFC to work properly on the Samsung Galaxy A3/A5 (2015).
> 
> Changes in v2: Rewrite commit message and comment based on discussion
> 
>   Note: I tried to explain the setup a bit better but dropped most of
>         the explanations about the exact configuration on the Samsung
>         Galaxy A5. I think the HW-specific details were more confusing
>         than helping. :)
> 
> v1: https://lore.kernel.org/netdev/20210518133935.571298-2-stephan@gerhold.net/
> ---
>  drivers/nfc/s3fwrn5/i2c.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
