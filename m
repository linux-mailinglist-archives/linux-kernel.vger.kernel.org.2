Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE9341AEC3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbhI1MUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:20:09 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:38723 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240676AbhI1MT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:19:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632831499; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=XVITHsJ9eg8UKU/x0/Au9E7feURfvVXtzCIeg+cG94I=;
 b=KTSRmzSJkA0HDYtBq7nTPb34CCN1ZvQ0oOwo+h5c9uG9h6h85+dZgeBYzkERv70qRfZQqkyp
 7JdsutoEBDAnIBpPipM+Bzdwqdi6yWOugDeuls7iuh5fMMLGcqHALXQ7z6+nAJXc6qJXnXsC
 pD0NNBmpyazRflQZEwTGQCmGtbQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 615307d9a5a9bab6e891c511 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 12:17:29
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0ED1C43619; Tue, 28 Sep 2021 12:17:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40AAEC43617;
        Tue, 28 Sep 2021 12:17:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Sep 2021 17:47:27 +0530
From:   mdalam@codeaurora.org
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
Subject: Re: [PATCH 1/3] mtd: rawnand: qcom: Add support for status pipe
In-Reply-To: <1631699851-12172-2-git-send-email-mdalam@codeaurora.org>
References: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
 <1631699851-12172-2-git-send-email-mdalam@codeaurora.org>
Message-ID: <97df48e5505c4e6ae3bc6b7e953c156c@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-15 15:27, Md Sadre Alam wrote:
> From QPIC V2.0 onwards there is a separate pipe
> to read status of each code word, called "status" pipe.
> 
> "status" pipe will use to read CW status in case of
> enhanced read mode like page scope read, multi page read.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c
> b/drivers/mtd/nand/raw/qcom_nandc.c
> index 04e6f7b..42c6291 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -389,6 +389,7 @@ struct qcom_nand_controller {
>  			struct dma_chan *tx_chan;
>  			struct dma_chan *rx_chan;
>  			struct dma_chan *cmd_chan;
> +			struct dma_chan *sts_chan;
>  		};
> 
>  		/* will be used only by EBI2 for ADM DMA */
> @@ -2737,6 +2738,11 @@ static void qcom_nandc_unalloc(struct
> qcom_nand_controller *nandc)
> 
>  		if (nandc->cmd_chan)
>  			dma_release_channel(nandc->cmd_chan);
> +
> +		if (nandc->props->qpic_v2) {
> +			if (nandc->sts_chan)
> +				dma_release_channel(nandc->sts_chan);
> +		}
>  	} else {
>  		if (nandc->chan)
>  			dma_release_channel(nandc->chan);
> @@ -2815,6 +2821,14 @@ static int qcom_nandc_alloc(struct
> qcom_nand_controller *nandc)
>  			goto unalloc;
>  		}
> 
> +		if (nandc->props->qpic_v2) {
> +			nandc->sts_chan = dma_request_slave_channel(nandc->dev, "sts");
> +			if (!nandc->sts_chan) {
> +				dev_err(nandc->dev, "failed to request sts channel\n");
> +				return -ENODEV;
> +			}
> +		}
> +
>  		/*
>  		 * Initially allocate BAM transaction to read ONFI param page.
>  		 * After detecting all the devices, this BAM transaction will

Ping! Please provide me some updates on this patch.
