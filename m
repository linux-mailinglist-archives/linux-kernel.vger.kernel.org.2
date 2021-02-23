Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E185D322ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhBWQfi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Feb 2021 11:35:38 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:58191 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbhBWQfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:35:36 -0500
Received: from xps13 (lfbn-tou-1-972-113.w86-210.abo.wanadoo.fr [86.210.203.113])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1020A24000E;
        Tue, 23 Feb 2021 16:34:50 +0000 (UTC)
Date:   Tue, 23 Feb 2021 17:34:49 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     mani@kernel.org, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: update last code word register
Message-ID: <20210223173449.1a55df1e@xps13>
In-Reply-To: <1614024267-12529-1-git-send-email-mdalam@codeaurora.org>
References: <1614024267-12529-1-git-send-email-mdalam@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Md Sadre Alam <mdalam@codeaurora.org> wrote on Tue, 23 Feb 2021
01:34:27 +0530:

> From QPIC version 2.0 onwards new register got added to read last

                               a new

> codeword. This change will add the READ_LOCATION_LAST_CW_n register.

            Add support for this READ_LOCATION_LAST_CW_n register.

> 
> For first three code word READ_LOCATION_n register will be
> use.For last code word READ_LOCATION_LAST_CW_n register will be
> use.

"
In the case of QPIC v2, codewords 0, 1 and 2 will be accessed through
READ_LOCATION_n, while codeword 3 will be accessed through
READ_LOCATION_LAST_CW_n.
"

When I read my own sentence, I feel that there is something wrong.
If there are only 4 codewords, I guess a QPIC v2 is able to use
READ_LOCATION_3 or READ_LOCATION_LAST_CW_0 interchangeably. Isn't it?

I guess the point of having these "last_cw_n" registers is to support
up to 8 codewords, am I wrong? If this the case, the current patch
completely fails doing that I don't get the point of such change.

> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---

[...]

>  /* helper to configure address register values */
> @@ -700,8 +727,9 @@ static void set_address(struct qcom_nand_host *host, u16 column, int page)
>   *
>   * @num_cw:		number of steps for the read/write operation
>   * @read:		read or write operation
> + * @cw	:		which code word
>   */
> -static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
> +static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, int cw)
>  {
>  	struct nand_chip *chip = &host->chip;
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> @@ -740,7 +768,7 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
>  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
>  
>  	if (read)
> -		nandc_set_read_loc(chip, 0, 0, 0, host->use_ecc ?
> +		nandc_set_read_loc(chip, cw, 0, 0, host->use_ecc ?
>  				   host->cw_data : host->cw_size, 1);
>  }
>  
> @@ -1111,18 +1139,34 @@ static void config_nand_page_read(struct nand_chip *chip)
>  		      NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
>  }
>  
> +/* helper to check which location register should be use for this

    /*
     * Check which location...

> + * code word. NAND_READ_LOCATION or NAND_READ_LOCATION_LAST_CW
> + */
> +static bool config_loc_last_reg(struct nand_chip *chip, int cw)
> +{
> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +
> +	if (nandc->props->qpic_v2 && qcom_nandc_is_last_cw(ecc, cw))
> +		return true;

Not sure this is really useful, it's probably better to drop this
helper and just use...

> +
> +	return false;
> +}
>  /*
>   * Helper to prepare DMA descriptors for configuring registers
>   * before reading each codeword in NAND page.
>   */
>  static void
> -config_nand_cw_read(struct nand_chip *chip, bool use_ecc)
> +config_nand_cw_read(struct nand_chip *chip, bool use_ecc, int cw)
>  {
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> +	int reg = NAND_READ_LOCATION_0;
> +
> +	if (config_loc_last_reg(chip, cw))

...     if (nandc->props->qpic_v2 && qcom_nandc_is_lastcw()) here.

> +		reg = NAND_READ_LOCATION_LAST_CW_0;
>  
>  	if (nandc->props->is_bam)
> -		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
> -			      NAND_BAM_NEXT_SGL);
> +		write_reg_dma(nandc, reg, 4, NAND_BAM_NEXT_SGL);
>  
>  	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> @@ -1142,12 +1186,12 @@ config_nand_cw_read(struct nand_chip *chip, bool use_ecc)

Thanks,
Miquèl
