Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89D344C014
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhKJLYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:24:20 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:37172 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231131AbhKJLYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:24:18 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 436B44149C;
        Wed, 10 Nov 2021 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1636543287; x=1638357688; bh=0j+5adaOZ/y7OCM2k3Q3Gxg0r
        f6lX+g+/MKSVly8bkU=; b=gO9R8N8LqYo2ycdHDGCPNW9Do+n5AAfUQvsVnDM2W
        VLqyYvrNLp1ac6Wh87aJUzr17nj9TPqeh09rNGVycfyDoPhsfjPep2uN+HbDesv9
        BNAoBLaQkby/Gi2s+xSpqV2MjuXcjhM0dZrse9bXBH8M/lNSI3Ut/nKKaald4jke
        nI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fd_qe8dQZ0sm; Wed, 10 Nov 2021 14:21:27 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4A78D41499;
        Wed, 10 Nov 2021 14:21:24 +0300 (MSK)
Received: from [10.199.10.105] (10.199.10.105) by T-EXCH-04.corp.yadro.com
 (172.17.100.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 10
 Nov 2021 14:21:24 +0300
Message-ID: <1a063a1797fd9247dae3660cd04d1f19b0fc32b8.camel@yadro.com>
Subject: Re: [PATCH v4 4/4] ARM: dts: aspeed: Add eSPI node
From:   Andrei Kartashev <a.kartashev@yadro.com>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ryan_chen@aspeedtech.com>
Date:   Wed, 10 Nov 2021 14:21:23 +0300
In-Reply-To: <20210901033015.910-5-chiawei_wang@aspeedtech.com>
References: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
         <20210901033015.910-5-chiawei_wang@aspeedtech.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.199.10.105]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chia-Wei,

How is it about g5? Why did you add definition only for g6 here?


On Wed, 2021-09-01 at 11:30 +0800, Chia-Wei Wang wrote:
> Add eSPI to the device tree for Aspeed 5/6th generation SoCs.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi
> b/arch/arm/boot/dts/aspeed-g6.dtsi
> index f96607b7b4e2..47dc0b3993d1 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -364,6 +364,23 @@
>                                 status = "disabled";
>                         };
>  
> +                       espi: espi@1e6ee000 {
> +                               compatible = "aspeed,ast2600-espi",
> "simple-mfd", "syscon";
> +                               reg = <0x1e6ee000 0x1000>;
> +
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +                               ranges = <0x0 0x1e6ee000 0x1000>;
> +
> +                               espi_ctrl: espi-ctrl@0 {
> +                                       compatible = "aspeed,ast2600-
> espi-ctrl";
> +                                       reg = <0x0 0x800>;
> +                                       interrupts = <GIC_SPI 42
> IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&syscon
> ASPEED_CLK_GATE_ESPICLK>;
> +                                       status = "disabled";
> +                               };
> +                       };
> +
>                         gpio0: gpio@1e780000 {
>                                 #gpio-cells = <2>;
>                                 gpio-controller;

-- 
Best regards,
Andrei Kartashev


