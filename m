Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDB53161D3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhBJJMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhBJJCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:02:35 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE783C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 01:01:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id k13so818965pfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 01:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZR4GWczI+xHbDhy8yOwk9fJn8ZUuJW3l++fUKt2TTmI=;
        b=yh0yiPM9YI7dLK05YNe7g5QKHA9z63Z3iVqHuDfs3yD4fGnGacePFZrzTO+KHh7icC
         MPZLidOMyUdM3C7L4mei80RNnDSTbZQLSSZN7SmbQaFbOQAMc2ePUBipwSB0Vaad4Yd2
         vPKNBqHPSeDdrhfpnMFS02efBBMOiKijd1FdXQfthnYdy194K0Bk+atdrwOl5/Fu8WDA
         MJpQ6NzgC/krfTylo8L09AS9BsfzFeC0Zyi1+uRhuGghgQF3SjCAqZtIHubcmGyu4bB8
         avLJij9knNCry/xJbZEu5XrKT5KOh73MoA23QJtQpMoK+4VXYgbyEyJ1W18cB9bqfJnO
         w2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZR4GWczI+xHbDhy8yOwk9fJn8ZUuJW3l++fUKt2TTmI=;
        b=Ht3LYp9OcqrqJCt5tXNpk9TWkaTwX3wkVlpeCqWTfVf82NNE92MuOEklcYi3RhPdRH
         5KHK6s5PU+IIrGwblZAq2dSfB8wNYNvMaJVQb2ecSdiZ6GPWYqOJaCuufdPPp+HryysA
         40bkVA914pLjCqUpJkzYRjAzzpfIJufts12lYkU9bJml7Fn0+o0653OsEuKBHgrG1o2H
         BjBFoUVugLlFcRW6ZPKyp/2lIhqhkvUnVTrZpcqYAZf5pjh368TrR2xKaYaF85gyVcjb
         LknH989AMjYIUv4upSBcSMNO0aoHZFhi/ZXfFAnFSeDpDI3n5+Vd07McXvdKrF+M4syZ
         Y7oQ==
X-Gm-Message-State: AOAM530yY1/4Yrl+4uDlCynl8pWZLzVAMfZi2ygsigShf/+BH1cJD9ch
        Iscj+Hocg7FiOZBvYU9KiJto
X-Google-Smtp-Source: ABdhPJxshQShTa9xlKcEJvbbFXKh7+En4nStubVYK1Tm2QncQAPwh19ZJt2iU2E6ZBO4gqcagz9g7g==
X-Received: by 2002:a63:1965:: with SMTP id 37mr2194334pgz.349.1612947708171;
        Wed, 10 Feb 2021 01:01:48 -0800 (PST)
Received: from work ([103.66.79.29])
        by smtp.gmail.com with ESMTPSA id p19sm1444013pjo.7.2021.02.10.01.01.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Feb 2021 01:01:47 -0800 (PST)
