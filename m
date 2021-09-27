Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF29419659
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhI0O3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:29:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43412 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbhI0O3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:29:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18REROHn023854;
        Mon, 27 Sep 2021 09:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632752844;
        bh=0iqsvxPp8QBtCV2wE/2VVRWlk7xjyfyApisV+VMQkzk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lf3v7flGmpHSn0e+jLS0ToQgJC13wUGdCNcmZT4JXkbLD867BgZQ9Ofel0gOORsfn
         a6Pto+Ca7AUikMEmZjL43YRVQoSTmYHJ3r6RcVHVlB499IA2TlDzXXUGHEfeiKHT5Z
         OqXoysfZSm6ti4MsV+2aY55Y4R/R9Xx5xBdLNZMo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18RERO4V044603
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Sep 2021 09:27:24 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Sep 2021 09:27:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Sep 2021 09:27:24 -0500
Received: from [10.250.37.219] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18REROtl058589;
        Mon, 27 Sep 2021 09:27:24 -0500
Subject: Re: [PATCH V2 3/4] arm64: dts: ti: k3-j721e-common-proc-board: Add
 j721e-evm compatible
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
 <20210925201430.11678-4-nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <a8001155-11f6-0708-12c6-7f1a4254da1f@ti.com>
Date:   Mon, 27 Sep 2021 09:27:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210925201430.11678-4-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/21 3:14 PM, Nishanth Menon wrote:
> Add j721e-evm compatible to the board to allow the board to distinguish
> itself from other platforms that are pending to be added.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
> 
> Changes in V2:
> * no change
> 
> V1: https://lore.kernel.org/all/20210915121937.27702-3-nm@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 8bd02d9e28ad..dc2bc67f9f48 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -12,6 +12,9 @@
>  #include <dt-bindings/phy/phy-cadence.h>
>  
>  / {
> +	compatible = "ti,j721e-evm", "ti,j721e";
> +	model = "Texas Instruments J721e EVM";
> +
>  	chosen {
>  		stdout-path = "serial2:115200n8";
>  		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
> 

