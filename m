Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A263632CC9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhCDGQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:16:26 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58004 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbhCDGQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:16:24 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1246F16Q004866;
        Thu, 4 Mar 2021 00:15:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614838501;
        bh=m6eC28W0Xv9ue1xbRkmFg98fwhZlNWeIgSSQfllRibo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yDswH5B3znKP8aFHWsE3dxItJUeU8VGTioXAnjckAdQI4FwQUnDGRk4DJ02MzYuS2
         99svegxUkQIHU7IespuHKK0teUzC+PyFunXjVbUqlXXDKAZFZuR7cMgh8jqQX7hSpX
         bOU1dd0C9obr5rHCPHbIn4gX4VRH+c+Jjh/hWJkI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1246F19Y032450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 00:15:01 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 00:15:00 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 00:15:00 -0600
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1246EvNm120554;
        Thu, 4 Mar 2021 00:14:57 -0600
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: ti: Add bindings for Siemens
 IOT2050 boards
To:     Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Le Jin <le.jin@siemens.com>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
 <68c2099e6b3a568fe43f522a042592b120f871a3.1613071976.git.jan.kiszka@siemens.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <2cf783e2-bd16-8bca-e542-9ccbca400f08@ti.com>
Date:   Thu, 4 Mar 2021 11:44:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <68c2099e6b3a568fe43f522a042592b120f871a3.1613071976.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/21 1:02 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> These boards are based on AM6528 GP and AM6548 HS SOCs.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> index c6e1c1e63e43..b1ab0cf4a2d6 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -23,6 +23,8 @@ properties:
>          items:
>            - enum:
>                - ti,am654-evm
> +              - siemens,iot2050-basic
> +              - siemens,iot2050-advanced
>            - const: ti,am654
>  
>        - description: K3 J721E SoC
> 
