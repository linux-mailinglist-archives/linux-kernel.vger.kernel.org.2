Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6178B43115C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhJRH2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 03:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhJRH2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 03:28:19 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED3EC06161C;
        Mon, 18 Oct 2021 00:26:08 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 344628C6;
        Mon, 18 Oct 2021 09:26:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1634541964;
        bh=s+35dVXIiZQlJtK7I4ILbFbiGh0fIoV9u8yEqsBt5AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s8md4ByrxswRfQYqJ26/hprPufyhoscvdVLD00eVS59Kc08Og41DWz+SMneN6Yj8W
         6MyJcogwBBDFwHImx9rZM+Ez8UYNmVTzCkpbFGe+lV6v9HZTJXDdVOI2K5HeXU+Tnj
         KgfEZY6qD9t5Hqi3luWED9R5xyfzcfV/QUDZmV3s=
Date:   Mon, 18 Oct 2021 10:25:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: display: xilinx: Fix example with psgtr
Message-ID: <YW0he/FObi1WYqBf@pendragon.ideasonboard.com>
References: <a291be294dea6e580ad9acd436742a48b7cd00a2.1634539210.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a291be294dea6e580ad9acd436742a48b7cd00a2.1634539210.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Mon, Oct 18, 2021 at 08:40:12AM +0200, Michal Simek wrote:
> Commit cea0f76a483d ("dt-bindings: phy: Add DT bindings for Xilinx ZynqMP
> PSGTR PHY") clearly defines #phy-cells as 4. In past 5 cells were used by
> it never went to upstream. That's why fix example by using only 4 cells
> instead of 5.
> 
> Fixes: e7c7970a678d ("dt-bindings: display: xlnx: Add ZynqMP DP subsystem bindings")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml   | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> index d88bd93f4b80..10ec78ca1c65 100644
> --- a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> +++ b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> @@ -160,8 +160,8 @@ examples:
>                 <&xlnx_dpdma 2>,
>                 <&xlnx_dpdma 3>;
>  
> -        phys = <&psgtr 1 PHY_TYPE_DP 0 3 27000000>,
> -               <&psgtr 0 PHY_TYPE_DP 1 3 27000000>;
> +        phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
> +               <&psgtr 0 PHY_TYPE_DP 1 3>;
>  
>          phy-names = "dp-phy0", "dp-phy1";
>      };

-- 
Regards,

Laurent Pinchart
