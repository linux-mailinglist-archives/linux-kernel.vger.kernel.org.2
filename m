Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120D63E2EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbhHFQ5T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Aug 2021 12:57:19 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:60533 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbhHFQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:57:18 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C23B4C0003;
        Fri,  6 Aug 2021 16:56:59 +0000 (UTC)
Date:   Fri, 6 Aug 2021 18:56:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: xway: No hardcoded ECC engine for Micron
 Chips
Message-ID: <20210806185658.5b4772a7@xps13>
In-Reply-To: <20210803143256.GA5209@ubuntu>
References: <20210803143256.GA5209@ubuntu>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Kestrel <kestrelseventyfour@gmail.com> wrote on Tue, 3 Aug 2021
16:32:56 +0200:

> Some lantiq xway devices use Micron NAND chips, which use on-die ECC.
> The hardcoded setting of NAND_ECC_ENGINE_TYPE_SOFT makes them unusable,
> because the software ECC on top of the hardware ECC produces errors for
> every read and write access, not to mention that booting does not work,
> because the boot loader uses the correct ECC when trying to load the
> kernel and stops loading on severe ECC errors.
> Removing the hardcoded settings would break a number of devices that
> work with those settings.
> Adding a DTB property was considered, but did not work, because devices
> of the same type but from different manufacture dates have different
> NAND chips and as such it is not possible to determine the NAND chip
> in advance or device specific.

I understand the problem and it is a very crappy situation.

> 
> Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> ---
>  drivers/mtd/nand/raw/xway_nand.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
> index 26751976e502..20cb5ce2f3b0 100644
> --- a/drivers/mtd/nand/raw/xway_nand.c
> +++ b/drivers/mtd/nand/raw/xway_nand.c
> @@ -10,6 +10,7 @@
>  #include <linux/of_platform.h>
>  
>  #include <lantiq_soc.h>
> +#include "internals.h"
>  
>  /* nand registers */
>  #define EBU_ADDSEL1		0x24
> @@ -148,7 +149,8 @@ static void xway_write_buf(struct nand_chip *chip, const u_char *buf, int len)
>  
>  static int xway_attach_chip(struct nand_chip *chip)
>  {
> -	chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
> +	if (chip->manufacturer.desc->id != NAND_MFR_MICRON)
> +		chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;

Could we make this a little bit clever with something like this:
https://elixir.bootlin.com/linux/v5.13-rc7/source/drivers/mtd/nand/raw/nand_micron.c#L434

This is far from ideal, there should definitely be a change in the DT.
But given your initial comments I guess it is not possible.

Anyway I don't find a better way as, during the attach() call, we don't
yet ran the manufacturer code, hence we don't know if on-die ECC is
actually available or not.

Thanks,
Miquèl
