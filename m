Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E64138B21F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 16:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhETOox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 10:44:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51482 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhETOni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 10:43:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14KEg4Qt064654;
        Thu, 20 May 2021 09:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621521724;
        bh=KXJRdD9vsdXDVEZ3u/jDm1YqTGEWtAtg3jh5wuKXpQk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YkNu734l+g6KJM7nL10UyQz7jJsm37eoQ5rna1rXi8jhO3PS1ShXqzafEQ6/fuKiB
         fq7oluX3FUp6Mun2sCiUTnq5A2cSgX+zk5Tg3wQVJwNj6+P4qUlP+Up2/4RxHv3dTN
         wPHVLFdI/p1M637LlzojtZZYmxDTLHPsM+iK4qsQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14KEg4Sb130945
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 May 2021 09:42:04 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 20
 May 2021 09:42:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 20 May 2021 09:42:04 -0500
Received: from [10.250.234.143] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14KEfxrw075781;
        Thu, 20 May 2021 09:42:00 -0500
Subject: Re: [PATCH 1/6] dt-bindings: mfd: ti,j721e-system-controller: Fix mux
 node errors
To:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Jonathan Cameron <jic23@kernel.org>
References: <20210518232858.1535403-1-robh@kernel.org>
 <20210518232858.1535403-2-robh@kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <72b27bc0-838c-fd7d-32f8-bc00f8508d1d@ti.com>
Date:   Thu, 20 May 2021 20:11:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210518232858.1535403-2-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 19/05/21 4:58 am, Rob Herring wrote:
> The ti,j721e-system-controller binding does not follow the standard mux
> controller node name 'mux-controller' and the example is incomplete. Fix
> these to avoid schema errors before the mux controller binding is
> converted to schema.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../mfd/ti,j721e-system-controller.yaml       | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> index 19fcf59fd2fe..272832e9f8f2 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> @@ -43,12 +43,10 @@ properties:
>  
>  patternProperties:
>    # Optional children
> -  "^serdes-ln-ctrl@[0-9a-f]+$":
> +  "^mux-controller@[0-9a-f]+$":
>      type: object
> -    description: |
> -      This is the SERDES lane control mux. It should follow the bindings
> -      specified in
> -      Documentation/devicetree/bindings/mux/reg-mux.txt
> +    description:
> +      This is the SERDES lane control mux.
>  
>  required:
>    - compatible
> @@ -68,9 +66,18 @@ examples:
>          #size-cells = <1>;
>          ranges;
>  
> -        serdes_ln_ctrl: serdes-ln-ctrl@4080 {
> +        serdes_ln_ctrl: mux-controller@4080 {
>              compatible = "mmio-mux";
>              reg = <0x00004080 0x50>;

"mmio-mux" compatible doesn't define using "reg" property. But a system
can have multiple mux-controllers which would require us to use
mux-controller@0, mux-controller@1,..

And IIRC if we have "@", 'reg' will be a required required property.
Would it be an issue here?

Thanks
Kishon
