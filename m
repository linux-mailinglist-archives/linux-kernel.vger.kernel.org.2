Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02B630704C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhA1Hyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhA1Hxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:53:39 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4588FC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:52:58 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id md11so3394431pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VsdZHEXPOYBz1t7Uapp8O+nzDu+rjZQkCqjAz0dmanc=;
        b=hirkWz3AUfnmEfgBflhYsHNAKT2Opv+yUSQpfA9pWpHH1FqbiJ6Gfd9YPCcd33ysBy
         QezBDwBeMAb0MrM39cZ96gr6g7bFgaCfQ4dGd8vyWiJUmvE1/jI2N13lbcPbpaiQS1Fz
         f39wFaVxC4nRmw7yjb7n227pi4LGcyZ5CkhCfERij7SNFiHfF+Qc8vKqh0u8HdvhCbiO
         ZYR4XI648Y44w66bxslwoctwpU6ccLz+7xJUUbRktbrdB2EhXOUZpl3FnZcTTvW9RwX4
         qTeM0wr/rtLvuD6iLUydoG55TCAh3HAaGWSlCExsYBQ6TtMxk9zasrd6MYz04C7no42S
         J/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VsdZHEXPOYBz1t7Uapp8O+nzDu+rjZQkCqjAz0dmanc=;
        b=p03ErKqbjNXHy2G9orXRsmuCuLT/ZBKaSg6d+RiSBG4/NPKdlvTdnHqKqFsYmj94xo
         yfm0jl+WxVMkpWbAZd6OD5aGRRHyGwh+VAia1WFa832Ped/NCQbLc9OQETlc/lU1qEUr
         c0zpVzH2KLbdEctCwMH6YForug9v3ilfbSlesN3uOHhEi7pwwQzvuqkY0kdJEPhBJnSS
         ULgXGHxdtIazZxhvbv3IjR/wAJH0l60w3Jz1Qp96Ev3Afze9DaslmVpIoQeb1uPauyTZ
         MZsjR5U1KYHoRbNTCd6fjO++HsqPWi5aN+HK3E5Ek4sYltoalqEc6eR303oQDxEtPuI5
         7kJA==
X-Gm-Message-State: AOAM533tGr1bUr36I8lDJ2znCKdb8prnkbmEKyAyNfdjw2cczMz29lmX
        MSiLyFhkohjHuhPpWHIqhnM0
X-Google-Smtp-Source: ABdhPJzzzYNIlXEgBMv3vSx5fp7JvWt2aQkGBD+cHyBm7aGgUtykjfsy6mkV6/vCoaHJyq2V9r6yDw==
X-Received: by 2002:a17:902:d4d0:b029:df:d246:ca81 with SMTP id o16-20020a170902d4d0b02900dfd246ca81mr15522541plg.58.1611820377621;
        Wed, 27 Jan 2021 23:52:57 -0800 (PST)
Received: from thinkpad ([2409:4072:69e:9090:ae18:d40b:b43a:cda9])
        by smtp.gmail.com with ESMTPSA id i67sm4827628pfc.153.2021.01.27.23.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 23:52:56 -0800 (PST)
Date:   Thu, 28 Jan 2021 13:22:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH V3] mtd: rawnand: qcom: update last code word register
Message-ID: <20210128075248.GA31543@thinkpad>
References: <1610251305-20792-1-git-send-email-mdalam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610251305-20792-1-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 09:31:45AM +0530, Md Sadre Alam wrote:
> From QPIC version 2.0 onwards new register got added to
> read last codeword. This change will update the same.
> 
> For first three code word READ_LOCATION_n register will be
> use.For last code word READ_LOCATION_LAST_CW_n register will be
> use.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>

I gave this patch a try on SDX55 board but not able to resolve an issue and
I think it is related to reading the last code word which this patch is trying
to address. For my patch on supporting QPIC v2 IP, I tested with SDX55-MTP board
and I never hit any issue. But on my new dev board (Telit FN980), there seems to
be an issue while populating the partitions and tracing down that bug lands me
in copy_last_cw() function.

The issue only happens while creating the 3rd partition on Telit board whose
size differs when compared with MTP. The board just reboots into QDL mode
whenever it tries to read the last code word.

Below is the snippet of partition layout:

Telit partitions:

[    1.082015] 0: sbl offs=0x00000000 size=0x0000000a attr:0x000000ff
[    1.082702] 1: mibib offs=0x0000000a size=0x0000000a attr:0x000000ff
[    1.083488] 2: ico offs=0x00000014 size=0x00000014 attr:0x000000ff
[    1.084572] 3: efs2 offs=0x00000028 size=0x0000002c attr:0x000000ff
[    1.085316] 4: tz offs=0x00000054 size=0x00000007 attr:0x000000ff
[    1.086089] 5: tz_devcfg offs=0x0000005b size=0x00000004 attr:0x000000ff
....

MTP partitions:

[    1.573871] 0: sbl offs=0x00000000 size=0x0000000a attr:0x000000ff
[    1.581139] 1: mibib offs=0x0000000a size=0x0000000a attr:0x000000ff
[    1.587362] 2: efs2 offs=0x00000014 size=0x0000002c attr:0x000000ff
[    1.593853] 3: tz offs=0x00000040 size=0x00000007 attr:0x000000ff
[    1.599860] 4: tz_devcfg offs=0x00000047 size=0x00000004 attr:0x000000ff
...

So until I figure this out, please keep this patch on hold!

Thanks,
Mani

> ---
> [V3]
>  * Added else condition for last code word in update_rw_regs().
>  drivers/mtd/nand/raw/qcom_nandc.c | 84 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 70 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 667e4bf..50ff6e3 100644
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
> @@ -1096,9 +1123,13 @@ static void config_nand_page_read(struct qcom_nand_controller *nandc)
>  static void
>  config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
>  {
> -	if (nandc->props->is_bam)
> +	if (nandc->props->is_bam) {
> +		if (nandc->props->qpic_v2)
> +			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0,
> +				      1, NAND_BAM_NEXT_SGL);
>  		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
>  			      NAND_BAM_NEXT_SGL);
> +	}
>  
>  	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> @@ -1633,16 +1664,28 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  	}
>  
>  	if (nandc->props->is_bam) {
> -		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> +			nandc_set_read_loc_last(nandc, 0, read_loc, data_size1, 0);
> +		else
> +			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
>  		read_loc += data_size1;
>  
> -		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> +			nandc_set_read_loc_last(nandc, 1, read_loc, oob_size1, 0);
> +		else
> +			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
>  		read_loc += oob_size1;
>  
> -		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> +			nandc_set_read_loc_last(nandc, 2, read_loc, data_size2, 0);
> +		else
> +			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
>  		read_loc += data_size2;
>  
> -		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> +			nandc_set_read_loc_last(nandc, 3, read_loc, oob_size2, 0);
> +		else
> +			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
>  	}
>  
>  	config_nand_cw_read(nandc, false);
> @@ -1873,14 +1916,27 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
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
> -- 
> 2.7.4
> 
