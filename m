Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07FC40C850
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbhIOPaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:30:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39332 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhIOPaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:30:08 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18FFSf91017429;
        Wed, 15 Sep 2021 10:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631719721;
        bh=qbzow5ypizsvI+pviMheO7Zt+Z9kjRjW9l+xECbmrNY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fJK8fbuhac+4AoH2am0to+/LvQNTJzd8c8AZcQM/ZV3Bq4q12Lwt6paZsP/AUhEQ2
         c+dfuWTAOOeSyRz7XYpGKa3LwuG0X8RMQ8kmY1ktZ1ZgCKhRkDs0K7C7xPJjXdXKr3
         bNwwLGDM4e1Uyz5lkz2Aqfqw+1i1w43lGuV5AhEk=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18FFSfiP070717
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 10:28:41 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 10:28:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 10:28:40 -0500
Received: from [10.250.234.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18FFSajb060663;
        Wed, 15 Sep 2021 10:28:37 -0500
Subject: Re: [PATCH v3 3/5] arm64: dts: ti: iot2050: Add/enabled mailboxes and
 carve-outs for R5F cores
To:     Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
References: <cover.1631216478.git.jan.kiszka@siemens.com>
 <e4cfc36a6f4fef33727f042748caa7d83f8609a7.1631216478.git.jan.kiszka@siemens.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <669d3baa-d5f7-dfee-691b-58d00ce43a2c@ti.com>
Date:   Wed, 15 Sep 2021 20:58:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e4cfc36a6f4fef33727f042748caa7d83f8609a7.1631216478.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/21 1:11 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Analogously to the am654-base-board, configure the mailboxes for the the
> two R5F cores, add them and the already existing memory carve-outs to
> the related MCU nodes. Allows to load applications under Linux onto the
> cores, e.g. the RTI watchdog firmware.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

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
> 
