Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7324141AED7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbhI1MWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:22:21 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57144 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240690AbhI1MWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:22:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632831640; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=BWHTD80p4ldnuMpA917V4DyK793QrG/OscwoVYr3Vr0=;
 b=axmobSVYwfOrF29pq6NStUY1EF/KhAejpyeOTpOMC0v8deE0viOMFooT6osObZ3A7kFUQCWC
 Btu6rkRNzqKC8G3J3dP+Kz+m1gXRBl5xrXiwSst7nzJO99bVVDaqqZeNT0pcG6i4Z52SMNKg
 BHpSMt6P2WaAbr5pbPgzjSDxJr0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61530878a5a9bab6e893de0a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 12:20:08
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D4184C4360C; Tue, 28 Sep 2021 12:20:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C56FC43618;
        Tue, 28 Sep 2021 12:20:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Sep 2021 17:50:06 +0530
From:   mdalam@codeaurora.org
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
Subject: Re: [PATCH 2/3] mtd: rawnand: qcom: Add sg list to handle status pipe
 request
In-Reply-To: <1631699851-12172-3-git-send-email-mdalam@codeaurora.org>
References: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
 <1631699851-12172-3-git-send-email-mdalam@codeaurora.org>
Message-ID: <07b52169db478045d409def2b5f55b01@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-15 15:27, Md Sadre Alam wrote:
> From QPIC V2.0 onwards there is separate pipe to read status
> for each code word while reading in enhanced mode. page scope
> read and multi page read.
> 
> This sgl list will be use to handle the request via status pipe
> during page scope and multi page read.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 34 
> ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c
> b/drivers/mtd/nand/raw/qcom_nandc.c
> index 42c6291..07448c4 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -213,6 +213,7 @@ nandc_set_reg(chip, reg,			\
>  #define QPIC_PER_CW_CMD_ELEMENTS	32
>  #define QPIC_PER_CW_CMD_SGL		32
>  #define QPIC_PER_CW_DATA_SGL		8
> +#define	QPIC_PER_CW_STS_SGL		8
> 
>  #define QPIC_NAND_COMPLETION_TIMEOUT	msecs_to_jiffies(2000)
> 
> @@ -258,6 +259,7 @@ struct bam_transaction {
>  	struct bam_cmd_element *bam_ce;
>  	struct scatterlist *cmd_sgl;
>  	struct scatterlist *data_sgl;
> +	struct scatterlist *sts_sgl;
>  	u32 bam_ce_pos;
>  	u32 bam_ce_start;
>  	u32 cmd_sgl_pos;
> @@ -266,6 +268,8 @@ struct bam_transaction {
>  	u32 tx_sgl_start;
>  	u32 rx_sgl_pos;
>  	u32 rx_sgl_start;
> +	u32 sts_sgl_pos;
> +	u32 sts_sgl_start;
>  	bool wait_second_completion;
>  	struct completion txn_done;
>  	struct dma_async_tx_descriptor *last_data_desc;
> @@ -508,6 +512,8 @@ alloc_bam_transaction(struct qcom_nand_controller 
> *nandc)
>  		((sizeof(*bam_txn->bam_ce) * QPIC_PER_CW_CMD_ELEMENTS) +
>  		(sizeof(*bam_txn->cmd_sgl) * QPIC_PER_CW_CMD_SGL) +
>  		(sizeof(*bam_txn->data_sgl) * QPIC_PER_CW_DATA_SGL));
> +	if (nandc->props->qpic_v2)
> +		bam_txn_size += (sizeof(*bam_txn->sts_sgl) * QPIC_PER_CW_STS_SGL);
> 
>  	bam_txn_buf = devm_kzalloc(nandc->dev, bam_txn_size, GFP_KERNEL);
>  	if (!bam_txn_buf)
> @@ -526,6 +532,12 @@ alloc_bam_transaction(struct qcom_nand_controller 
> *nandc)
> 
>  	bam_txn->data_sgl = bam_txn_buf;
> 
> +	if (nandc->props->qpic_v2) {
> +		bam_txn_buf +=
> +			sizeof(*bam_txn->sts_sgl) * QPIC_PER_CW_STS_SGL * num_cw;
> +		bam_txn->sts_sgl = bam_txn_buf;
> +	}
> +
>  	init_completion(&bam_txn->txn_done);
> 
>  	return bam_txn;
> @@ -554,6 +566,12 @@ static void clear_bam_transaction(struct
> qcom_nand_controller *nandc)
>  		      QPIC_PER_CW_CMD_SGL);
>  	sg_init_table(bam_txn->data_sgl, nandc->max_cwperpage *
>  		      QPIC_PER_CW_DATA_SGL);
> +	if (nandc->props->qpic_v2) {
> +		bam_txn->sts_sgl_pos = 0;
> +		bam_txn->sts_sgl_start = 0;
> +		sg_init_table(bam_txn->sts_sgl, nandc->max_cwperpage *
> +				QPIC_PER_CW_STS_SGL);
> +	}
> 
>  	reinit_completion(&bam_txn->txn_done);
>  }
> @@ -808,6 +826,12 @@ static int prepare_bam_async_desc(struct
> qcom_nand_controller *nandc,
>  		bam_txn->tx_sgl_start = bam_txn->tx_sgl_pos;
>  		dir_eng = DMA_MEM_TO_DEV;
>  		desc->dir = DMA_TO_DEVICE;
> +	} else if (nandc->props->qpic_v2 && chan == nandc->sts_chan) {
> +		sgl = &bam_txn->sts_sgl[bam_txn->sts_sgl_start];
> +		sgl_cnt = bam_txn->sts_sgl_pos - bam_txn->sts_sgl_start;
> +		bam_txn->sts_sgl_start = bam_txn->sts_sgl_pos;
> +		dir_eng = DMA_DEV_TO_MEM;
> +		desc->dir = DMA_FROM_DEVICE;
>  	} else {
>  		sgl = &bam_txn->data_sgl[bam_txn->rx_sgl_start];
>  		sgl_cnt = bam_txn->rx_sgl_pos - bam_txn->rx_sgl_start;
> @@ -1394,6 +1418,14 @@ static int submit_descs(struct
> qcom_nand_controller *nandc)
>  			if (r)
>  				return r;
>  		}
> +
> +		if (nandc->props->qpic_v2) {
> +			if (bam_txn->sts_sgl_pos > bam_txn->sts_sgl_start) {
> +				r = prepare_bam_async_desc(nandc, nandc->sts_chan, 0);
> +				if (r)
> +					return r;
> +			}
> +		}
>  	}
> 
>  	list_for_each_entry(desc, &nandc->desc_list, node)
> @@ -1411,6 +1443,8 @@ static int submit_descs(struct
> qcom_nand_controller *nandc)
>  		dma_async_issue_pending(nandc->tx_chan);
>  		dma_async_issue_pending(nandc->rx_chan);
>  		dma_async_issue_pending(nandc->cmd_chan);
> +		if (nandc->props->qpic_v2)
> +			dma_async_issue_pending(nandc->sts_chan);
> 
>  		if (!wait_for_completion_timeout(&bam_txn->txn_done,
>  						 QPIC_NAND_COMPLETION_TIMEOUT))


Ping! Please provide me some updates on this patch.
