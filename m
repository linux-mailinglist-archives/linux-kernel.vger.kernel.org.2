Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8AD3FEB18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbhIBJSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233639AbhIBJSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:18:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEA9C60FE6;
        Thu,  2 Sep 2021 09:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630574256;
        bh=k+p+COLdCn00GYtaVT9P/WwwAYDhVRDB8CAIAw6yoms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1Xe3/ZvbnEU4ZfeoQNpf1mgJS3OXI+wINpG8dGxyqXJL+E1bILWp5dCVcwSyIUEB
         m8JW+eD5fPi2snq0qhOP46mqCSCutArczb6KC3gUkVyxnuABIX1ExmOjVnDfBlgZ1E
         GYZg4uOW8cnC0jk6k2AljGulapEtRvGhOdct47wAm5GzHhJqn/GFS47SksK3umm954
         JTtG4DzFSvuHiPQe5A2HTkIvHpLMCzv0TXhMx2lWZF5HUx1qR/2gu4A0q4bJkWpbVN
         Q5EKjq39n3Btf/zwqUvrWC9odv9H/9Wq5V9Bc8buWgHo6/5pM5ouYaKJYJ8PqUtydI
         VdTp30wXdpkbw==
Date:   Thu, 2 Sep 2021 14:47:30 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org,
        stable@kernel.org
Subject: Re: [PATCH V4] mtd: rawnand: qcom: Update code word value for raw
 read
Message-ID: <20210902091730.GA10844@workstation>
References: <1630561763-18486-1-git-send-email-mdalam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630561763-18486-1-git-send-email-mdalam@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 11:19:23AM +0530, Md Sadre Alam wrote:
> From QPIC V2 onwards there is a separate register to read
> last code word "QPIC_NAND_READ_LOCATION_LAST_CW_n".
> 
> qcom_nandc_read_cw_raw() is used to read only one code word
> at a time. If we will configure number of code words to 1 in
> in QPIC_NAND_DEV0_CFG0 register then QPIC controller thinks
> its reading the last code word, since from QPIC V2 onwards
> we are having separate register to read the last code word,
> we have to configure "QPIC_NAND_READ_LOCATION_LAST_CW_n"
> register to fetch data from controller buffer to system
> memory.
> 
> Fixes: 503ee5aa ("mtd: rawnand: qcom: update last code word register")

Commit hash should be of 12 digits.

> Cc: stable@kernel.org
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
> [V4]
>  * Added commit message
>  * Added changelog
> 
>  In commit 503ee5aa added QPIC V2 support. Since QPIC V2 onwards there
>  is separate register to get last CW data. If total number of CW configred is 1 
>  then , QPIC controller treat this as last CW and software shhould copy data to memory
>  via QPIC_NAND_READ_LOCATION_LAST_CW_n register instead of QPIC_NAND_READ_LOCATION_n.
>  Since in raw read we are configuring total number of CW 1, this change fixes
>  this if total number of CW 1 then make this as last CW.  raw_cw = ecc->steps - 1;
>  since ecc->steps holds total number of CWs.
> 

This is not a changelog. Changelog should mention what has been changed
between versions from v1 to v4. For example:

Changes in v4:

* Incorporated AAA comments from X
* Changed a local variable

Changes in v3:

* Incorporated BBB comments from X

Changes in v2:

* Incorporated CCC comments from X

>  drivers/mtd/nand/raw/qcom_nandc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index ef0bade..04e6f7b 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -1676,13 +1676,17 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
>  	int data_size1, data_size2, oob_size1, oob_size2;
>  	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
> +	int raw_cw = cw;
>  
>  	nand_read_page_op(chip, page, 0, NULL, 0);
>  	host->use_ecc = false;
>  
> +	if (nandc->props->qpic_v2)
> +		raw_cw = ecc->steps - 1;
> +

Sorry, I don't understand how it can work. For reading a codeword like
0, you are reading the last codeword here if the controller is v2. And
you'll continue to read the last codeword only for any codeword
requested :/

Thanks,
Mani

>  	clear_bam_transaction(nandc);
>  	set_address(host, host->cw_size * cw, page);
> -	update_rw_regs(host, 1, true, cw);
> +	update_rw_regs(host, 1, true, raw_cw);
>  	config_nand_page_read(chip);
>  
>  	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
> @@ -1711,7 +1715,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  		nandc_set_read_loc(chip, cw, 3, read_loc, oob_size2, 1);
>  	}
>  
> -	config_nand_cw_read(chip, false, cw);
> +	config_nand_cw_read(chip, false, raw_cw);
>  
>  	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
>  	reg_off += data_size1;
> -- 
> 2.7.4
> 
