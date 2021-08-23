Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFBB3F4326
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhHWBle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhHWBld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:41:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7548BC061575;
        Sun, 22 Aug 2021 18:40:51 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA3752A5;
        Mon, 23 Aug 2021 03:40:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1629682850;
        bh=k6+4OfI45DhHfve81i0giUwJcmmc/TpvDjpMdvv6gws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iqHohXABRCQCvowzxtA0IWjvs3got1DFZUZJTdxTp0ywrY3aZD3z7dCiiA4KJbjXG
         5FgQiffaab0nPXS05IMWYwXdB6y1jplo+HXbge0zrR6vIXxNXd0ryDRMPrC7nc/bP4
         LUWt/vWPhAKh8VzM5m7u1S2EXYK6QElWUvHTdHBg=
Date:   Mon, 23 Aug 2021 04:40:40 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 4/6] phy: dt-bindings: cdns,dphy: make clocks optional
Message-ID: <YSL8mH8hd/PzyRRo@pendragon.ideasonboard.com>
References: <20210820190346.18550-1-p.yadav@ti.com>
 <20210820190346.18550-5-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820190346.18550-5-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Sat, Aug 21, 2021 at 12:33:44AM +0530, Pratyush Yadav wrote:
> The clocks are not used by the DPHY when used in Rx mode so make them
> optional.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Acked-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Add Rob's Ack.
> 
> Changes in v2:
> - Re-order subject prefixes.
> 
>  Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> index b90a58773bf2..3bb5be05e825 100644
> --- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> @@ -33,8 +33,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - clocks
> -  - clock-names

Could you turn this into a conditional requirement based on the compat
string, as the clocks are needed in the TX case ?

>    - "#phy-cells"
>  
>  additionalProperties: false

-- 
Regards,

Laurent Pinchart
