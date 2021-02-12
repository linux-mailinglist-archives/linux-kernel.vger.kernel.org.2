Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBB731A0FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhBLO5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:57:01 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47214 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhBLO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:56:51 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11CEt7Tk014615;
        Fri, 12 Feb 2021 08:55:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1613141707;
        bh=/bYLT8Hs6JR9LTpaSuxWV8Tu/M0MjdnN2Avy/KfFrqk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=L00o9c/UJ00fMieIT+SMpErVzcV4xP0uHSGguvAS1s/Vmdh1AA7lQRLeeRZ9LcQx5
         w51242jdhVU9EGi4fqAAouEU4VK65ZNlsEmB6QPGWjdFqKpoZfHCnotHC8+iXsvRrJ
         T2CI8K826hsE4tDV2+MHVw1Lf3MhKYBfs/PgB9qg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11CEt7BY005708
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Feb 2021 08:55:07 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Feb 2021 08:55:07 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Feb 2021 08:55:07 -0600
Received: from [10.250.234.22] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11CEt38t033461;
        Fri, 12 Feb 2021 08:55:04 -0600
Subject: Re: [PATCH v2 4/4] arm64: dts: ti: k3-am65-main: Add device_type to
 pcie*_rc nodes
To:     Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Le Jin <le.jin@siemens.com>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
 <881dfd6c75423efce1d10261909939cd5ef19937.1613071976.git.jan.kiszka@siemens.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <94eb4288-7c6b-9fef-f266-512e131f5e75@ti.com>
Date:   Fri, 12 Feb 2021 20:25:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <881dfd6c75423efce1d10261909939cd5ef19937.1613071976.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/02/21 1:02 am, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This is demanded by the parent binding of ti,am654-pcie-rc, see
> Documentation/devicetree/bindings/pci/designware-pcie.txt.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 12591a854020..787a49523c35 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -707,6 +707,7 @@ pcie0_rc: pcie@5500000 {
>  		dma-coherent;
>  		interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
>  		msi-map = <0x0 &gic_its 0x0 0x10000>;
> +		device_type = "pci";
>  	};
>  
>  	pcie0_ep: pcie-ep@5500000 {
> @@ -739,6 +740,7 @@ pcie1_rc: pcie@5600000 {
>  		dma-coherent;
>  		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
>  		msi-map = <0x0 &gic_its 0x10000 0x10000>;
> +		device_type = "pci";
>  	};
>  
>  	pcie1_ep: pcie-ep@5600000 {
> 
