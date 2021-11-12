Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECDD44EA8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhKLPmR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 Nov 2021 10:42:17 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36911 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbhKLPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:41:53 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C32E360002;
        Fri, 12 Nov 2021 15:39:00 +0000 (UTC)
Date:   Fri, 12 Nov 2021 16:38:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] mtd: rawnand: fsmc: Force to use 8 bits access when
 expected
Message-ID: <20211112163859.23a2487a@xps13>
In-Reply-To: <20211112143855.2678989-3-herve.codina@bootlin.com>
References: <20211112143855.2678989-1-herve.codina@bootlin.com>
        <20211112143855.2678989-3-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hervé,

herve.codina@bootlin.com wrote on Fri, 12 Nov 2021 15:38:53 +0100:

> Some data transfers are expected on 8 bits by the nand core.
> The fsmc driver did not check this constraint and these transfers
> can be done on 32 bits depending on buffer alignment and transfers
> data size.
> 
> This patch ensures that these transfers will be 8bits transfers in
> all cases.

I believe there is a misunderstanding here: NAND buses -between the
NAND controller and the NAND chip- are either 8-bit or 16-bit wide and
the amount of bytes that you will retrieve per register read is not
related to it.

When the controller supports 16-bit accesses, there are certain
operations that must be performed using only the lowest 8 bits of the
NAND bus, such as reading a status [1]. In this case, the controller
must have a way to disable the 16-bit mode temporarily. See [2] and [3]
for an example. Reading with readb() or readl() will IMHO not impact the
amount of data lines used for the operation.

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

[1] https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nand_base.c#L673
[2] Marvell NAND controller can change the used width of the bus
https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/marvell_nand.c#L1777
[3] ... while still doing 32-bit accesses
https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/marvell_nand.c#L906

Thanks,
Miquèl

> ---
>  drivers/mtd/nand/raw/fsmc_nand.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
> index 658f0cbe7ce8..7f057cfee6c4 100644
> --- a/drivers/mtd/nand/raw/fsmc_nand.c
> +++ b/drivers/mtd/nand/raw/fsmc_nand.c
> @@ -540,12 +540,12 @@ static int dma_xfer(struct fsmc_nand_data *host, void *buffer, int len,
>   * @len:	number of bytes to write
>   */
>  static void fsmc_write_buf(struct fsmc_nand_data *host, const u8 *buf,
> -			   int len)
> +			   int len, bool force_8bit)
>  {
>  	int i;
>  
>  	if (IS_ALIGNED((uintptr_t)buf, sizeof(u32)) &&
> -	    IS_ALIGNED(len, sizeof(u32))) {
> +	    IS_ALIGNED(len, sizeof(u32)) && !force_8bit) {
>  		u32 *p = (u32 *)buf;
>  
>  		len = len >> 2;
> @@ -563,12 +563,13 @@ static void fsmc_write_buf(struct fsmc_nand_data *host, const u8 *buf,
>   * @buf:	buffer to store date
>   * @len:	number of bytes to read
>   */
> -static void fsmc_read_buf(struct fsmc_nand_data *host, u8 *buf, int len)
> +static void fsmc_read_buf(struct fsmc_nand_data *host, u8 *buf, int len,
> +			  bool force_8bit)
>  {
>  	int i;
>  
>  	if (IS_ALIGNED((uintptr_t)buf, sizeof(u32)) &&
> -	    IS_ALIGNED(len, sizeof(u32))) {
> +	    IS_ALIGNED(len, sizeof(u32)) && !force_8bit) {
>  		u32 *p = (u32 *)buf;
>  
>  		len = len >> 2;
> @@ -646,7 +647,8 @@ static int fsmc_exec_op(struct nand_chip *chip, const struct nand_operation *op,
>  						  instr->ctx.data.len);
>  			else
>  				fsmc_read_buf(host, instr->ctx.data.buf.in,
> -					      instr->ctx.data.len);
> +					      instr->ctx.data.len,
> +					      instr->ctx.data.force_8bit);
>  			break;
>  
>  		case NAND_OP_DATA_OUT_INSTR:
> @@ -656,7 +658,8 @@ static int fsmc_exec_op(struct nand_chip *chip, const struct nand_operation *op,
>  						   instr->ctx.data.len);
>  			else
>  				fsmc_write_buf(host, instr->ctx.data.buf.out,
> -					       instr->ctx.data.len);
> +					       instr->ctx.data.len,
> +					       instr->ctx.data.force_8bit);
>  			break;
>  
>  		case NAND_OP_WAITRDY_INSTR:

