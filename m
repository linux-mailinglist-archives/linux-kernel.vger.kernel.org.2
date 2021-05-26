Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17602391FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 20:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhEZSxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 14:53:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47574 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbhEZSxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 14:53:08 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QIpXQr023283;
        Wed, 26 May 2021 13:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622055093;
        bh=BKwkIfBERwTZedUQYKugmdcf1E8hKbfekE2TBc1GF3I=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=swLeJDJ1yxuHYqIOz7Tmqd9cplo5eZGnfVP0OBDfEhQfZbLskVubqEX964v5/hjoi
         dQOYmmNCpqdgIaXPny9JIms7YxczG5YKFBg+/6nxWMdWgLdyMwkaw7R8FQAFH8xbPM
         8BbXGhc4MQf81MEDH2hQzAtBR1Z1qpVRDNEQYd58=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QIpXoN011162
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 13:51:33 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 13:51:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 13:51:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QIpXbf064439;
        Wed, 26 May 2021 13:51:33 -0500
Date:   Wed, 26 May 2021 13:51:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v3 2/5] arm64: dts: ti: k3-am64-main: Add PCIe DT node
Message-ID: <20210526185133.sm2iqqpequz3mmvq@crafty>
References: <20210526142921.12127-1-kishon@ti.com>
 <20210526142921.12127-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210526142921.12127-3-kishon@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:59-20210526, Kishon Vijay Abraham I wrote:
> AM64 has one PCIe instance which can be configured in either
> host mode (RC) or device mode (EP). Add PCIe DT node for host
> mode and device mode here.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 46 ++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index a67f10406a8e..9c77f7da5d28 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -728,4 +728,50 @@
>  			#clock-cells = <1>;
>  		};
>  	};
> +
> +	pcie0_rc: pcie@f102000 {
> +		compatible = "ti,am64-pcie-host", "ti,j721e-pcie-host";
> +		reg = <0x00 0x0f102000 0x00 0x1000>,
> +		      <0x00 0x0f100000 0x00 0x400>,
> +		      <0x00 0x0d000000 0x00 0x00800000>,
> +		      <0x00 0x68000000 0x00 0x00001000>;
> +		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
[...]
> +
> +	pcie0_ep: pcie-ep@f102000 {
Hmm... 
Warning (unique_unit_address): /bus@f4000/pcie@f102000: duplicate unit-address (also used in node /bus@f4000/pcie-ep@f102000)
we could pick reg for pcie-ep for node address, instead of intd_cfg address?

OR, does that mess something else up?

> +		compatible = "ti,am64-pcie-ep", "ti,j721e-pcie-ep";
> +		reg = <0x00 0x0f102000 0x00 0x1000>,
> +		      <0x00 0x0f100000 0x00 0x400>,
> +		      <0x00 0x0d000000 0x00 0x00800000>,
> +		      <0x00 0x68000000 0x00 0x08000000>;

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
