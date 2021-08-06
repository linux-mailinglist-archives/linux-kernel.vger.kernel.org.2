Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA9A3E300F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbhHFUDB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Aug 2021 16:03:01 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41853 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244163AbhHFUDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:03:00 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 93C98C0002;
        Fri,  6 Aug 2021 20:02:43 +0000 (UTC)
Date:   Fri, 6 Aug 2021 22:02:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: spinand: core: Properly fill the OOB area.
Message-ID: <20210806220242.4b83237d@xps13>
In-Reply-To: <20210617110842.2358461-1-daniel@0x0f.com>
References: <20210617110842.2358461-1-daniel@0x0f.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Palmer <daniel@0x0f.com> wrote on Thu, 17 Jun 2021 20:08:42
+0900:

> The comment in spinand_write_to_cache_op() says that
> spinand_ondie_ecc_prepare_io_req() should 0xff fill the OOB
> area but it doesn't.
> 
> This causes the OOB area to get filled with zeros
> and anytime the first page in a block the bad block marker
> is cleared and it becomes a bad block on the next boot.
> 
> This was observed on Longsys FORSEE branded parts and
> might be specific to these parts.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

This change looks fine, I'll use spinand->oobbuf instead of databuf +
offset (will update when applying).

> ---
>  drivers/mtd/nand/spi/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 6f2d39f9bb06..f1c76fa0e220 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -281,6 +281,9 @@ static int spinand_ondie_ecc_prepare_io_req(struct nand_device *nand,
>  	struct spinand_device *spinand = nand_to_spinand(nand);
>  	bool enable = (req->mode != MTD_OPS_RAW);
>  
> +	memset(spinand->databuf + nanddev_page_size(nand),
> +			0xff, nanddev_per_page_oobsize(nand));
> +
>  	/* Only enable or disable the engine */
>  	return spinand_ecc_enable(spinand, enable);
>  }

Thanks,
Miquèl
