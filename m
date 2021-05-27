Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDACC392A23
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhE0I4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:56:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59348 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbhE0I4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:56:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14R8swkm096557;
        Thu, 27 May 2021 03:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622105698;
        bh=QOXF4exdccuvX7tJ9K7Byk4SL1OgspG3Xo90oifk1so=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=K6KTAHbFDfIuvGdPUKl1y3HdlUte/K87HDMES5jxKUPsP+CLFCapZOaoIYKYvCsbs
         8NERLPsnGD2s4m2042uNJIfW3kzzkYEN7RSaSxmpQAoabZ+BTe2bDpz18AjB2byHgs
         ANMzreZomXLfV8be2i7hgGnuRNCaEsBgTldOlbEg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14R8swaL001570
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 May 2021 03:54:58 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 03:54:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 27 May 2021 03:54:58 -0500
Received: from [10.250.234.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14R8ss7j115827;
        Thu, 27 May 2021 03:54:55 -0500
Subject: Re: [PATCH next] arm64: dts: ti:
 k3-am654x/j721e/j7200-common-proc-board: fix MCU_RGMII1_TXC direction
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
References: <20210526132041.6104-1-grygorii.strashko@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <b7e2c553-cdce-38e8-4c1f-77b363e0b54c@ti.com>
Date:   Thu, 27 May 2021 14:24:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210526132041.6104-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/21 6:50 PM, Grygorii Strashko wrote:
> The MCU RGMII MCU_RGMII1_TXC pin is defined as input by mistake, although
> this does not make any difference functionality wise it's better to update
> to avoid confusion.
> 
> Hence fix MCU RGMII MCU_RGMII1_TXC pin pinmux definitions to be an output
> in K3 am654x/j721e/j7200 board files.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts        | 2 +-
>  arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 2 +-
>  arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index eddb2ffb93ca..97c344088483 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -136,7 +136,7 @@
>  			AM65X_WKUP_IOPAD(0x007c, PIN_INPUT, 0) /* (L5) MCU_RGMII1_RD2 */
>  			AM65X_WKUP_IOPAD(0x0080, PIN_INPUT, 0) /* (M6) MCU_RGMII1_RD1 */
>  			AM65X_WKUP_IOPAD(0x0084, PIN_INPUT, 0) /* (L6) MCU_RGMII1_RD0 */
> -			AM65X_WKUP_IOPAD(0x0070, PIN_INPUT, 0) /* (N1) MCU_RGMII1_TXC */
> +			AM65X_WKUP_IOPAD(0x0070, PIN_OUTPUT, 0) /* (N1) MCU_RGMII1_TXC */
>  			AM65X_WKUP_IOPAD(0x0074, PIN_INPUT, 0) /* (M1) MCU_RGMII1_RXC */
>  		>;
>  	};
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index bedd01b7a32c..d14f3c18b65f 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -90,7 +90,7 @@
>  			J721E_WKUP_IOPAD(0x008c, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
>  			J721E_WKUP_IOPAD(0x0090, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
>  			J721E_WKUP_IOPAD(0x0094, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
> -			J721E_WKUP_IOPAD(0x0080, PIN_INPUT, 0) /* MCU_RGMII1_TXC */
> +			J721E_WKUP_IOPAD(0x0080, PIN_OUTPUT, 0) /* MCU_RGMII1_TXC */
>  			J721E_WKUP_IOPAD(0x0084, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
>  		>;
>  	};
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 60764366e22b..351bb84db65b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -237,7 +237,7 @@
>  			J721E_WKUP_IOPAD(0x007c, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
>  			J721E_WKUP_IOPAD(0x0080, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
>  			J721E_WKUP_IOPAD(0x0084, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
> -			J721E_WKUP_IOPAD(0x0070, PIN_INPUT, 0) /* MCU_RGMII1_TXC */
> +			J721E_WKUP_IOPAD(0x0070, PIN_OUTPUT, 0) /* MCU_RGMII1_TXC */
>  			J721E_WKUP_IOPAD(0x0074, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
>  		>;
>  	};
> 