Date:   Wed, 10 Feb 2021 14:31:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     miquel.raynal@bootlin.com, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, sricharan@codeaurora.org
Subject: Re: [PATCH V4] mtd: rawnand: qcom: update last code word register
Message-ID: <20210210090144.GE19226@work>
References: <1611869959-5109-1-git-send-email-mdalam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611869959-5109-1-git-send-email-mdalam@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 03:09:19AM +0530, Md Sadre Alam wrote:
> From QPIC version 2.0 onwards new register got added to
> read last codeword. This change will add the READ_LOCATION_LAST_CW_n
> register.
> 
> For first three code word READ_LOCATION_n register will be
> use.For last code word READ_LOCATION_LAST_CW_n register will be
> use.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> [V4]
>  * Modified condition for nandc_set_read_loc_last() in qcom_nandc_read_cw_raw().
>  * Added one additional argument "last_cw" to the function config_nand_cw_read()
>    to handle last code word condition.
>  * Changed total number of last code word register "NAND_READ_LOCATION_LAST_CW_0" to 4
>    while doing code word configuration.
>  drivers/mtd/nand/raw/qcom_nandc.c | 110 +++++++++++++++++++++++++++++---------
>  1 file changed, 84 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 667e4bf..9484be8 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -48,6 +48,10 @@
>  #define	NAND_READ_LOCATION_1		0xf24
>  #define	NAND_READ_LOCATION_2		0xf28
>  #define	NAND_READ_LOCATION_3		0xf2c
> +#define	NAND_READ_LOCATION_LAST_CW_0	0xf40
> +#define	NAND_READ_LOCATION_LAST_CW_1	0xf44
> +#define	NAND_READ_LOCATION_LAST_CW_2	0xf48
> +#define	NAND_READ_LOCATION_LAST_CW_3	0xf4c
>  
>  /* dummy register offsets, used by write_reg_dma */
>  #define	NAND_DEV_CMD1_RESTORE		0xdead
> @@ -187,6 +191,12 @@ nandc_set_reg(nandc, NAND_READ_LOCATION_##reg,			\
>  	      ((size) << READ_LOCATION_SIZE) |			\
>  	      ((is_last) << READ_LOCATION_LAST))
>  
> +#define nandc_set_read_loc_last(nandc, reg, offset, size, is_last)	\
> +nandc_set_reg(nandc, NAND_READ_LOCATION_LAST_CW_##reg,			\
> +	      ((offset) << READ_LOCATION_OFFSET) |		\
> +	      ((size) << READ_LOCATION_SIZE) |			\
> +	      ((is_last) << READ_LOCATION_LAST))
> +
>  /*
>   * Returns the actual register address for all NAND_DEV_ registers
>   * (i.e. NAND_DEV_CMD0, NAND_DEV_CMD1, NAND_DEV_CMD2 and NAND_DEV_CMD_VLD)
> @@ -316,6 +326,10 @@ struct nandc_regs {
>  	__le32 read_location1;
>  	__le32 read_location2;
>  	__le32 read_location3;
> +	__le32 read_location_last0;
> +	__le32 read_location_last1;
> +	__le32 read_location_last2;
> +	__le32 read_location_last3;
>  
>  	__le32 erased_cw_detect_cfg_clr;
>  	__le32 erased_cw_detect_cfg_set;
> @@ -644,6 +658,14 @@ static __le32 *offset_to_nandc_reg(struct nandc_regs *regs, int offset)
>  		return &regs->read_location2;
>  	case NAND_READ_LOCATION_3:
>  		return &regs->read_location3;
> +	case NAND_READ_LOCATION_LAST_CW_0:
> +		return &regs->read_location_last0;
> +	case NAND_READ_LOCATION_LAST_CW_1:
> +		return &regs->read_location_last1;
> +	case NAND_READ_LOCATION_LAST_CW_2:
> +		return &regs->read_location_last2;
> +	case NAND_READ_LOCATION_LAST_CW_3:
> +		return &regs->read_location_last3;
>  	default:
>  		return NULL;
>  	}
> @@ -719,9 +741,14 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
>  	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
>  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
>  
> -	if (read)
> -		nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
> -				   host->cw_data : host->cw_size, 1);
> +	if (read) {
> +		if (nandc->props->qpic_v2)
> +			nandc_set_read_loc_last(nandc, 0, 0, host->use_ecc ?
> +					host->cw_data : host->cw_size, 1);
> +		else
> +			nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
> +					host->cw_data : host->cw_size, 1);
> +	}
>  }
>  
>  /*
> @@ -1094,11 +1121,16 @@ static void config_nand_page_read(struct qcom_nand_controller *nandc)
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
> +	}
>  
>  	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> @@ -1118,10 +1150,10 @@ config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
>   */
>  static void
>  config_nand_single_cw_page_read(struct qcom_nand_controller *nandc,
> -				bool use_ecc)
> +				bool use_ecc, bool last_cw)
>  {
>  	config_nand_page_read(nandc);
> -	config_nand_cw_read(nandc, use_ecc);
> +	config_nand_cw_read(nandc, use_ecc, last_cw);
>  }
>  
>  /*
> @@ -1215,7 +1247,7 @@ static int nandc_param(struct qcom_nand_host *host)
>  	nandc->buf_count = 512;
>  	memset(nandc->data_buffer, 0xff, nandc->buf_count);
>  
> -	config_nand_single_cw_page_read(nandc, false);
> +	config_nand_single_cw_page_read(nandc, false, false);
>  
>  	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
>  		      nandc->buf_count, 0);
> @@ -1633,19 +1665,32 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  	}
>  
>  	if (nandc->props->is_bam) {
> -		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> -		read_loc += data_size1;
> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1)) {
> +			nandc_set_read_loc_last(nandc, 0, read_loc, data_size1, 0);
> +			read_loc += data_size1;
> +
> +			nandc_set_read_loc_last(nandc, 1, read_loc, oob_size1, 0);
> +			read_loc += oob_size1;
>  
> -		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
> -		read_loc += oob_size1;
> +			nandc_set_read_loc_last(nandc, 2, read_loc, data_size2, 0);
> +			read_loc += data_size2;
>  
> -		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
> -		read_loc += data_size2;
> +			nandc_set_read_loc_last(nandc, 3, read_loc, oob_size2, 1);
> +		} else {
> +			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> +			read_loc += data_size1;
> +
> +			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
> +			read_loc += oob_size1;
>  
> -		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
> +			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
> +			read_loc += data_size2;
> +
> +			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
> +		}
>  	}
>  
> -	config_nand_cw_read(nandc, false);
> +	config_nand_cw_read(nandc, false, cw == ecc->steps - 1 ? true : false);
>  
>  	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
>  	reg_off += data_size1;
> @@ -1873,18 +1918,31 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
>  
>  		if (nandc->props->is_bam) {
>  			if (data_buf && oob_buf) {
> -				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
> -				nandc_set_read_loc(nandc, 1, data_size,
> -						   oob_size, 1);
> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1)) {
> +					nandc_set_read_loc_last(nandc, 0, 0, data_size, 0);
> +					nandc_set_read_loc_last(nandc, 1, data_size,
> +								oob_size, 1);
> +				} else {
> +					nandc_set_read_loc(nandc, 0, 0, data_size, 0);
> +					nandc_set_read_loc(nandc, 1, data_size,
> +							   oob_size, 1);
> +				}
>  			} else if (data_buf) {
> -				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
> +					nandc_set_read_loc_last(nandc, 0, 0, data_size, 1);
> +				else
> +					nandc_set_read_loc(nandc, 0, 0, data_size, 1);
>  			} else {
> -				nandc_set_read_loc(nandc, 0, data_size,
> -						   oob_size, 1);
> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
> +					nandc_set_read_loc_last(nandc, 0, data_size,
> +								oob_size, 1);
> +				else
> +					nandc_set_read_loc(nandc, 0, data_size,
> +							   oob_size, 1);
>  			}
>  		}
>  
> -		config_nand_cw_read(nandc, true);
> +		config_nand_cw_read(nandc, true, i == ecc->steps - 1 ? true : false);
>  
>  		if (data_buf)
>  			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
> @@ -1946,7 +2004,7 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
>  	set_address(host, host->cw_size * (ecc->steps - 1), page);
>  	update_rw_regs(host, 1, true);
>  
> -	config_nand_single_cw_page_read(nandc, host->use_ecc);
> +	config_nand_single_cw_page_read(nandc, host->use_ecc, true);
>  
>  	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
>  
> -- 
> 2.7.4
> 
