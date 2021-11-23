Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB4459B65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhKWFOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:14:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhKWFOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:14:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE1E960187;
        Tue, 23 Nov 2021 05:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637644305;
        bh=pwCsV32PddfqKxDNCQ85J0Dw/5UwXakf4JnoU0OOMUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PcyE1h4jBIU+Tp4uxwSpOmM48ssx6zW869/ImXd6Il/y9d8BZBBZMSGvE9yJSvekv
         ZtOHq+cFwi2UNNuuvOm4aFP++h3KtT99rZOZSs/Ch8yOngOgcg4bwtsaWcemBqk3Lg
         qQ3yZDqrB6+v2ERFCcZAdMm9UJovxPfeMr27AgBBKxyBMYO4EfJW5QIutn8G/NOr89
         T7agXKRIXin+zee459rS70hovvj3PysssCP3jSrLHAd41/6kDQvOTzPdsFaNBcmH1B
         3s4Mou4EAPrkr6W2bGfzJ/J7bTwgzmRedPkr9WYU9d+3QzXS/pTNckoZRM0IY6dhUt
         Viar+uD2q9edA==
Date:   Tue, 23 Nov 2021 10:41:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liam Beguin <lvb@xiphos.com>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] dt-bindings: phy: zynqmp-psgtr: fix USB phy name
Message-ID: <YZx4DfXl+OBxwKKD@matsya>
References: <20211117003841.2030813-1-lvb@xiphos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117003841.2030813-1-lvb@xiphos.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-21, 19:38, Liam Beguin wrote:
> PHY_TYPE_USB is undefined and was added as PHY_TYPE_USB2 and
> PHY_TYPE_USB3 in 2fbbc96d1600 (phy: Add PHY header file for DT x Driver
> defines, 2014-11-04). Fix documentation to avoid misleading users.

Applied, thanks

> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> index 04d5654efb38..79906519c652 100644
> --- a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> +++ b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> @@ -29,7 +29,7 @@ properties:
>            - PHY_TYPE_PCIE
>            - PHY_TYPE_SATA
>            - PHY_TYPE_SGMII
> -          - PHY_TYPE_USB
> +          - PHY_TYPE_USB3
>        - description: The PHY instance
>          minimum: 0
>          maximum: 1 # for DP, SATA or USB
> -- 
> 2.34.0

-- 
~Vinod
