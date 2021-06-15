Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A1F3A88CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhFOSu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:50:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48280 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhFOSu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:50:26 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15FImEot083098;
        Tue, 15 Jun 2021 13:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623782894;
        bh=x741ettLoRgaTuq5yGrx+s4FMVNLrPcflAay6gHWjUk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RyQNSKzis0oY4xhRF4+fmHOJJuukeflRQAjUuD5oJxS9fB8rzxq9g6jea4mPy5i3K
         Olgqw8ZPo0TsHmLSAnD8w28yybqgjP6hhtoBKglKvuEb9h9UtVk6Ia8Get+gJm/JrV
         U6Kddcmy3U5zJ9F+L1UdOwaa/I9oyFsfw/x20xO8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15FImE2N060806
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jun 2021 13:48:14 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 13:48:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 15 Jun 2021 13:48:14 -0500
Received: from [10.250.35.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15FImEb8084161;
        Tue, 15 Jun 2021 13:48:14 -0500
Subject: Re: [PATCH v4 2/3] arm64: dts: ti: k3-am64-main: Reserve OCMRAM for
 DMSC-lite and secure proxy communication
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210615174325.22853-1-a-govindraju@ti.com>
 <20210615174325.22853-3-a-govindraju@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <8206a84c-b5d8-4428-6501-7e114798b1bb@ti.com>
Date:   Tue, 15 Jun 2021 13:48:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615174325.22853-3-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/21 12:43 PM, Aswath Govindraju wrote:
> The final 128KB in SRAM is reserved by default for DMSC-lite code and
> secure proxy communication buffer. The memory region used for DMSC-lite
> code can be optionally freed up by secure firmware API[1]. However, the
> buffer for secure proxy communication is not configurable. This default
> hardware configuration is unique for AM64.
> 
> Therefore, indicate the area reserved for DMSC-lite code and secure proxy
> communication buffer in the oc_sram device tree node.
> 
> [1] - http://downloads.ti.com/tisci/esd/latest/6_topic_user_guides/security_handover.html#triggering-security-handover
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Suman Anna <s-anna@ti.com>

> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 693fe24e7f7a..6a883f4349cb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -27,6 +27,14 @@
>  		tfa-sram@0 {
>  			reg = <0x0 0x1c000>;
>  		};
> +
> +		dmsc-sram@1e0000 {
> +			reg = <0x1e0000 0x1c000>;
> +		};
> +
> +		sproxy-sram@1fc000 {
> +			reg = <0x1fc000 0x4000>;
> +		};
>  	};
>  
>  	main_conf: syscon@43000000 {
> 

