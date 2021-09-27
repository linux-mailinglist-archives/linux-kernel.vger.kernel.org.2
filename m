Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A479419657
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhI0O26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:28:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41008 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbhI0O24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:28:56 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18RER9ik014579;
        Mon, 27 Sep 2021 09:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632752829;
        bh=n3yXpVmcGx109UHMZf/1+ZQmO05u3Wfv2919zo6o8tA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KnU+JF9pRBtyOuNet34Fm8PddX09JCWA8dytQibFL64pE/g1zQlzwPk2HXPHoOkgy
         4qygvoMEnwHTl10t8bqthdMazbSpdDV8X1lgxCI4N+Suajyb+3WiD4+WU+0IMkZb0w
         eCy1ZqtCSxfl2B/tAFDHajmoHM1uK14Htrcb31/Y=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18RER9lE039790
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Sep 2021 09:27:09 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Sep 2021 09:26:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Sep 2021 09:26:02 -0500
Received: from [10.250.37.219] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18REQ21b002334;
        Mon, 27 Sep 2021 09:26:02 -0500
Subject: Re: [PATCH V2 2/4] dt-bindings: arm: ti: am642/am654: Allow for SoC
 only compatibles
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
 <20210925201430.11678-3-nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <4bffc138-1a78-3876-349a-d5833c7fa5a1@ti.com>
Date:   Mon, 27 Sep 2021 09:26:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210925201430.11678-3-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/21 3:14 PM, Nishanth Menon wrote:
> Maintain consistency in K3 SoCs by allowing AM654 and AM642 platforms
> just state SoC compatibles without specific board specific compatibles
> aligned with what we have done for J721E/J7200 platforms as well.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
> 
> Motivation to introduce in V2:
> * Retain consistency with both "soc only" and "board specific" as two
>   schemes we support across k3.

Thanks for the updates and making it consistent across the K3 platforms.

regards
Suman

> 
> V1:  did'nt exist
> 
>  .../devicetree/bindings/arm/ti/k3.yaml        | 23 +++++++++++--------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> index cefb06424a4a..30c3f5c70014 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -20,12 +20,15 @@ properties:
>      oneOf:
>  
>        - description: K3 AM654 SoC
> -        items:
> -          - enum:
> -              - ti,am654-evm
> -              - siemens,iot2050-basic
> -              - siemens,iot2050-advanced
> +        oneOf:
>            - const: ti,am654
> +          - items:
> +              - enum:
> +                  - ti,am654-evm
> +                  - siemens,iot2050-basic
> +                  - siemens,iot2050-advanced
> +              - const: ti,am654
> +
>  
>        - description: K3 J721E SoC
>          oneOf:
> @@ -44,11 +47,13 @@ properties:
>                - const: ti,j7200
>  
>        - description: K3 AM642 SoC
> -        items:
> -          - enum:
> -              - ti,am642-evm
> -              - ti,am642-sk
> +        oneOf:
>            - const: ti,am642
> +          - items:
> +              - enum:
> +                  - ti,am642-evm
> +                  - ti,am642-sk
> +              - const: ti,am642
>  
>  additionalProperties: true
>  
> 

