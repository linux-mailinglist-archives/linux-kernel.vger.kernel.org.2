Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7B3527C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhDBJCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhDBJCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:02:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594E3C0613E6;
        Fri,  2 Apr 2021 02:02:19 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C0E452C1;
        Fri,  2 Apr 2021 11:02:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1617354137;
        bh=m6ZGYgbYLj1bfOfHZhYxK0ZYKThedUquzSx1M4VPGJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSSBmsRNzTmOU9YZJaT9Z80yzzGWowTKNNTJq2687wUnHDO5/9oRQ33zFw6Gj44xa
         P1FxayPZjFmx4aCyDYnBBMMTZ73OPUfcofIdIWQK4rYL+hJkQkzki2DK2tqy/atG1m
         u2yWvO3pjDqc8gpqxgxy6bh1znbL9+SFBcvMgWMw=
Date:   Fri, 2 Apr 2021 12:01:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/32] MAINTAINERS: update imi,rdacm2x-gmsl.yaml reference
Message-ID: <YGbdbL6Bf4293Pno@pendragon.ideasonboard.com>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
 <b03a41b5051b6cb115b2aa9c3d610e75d84dcfea.1617279356.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b03a41b5051b6cb115b2aa9c3d610e75d84dcfea.1617279356.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

Thank you for the patch.

On Thu, Apr 01, 2021 at 02:17:44PM +0200, Mauro Carvalho Chehab wrote:
> The file name: Documentation/devicetree/bindings/media/i2c/rdacm2x-gmsl.yaml
> should be, instead: Documentation/devicetree/bindings/media/i2c/imi,rdacm2x-gmsl.yaml.

While at it, shouldn't we also rename the file to imi,rdacm2x.yaml ?

> Update its cross-reference accordingly.
> 
> Fixes: 34009bffc1c6 ("media: i2c: Add RDACM20 driver")
> Fixes: e9f817689789 ("media: dt-bindings: media: i2c: Add bindings for IMI RDACM2x")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1644b6e9697c..b405ee71f730 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15258,7 +15258,7 @@ M:	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>  M:	Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/media/i2c/rdacm2x-gmsl.yaml
> +F:	Documentation/devicetree/bindings/media/i2c/imi,rdacm2x-gmsl.yaml
>  F:	drivers/media/i2c/max9271.c
>  F:	drivers/media/i2c/max9271.h
>  F:	drivers/media/i2c/rdacm21.c

-- 
Regards,

Laurent Pinchart
