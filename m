Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2109C3EBC6B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhHMTJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 15:09:06 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:44949 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHMTJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 15:09:05 -0400
Received: by mail-ot1-f46.google.com with SMTP id l36-20020a0568302b24b0290517526ce5e3so5753886otv.11;
        Fri, 13 Aug 2021 12:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8EJGPI/Iw2Zn1XdZIHti7bj0g9xtSy2psJ1mCcHZ2bA=;
        b=M63+pT/1OJdXOFW1ZrCX8hDo7G10SctiMbA5tibc+FkKDV9PyezXEpaaeOCVRvsPC/
         beVvBbf6XVOs00WaHnkCbEipFd2jf52ZLiJUnngk6/mW0h4wJfiKzcQZN5X/Lat2HPYF
         tqPefXVB0a2Uf3Noi35Vdbq4MH3gWAbjp9EZQ7Ns4vBS1B9Z9I02vSjMCJCxnT/UyeU3
         sBOPeTxrtwlsC+8GSESeSjcpB11PSB44Rev6r7K1cz1NXWA+Ezk+HwPm+asRfvdQN6U5
         pM1HmfBQCUsnNGBe8HSdeQFhTPAqUoiA6YmORHVmnxIyF+S9g9C5ZImCTPEGv2y1BOIz
         LruQ==
X-Gm-Message-State: AOAM5315Nnffvyl1AIqCnniE6x2TFX5QXwUdqKF1w0A1cHMw8QJsc0x9
        hVnpESyx7RQd+EY8+cHGtg==
X-Google-Smtp-Source: ABdhPJwFDYp9hZCyj4zII3+NVz+ViBLdMy50n1u1/NyzEsI1FrczJ0+ZJa5OzDWY5s2KSJ/VlVydMQ==
X-Received: by 2002:a9d:5d14:: with SMTP id b20mr3403981oti.307.1628881718575;
        Fri, 13 Aug 2021 12:08:38 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e20sm467648otj.4.2021.08.13.12.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 12:08:37 -0700 (PDT)
Received: (nullmailer pid 3881512 invoked by uid 1000);
        Fri, 13 Aug 2021 19:08:36 -0000
Date:   Fri, 13 Aug 2021 14:08:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: synaptics: remove unused DTSI for AS370
Message-ID: <YRbDNInfG7caSr2r@robh.at.kernel.org>
References: <20210806082635.20239-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806082635.20239-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2021 10:26:35 +0200, Krzysztof Kozlowski wrote:
> The as370.dtsi for Synaptics AS370 SoC does not have a user (DTS board
> file), is uncompilable and untestable.  It was added back in 2018.  No
> user appeared since that time, so assume it won't be added.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/arm/syna.txt          |   4 -
>  arch/arm64/boot/dts/synaptics/as370.dtsi      | 173 ------------------
>  2 files changed, 177 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi
> 

I assume Arnd/Olof will take this.

Acked-by: Rob Herring <robh@kernel.org>
