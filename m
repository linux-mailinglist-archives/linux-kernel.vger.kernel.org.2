Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A29419645
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhI0O1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:27:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40656 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhI0O1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:27:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18REPOrO013841;
        Mon, 27 Sep 2021 09:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632752724;
        bh=ZZ/fd4T24vkQFU+WnWgoQFOLD+vKERuEgD7ECsQbYyU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sxHy/0+HtMKAcJAR+RtNNXR0um6qs6UqVWCV3q5oD53RfUKtC9kCeKyQLAj+6lERy
         Eoy0gjjUHE6oXc6x9sP0j0BphsiDAy1cvxBx6OwjFn3TYQnXFJT1f+8XO5iSf3Q+FQ
         BlAmexMuV7EgsXeNeD8xGlupxdkiKUhuDwY8WQBQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18REPOq2040301
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Sep 2021 09:25:24 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Sep 2021 09:24:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Sep 2021 09:24:41 -0500
Received: from [10.250.37.219] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18REOfb2094692;
        Mon, 27 Sep 2021 09:24:41 -0500
Subject: Re: [PATCH V2 1/4] dt-bindings: arm: ti: Add missing compatibles for
 j721e/j7200 evms
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Hari Nagalla <hnagalla@ti.com>,
        Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <20210925201430.11678-1-nm@ti.com>
 <20210925201430.11678-2-nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <864e547b-88d3-212e-2ade-5b0ba7937933@ti.com>
Date:   Mon, 27 Sep 2021 09:24:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210925201430.11678-2-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/21 3:14 PM, Nishanth Menon wrote:
> Add compatibles for j721e and j7200 evms to allow for newer platforms
> to distinguish themselves.
> 
> While doing this, maintain support for older style of description where
> the board compatibility was not required.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
> 
> Changes in V2:
> * Modified such that legacy style of compatibles (of just SoC alone) is
>   still valid
> * Made the capability of providing a board specific compatible as an
>   alternate scheme
> * No longer dependent on rproc cleanup and platforms hosted in
>   downstream trees remain compatible
> 
> V1: https://lore.kernel.org/all/20210915121937.27702-2-nm@ti.com/
> 
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> index c5aa362e4026..cefb06424a4a 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -28,12 +28,20 @@ properties:
>            - const: ti,am654
>  
>        - description: K3 J721E SoC
> -        items:
> +        oneOf:
>            - const: ti,j721e
> +          - items:
> +              - enum:
> +                  - ti,j721e-evm
> +              - const: ti,j721e
>  
>        - description: K3 J7200 SoC
> -        items:
> +        oneOf:
>            - const: ti,j7200
> +          - items:
> +              - enum:
> +                  - ti,j7200-evm
> +              - const: ti,j7200
>  
>        - description: K3 AM642 SoC
>          items:
> 

