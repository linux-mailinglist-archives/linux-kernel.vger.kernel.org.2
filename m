Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89650322E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhBWQNR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Feb 2021 11:13:17 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34091 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbhBWQNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:13:15 -0500
X-Originating-IP: 86.210.203.113
Received: from xps13 (lfbn-tou-1-972-113.w86-210.abo.wanadoo.fr [86.210.203.113])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DF253E0013;
        Tue, 23 Feb 2021 16:12:24 +0000 (UTC)
Date:   Tue, 23 Feb 2021 17:12:23 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     mani@kernel.org, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: Add helper to check last code word
Message-ID: <20210223171223.53f86959@xps13>
In-Reply-To: <1613975095-15550-1-git-send-email-mdalam@codeaurora.org>
References: <1613975095-15550-1-git-send-email-mdalam@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Md Sadre Alam <mdalam@codeaurora.org> wrote on Mon, 22 Feb 2021
11:54:55 +0530:

> This change will add helper qcom_nandc_is_last_cw()

Use the imperative form, something like:

"
Add the qcom_nandc_is_last_cw() helper which checks if the input cw
index is the last one or not.
"

> which will check for last code word and return true for
> last code word and false for other code word.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index ae8870ec..4189a7f 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -661,6 +661,12 @@ static void nandc_set_reg(struct qcom_nand_controller *nandc, int offset,
>  		*reg = cpu_to_le32(val);
>  }
>  
> +/* Helper to check the code word, whether it is last cw or not */
> +static bool qcom_nandc_is_last_cw(struct nand_ecc_ctrl *ecc, int cw)
> +{
> +	return cw == (ecc->steps - 1);
> +}
> +
>  /* helper to configure address register values */
>  static void set_address(struct qcom_nand_host *host, u16 column, int page)
>  {
> @@ -1632,7 +1638,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
>  	oob_size1 = host->bbm_size;
>  
> -	if (cw == (ecc->steps - 1)) {
> +	if (qcom_nandc_is_last_cw(ecc, cw)) {
>  		data_size2 = ecc->size - data_size1 -
>  			     ((ecc->steps - 1) * 4);
>  		oob_size2 = (ecc->steps * 4) + host->ecc_bytes_hw +
> @@ -1713,7 +1719,7 @@ check_for_erased_page(struct qcom_nand_host *host, u8 *data_buf,
>  	}
>  
>  	for_each_set_bit(cw, &uncorrectable_cws, ecc->steps) {
> -		if (cw == (ecc->steps - 1)) {
> +		if (qcom_nandc_is_last_cw(ecc, cw)) {
>  			data_size = ecc->size - ((ecc->steps - 1) * 4);
>  			oob_size = (ecc->steps * 4) + host->ecc_bytes_hw;
>  		} else {
> @@ -1773,7 +1779,7 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
>  		u32 flash, buffer, erased_cw;
>  		int data_len, oob_len;
>  
> -		if (i == (ecc->steps - 1)) {
> +		if (qcom_nandc_is_last_cw(ecc, i)) {
>  			data_len = ecc->size - ((ecc->steps - 1) << 2);
>  			oob_len = ecc->steps << 2;
>  		} else {
> @@ -1872,7 +1878,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
>  	for (i = 0; i < ecc->steps; i++) {
>  		int data_size, oob_size;
>  
> -		if (i == (ecc->steps - 1)) {
> +		if (qcom_nandc_is_last_cw(ecc, i)) {
>  			data_size = ecc->size - ((ecc->steps - 1) << 2);
>  			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw +
>  				   host->spare_bytes;
> @@ -2051,7 +2057,7 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
>  	for (i = 0; i < ecc->steps; i++) {
>  		int data_size, oob_size;
>  
> -		if (i == (ecc->steps - 1)) {
> +		if (qcom_nandc_is_last_cw(ecc, i)) {
>  			data_size = ecc->size - ((ecc->steps - 1) << 2);
>  			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw +
>  				   host->spare_bytes;
> @@ -2068,10 +2074,10 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
>  		 * when ECC is enabled, we don't really need to write anything
>  		 * to oob for the first n - 1 codewords since these oob regions
>  		 * just contain ECC bytes that's written by the controller
> -		 * itself. For the last codeword, we skip the bbm positions and
> -		 * write to the free oob area.
> +		 * itself. For the last codeword, we skip the bbm positions and write
> +		 * to the free oob area.

Not related change, please drop.

>  		 */
> -		if (i == (ecc->steps - 1)) {
> +		if (qcom_nandc_is_last_cw(ecc, i)) {
>  			oob_buf += host->bbm_size;
>  
>  			write_data_dma(nandc, FLASH_BUF_ACC + data_size,
> @@ -2126,7 +2132,7 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
>  		data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
>  		oob_size1 = host->bbm_size;
>  
> -		if (i == (ecc->steps - 1)) {
> +		if (qcom_nandc_is_last_cw(ecc, i)) {
>  			data_size2 = ecc->size - data_size1 -
>  				     ((ecc->steps - 1) << 2);
>  			oob_size2 = (ecc->steps << 2) + host->ecc_bytes_hw +


Thanks,
Miquèl
