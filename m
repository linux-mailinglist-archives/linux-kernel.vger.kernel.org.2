Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2219A393051
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhE0N73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:59:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60628 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbhE0N7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:59:08 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14RDvTGR020500;
        Thu, 27 May 2021 08:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622123849;
        bh=N7lm3iC6z4c1vvCF3/BGcb13/gOgPoEV04H4Ao2pjik=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lTYbUdJQv98JuV38uG2wwr5BDya6C6j2W6soOtz3x4imoFqzKsj4PfS/4eXd1q8Wk
         C6/FtX2h7DQKK1NJ2ZfJHB1taQ4BI8K6ruPiSrwzIe4UvfHUdN4Cd/skqVNNVRr81L
         PNmaN6r5jdQdaWS7IXEUP+W2kvVyITZHQUPXaMho=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14RDvT77030778
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 May 2021 08:57:29 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 08:57:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 27 May 2021 08:57:29 -0500
Received: from [10.250.234.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14RDvPZ8125767;
        Thu, 27 May 2021 08:57:26 -0500
Subject: Re: [PATCH] arm64: dts: ti: j7200-main: Enable USB2 PHY RX
 sensitivity workaround
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20210512153308.5840-1-a-govindraju@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <24eaca68-ff57-af91-c3d6-98095c159354@ti.com>
Date:   Thu, 27 May 2021 19:27:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210512153308.5840-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/21 9:03 PM, Aswath Govindraju wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Enable work around feature built into the controller to address issue with
> RX Sensitivity for USB2 PHY.
> 
> Fixes: 6197d7139d12 ("arm64: dts: ti: k3-j7200-main: Add USB controller")
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index f86c493a44f1..07c0ce484cae 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -679,6 +679,7 @@
>  					  "otg";
>  			maximum-speed = "super-speed";
>  			dr_mode = "otg";
> +			cdns,phyrst-a-enable;
>  		};
>  	};
>  
> 
