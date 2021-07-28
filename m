Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6509A3D871D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 07:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhG1FUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 01:20:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52898 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhG1FUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 01:20:16 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16S5K3TJ103171;
        Wed, 28 Jul 2021 00:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627449603;
        bh=BSgt4SiE8hyUEtApWzSZPY+o3LUrlYq1tCtV72k5fpE=;
        h=Subject:CC:References:To:From:Date:In-Reply-To;
        b=eQjS+Mt5mYyvM3wT77RmQzgWpTR2Q3fy9r9V07nuHrnwtdOeAPanHRm9+ANy1wq/C
         9kCFLKOSZOVRl7HrHymOMuO+6/rTY2qUTMUnoJ/ANWdhxh0WNLP3cP2QdsVECIjkg+
         VE/1tzhoVlInBZZFw36HMgW8OXpl3t2KVtcfo/QY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16S5K38J061184
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Jul 2021 00:20:03 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 28
 Jul 2021 00:20:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 28 Jul 2021 00:20:03 -0500
Received: from [10.250.232.46] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16S5Jx6P093003;
        Wed, 28 Jul 2021 00:19:59 -0500
Subject: Re: [PATCH v2 0/6] CAN: Add support for CAN in AM65,J721e and AM64
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>
References: <20210726101012.26983-1-a-govindraju@ti.com>
To:     "Menon, Nishanth" <nm@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <f5abf985-d953-a9cd-f6e6-ee86d3a0f398@ti.com>
Date:   Wed, 28 Jul 2021 10:49:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726101012.26983-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 26/07/21 3:40 pm, Aswath Govindraju wrote:
> The following series of patches add support for CAN in SoC's AM65, J721e
> and AM64.
> 
> This patch series is dependent on [1] and [2] and I have requested for an
> immutable tag from the Marc Kleine-Budde(maintainer of net tree).

Here is the tag in [0] shared by Marc after applying patches [1] and
[2], linux-can-next-for-5.15-20210725,

[0] -
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=linux-can-next-for-5.15-20210725

Thanks,
Aswath

> 
> [1] - https://lore.kernel.org/patchwork/patch/1423048/
> [2] - https://www.spinics.net/lists/linux-can/msg08108.html
> 
> changes since v1 -
> - changed the message ram configuration to use the maximum value
>   in each field, for better performance.
> 
> Aswath Govindraju (3):
>   arm64: dts: ti: am654-base-board: Disable mcan nodes
>   arm64: dts: ti: k3-am64-main: Add support for MCAN
>   arm64: dts: ti: k3-am642-evm/sk: Add support for main domain mcan
>     nodes in EVM and disable them on SK
> 
> Faiz Abbas (3):
>   arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
>   arm64: dts: ti: k3-j721e: Add support for MCAN nodes
>   arm64: dts: ti: k3-j721e-common-proc-board: Add support for mcu_mcan
>     nodes
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  28 +++
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  40 ++++
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts        |   8 +
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  30 +++
>  .../arm64/boot/dts/ti/k3-am654-base-board.dts |   8 +
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 116 +++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 196 ++++++++++++++++++
>  .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  28 +++
>  8 files changed, 454 insertions(+)
> 

