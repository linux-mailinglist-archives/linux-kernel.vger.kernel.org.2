Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D0F3DF7CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhHCW3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:29:17 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:47014 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhHCW3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:29:15 -0400
Received: by mail-io1-f47.google.com with SMTP id z7so198440iog.13;
        Tue, 03 Aug 2021 15:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EIElEyRSM53MLE3+1DvYpQLnAdfHbUBM8sLtZAJMDa8=;
        b=ucLkj9pNLIy6BsPXV1wE1mBzwHBnd+z8FKDqQmoDPnKpeIclZ9J7l1ivE8yx9Dp8PZ
         KXJ1VixyruGUBnn/wiwf4AyqM4UHSWvpNBTBee6+g4IqsMsXSLiEf0fWgmx+K/OX/C5i
         qxuxyCz//dER+PtOPM5sVhM+36z+IQ8OEPb9G7J/TbyJ9LaXZHzfbGDHBFNxjXD7d1ho
         dj7VVOGY7qEqAoX65sbpxL7BVZeqf+y44oyeXsSPiLqzjcPlUnlbUqRtZLXB07GczdbU
         obhjgeDWIFH4pTNWTDKxrSI5O1KI5Td6tpPlUbfB52fv25k5fr0La802brHuB+SdNEy1
         YrUw==
X-Gm-Message-State: AOAM533WBeOLO1KMkKR601DoHgo+tQE9k/VguGgcUjhmvZv1cyozsDpR
        pxs8sC+SPgDtczOmnDt4Lg==
X-Google-Smtp-Source: ABdhPJzC/sOjRlF3AqPXMRIf3nwj9myK7PMuHWJzsHWxC2L4m8Q4yn24FuoLuAd2V6EtStJc3TFR/g==
X-Received: by 2002:a5d:9ac1:: with SMTP id x1mr629577ion.191.1628029742852;
        Tue, 03 Aug 2021 15:29:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v5sm155949ilu.19.2021.08.03.15.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 15:29:02 -0700 (PDT)
Received: (nullmailer pid 3843862 invoked by uid 1000);
        Tue, 03 Aug 2021 22:29:00 -0000
Date:   Tue, 3 Aug 2021 16:29:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 4/4] dt-bindings: phy: Add bindings for HiKey 970 PCIe
 PHY
Message-ID: <YQnDLFmvV3AtihBy@robh.at.kernel.org>
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
 <b5809d8acf257834dd84807aa0474f68a94d8084.1627965261.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5809d8acf257834dd84807aa0474f68a94d8084.1627965261.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 06:38:58AM +0200, Mauro Carvalho Chehab wrote:
> Document the bindings for HiKey 970 (hi3670) PCIe PHY
> interface, supported via the pcie-kirin driver.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../phy/hisilicon,phy-hi3670-pcie.yaml        | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> new file mode 100644
> index 000000000000..1e0153e4f4a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/hisilicon,phy-hi3670-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon Kirin970 PCIe PHY
> +
> +maintainers:
> +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +description: |+
> +  Bindings for PCIe PHY on HiSilicon Kirin 970.
> +
> +properties:
> +  compatible:
> +    const: hisilicon,hi970-pcie-phy
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +    description: PHY Control registers
> +
> +  phy-supply:
> +    description: The PCIe PHY power supply
> +
> +  clocks:
> +    items:
> +      - description: PCIe PHY clock
> +      - description: PCIe AUX clock
> +      - description: PCIe APB PHY clock
> +      - description: PCIe APB SYS clock
> +      - description: PCIe ACLK clock
> +
> +  clock-names:
> +    items:
> +      - const: phy_ref
> +      - const: aux
> +      - const: apb_phy
> +      - const: apb_sys
> +      - const: aclk
> +
> +  clkreq-gpios:
> +    description: Clock request GPIOs
> +    maxItems: 3

This can be dropped now?

If not, at least use the same property name. (But really, why duplicate 
information in DT).

Rob
