Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A734131B5F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 09:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhBOIlw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Feb 2021 03:41:52 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42015 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhBOIls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 03:41:48 -0500
X-Originating-IP: 90.89.99.36
Received: from xps13 (lfbn-tou-1-1536-36.w90-89.abo.wanadoo.fr [90.89.99.36])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 42BA5E0005;
        Mon, 15 Feb 2021 08:40:56 +0000 (UTC)
Date:   Mon, 15 Feb 2021 09:40:55 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     richard@nod.at, vigneshr@ti.com, boris.brezillon@collabora.com,
        mani@kernel.org, krzk@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: update last code word register
Message-ID: <20210215094055.1c3847f8@xps13>
In-Reply-To: <1613337451-8002-1-git-send-email-mdalam@codeaurora.org>
References: <1613337451-8002-1-git-send-email-mdalam@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Md Sadre Alam <mdalam@codeaurora.org> wrote on Mon, 15 Feb 2021
02:47:31 +0530:

> From QPIC version 2.0 onwards new register got added to
> read last codeword. This change will add the READ_LOCATION_LAST_CW_n
> register.
> 
> For first three code word READ_LOCATION_n register will be
> use.For last code word READ_LOCATION_LAST_CW_n register will be
> use.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
> [V5]
>  * Added helper function to update location register value.


Please don't forget the "v5" in the message object.

>  /*
> @@ -1094,11 +1141,16 @@ static void config_nand_page_read(struct qcom_nand_controller *nandc)
>   * before reading each codeword in NAND page.
>   */
>  static void
> -config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
> +config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc, bool last_cw)
>  {
> -	if (nandc->props->is_bam)
> -		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
> -			      NAND_BAM_NEXT_SGL);
> +	if (nandc->props->is_bam) {
> +		if (nandc->props->qpic_v2 && last_cw)
> +			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0, 4,
> +				      NAND_BAM_NEXT_SGL);
> +		else
> +			write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
> +				      NAND_BAM_NEXT_SGL);

I guess write_reg_dma should be updated as well.


[...]

>  
> -	config_nand_cw_read(nandc, false);
> +	config_nand_cw_read(nandc, false, cw == ecc->steps - 1 ? true : false);
>  
>  	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
>  	reg_off += data_size1;
> @@ -1873,18 +1938,31 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
>  
>  		if (nandc->props->is_bam) {
>  			if (data_buf && oob_buf) {
> -				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
> -				nandc_set_read_loc(nandc, 1, data_size,
> -						   oob_size, 1);
> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1)) {

I would like the helper to handle this condition. I would prefer to
avoid yet an extra indentation level.

> +					nandc_set_read_loc(chip, i, 0, 0, data_size, 0);
> +					nandc_set_read_loc(chip, i, 1, data_size,
> +							   oob_size, 1);
> +				} else {
> +					nandc_set_read_loc(chip, i, 0, 0, data_size, 0);
> +					nandc_set_read_loc(chip, i, 1, data_size,
> +							   oob_size, 1);
> +				}
>  			} else if (data_buf) {
> -				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
> +					nandc_set_read_loc(chip, i, 0, 0, data_size, 1);
> +				else
> +					nandc_set_read_loc(chip, i, 0, 0, data_size, 1);
>  			} else {
> -				nandc_set_read_loc(nandc, 0, data_size,
> -						   oob_size, 1);
> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
> +					nandc_set_read_loc(chip, i, 0, data_size,
> +							   oob_size, 1);
> +				else
> +					nandc_set_read_loc(chip, i, 0, data_size,
> +							   oob_size, 1);
>  			}
>  		}
>  
> -		config_nand_cw_read(nandc, true);
> +		config_nand_cw_read(nandc, true, i == ecc->steps - 1 ? true : false);

	i == (ecc->steps - 1)

is already a boolean, you don't need

	"? true : false"

>  
>  		if (data_buf)
>  			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
> @@ -1946,7 +2024,7 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
>  	set_address(host, host->cw_size * (ecc->steps - 1), page);
>  	update_rw_regs(host, 1, true);
>  
> -	config_nand_single_cw_page_read(nandc, host->use_ecc);
> +	config_nand_single_cw_page_read(nandc, host->use_ecc, true);

Maybe it's best to just forward the codeword and let the code that
needs to know if it is the last one or not do the comparison.

>  
>  	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
>  

Thanks,
Miquèl
