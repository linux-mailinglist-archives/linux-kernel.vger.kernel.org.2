Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9141965E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhI0O33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:29:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41148 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhI0O31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:29:27 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18REReXv015040;
        Mon, 27 Sep 2021 09:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632752860;
        bh=FJWLNYViwTUWu9K8VtFGQXKFiwr+leS4+2POVpUO7xs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BV1RXuvE6Jdbq/U1qVlqrJdvUP02B67QAP4lp4Cm3g9mA4e2W+lawAmJwniVLTarZ
         JJT4e27k7vFzogVfwfhIttWj/Ws9dDLnjwzBW7yFyGBJUxwMLf+E0UifnX+YMqP+Ym
         MuqfM0qnTTEUib0RI27br/VGDzIpPTHju+BTyPZg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18RERevk041578
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Sep 2021 09:27:40 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Sep 2021 09:27:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Sep 2021 09:27:40 -0500
Received: from [10.250.37.219] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18REReeH005855;
        Mon, 27 Sep 2021 09:27:40 -0500
Subject: Re: [PATCH V2 4/4] arm64: dts: ti: k3-j7200-common-proc-board: Add
 j7200-evm compatible
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
 <20210925201430.11678-5-nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <dded6ab1-7d99-77ee-6865-046a4f45c82b@ti.com>
Date:   Mon, 27 Sep 2021 09:27:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210925201430.11678-5-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/21 3:14 PM, Nishanth Menon wrote:
> Add j7200-evm compatible to the board to allow the board to distinguish
> itself from other platforms that may be added in the future.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
> 
> Changes in V2:
> * no change
> 
> V1: https://lore.kernel.org/all/20210915121937.27702-4-nm@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index d14f3c18b65f..121975dc8239 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -12,6 +12,9 @@
>  #include <dt-bindings/phy/phy.h>
>  
>  / {
> +	compatible = "ti,j7200-evm", "ti,j7200";
> +	model = "Texas Instruments J7200 EVM";
> +
>  	chosen {
>  		stdout-path = "serial2:115200n8";
>  		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
> 

