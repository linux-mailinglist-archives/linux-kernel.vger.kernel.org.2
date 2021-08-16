Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F412F3ECF69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhHPHcH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 03:32:07 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35503 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhHPHcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:32:00 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8CE7540002;
        Mon, 16 Aug 2021 07:31:27 +0000 (UTC)
Date:   Mon, 16 Aug 2021 09:31:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
Message-ID: <20210816093126.442f74a1@xps13>
In-Reply-To: <20210808072643.GA5084@ubuntu>
References: <20210808072643.GA5084@ubuntu>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Kestrel <kestrelseventyfour@gmail.com> wrote on Sun, 8 Aug 2021
09:26:43 +0200:

> Some devices use Micron NAND chips, which use on-die ECC. The hardcoded
> setting of NAND_ECC_ENGINE_TYPE_SOFT makes them unusable, because the
> software ECC on top of the hardware ECC produces errors for every read
> and write access, not to mention that booting does not work, because
> the boot loader uses the correct ECC when trying to load the kernel
> and stops loading on severe ECC errors.
> This patch requires the devices that currently work with the hard coded
> setting to set the nand-ecc-mode property to soft in their device
> tree.
> 

Please add a Fixes: and Cc: stable tags, you will also need to send to
stable@vger.kernel.org a different version of the patch for the kernel
5.4 IIUC.

> Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> Tested-by: Aleksander Jan Bajkowski <olek2@wp.pl> # tested on BT Home Hub 5A
> ---
>  drivers/mtd/nand/raw/xway_nand.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
> index 26751976e502..0a4b0aa7dd4c 100644
> --- a/drivers/mtd/nand/raw/xway_nand.c
> +++ b/drivers/mtd/nand/raw/xway_nand.c
> @@ -148,8 +148,6 @@ static void xway_write_buf(struct nand_chip *chip, const u_char *buf, int len)
>  
>  static int xway_attach_chip(struct nand_chip *chip)
>  {
> -	chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
> -
>  	if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
>  		chip->ecc.algo = NAND_ECC_ALGO_HAMMING;

You also need to only set the Hamming algorithm when engine_type is
TYPE_SOFT.

Thanks,
Miquèl
