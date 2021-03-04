Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3450032CBA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhCDEsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:48:25 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48130 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbhCDEsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:48:07 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1244jp9U053936;
        Wed, 3 Mar 2021 22:45:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614833151;
        bh=u9Fq9fIcV8m7q8E+GxjFecB7Rn7qfqMQABRRfIQPQ20=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=U7AUjuUC2GePB6TOCvKlXOErPWvIBabL0u2hKgcX4tjWItsT1YShQ5PJG6BwvLFC2
         1a0PODXcFRL9A1MxGhkd4fuLPd0aA3/bt7fBsNqfdIQqOvTjlxlOGLmnjqGFZ4APga
         0LXrjlI+JQScEtebPVQZALC1mT58YCwqY5OfnAP4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1244jpKF074566
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Mar 2021 22:45:51 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 3 Mar
 2021 22:45:51 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 3 Mar 2021 22:45:51 -0600
Received: from [10.250.233.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1244jmBx090114;
        Wed, 3 Mar 2021 22:45:49 -0600
Subject: Re: [PATCH v2 1/9] dt-bindings: phy: ti,phy-j721e-wiz: Add bindings
 for AM64 SERDES Wrapper
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
References: <20210222112314.10772-1-kishon@ti.com>
 <20210222112314.10772-2-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8fc3e9a0-573e-01b1-1054-55d3c19e42f6@ti.com>
Date:   Thu, 4 Mar 2021 10:15:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222112314.10772-2-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 22/02/21 4:53 pm, Kishon Vijay Abraham I wrote:
> Add bindings for AM64 SERDES Wrapper.

I've fixed all your comments provided in the previous version. Can you
review this and give your ACKs please?

Best Regards,
Kishon

> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 10 ++++++---
>  include/dt-bindings/phy/phy-ti.h              | 21 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/phy/phy-ti.h
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> index c33e9bc79521..bf431f98e6ea 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -12,9 +12,10 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - ti,j721e-wiz-16g
> -      - ti,j721e-wiz-10g
> +    oneOf:
> +      - const: ti,j721e-wiz-16g
> +      - const: ti,j721e-wiz-10g
> +      - const: ti,am64-wiz-10g
>  
>    power-domains:
>      maxItems: 1
> @@ -42,6 +43,9 @@ properties:
>    "#reset-cells":
>      const: 1
>  
> +  "#clock-cells":
> +    const: 1
> +
>    ranges: true
>  
>    assigned-clocks:
> diff --git a/include/dt-bindings/phy/phy-ti.h b/include/dt-bindings/phy/phy-ti.h
> new file mode 100644
> index 000000000000..ad955d3a56b4
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-ti.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for TI SERDES.
> + */
> +
> +#ifndef _DT_BINDINGS_TI_SERDES
> +#define _DT_BINDINGS_TI_SERDES
> +
> +/* Clock index for output clocks from WIZ */
> +
> +/* MUX Clocks */
> +#define TI_WIZ_PLL0_REFCLK	0
> +#define TI_WIZ_PLL1_REFCLK	1
> +#define TI_WIZ_REFCLK_DIG	2
> +
> +/* Reserve index here for future additions */
> +
> +/* MISC Clocks */
> +#define TI_WIZ_PHY_EN_REFCLK	16
> +
> +#endif /* _DT_BINDINGS_TI_SERDES */
> 
