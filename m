Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAE937EB42
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbhELTVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245449AbhELQwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:52:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB97C0612B0;
        Wed, 12 May 2021 09:33:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e7so5740275wrc.11;
        Wed, 12 May 2021 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WKFBLhMyTkS7BKOikVrkP4FV7nAoabO4CG7z4br68DE=;
        b=a+aNAviufzUkCgligaluZ5C/T3prJd7/DnIW10TdVFgYsepOPcPBYdS6DZa6kGcKDU
         9opBe9mB1gus8F0tcunOE8LsKHwDO3KXAjYPY2sCNaK3/Jb+/2H2J4/HZnABK0qEX+zl
         eIG3LLHjIJsoihkLzGwanc5eTna08dI+Ecdr67+7L5brlX6JEOHAgZ/mFTs7fLFHlGfs
         TTAkNtO4/s5lg4t6dFeaO5/9pzKF5UhWaHQDBauQPyh5H06xAJ3yeDfd9cm2iRSWDGM4
         8hFFzBElkkiOcPlDIac4Ma8R+sImyWV7rDdExpS3IojdoAX+dIaAkEeFMHlgPJq/fJY3
         WRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WKFBLhMyTkS7BKOikVrkP4FV7nAoabO4CG7z4br68DE=;
        b=pdQIP3WCWKJLWtTAQzIJo3cWvnn84fyOrxB9LsOlOuLDxorVnYPt3MeHkPym509aT8
         GxJtLpt72Gt+xORctAHfSKCFKvco6M2gY4o2veqRQYrbfHWSSzoKzY23TE3R/QfHmRBZ
         pcdrSFE3IOh9rZ/547Nga8XYJlfP8SofVT9Ggra2mfLQAGnTwGXYsWhW3JZ6b4pLmh+j
         5miLDxdf/s9zS27Yu6upm2IhzUB4S+foq6BfrM784cyTqEAOU0rUAWbp0+wxtAhrudzh
         CjOO67s2JMI8UxKk+DxBOfTHPrvZMkj5+g3njelwJmSbHLOXQttQDAeCMA6VhD70/OH2
         G4vA==
X-Gm-Message-State: AOAM533v5kj2WDXczIhnM0kzcHKh/u8ZBARLBogY9SbBMY/JXahOus+X
        ii9VKyY5QRctw47WXW503Ew=
X-Google-Smtp-Source: ABdhPJyokWdNDAfgloClWaWik3W3sa7b0KN2iLv2Mnjl86s3mNiHt+RjWCfKBpdWy5qTA3eOD97hmg==
X-Received: by 2002:a05:6000:1549:: with SMTP id 9mr46381060wry.367.1620837229554;
        Wed, 12 May 2021 09:33:49 -0700 (PDT)
Received: from ziggy.stardust ([37.223.140.37])
        by smtp.gmail.com with ESMTPSA id k16sm155693wmi.44.2021.05.12.09.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 09:33:49 -0700 (PDT)
Subject: Re: [PATCH v3 00/10] Add several jacuzzi boards
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20210421090601.730744-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b241e27c-b68a-1d2a-cbae-4f8b41cf02b1@gmail.com>
Date:   Wed, 12 May 2021 18:33:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210421090601.730744-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/04/2021 11:05, Hsin-Yi Wang wrote:
> Add several jacuzzi follower devices: kappa, willo, burnet, kenzo, and
> fennel.
> 
> Change log:
> v2 -> v3:
>  - remove unused property in i2c2 in willow and burnet.
>  - add fennel.
> 
> Hsin-Yi Wang (10):
>   dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kappa
>   dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-willow
>   dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-burnet
>   dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kenzo
>   dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-fennel
>   arm64: dts: mt8183: Add kukui-jacuzzi-kappa board
>   arm64: dts: mt8183: Add kukui-jacuzzi-willow board
>   arm64: dts: mt8183: Add kukui-jacuzzi-burnet board
>   arm64: dts: mt8183: Add kukui-jacuzzi-kenzo board
>   arm64: dts: mt8183: Add kukui-jacuzzi-fennel board
> 

Whole series applied to v5.13-next/dts64

Thanks!

>  .../devicetree/bindings/arm/mediatek.yaml     | 29 +++++++++++-
>  arch/arm64/boot/dts/mediatek/Makefile         |  8 ++++
>  .../mediatek/mt8183-kukui-jacuzzi-burnet.dts  | 30 +++++++++++++
>  .../mt8183-kukui-jacuzzi-fennel-sku1.dts      | 44 +++++++++++++++++++
>  .../mt8183-kukui-jacuzzi-fennel-sku6.dts      | 32 ++++++++++++++
>  .../mediatek/mt8183-kukui-jacuzzi-fennel.dtsi | 27 ++++++++++++
>  .../mt8183-kukui-jacuzzi-fennel14.dts         | 16 +++++++
>  .../mediatek/mt8183-kukui-jacuzzi-kappa.dts   | 16 +++++++
>  .../mediatek/mt8183-kukui-jacuzzi-kenzo.dts   | 12 +++++
>  .../mt8183-kukui-jacuzzi-willow-sku0.dts      | 13 ++++++
>  .../mt8183-kukui-jacuzzi-willow-sku1.dts      | 12 +++++
>  .../mediatek/mt8183-kukui-jacuzzi-willow.dtsi | 26 +++++++++++
>  .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |  8 ++++
>  13 files changed, 271 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
> 
