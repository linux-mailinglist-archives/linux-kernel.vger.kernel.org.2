Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525FC3F79F6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhHYQQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:16:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60754 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhHYQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:16:01 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17PGF6GP126733;
        Wed, 25 Aug 2021 11:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629908106;
        bh=NhOMSA/IyBpG0GANEr+mpRgHHqSD773oASYsgzAIcnE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=g5L/OxmiLTynIiHv06C/YLAa1Vn6x58E0Qb3J/BXTfmWEJU0vdOmQ3xIraU2rXv1t
         fKIDtdZFKC7JFHHMR1/VTRqTk6zpENQdVnWXJcovyPY1xl0DkijuqJfb7LQWxAZ4w2
         SxdPfcH3SzfVVHFL2Pu7jfuU9GWLIxc5H5wsx/ts=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17PGF6U6057518
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Aug 2021 11:15:06 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 25
 Aug 2021 11:15:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 25 Aug 2021 11:15:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17PGF319048958;
        Wed, 25 Aug 2021 11:15:03 -0500
Date:   Wed, 25 Aug 2021 11:15:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <nsekhar@ti.com>, <bgolaszewski@baylibre.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: da850-evm: Change aemif node status from
 "ok" to "okay"
Message-ID: <20210825161502.ap2clalwfljezoqk@perfume>
References: <20210824105512.19242-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210824105512.19242-1-rogerq@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:55-20210824, Roger Quadros wrote:
> As per Device Tree Specification [1], the status parameter of nodes can
> be "okay", "disabled", etc. "ok" is not a valid parameter.
> 
> U-boot Driver Model does not recognize status="ok" either and treats
> the node as disabled.

^^ the above comment might be fine to indicate the side effect of
non-compliance

> 
> [1] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Nishanth Menon <nm@ti.com>

> ---
> Changelog:
> v2
> -refer to DT spec instead of schema in commit log.
> 
>  arch/arm/boot/dts/da850-evm.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 87c517d65f62..9dc79b5977bf 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -415,7 +415,7 @@
>  &aemif {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&nand_pins>;
> -	status = "ok";
> +	status = "okay";
>  	cs3 {
>  		#address-cells = <2>;
>  		#size-cells = <1>;
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
