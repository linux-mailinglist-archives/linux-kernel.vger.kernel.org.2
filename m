Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8DE40B8D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhINUR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:17:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38726 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhINUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:17:56 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18EKGX3m118731;
        Tue, 14 Sep 2021 15:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631650593;
        bh=uWPQHA6IGjfDQPaAbnzSASJkiTweOzUE4gDEBM2O0tU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=EW6pD1vnBi/Yk6vGXT2dl9WZvbBND/dvVD3DrmlADqZo3XXleeRIjbXHU6kOJbW1q
         QZ5EQeV9yEEZJi2+HNyJ2CJ1uQ/pJbOpgYul87ar7nuZ8MQu0Ya5+hXINL6xCQkoKp
         h9CZ/gqniNJ13D/S7WLaYISrTdtr1vKxFdoI9qbU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18EKGXFx076008
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Sep 2021 15:16:33 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Sep 2021 15:16:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Sep 2021 15:16:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18EKGWrH111951;
        Tue, 14 Sep 2021 15:16:32 -0500
Date:   Tue, 14 Sep 2021 15:16:32 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: Re: [PATCH v3 3/5] arm64: dts: ti: iot2050: Add/enabled mailboxes
 and carve-outs for R5F cores
Message-ID: <20210914201632.q5ato3bkvk3qd34s@easiness>
References: <cover.1631216478.git.jan.kiszka@siemens.com>
 <e4cfc36a6f4fef33727f042748caa7d83f8609a7.1631216478.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e4cfc36a6f4fef33727f042748caa7d83f8609a7.1631216478.git.jan.kiszka@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:41-20210909, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Analogously to the am654-base-board, configure the mailboxes for the the

s/the the/the -> could you checkpatch and dtbs_checks please?

> two R5F cores, add them and the already existing memory carve-outs to
> the related MCU nodes. Allows to load applications under Linux onto the
> cores, e.g. the RTI watchdog firmware.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 26 +++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index 58c8e64d5885..b29537088289 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -658,11 +658,21 @@ &pcie1_ep {
>  };
>  
>  &mailbox0_cluster0 {
> -	status = "disabled";
> +	interrupts = <436>;
> +
> +	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
> +		ti,mbox-tx = <1 0 0>;
> +		ti,mbox-rx = <0 0 0>;
> +	};
>  };
>  
>  &mailbox0_cluster1 {
> -	status = "disabled";
> +	interrupts = <432>;
> +
> +	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
> +		ti,mbox-tx = <1 0 0>;
> +		ti,mbox-rx = <0 0 0>;
> +	};
>  };
>  
>  &mailbox0_cluster2 {
> @@ -705,6 +715,18 @@ &mailbox0_cluster11 {
>  	status = "disabled";
>  };
>  
> +&mcu_r5fss0_core0 {
> +	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
> +			<&mcu_r5fss0_core0_memory_region>;
> +	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
> +};
> +
> +&mcu_r5fss0_core1 {
> +	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
> +			<&mcu_r5fss0_core1_memory_region>;
> +	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
> +};
> +
>  &icssg0_mdio {
>  	status = "disabled";
>  };
> -- 
> 2.31.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
