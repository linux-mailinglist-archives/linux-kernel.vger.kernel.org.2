Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C88351254
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhDAJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhDAJcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:32:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D84C0613E6;
        Thu,  1 Apr 2021 02:32:30 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v4so1092048wrp.13;
        Thu, 01 Apr 2021 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m7OrC6vj4Ru9A4xIjIuXg2uQCm2nhCLjuUpyEt8tkp4=;
        b=doV/YsPMjbZWumawG16LSTXvaXbvbIqQJK+85kUXXkHAqlMAZVew+GoeoiCXhoOmKf
         Wf0mAtYzU4Hd+RfB7y3yWvTvV6tKv/loIBWkpybrAz8acGW7g9XeULyIVtXWkMvcPHaS
         0gg1yLhXMCoP/YDMI2rzRqzpFHVsL5KTSQT4EYYoa7F0CHUkQsbvLUibPXIbz9+ABzBb
         Y/UPM+OeR6eJbHwglanaIz6WeaKJuk8rvBXbSiBXDBZMfTjFw+Cr3vzvKJY7adgj+T17
         5nGyl5G2Qddu698VpYLhBVb1HyQPtrSJuTEHLjVsDsOnPEKq/4C8xFJ4QyxIQdbAUt5M
         zoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m7OrC6vj4Ru9A4xIjIuXg2uQCm2nhCLjuUpyEt8tkp4=;
        b=k2L95vd1l53uWkgetCoTyTQVc60nI8kU7Q1RaCOs677ePSJ8AXpCLPHI9aE8pqQcG+
         zgKd8ojEC/jPGFTtyaIfYCjP0bZOsC1p0kR9R4ch40i53AJXAByqHfwLLLmnPsiPvcjB
         Roz1Tg2/9Zlv6jMXNxeZ0Q7TTmkKBCEhxRqiwCrU3NvT7QaphKdadgRJy/Rrr+VqgTSC
         goJZaF7QKXWQ8i2MwE6Xj6rh4cF3QVhGhKdKxbD/mSs9FE0xPMYFoSajTE3aa80EPUZS
         milqZZwmqVQY7dcFPZ5i8yINzsjvjA+OWtxfmc3cbb8AUbbY4FL8y7svUXaxc3maYqIZ
         N2SQ==
X-Gm-Message-State: AOAM5317SS8IS4h7flSZMHyB6M3W9VdTCW5m2PEfDCqLb/ygq7VzmgfM
        UskbDyhP1QEjBmisGFsjFS8qd0Hlh8lZfw==
X-Google-Smtp-Source: ABdhPJxHaKLGzIFoJky4dcK5r6tLtS/ecHY7Cyikt6QgG4Ix4m0ncb/XjwK//QYxBmD90AOX4tGT3Q==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr8280936wrw.422.1617269549475;
        Thu, 01 Apr 2021 02:32:29 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id u17sm8760176wrw.51.2021.04.01.02.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:32:29 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: arm64: dts: mediatek: Add mt8183-pumpkin
 board
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     mkorpershoek@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210217205945.830006-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <86a6d071-007d-5a20-bd59-ba09054b9fc1@gmail.com>
Date:   Thu, 1 Apr 2021 11:32:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210217205945.830006-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/02/2021 21:59, Fabien Parent wrote:
> Add binding documentation for the MT8183 Pumpkin board.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Whole series applied to v5.12-next/dts64

Thanks!

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 53f0d4e3ea98..8f5a625cfb3d 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -123,6 +123,10 @@ properties:
>            - const: google,krane-sku176
>            - const: google,krane
>            - const: mediatek,mt8183
> +      - items:
> +          - enum:
> +              - mediatek,mt8183-pumpkin
> +          - const: mediatek,mt8183
>  
>  additionalProperties: true
>  
> 
