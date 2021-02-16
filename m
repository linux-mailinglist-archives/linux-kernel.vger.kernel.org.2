Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2488F31CCAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhBPPLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:11:10 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:60737 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhBPPLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:11:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613488240; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=fpUjfJvr9mWbJbQxI8Nr8zNyIuM86yM2wV+L4Sf4oWU=;
 b=FS2i59KuuMCJUcNR3OvebcTI0acSWgv4hj4YnwivwxkT1HGLsKrnJAvi3FhF8jU4nHghDXAH
 7mrhXtvTghqI2kl8Zmur9PYcyafEv7j/xtObpWoN6Rz3hovHbEWzLgop44vGQ5ZsIGgfnSTN
 7DrZS1eVmghFmwNgb8RcVC1yRcs=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 602be04ffe1d396438d82cee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Feb 2021 15:10:07
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5E594C433ED; Tue, 16 Feb 2021 15:10:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75BDEC433C6;
        Tue, 16 Feb 2021 15:10:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Feb 2021 20:40:04 +0530
From:   mdalam@codeaurora.org
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: spi-nor: gigadevice: Add support for gd25lb256e
In-Reply-To: <1612869079-19593-1-git-send-email-mdalam@codeaurora.org>
References: <1612869079-19593-1-git-send-email-mdalam@codeaurora.org>
Message-ID: <2df4218ba5ad2a039833bab8c401fa07@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-09 16:41, Md Sadre Alam wrote:
> Add support for gd25lb256e. This device tested on IPQ5018
> platform with dd from/to the flash for read/write respectly,
> and mtd erase for erasing the flash.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
>  drivers/mtd/spi-nor/gigadevice.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/gigadevice.c 
> b/drivers/mtd/spi-nor/gigadevice.c
> index 447d84b..8f1e7ec 100644
> --- a/drivers/mtd/spi-nor/gigadevice.c
> +++ b/drivers/mtd/spi-nor/gigadevice.c
> @@ -50,6 +50,9 @@ static const struct flash_info gigadevice_parts[] = {
>  			   SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK |
>  			   SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
>  		.fixups = &gd25q256_fixups },
> +	{ "gd25lb256e", INFO(0xc86719, 0, 64 * 1024, 512,
> +			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +			  SPI_NOR_4B_OPCODES) },
>  };
> 
>  const struct spi_nor_manufacturer spi_nor_gigadevice = {

ping! Is there any additional info needed for this ?
