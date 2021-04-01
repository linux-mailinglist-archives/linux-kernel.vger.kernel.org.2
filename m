Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB347351ED7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhDASr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:47:27 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:56799 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbhDAS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:26:05 -0400
X-Greylist: delayed 2385 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Apr 2021 14:26:04 EDT
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 969B4D2E8F;
        Thu,  1 Apr 2021 15:45:59 +0000 (UTC)
X-Originating-IP: 93.61.96.190
Received: from uno.localdomain (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E413960007;
        Thu,  1 Apr 2021 15:45:36 +0000 (UTC)
Date:   Thu, 1 Apr 2021 17:46:12 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/32] MAINTAINERS: update imi,rdacm2x-gmsl.yaml reference
Message-ID: <20210401154612.v4wjdgq27ozwhfye@uno.localdomain>
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

On Thu, Apr 01, 2021 at 02:17:44PM +0200, Mauro Carvalho Chehab wrote:
> The file name: Documentation/devicetree/bindings/media/i2c/rdacm2x-gmsl.yaml
> should be, instead: Documentation/devicetree/bindings/media/i2c/imi,rdacm2x-gmsl.yaml.
>
> Update its cross-reference accordingly.
>
> Fixes: 34009bffc1c6 ("media: i2c: Add RDACM20 driver")
> Fixes: e9f817689789 ("media: dt-bindings: media: i2c: Add bindings for IMI RDACM2x")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks

Acked-by: Jacopo Mondi <jacopo@jmondi.org>

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
> --
> 2.30.2
>
