Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BE4379845
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 22:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhEJUY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 16:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJUYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 16:24:25 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DFFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 13:23:20 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5FFBF2222E;
        Mon, 10 May 2021 22:23:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620678198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zh2qKj0wlhB14In1f+H+fqUjJiGKaYlhnHJZ6AKDhY=;
        b=FEDZf539jsOWkamB0QjN96wz1YgV6LvkMeKWV1RwMcyQOEYpEST7cE2sN4ROXNocLlvA1L
        IxViAaqly5cZF/5EeMLRbPiVNqqVFZMnrwZWgQQrvKB4tJLs1inJ/ksUevyI6WZSe7z/jn
        bGPOBFH/HTGfLymQc2lIjkHCJ/q8cVY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 May 2021 22:23:18 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vz@mleia.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: spi-nor: Use SPI_MODE_X_MASK
In-Reply-To: <20210510141343.56805-1-andriy.shevchenko@linux.intel.com>
References: <20210510141343.56805-1-andriy.shevchenko@linux.intel.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <8b280c0fc105ededc399ee22b940e671@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-05-10 16:13, schrieb Andy Shevchenko:
> Use SPI_MODE_X_MASK instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mtd/spi-nor/controllers/nxp-spifi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/controllers/nxp-spifi.c
> b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
> index 5703e8313980..2635c80231bb 100644
> --- a/drivers/mtd/spi-nor/controllers/nxp-spifi.c
> +++ b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
> @@ -326,7 +326,7 @@ static int nxp_spifi_setup_flash(struct nxp_spifi 
> *spifi,
>  		ctrl |= SPIFI_CTRL_DUAL;
>  	}
> 
> -	switch (mode & (SPI_CPHA | SPI_CPOL)) {
> +	switch (mode & SPI_MODE_X_MASK) {
>  	case SPI_MODE_0:
>  		ctrl &= ~SPIFI_CTRL_MODE3;
>  		break;

Reviewed-by: Michael Walle <michael@walle.cc>

-michael
