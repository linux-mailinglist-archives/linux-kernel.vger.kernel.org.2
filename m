Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A023F3280
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbhHTRvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:51:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42146 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbhHTRvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:51:07 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KHoMHO005168;
        Fri, 20 Aug 2021 12:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629481822;
        bh=VlN9CEo0ijCBuzud8EHgmTvwHGz/WL0hJVCP9JU59zM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iKq/JkK2/FxnNL3zuXMyVLuYsvNsNhx74Ft1bH93N7f9zLJx/RDkmJWwANp0w0P6z
         G7zKcw0TJT1C7q6DWat+iK1KoxWgwI8xI62DZ5PfDsqrIrEbAK0OP1+r09vi7ODlnO
         Mwi70VEHfl6khEPss6NSF7HrXpM8EJwMv77IpZPQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KHoMGE114005
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 12:50:22 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 12:50:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 12:50:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KHoMIv125749;
        Fri, 20 Aug 2021 12:50:22 -0500
Date:   Fri, 20 Aug 2021 12:50:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <nsekhar@ti.com>, <bgolaszewski@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: da850-evm: Change aemif node status from "ok"
 to "okay"
Message-ID: <20210820175022.vdx53s4aih2r2xce@joyride>
References: <20210820093744.4877-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210820093744.4877-1-rogerq@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:37-20210820, Roger Quadros wrote:
> As per Device Tree core schema, status parameter of nodes can be either
> "okay" or "disabled".
> 
> U-boot Driver Model does not recognize status="ok" either and treats
> the node as disabled.
> 
> [1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/dt-core.yaml#L36

May be pointing to the spec is better here..? 



https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
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
