Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D30530B655
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhBBERY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhBBERA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:17:00 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A669C061786
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:16:20 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z21so14054073pgj.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 20:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=voXjzMFXu6z+viPuy/BWrmyMPRk9jtrQCw1WWpPx03o=;
        b=pEP+WfeazvjfFZlIx1bIoJGWjjlwEvSWlNVjbhUv1TxoUXLnsPEQW4mdPsyArWY/2g
         ruLtdpvOtbUXO0taNxCXVhRzia059Zi8ze96oKMr4wxKjI3YDL2rW44CyszxN6sI2mUh
         snf9M++3pL+0nPpXuXrstV+X1WFZEur2GFFCIwiAs98vx25shanCDYZDbUN7yrHqA5bq
         GirtT1SF9x8DwVJ7IwN2mHsPtVYYjilvE3nccHSTPaOpDIi1VQcfmT/PbcPnXAYKJGdw
         7yBpG2to8UWenGoTZINfTNzh6MNUJrDrqdreSAKP1Jx3kjKac5vyr4DjR0GxFemv9CS6
         ksTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=voXjzMFXu6z+viPuy/BWrmyMPRk9jtrQCw1WWpPx03o=;
        b=b9Pax5MNP2bbiNTLSYskjM0m2quq8ffRtkqv5nYBEfgwIQgPFa9KaBoj9Red9rfY0n
         QA7adJzyItI93gOLwiDlvroOzAyoCfzDpiNlvJSiFiIJo5QGKhFvMPI1bjEa6aEbpxnC
         AieYdHBccQCQO/+Cm4qhjjyMGqjixf2MrmNtUa1X62uHVvUBrwHRjb2NaopBUg+dwRVB
         PMEZ2KYZwG5muKMEwssOF6GGTB6WobKf28eaasaYBKx/a3NZP1Upcj2NxmABTRr1U/sT
         M9tXO1Rk2+SCLYCW+aI4of6iDiXmmqZkfMX+8WCMd36ROEgKSMD6fWxBVBTMr7NkaZwt
         48nw==
X-Gm-Message-State: AOAM530tkVZh27jzzclfRqYlfHYzgbzPLKDpY4UEHJYBl890Br1T09vh
        lQuuTNCScif4beOrOtOLEpJL
X-Google-Smtp-Source: ABdhPJw5Jt+ornFBPPnaCufSVeoU97SdnZ7+6U94Fqu8kywGM+I9lYLblJtPxaOxtmRemL7eOpJ9NA==
X-Received: by 2002:a63:e10b:: with SMTP id z11mr20098899pgh.40.1612239379381;
        Mon, 01 Feb 2021 20:16:19 -0800 (PST)
Received: from work ([103.77.37.138])
        by smtp.gmail.com with ESMTPSA id i22sm995929pjv.35.2021.02.01.20.16.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Feb 2021 20:16:18 -0800 (PST)
Date:   Tue, 2 Feb 2021 09:46:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH] mtd: rawnand: Do not check for bad block if bbt is
 unavailable
Message-ID: <20210202041614.GA840@work>
References: <20210130035412.6456-1-manivannan.sadhasivam@linaro.org>
 <20210201151824.5a9dca4a@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210201151824.5a9dca4a@xps13>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 01, 2021 at 03:18:24PM +0100, Miquel Raynal wrote:
> Hi Manivannan,
> 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote on Sat,
> 30 Jan 2021 09:24:12 +0530:
> 
> > The bbt pointer will be unavailable when NAND_SKIP_BBTSCAN option is
> > set for a NAND chip. The intention is to skip scanning for the bad
> > blocks during boot time.
> 
> I don't have the same understanding: this flag skips the bad block
> table scan, not the bad block scan. We do want to scan all the devices
> in order to construct a RAM based table.
> 
> > However, the MTD core will call
> > _block_isreserved() and _block_isbad() callbacks unconditionally for
> > the rawnand devices due to the callbacks always present while collecting
> > the ecc stats.
> > 
> > The _block_isreserved() callback for rawnand will bail out if bbt
> > pointer is not available. But _block_isbad() will continue without
> > checking for it. So this contradicts with the NAND_SKIP_BBTSCAN option
> > since the bad block check will happen anyways (ie., not much difference
> > between scanning for bad blocks and checking each block for bad ones).
> > 
> > Hence, do not check for the bad block if bbt pointer is unavailable.
> 
> Not checking for bad blocks at all feels insane. I don't really get the
> scope and goal of such change?
> 

The issue I encountered is, on the Telit FN980 device one of the
partition seems to be protected. So trying to read the bad blocks in
that partition makes the device to reboot during boot.

There seems to be no flag passed by the parser for this partition. So
the only way I could let the device to boot is to completely skip the
bad block check.

AFAIK, MTD core only supports checking for the reserved blocks to be
used for BBM and there is no way to check for a reserved partition like
this.

I agree that skipping bad block check is not a sane way but I don't know
any other way to handle this problem.

Thanks,
Mani

> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/mtd/nand/raw/nand_base.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> > index c33fa1b1847f..f18cd1db79a9 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -4286,6 +4286,9 @@ static int nand_block_isbad(struct mtd_info *mtd, loff_t offs)
> >  	int chipnr = (int)(offs >> chip->chip_shift);
> >  	int ret;
> >  
> > +	if (!chip->bbt)
> > +		return 0;
> > +
> >  	/* Select the NAND device */
> >  	ret = nand_get_device(chip);
> >  	if (ret)
> 
> Cheers,
> Miqu�l
