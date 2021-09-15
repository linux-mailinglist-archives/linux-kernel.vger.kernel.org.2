Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C12B40C3F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 12:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhIOKvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 06:51:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40528 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhIOKvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 06:51:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18FAoHVb060341;
        Wed, 15 Sep 2021 05:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631703017;
        bh=GN8pZsey/RR06IXEKnscJqHOLNMGzjG3cDJ4OGON/0Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IOFeOdYYrfOhwQoGRn/2l/NwOwtilMr0DX/4N2BSlKqioOBEiT8i0Hbx0AUUJ+uP4
         vOhBaApcoPiCyNx+0zQRaY6sITRk+51N8ql0QnwCz61eDf2baI0OG81g4Y7MnYy/6F
         Z+SLjWzD9qR3GOU3RubyYsWHJzClh3e8agXqc8IA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18FAoHe2088727
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 05:50:17 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 05:50:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 05:50:16 -0500
Received: from [10.250.232.51] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18FAoCW6030304;
        Wed, 15 Sep 2021 05:50:14 -0500
Subject: Re: [PATCH 0/6] AM65/J7200/J721E: Misc PCIe DT fixes
To:     Kishon Vijay Abraham I <kishon@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lokeshvutla@ti.com>
References: <20210915055358.19997-1-kishon@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <baec5ff9-8c33-eae9-819b-78697a30b478@ti.com>
Date:   Wed, 15 Sep 2021 16:20:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915055358.19997-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/21 11:23 am, Kishon Vijay Abraham I wrote:
> Patch series adds a bunch of PCIe DT fixes. Except from
> "[PATCH 5/6] arm64: dts: ti: j7200-main: Add *max-virtual-functions*
>  for pcie-ep DT node" which adds *max-virtual-functions* property
> to PCIe DT node, rest of them are fixes or cleanups on already added
> DT properties.
> 
> If required I can post 5th patch separately to be merged for next merge
> window while the rest can go in this -rc cycle.
> 
> Kishon Vijay Abraham I (6):
>   arm64: dts: ti: k3-j721e-main: Fix "max-virtual-functions" in PCIe EP
>     nodes
>   arm64: dts: ti: k3-j721e-main: Fix "bus-range" upto 256 bus number for
>     PCIe
>   arm64: dts: ti: j7200-main: Fix "vendor-id"/"device-id" properties of
>     pcie node
>   arm64: dts: ti: j7200-main: Fix "bus-range" upto 256 bus number for
>     PCIe
>   arm64: dts: ti: j7200-main: Add *max-virtual-functions* for pcie-ep DT
>     node
>   arm64: dts: ti: k3-am65-main: Cleanup "ranges" property in "pcie" DT
>     node
> 

for the complete series,

Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>

Thanks,
Aswath

>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi  |  8 ++++----
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi |  7 ++++---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 16 ++++++++--------
>  3 files changed, 16 insertions(+), 15 deletions(-)
> 

