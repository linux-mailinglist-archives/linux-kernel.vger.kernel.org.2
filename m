Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFC53D6F96
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 08:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhG0GnN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jul 2021 02:43:13 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41227 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhG0GnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 02:43:12 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1AE7260003;
        Tue, 27 Jul 2021 06:43:09 +0000 (UTC)
Date:   Tue, 27 Jul 2021 08:43:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-mtd@lists.infradead.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: repair Miquel Raynal's email address
Message-ID: <20210727084309.01b52748@xps13>
In-Reply-To: <20210726144949.10439-1-lukas.bulwahn@gmail.com>
References: <20210726144949.10439-1-lukas.bulwahn@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote on Mon, 26 Jul 2021
16:49:49 +0200:

> Commit d70c6b026069 ("MAINTAINERS: Add PL353 NAND controller entry") and
> commit 813d52799ad2 ("MAINTAINERS: Add PL353 SMC entry") adds Miquel
> Raynal as maintainer with an obvious invalid email address, which can be
> easily fixed.
> 
> Repair this copy-and-paste error in Miquel Raynal's email address.

Sometimes my fingers don't follow my commands, strange that I did
not spot it earlier. I'll take this through my tree.

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Miquel, please pick or ack this patch.
> Krzysztof, please pick this patch if Miquel does not.
> 
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d69b2d4646be..f31922d0503a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1476,7 +1476,7 @@ F:	drivers/amba/
>  F:	include/linux/amba/bus.h
>  
>  ARM PRIMECELL PL35X NAND CONTROLLER DRIVER
> -M:	Miquel Raynal <miquel.raynal@bootlin.com@bootlin.com>
> +M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
>  L:	linux-mtd@lists.infradead.org
>  S:	Maintained
> @@ -1484,7 +1484,7 @@ F:	Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
>  F:	drivers/mtd/nand/raw/pl35x-nand-controller.c
>  
>  ARM PRIMECELL PL35X SMC DRIVER
> -M:	Miquel Raynal <miquel.raynal@bootlin.com@bootlin.com>
> +M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained


Thanks,
Miquèl
