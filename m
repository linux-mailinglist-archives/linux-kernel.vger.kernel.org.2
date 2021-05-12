Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F2337ECE3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384850AbhELUC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:02:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37496 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239491AbhELSsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:48:33 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14CIkvcS079077;
        Wed, 12 May 2021 13:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620845217;
        bh=+qlCC1Oh9br/08D52lMvpxPo1A6lpVxS/kywEzQ8g+I=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=SrtzjOSOBujOsFsvR4lli7We8pjeduaGlWp0A7/+DPPjdvlE6H+jVchysUytlkoOK
         C5Ver/e0zwupbN7IwfiQ5j7vxqu4Uw/L484QxLd4bWe/168B4nyFEH+xJ2o0kHVpTD
         tz/7b0a6MZyNPIMChj2EHR4JwSyzydgUJrbqF23E=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14CIkvYr123186
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 May 2021 13:46:57 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 12
 May 2021 13:46:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 12 May 2021 13:46:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14CIkv5q121571;
        Wed, 12 May 2021 13:46:57 -0500
Date:   Wed, 12 May 2021 13:46:57 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, <a-govindraju@ti.com>
Subject: Re: [PATCH 0/5] AM64: EVM/SK: Enable PCIe and USB
Message-ID: <20210512184657.27wjr5bfcvkp47m3@twelve>
References: <20210512150107.26793-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210512150107.26793-1-kishon@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:31-20210512, Kishon Vijay Abraham I wrote:
> AM642 EVM has one PCIe slot and AM642 SK has one USB slot.
> AM64 SoC has one SERDES module which can be used by either PCIe or USB.
> 
> Add DT nodes to represent and enable SERDES/PCIe/USB modules in EVM/SK.
> 
> Kishon Vijay Abraham I (5):
>   arm64: dts: ti: k3-am64-main: Add SERDES DT node
>   arm64: dts: ti: k3-am64-main: Add PCIe DT node
>   arm64: dts: ti: k3-am642-evm: Enable PCIe and SERDES
>   arm64: dts: ti: k3-am642-sk: Enable USB Super-Speed HOST port
>   arm64: dts: ti: k3-am642-sk: Disable PCIe
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 102 +++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  30 +++++++
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  47 +++++++++++
>  3 files changed, 179 insertions(+)
> 
> -- 
> 2.17.1
> 

when applied on next-20210512 : the following got added in dtbs_check

arch/arm64/boot/dts/ti/k3-am642-evm.dt.yaml:0:0: /bus@f4000/syscon@43000000/mux: failed to match any schema with compatible: ['mmio-mux']
arch/arm64/boot/dts/ti/k3-am642-sk.dt.yaml:0:0: /bus@f4000/syscon@43000000/mux: failed to match any schema with compatible: ['mmio-mux']
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
