Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D74F337F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 21:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhCKUc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 15:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhCKUcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 15:32:02 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6664C061574;
        Thu, 11 Mar 2021 12:32:01 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f26so3867957ljp.8;
        Thu, 11 Mar 2021 12:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CKnkGjn47xa7ZD0AoETSWdNCSl6QePkA6H1YePqpgRk=;
        b=R5SddUDX7JcsfaoRxdnopRqF5y0Y6lIJ+yRKOIEp3qoiAPAvf3q1REQbVmB5Lvr03Z
         1xx8JBMzmkAgLOZ2hQ/ar31Epn7HlMRI47KaA1J6ix+/hJ8oDBSF5VgPxynsBpFJZDlh
         k4g1crqta5scPMyLHhYBeQcqAAT/g5BK3nOpcDd/8eSBAQwuVi0s6In5nC+1g91S9YDV
         IvHs6MFKRtL+WSVUKfLDs9NiHZ5DA+32ZkW6V++S9VjNqgZsqkQuQiPiOjAqqXS8LOvP
         h/zRyO+Wk6GlEjcdOddyI8hM9YnAD3zFrbcIkC/lee+TZQRu+7PuIhw85Ndw29e6Zhho
         gYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CKnkGjn47xa7ZD0AoETSWdNCSl6QePkA6H1YePqpgRk=;
        b=U5fvC08dRiyCi9dOOVTnhzCazrxGA4Lw2tdTsFpdURUQNOtywfkK8adOJxF4NUIJUb
         4ybVb5GThpFX59C30zza406TsQyZQX7Otx7Kz6LqJEfSMgMxMAdvKbE2m89Hvh0WdlVp
         NfWCFuXZn5jlATrcn6TsA4KGxvk1HrhEdFwafH8S7QGfDx+0oFRt4SncDXq71o9z6AuK
         4o74xrSkZRfaVlmGR73sTf5owRnwMJcMHHnbDdodwH+5f8+IYSt+tKiKV0iPg/j9msu4
         KRzfHrJcICJUlRhJ3d46AY4179lY/JPk1jOTTIYka7akjaNwBaZsbDCXS5KUuR9tM2MH
         3r4g==
X-Gm-Message-State: AOAM530oQBpV6ZT1Lqf7nS4qBUNwJuH0JAN4le1dCo3SHA19DHClQkwv
        rWs6uieGIolRHpKK7AjzdB0=
X-Google-Smtp-Source: ABdhPJxjS5IIsA+kqp/6+wprfQzsWbKbfDun7F5Pslcf3YIkpLewR5euFf+kYCbb8ZI9YdxKPPaxlA==
X-Received: by 2002:a05:651c:481:: with SMTP id s1mr371983ljc.152.1615494720334;
        Thu, 11 Mar 2021 12:32:00 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id h24sm1341976lji.35.2021.03.11.12.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 12:31:59 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: phy: bcm-ns-usb3-phy: convert to yaml
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-phy@lists.infradead.org, Vivek Unune <npcomplete13@gmail.com>
References: <20201116074650.16070-1-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <ed093ddb-da37-c3c4-cdd9-3b8e8db776bb@gmail.com>
Date:   Thu, 11 Mar 2021 21:31:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20201116074650.16070-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16.11.2020 08:46, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Change syntax from txt to yaml
> 2. Drop "Driver for" from the title
> 3. Drop "reg = <0x0>;" from example (noticed by dt_binding_check)
> 4. Specify license
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> I think this should go through linux-phy tree. Kishon, Vinod, can you
> take this patch?
> 
> This patch generates a false positive checkpatch.pl warning [0].
> Please ignore:
> WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
> 
> [0] https://lkml.org/lkml/2020/2/18/1084

Kishon, Vinod: I sent this patch back in December, it was Reviewed-by
Rob, but never accepted.

Could you push this patch to the linux-phy.git?


> ---
>   .../bindings/phy/bcm-ns-usb3-phy.txt          | 34 ----------
>   .../bindings/phy/bcm-ns-usb3-phy.yaml         | 62 +++++++++++++++++++
>   2 files changed, 62 insertions(+), 34 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
>   create mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt b/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
> deleted file mode 100644
> index 32f057260351..000000000000
> --- a/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -Driver for Broadcom Northstar USB 3.0 PHY
> -
> -Required properties:
> -
> -- compatible: one of: "brcm,ns-ax-usb3-phy", "brcm,ns-bx-usb3-phy".
> -- reg: address of MDIO bus device
> -- usb3-dmp-syscon: phandle to syscon with DMP (Device Management Plugin)
> -		   registers
> -- #phy-cells: must be 0
> -
> -Initialization of USB 3.0 PHY depends on Northstar version. There are currently
> -three known series: Ax, Bx and Cx.
> -Known A0: BCM4707 rev 0
> -Known B0: BCM4707 rev 4, BCM53573 rev 2
> -Known B1: BCM4707 rev 6
> -Known C0: BCM47094 rev 0
> -
> -Example:
> -	mdio: mdio@0 {
> -		reg = <0x0>;
> -		#size-cells = <1>;
> -		#address-cells = <0>;
> -
> -		usb3-phy@10 {
> -			compatible = "brcm,ns-ax-usb3-phy";
> -			reg = <0x10>;
> -			usb3-dmp-syscon = <&usb3_dmp>;
> -			#phy-cells = <0>;
> -		};
> -	};
> -
> -	usb3_dmp: syscon@18105000 {
> -		reg = <0x18105000 0x1000>;
> -	};
> diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml
> new file mode 100644
> index 000000000000..7fd419db45d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/bcm-ns-usb3-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Northstar USB 3.0 PHY
> +
> +description: |
> +  Initialization of USB 3.0 PHY depends on Northstar version. There are currently
> +  three known series: Ax, Bx and Cx.
> +  Known A0: BCM4707 rev 0
> +  Known B0: BCM4707 rev 4, BCM53573 rev 2
> +  Known B1: BCM4707 rev 6
> +  Known C0: BCM47094 rev 0
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,ns-ax-usb3-phy
> +      - brcm,ns-bx-usb3-phy
> +
> +  reg:
> +    description: address of MDIO bus device
> +    maxItems: 1
> +
> +  usb3-dmp-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the DMP (Device Management Plugin) syscon
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - usb3-dmp-syscon
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        usb3-phy@10 {
> +            compatible = "brcm,ns-ax-usb3-phy";
> +            reg = <0x10>;
> +            usb3-dmp-syscon = <&usb3_dmp>;
> +            #phy-cells = <0>;
> +        };
> +    };
> +
> +    usb3_dmp: syscon@18105000 {
> +        reg = <0x18105000 0x1000>;
> +    };
> 
