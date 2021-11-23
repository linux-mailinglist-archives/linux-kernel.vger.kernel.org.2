Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86145A801
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhKWQiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:38:02 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:36621 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbhKWQh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:37:59 -0500
Received: by mail-il1-f179.google.com with SMTP id l8so22338750ilv.3;
        Tue, 23 Nov 2021 08:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=0QKOHJ1OnKbL2a6U5UE9Sczj0KIVJUirLPHUpzoIxpE=;
        b=MvLgR1UL8n4xRGABtD9fpVDoy7W9zBLTJ3m4pLwW20e2/NMMap2HHAdNA5KK7PH3EK
         M3w7zaP06DbPiYczgisssPSA35X6l4Zt46Dvh9IeUvGirBGAxBkjZGSbiCPQBajx+HOb
         vWn1uHjMUgLTyuVHus8BguwIt1IZRZNttCNBIBTwdwIsuiBMgJHY/XqmVII8un71Cpsx
         ptSeS728cTvcjEp5J5+5jn6WVln1pCvvRNm0/jYVyVtLleXfLSnsSJPqG8MXbYEfean0
         4uaQm6ySv3wTR7c7p3UvVzO/UZ/fNR7hkKQnRKjXgb6tyjFHphlVZAwq5Qkgo1lF4UA5
         RA2A==
X-Gm-Message-State: AOAM53236VJNBJNjnQm9iOlEOZ4/FEcCqoAm301keeSV5p+QSold1tMn
        EMmw5ffwpxEtqyHuhfR83Q==
X-Google-Smtp-Source: ABdhPJwQbkkEsFEy5w9HCPyrvpKMWIAbN2aSLLV6mqx3Fn4hAA6t624FH30/QNlmaqLWwBm4sVG8Ow==
X-Received: by 2002:a92:c5ad:: with SMTP id r13mr2636828ilt.53.1637685290562;
        Tue, 23 Nov 2021 08:34:50 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t6sm3992225ios.13.2021.11.23.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:34:49 -0800 (PST)
Received: (nullmailer pid 3442924 invoked by uid 1000);
        Tue, 23 Nov 2021 16:34:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        fabrice.gasnier@foss.st.com, devicetree@vger.kernel.org,
        arnaud.pouliquen@foss.st.com, Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
In-Reply-To: <20211119144551.7577-2-olivier.moysan@foss.st.com>
References: <20211119144551.7577-1-olivier.moysan@foss.st.com> <20211119144551.7577-2-olivier.moysan@foss.st.com>
Subject: Re: [PATCH 1/9] ASoC: dt-bindings: stm32: i2s: update example
Date:   Tue, 23 Nov 2021 09:34:29 -0700
Message-Id: <1637685269.713393.3442923.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 15:45:43 +0100, Olivier Moysan wrote:
> Some STM32 SPI peripheral instances support I2S for audio.
> SPI and I2S features were initially described through two separated
> nodes in the SoC Device Tree. In the next SoC Device Trees
> a single node is used to describe SPI peripheral, leading
> to a change in node name for I2S.
> Change example in STM32 DT binding example to match this change.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1557188


audio-controller@4000b000: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/stm32mp157a-dk1.dt.yaml
	arch/arm/boot/dts/stm32mp157c-dk2.dt.yaml

