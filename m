Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300C63A8D54
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 02:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhFPAVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 20:21:34 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38398 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhFPAVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:21:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15G0JKKe074522;
        Tue, 15 Jun 2021 19:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623802760;
        bh=6OxDYf+23nAw2fpPm8+wlZjKZz5ixzNiDtfPgdKAwLc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bZwejNkIeRy2UkcftOMQvXNnyLpRuBq48V/5W1Zk4juRzTloN79rU/jECXb00WAOu
         GJXULOtuQsYKgIPSquvApNLB7mg8oH8JGrUZRnXmDDh78nYc2Mlr5GKAV2EOp3Dp6d
         aXjmH7MJtc++wXHOyIhp3uCvMtcc+wNzuLFuXguI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15G0JKnw016842
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jun 2021 19:19:20 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 19:19:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 15 Jun 2021 19:19:20 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15G0JKII032488;
        Tue, 15 Jun 2021 19:19:20 -0500
Date:   Tue, 15 Jun 2021 19:19:20 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Suman Anna <s-anna@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] arm64: dts: ti: k3-am64-main: Update TF-A's
 maximum size and node name
Message-ID: <20210616001920.m7a4v5nhkfowd4i3@huntsman>
References: <20210615174325.22853-1-a-govindraju@ti.com>
 <20210615174325.22853-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210615174325.22853-2-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:13-20210615, Aswath Govindraju wrote:
> The maximum size of TF-A 2.5 has been increased to 0x1c000 [1]. Therefore,
> update this accordingly in the device tree node.
> 
> Also, update the node name to "tfa-sram".

> [1] - https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=2fb5312f61a7de8b7a70e1639199c4f14a10b6f9
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Reviewed-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index dec54243f454..693fe24e7f7a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -24,8 +24,8 @@
>  		#size-cells = <1>;
>  		ranges = <0x0 0x00 0x70000000 0x200000>;
>  
> -		atf-sram@0 {
> -			reg = <0x0 0x1a000>;
> +		tfa-sram@0 {
> +			reg = <0x0 0x1c000>;

Thanks for catching this, but, I think tying things down tightly to
exact current size of TF-A is going to be tricky thing for us to
sustain. I suggest we make this 128K to account for future expansions
that are already known to be necessary for TF-A rather than another
piecemeal breaking change in the future.

>  		};
>  	};
>  
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
