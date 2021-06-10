Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4D43A2765
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFJIuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:50:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44272 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFJIuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:50:15 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrGMM-0007vX-6R
        for linux-kernel@vger.kernel.org; Thu, 10 Jun 2021 08:48:18 +0000
Received: by mail-wm1-f70.google.com with SMTP id 18-20020a05600c0252b029019a0ce35d36so3542821wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YCThDjpaFHnd9q5rWUaETkYePP9lVv23un9cpBMG23U=;
        b=nSnJbsot9+7ngJi3bChDXtP3f4YP1pTm5QLEEljtRtRk2zBpQmgfWQbra9FzICCrkq
         KsWxseLWZZF2G5Zd+bVviqlkSo/hG7hTW8CVV3NRwbDglqJ+Z1WUyJdS6b+nQSBkOJ7O
         UAhVm1YHgOw9kuvNVylHEL37JZkTaZ0tBcIadbhbrSTylJyUwwWLXLrODhISUDUeInsD
         E3qTMFvsXJF6PM+w3z3inUP6HLj9umeuzsxXaSmtlUedbBxvH+2vMnfrJaVpn3b+z4Xg
         2cXGvIpbFFvvcpZ5tF7Tp9JCauwricHXuz9m3+Nid7hz/VPK03vAmOcqamD1d1O6kTUK
         hYew==
X-Gm-Message-State: AOAM533iBD1pV+yNFB3YHknAAJ2oMgPt/3uc73oe3pc/xBIwE8zfjLZs
        RsvwIvNz7kiVerNkWMjoz36AXP6macsl/WfTvdO7NL1Hk9JsgOnr5JFUkh+X5+71iRp5Fgu0Y3a
        Qn1IyeRx2aK/Em6zVW/lViugiepLYIbClApo0Y6JRvg==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr4101185wru.77.1623314897978;
        Thu, 10 Jun 2021 01:48:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnI69OSD3AX6rHDEwFixaiCIwaEQAjUyh8avsvzpR/BP415Z0ipn+qaT3Xcoa9ZnIkST0Cww==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr4101169wru.77.1623314897855;
        Thu, 10 Jun 2021 01:48:17 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id d131sm8758029wmd.4.2021.06.10.01.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 01:48:17 -0700 (PDT)
Subject: Re: [PATCH v23 17/18] dt-bindings: mtd: pl353-nand: Describe this
 hardware controller
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        helmut.grohne@intenta.de, Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
 <20210610082040.2075611-18-miquel.raynal@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ce97c460-14eb-a758-31f6-124585e733f1@canonical.com>
Date:   Thu, 10 Jun 2021 10:48:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610082040.2075611-18-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2021 10:20, Miquel Raynal wrote:
> Add a yaml description of this NAND controller which is described as a
> subnode of the SMC bus.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/mtd/arm,pl353-nand-r2p1.yaml     | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> new file mode 100644
> index 000000000000..5f126bb9b202
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/arm,pl353-nand-r2p1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PL353 NAND Controller device tree bindings
> +
> +allOf:
> +  - $ref: "nand-controller.yaml"
> +
> +maintainers:
> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> +  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> +
> +properties:
> +  compatible:
> +    items:

I think you can skip the "items" here and leave only "const: foo".

Best regards,
Krzysztof
