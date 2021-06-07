Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA1339DEF2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFGOkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:40:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50616 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFGOkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:40:25 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 157EcQl8006429;
        Mon, 7 Jun 2021 09:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623076706;
        bh=jNaIN+Gya1SwEJ/A/roKUkAMJzCE7ATMF2355uU1Ytk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ichz9okHzgsb/ajyqd/s5aQ1IEAKaPm1XERuy0cmculoaIW0qtm2d6uHuXWXMqViy
         cSCp3oQtH+krYbB886wvON/1WMQE0lRuqIvinkLQQnZas0o5G/meJP7Vfho6hAQbl0
         9r4e0Qh1oRhoWAdaXJ0iuApM+AphhXSB8HeEc0HM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 157EcQ0M087431
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jun 2021 09:38:26 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 09:38:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 7 Jun 2021 09:38:25 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 157EcINC020778;
        Mon, 7 Jun 2021 09:38:20 -0500
Subject: Re: [PATCH v2 0/4] J721E: Use external clock in EVM for SERDES
To:     Kishon Vijay Abraham I <kishon@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210603143427.28735-1-kishon@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <f2202e2a-e66b-449f-f2fe-7a677799c265@ti.com>
Date:   Mon, 7 Jun 2021 20:08:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210603143427.28735-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/21 8:04 pm, Kishon Vijay Abraham I wrote:
> J721E EVM has clock generator that feeds both to the SERDES and to the
> PCIe slot present in the EVM. In order to use common reference clock on
> either side of the link, configure SERDES to use external reference
> clock.
> 
> Previously SERDES used internal reference clock and the attached device
> used clock from clock generator in the EVM.
> 
> Changes from v1:
> 1) Fixed clock names as suggested by Nishanth
> 2) Limit to < 100 lines
> 
> v1: http://lore.kernell.org/r/20210512151209.27560-1-kishon@ti.com
> 

For the whole series,

Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>

Thanks,
Aswath

> Kishon Vijay Abraham I (4):
>   arm64: dts: ti: k3-j721e-main: Fix external refclk input to SERDES
>   arm64: dts: ti: k3-j721e-main: Add #clock-cells property to serdes DT
>     node
>   arm64: dts: ti: k3-j721e-common-proc-board: Use external clock for
>     SERDES
>   arm64: dts: ti: k3-j721e-common-proc-board: Re-name "link" name as
>     "phy"
> 
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 52 ++++++++++-
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 86 +++++++++++--------
>  2 files changed, 98 insertions(+), 40 deletions(-)
> 

