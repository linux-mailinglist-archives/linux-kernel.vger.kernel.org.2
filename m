Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599FF4135BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhIUPBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:01:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35986 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbhIUPBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:01:40 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18LF069K044906;
        Tue, 21 Sep 2021 10:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632236406;
        bh=01BEgGuwNhMzILBu4hbl0m+cVmr0lxgoFh76rRiswQE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=t5sqKWb2fW2JE0O5v/6PwH/kIz1yjAfmXn05+7Wu7cdg4JvFlZ/QIP0+4pWScrNSQ
         zfnDODr/DuKuXJueR5V1oJ000v7LKVwCsvmV5/OtIbXN9tlW+ZnI2IVE1vYlayxsF5
         WksROS69Vz9bMlddt6xl7JQaA14KrkSUJVRGzJsg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18LF05Ec058258
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Sep 2021 10:00:06 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Sep 2021 10:00:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Sep 2021 10:00:05 -0500
Received: from [10.250.37.219] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18LF05p9089026;
        Tue, 21 Sep 2021 10:00:05 -0500
Subject: Re: [PATCH] arm64: dts: ti: Makefile: Collate AM64 platforms together
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210915121442.27112-1-nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <67c9e2ce-abef-45e3-4261-51c17749ced0@ti.com>
Date:   Tue, 21 Sep 2021 10:00:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915121442.27112-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 7:14 AM, Nishanth Menon wrote:
> Make sure that the platforms are grouped together per SoC. This helps
> keep the Makefile readable as newer platforms get added to the list.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

+1 for the logical grouping by SoC.

Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>  arch/arm64/boot/dts/ti/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index d56c742f5a10..7bfc543a578c 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -15,5 +15,4 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
> -
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
> 

