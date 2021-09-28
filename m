Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6FA41B351
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbhI1PzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241523AbhI1PzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:55:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F6A860F0F;
        Tue, 28 Sep 2021 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632844415;
        bh=Y5e9CIreOMBgUX4oGIdc1T/T430Kpn66zsMnsKXSXeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDnIpqhr8CyZ1nLAsDCphZ5Xu9Z28BgKX+qEVht6neCzo6kjVmkjYHIXfABqwMw/x
         5YJ2BV3BVBkrOmmtBVPsy3MnBhDT7/iJVULg2lY7ICk5+gG70IpcOueIzL1ssHD6Qw
         OTlSI97QGsJOyVyXMaimX2kiQgi7Uyj3EPCQkxiVyiNL4n91kQYe5Ltt0tWIxTRNWc
         xPftl/4Knqf3Ayhf0kB3o/OBqNviw8kbgSxRxV5rcGZZO2o2LNeyXvyygtcvfGC2QP
         zlwdHejxFlMNi9yfLm5/R86K4GXsrEDI2cNZ1gFIlt6Srg6U61CZCJQEaXD15iw25e
         jNh7Ao5GA1LzA==
Date:   Tue, 28 Sep 2021 21:22:05 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH 1/3] mtd: rawnand: qcom: Add support for status pipe
Message-ID: <20210928155205.GB12183@thinkpad>
References: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
 <1631699851-12172-2-git-send-email-mdalam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631699851-12172-2-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 03:27:29PM +0530, Md Sadre Alam wrote:
> From QPIC V2.0 onwards there is a separate pipe
> to read status of each code word, called "status" pipe.
> 
> "status" pipe will use to read CW status in case of
> enhanced read mode like page scope read, multi page read.
> 

The pipe you are referring to is a DMA pipe (channel). So it should be mentioned
here.

> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
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
> @@ -2737,6 +2738,11 @@ static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
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
> @@ -2815,6 +2821,14 @@ static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
>  			goto unalloc;
>  		}
>  
> +		if (nandc->props->qpic_v2) {
> +			nandc->sts_chan = dma_request_slave_channel(nandc->dev, "sts");
> +			if (!nandc->sts_chan) {
> +				dev_err(nandc->dev, "failed to request sts channel\n");
> +				return -ENODEV;
> +			}

If you are forcing the need of status pipe, then you should also update the
devicetree of relevant SoCs using the QPIC v2 controller. Else, they will fail
to probe.

Thanks,
Mani

> +		}
> +
>  		/*
>  		 * Initially allocate BAM transaction to read ONFI param page.
>  		 * After detecting all the devices, this BAM transaction will
> -- 
> 2.7.4
> 
