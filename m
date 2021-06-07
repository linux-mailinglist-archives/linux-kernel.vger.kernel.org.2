Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694C239DEB8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFGOac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:30:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47594 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhFGOaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:30:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 157ESX5l000979;
        Mon, 7 Jun 2021 09:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623076113;
        bh=Nhs2lIlWeop94Amwvao7E7V8u+v21TJc0yLbaW7eKJE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GW7oEZq1Swpcelylec9UqMFBKXoPdWsaSscRMwF+7xBFQACqjczZjZR0m+TvwoH88
         9VWyAfppBHAU6vAKIPesjCg+I2PARvAymCJpvnUTv3o7tMT0oO5ZDEVzI8NE5nv+sO
         8GyHp+D9FOuCm+33HEDBoaGHrxgWOpkEaXvRJXB8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 157ESXbu028338
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jun 2021 09:28:33 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 09:28:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 7 Jun 2021 09:28:33 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 157ESRvW130926;
        Mon, 7 Jun 2021 09:28:29 -0500
Subject: Re: [PATCH v4 0/5] AM64: EVM/SK: Enable PCIe and USB
To:     Kishon Vijay Abraham I <kishon@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210603142251.14563-1-kishon@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <a5cefbed-9553-66e6-2d1f-684814dea4ce@ti.com>
Date:   Mon, 7 Jun 2021 19:58:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210603142251.14563-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/21 7:52 pm, Kishon Vijay Abraham I wrote:
> AM642 EVM has one PCIe slot (no USB slot) and AM642 SK has one USB slot
> (no PCIe slot).
> AM64 SoC has one SERDES module which can be used by either PCIe or USB.
> 
> Add DT nodes to represent and enable SERDES/PCIe/USB modules in EVM/SK.
> 
> Changes from v3:
> 1) Limit the lines to < 100
> 
> Changes from v2:
> 1) Dropped "dt-bindings: mux: Convert reg-mux DT bindings to YAML" as
> it's handled by a different series from Rob
> 2) Rename "mux" DT node to a standard "mux-controller" DT node.
> 
> Changes from v1:
> 1) Add a patch to convert reg-mux DT bindings to YAML
> 2) Use generic names for clock node names
> 3) Remove redundant status = "okay" for serdes_wiz0
> 
> v1: http://lore.kernel.org/r/20210512150107.26793-1-kishon@ti.com
> v2: http://lore.kernel.org/r/20210517061739.5762-1-kishon@ti.com
> v3: http://lore.kernel.org/r/20210526142921.12127-1-kishon@ti.com
> 

For the whole series,

Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>

Thanks,
Aswath

> Kishon Vijay Abraham I (5):
>   arm64: dts: ti: k3-am64-main: Add SERDES DT node
>   arm64: dts: ti: k3-am64-main: Add PCIe DT node
>   arm64: dts: ti: k3-am642-evm: Enable PCIe and SERDES
>   arm64: dts: ti: k3-am642-sk: Enable USB Super-Speed HOST port
>   arm64: dts: ti: k3-am642-sk: Disable PCIe
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 107 +++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  30 +++++++
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  43 +++++++++
>  3 files changed, 180 insertions(+)
> 

