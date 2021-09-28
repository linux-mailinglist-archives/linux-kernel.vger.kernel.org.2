Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DBC41AF4D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbhI1Ms2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 08:48:28 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:53397 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240578AbhI1Ms1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:48:27 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6F135FF806;
        Tue, 28 Sep 2021 12:46:46 +0000 (UTC)
Date:   Tue, 28 Sep 2021 14:46:45 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     mdalam@codeaurora.org
Cc:     mani@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH 1/3] mtd: rawnand: qcom: Add support for status pipe
Message-ID: <20210928144645.40209af0@xps13>
In-Reply-To: <97df48e5505c4e6ae3bc6b7e953c156c@codeaurora.org>
References: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
        <1631699851-12172-2-git-send-email-mdalam@codeaurora.org>
        <97df48e5505c4e6ae3bc6b7e953c156c@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

mdalam@codeaurora.org wrote on Tue, 28 Sep 2021 17:47:27 +0530:

> On 2021-09-15 15:27, Md Sadre Alam wrote:
> > From QPIC V2.0 onwards there is a separate pipe
> > to read status of each code word, called "status" pipe.
> > 
> > "status" pipe will use to read CW status in case of

What is a CW status?

> > enhanced read mode like page scope read, multi page read.

What is a page scope read?

> > 
> > Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> > ---
> >  drivers/mtd/nand/raw/qcom_nandc.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c
> > b/drivers/mtd/nand/raw/qcom_nandc.c
> > index 04e6f7b..42c6291 100644
> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > @@ -389,6 +389,7 @@ struct qcom_nand_controller {
> >  			struct dma_chan *tx_chan;
> >  			struct dma_chan *rx_chan;
> >  			struct dma_chan *cmd_chan;
> > +			struct dma_chan *sts_chan;
> >  		};
> > 
> >  		/* will be used only by EBI2 for ADM DMA */
> > @@ -2737,6 +2738,11 @@ static void qcom_nandc_unalloc(struct
> > qcom_nand_controller *nandc)
> > 
> >  		if (nandc->cmd_chan)
> >  			dma_release_channel(nandc->cmd_chan);
> > +
> > +		if (nandc->props->qpic_v2) {
> > +			if (nandc->sts_chan)
> > +				dma_release_channel(nandc->sts_chan);
> > +		}
> >  	} else {
> >  		if (nandc->chan)
> >  			dma_release_channel(nandc->chan);
> > @@ -2815,6 +2821,14 @@ static int qcom_nandc_alloc(struct
> > qcom_nand_controller *nandc)
> >  			goto unalloc;
> >  		}
> > 
> > +		if (nandc->props->qpic_v2) {
> > +			nandc->sts_chan = dma_request_slave_channel(nandc->dev, "sts");
> > +			if (!nandc->sts_chan) {
> > +				dev_err(nandc->dev, "failed to request sts channel\n");
> > +				return -ENODEV;
> > +			}
> > +		}
> > +
> >  		/*
> >  		 * Initially allocate BAM transaction to read ONFI param page.
> >  		 * After detecting all the devices, this BAM transaction will  
> 
> Ping! Please provide me some updates on this patch.

I don't think you need to ping me on all your patches. This is
irritating given the time that I allocated to all your contributions so
far.

This being said, I had no particular comment regarding the
implementation of the series but giving it a second look I still don't
fully understand the goal of this "additional pipe" so, as my comments
above say, please elaborate a little bit.

Thanks,
Miquèl
