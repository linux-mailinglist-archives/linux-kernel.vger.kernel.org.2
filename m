Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2D140FAAE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbhIQOrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:47:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34564 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhIQOqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:46:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18HEiuTn011585;
        Fri, 17 Sep 2021 09:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631889896;
        bh=ysv5ZVPe5SGTihFHDPFl1BAEPEEhCTFeV2XgJ/Kb9JI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vkJkfidlcpaV16pn0laV4EMyXR17j10FcfVn+xGD7EjPXB9IrGlGJPo2peKTWTjuU
         CL5kMbRzzYU3Wjvlhd9gxXctwwVQEjercvfN2rbnpQ3L9FsQPX7uEL9HnpLnwcDbPp
         rOIs8xG78EvoWz3rcBPeXv16+NFGnOeqIHckT2aM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18HEiuYu086672
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Sep 2021 09:44:56 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Sep 2021 09:44:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Sep 2021 09:44:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18HEitB9062243;
        Fri, 17 Sep 2021 09:44:55 -0500
Date:   Fri, 17 Sep 2021 09:44:55 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>
CC:     Suman Anna <s-anna@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: Re: [PATCH] dt-bindings: hwlock: omap: Remove board-specific
 compatible from DT example
Message-ID: <20210917144455.nj6bc2enytlgqmzn@studied>
References: <20210917094740.18891-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210917094740.18891-1-sinthu.raja@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:17-20210917, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> The example includes a board-specific compatible property, this is
> wrong as the example should be board agnostic. Replace the same with a
> generic soc node.
> 
> Fixes: d8db9dc34871 ("dt-bindings: hwlock: omap: Convert binding to YAML")
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
> 
> This patch was triggered by discussions in [1].
> 
> When applying the patch, if you could provide an immutable tag for the
> bindings, it would help line things up for new platforms to be added for
> us. See [2] for the context


Aah yes, thanks.. Bjorn.. once Rob acks ofcourse (since this is
bindings).

Reviewed-by: Nishanth Menon <nm@ti.com>


> 
> [1] https://lore.kernel.org/all/20210818074030.1877-1-sinthu.raja@ti.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20210125141642.4yybjnklk3qsqjdy@steersman/
> 
>  .../devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml        | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
> index ae1b37dbee75..d56dc1bebdc6 100644
> --- a/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
> +++ b/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
> @@ -47,10 +47,8 @@ examples:
>      };
>  
>    - |
> -    / {
> +    soc {
>          /* K3 AM65x SoCs */
> -        model = "Texas Instruments K3 AM654 SoC";
> -        compatible = "ti,am654-evm", "ti,am654";
>          #address-cells = <2>;
>          #size-cells = <2>;
>  
> -- 
> 2.32.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
