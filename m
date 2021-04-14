Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C69635F46E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351082AbhDNNAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:00:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36361 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346952AbhDNNA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:00:28 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWf7k-00017y-Pk
        for linux-kernel@vger.kernel.org; Wed, 14 Apr 2021 13:00:04 +0000
Received: by mail-ed1-f71.google.com with SMTP id l2-20020a50e8c20000b02903825413b3e0so3276237edn.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 06:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=irHnM0N6YXz5tYQ++DF6/Rjy5fbDV4uUdW4SKyf56fY=;
        b=TMYQII5e9UgS3wxajd3cnR891X/9DR/lYdAfyS3kv1/Mlr3C079+vpkplqXB0mAAE3
         77oMrhpMQKq/xvBTxSv+HjCepa/CZZXkqanSF4TpqNZsVz1bJVVxHU/dN09VjOUD6y/x
         ACPCmefvX+z+W3V2n57Y0Gz03GKbAbCk9FoD58JEQ2cVIfqFZcXTYIaYSJAwgQj3bdD9
         O5lDP1oPLAgewK6IPjZhWgsQaGbUTap8X1UTo98ON2lRE+CUp3QkssaK1mMeHzc6JDoQ
         MldfKhlBpu5eYIHk8yTTmpgyzXdgHd8fjPsAdJot2x3R4plG2QBzTbQRHBVG9reKfik6
         gSbw==
X-Gm-Message-State: AOAM530q2WGXVu3kMq4Iow55kdpmT4J1WYFmTUlW+i8wtXX8C+3gjprZ
        neW0IgqXJ9PjQTVe5E1y4zdN3mk+aQuwCJftxQyfdXFezpNSLEpA6Uwp8WbbhzVb2YzPdLYYL0a
        ksYRM3JfSHTYXgyPEDW0PJmk/g1CnuGBQa4hJcwQ10w==
X-Received: by 2002:a17:906:af84:: with SMTP id mj4mr18235677ejb.195.1618405204372;
        Wed, 14 Apr 2021 06:00:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTkebU3A/QNq+HZhYySOXaAmDUrYhKt4+4jSXk3XZFDrf7d4xCgORuv00qre/OyoVQMCTqzA==
X-Received: by 2002:a17:906:af84:: with SMTP id mj4mr18235656ejb.195.1618405204218;
        Wed, 14 Apr 2021 06:00:04 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id gb22sm9891595ejc.78.2021.04.14.06.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 06:00:03 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: imx: Add i.mx6q DaSheng COM-9XX
 SBC board dts support
To:     dillon.minfei@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        krzk@kernel.org, linux@rempel-privat.de, s.riedmueller@phytec.de,
        matthias.schiffer@ew.tq-group.com, leoyang.li@nxp.com,
        arnd@arndb.de, olof@lixom.net, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        prabhakar.csengg@gmail.com, mchehab@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-media@vger.kernel.org
References: <1618383117-17179-1-git-send-email-dillon.minfei@gmail.com>
 <1618383117-17179-2-git-send-email-dillon.minfei@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6d8a5d4c-b741-dc7a-7cfb-eb66a642cb6f@canonical.com>
Date:   Wed, 14 Apr 2021 15:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1618383117-17179-2-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2021 08:51, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> The DaSheng Com-9xx is and ARM based signle board computer (SBC)
> featuring:
> - i.MX6Q
> - 2GiB LPDDR3 DRAM
> - 8GiB eMMC 5.0 FLASH
> - 4MiB SPI Flash
> - USB 2.0 Host/Device
> - Multiple multi-protocol RS232/RS485 Serial ports
> - microSD socket
> - 5V DC power input
> - HDMI1.4a,1080p@60
> - RGMIIx1 Gigabit Ethernet
> - CSI0x1, connect with ov2659
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
> v2: no changes
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 297c87f45db8..24bdfbd4853f 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -206,6 +206,7 @@ properties:
>                - fsl,imx6q-sabreauto
>                - fsl,imx6q-sabrelite
>                - fsl,imx6q-sabresd
> +              - ds,imx6q-sbc              # Da Sheng COM-9XX Modules

You break here the alphabetical order. Should be after dmo,imx6q-edmqmx6.


Best regards,
Krzysztof
