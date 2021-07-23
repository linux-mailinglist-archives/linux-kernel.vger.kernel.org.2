Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566FB3D4322
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 00:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhGWWKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 18:10:31 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:35689 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhGWWKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 18:10:30 -0400
Received: by mail-il1-f170.google.com with SMTP id k3so2982656ilu.2;
        Fri, 23 Jul 2021 15:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tn97+CizsFw2IJizFnnktOYs6q+YNVabHNC6r+3R/Zw=;
        b=YnZCxvXKxycVGXjy0l1ho+fN9iz530zglLR7hv7dQ57kDINUwo051xK42PNJPY+6Ne
         2hSk8UB8o4M3vWJteE4lFbU3bbmXolCISPsX9pzdeJQoTcmPdC4hWQbtyIUtkOYqqXoz
         g79blj2sdQk1rxmhmLmLilFSLXvCH8/6sbtSal3vVvqNmyGbDO9ksprIaRpkJBvZHGDU
         evi+KunNexK9/iQr1Vh22KYHqXtfIN4swKws3ijyJAdLWWOspKCPhwLRk0kfVmxCBZAA
         hTYnBaf55U+m6rwqMJdNaBUZ2EPW1/unvrmXcLQmvsHeFainWxmB9z3+0KZcgTsko42H
         /Yew==
X-Gm-Message-State: AOAM531K9ezVNeMWjQJUo7SN2UcaNmkQojBg0W6J5pZx6se8KstkBnYM
        psTjt3vXfGwex+gNQiWw0Q==
X-Google-Smtp-Source: ABdhPJyWShSD1k207DyYfCj8OBuahycWaQiiSDzxKTCbPLcLTn2vz5vRXmhkh0na1/i4ybC1Yi4P6g==
X-Received: by 2002:a92:cf03:: with SMTP id c3mr4924149ilo.195.1627080663062;
        Fri, 23 Jul 2021 15:51:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m184sm18795821ioa.17.2021.07.23.15.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 15:51:02 -0700 (PDT)
Received: (nullmailer pid 2750265 invoked by uid 1000);
        Fri, 23 Jul 2021 22:50:59 -0000
Date:   Fri, 23 Jul 2021 16:50:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v7 06/10] dt-bindings: phy: Add bindings for HiKey 970
 PCIe PHY
Message-ID: <20210723225059.GA2727093@robh.at.kernel.org>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
 <946f2426bc542638240980931eae924c57f2ba27.1626855713.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <946f2426bc542638240980931eae924c57f2ba27.1626855713.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 10:39:08AM +0200, Mauro Carvalho Chehab wrote:
> Document the bindings for HiKey 970 (hi3670) PCIe PHY
> interface, supported via the pcie-kirin driver.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../phy/hisilicon,phy-hi3670-pcie.yaml        | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> new file mode 100644
> index 000000000000..a5ea13332cac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> @@ -0,0 +1,95 @@
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
> +  reset-gpios:
> +    description: PCI PERST reset GPIOs
> +    maxItems: 4
> +
> +  clkreq-gpios:
> +    description: Clock request GPIOs
> +    maxItems: 3

Again, this will not work. 

It boils down to this fails to describe how the GPIOs are connected 
which is the point of GPIOs in DT. This in no way captures the hierarchy 
of devices. While you may be lucky that you can just assert or 
deassert all the lines at one time, that's not likely to work in a 
more complicated case (such as having to power up/down each device).

I realize the right solution is more complex, but that's the only way to 
handle this in a host bridge and board independent way.

If you want the simple solution, just configure all these GPIOs in 
firmware before Linux boots.

Rob
