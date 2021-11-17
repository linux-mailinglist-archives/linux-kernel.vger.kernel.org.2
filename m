Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E322945421A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 08:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhKQHxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 02:53:52 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:52950 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbhKQHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 02:53:40 -0500
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D8A3464;
        Wed, 17 Nov 2021 08:50:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1637135440;
        bh=ZqtMIdKGSNsSfuUw5T8CaCbr/LHYqL5hUB8UylD3eVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Guklbz5+OKnxLzXHKcQPRJfU6BmxbLYvX3v8TnOOUmAoN2YVNhzPmUNo8rapf5x9q
         TV6b2T4vLlBZZIc1DqRN3CiyhJId/lstfnnNmi5FGnZYXZHSGf5rvCbtg9r9EuTH1B
         BbugkvBXVJ65K4uNDfM/Wfw0h3btt4PbPYGYur8k=
Date:   Wed, 17 Nov 2021 09:50:18 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liam Beguin <lvb@xiphos.com>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] dt-bindings: phy: zynqmp-psgtr: fix USB phy name
Message-ID: <YZS0Ov0CL9mcrk/l@pendragon.ideasonboard.com>
References: <20211117003841.2030813-1-lvb@xiphos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211117003841.2030813-1-lvb@xiphos.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

Thank you for the patch.

On Tue, Nov 16, 2021 at 07:38:41PM -0500, Liam Beguin wrote:
> PHY_TYPE_USB is undefined and was added as PHY_TYPE_USB2 and
> PHY_TYPE_USB3 in 2fbbc96d1600 (phy: Add PHY header file for DT x Driver
> defines, 2014-11-04). Fix documentation to avoid misleading users.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

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

-- 
Regards,

Laurent Pinchart
