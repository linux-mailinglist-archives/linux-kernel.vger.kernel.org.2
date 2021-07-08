Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4823C1912
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 20:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhGHSSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 14:18:34 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46650 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbhGHSSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 14:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=aX6j6wV645lyKvbGF6341srpQQruCbkhUKywWbI56k4=; b=dO2DetIU9aB0IBUQhn7MFNEtgX
        psdHvdAM/YSNbDx9rBK4lduuOUaWteEynxFSkX8Wu3ROUuVCJj3b/D8zhzRfCQOwcS5e0Yuk9rdU/
        Fs7pxszFt/DYEv/8rEIKgZ6BdP9DsIp0USIPoTEbaQHh20IO55H5Qhp2CMdiytocnj3I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1m1YYs-00CfcR-Cc; Thu, 08 Jul 2021 20:15:46 +0200
Date:   Thu, 8 Jul 2021 20:15:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] drivers: atm: Follow the indentation coding
 standard on printks
Message-ID: <YOdA0vy58Lr6FPeE@lunn.ch>
References: <2784471.e9J7NaK4W3@iron-maiden>
 <5630870.MhkbZ0Pkbq@iron-maiden>
 <YOceNJYQJiPh3qhc@lunn.ch>
 <108389762.nniJfEyVGO@iron-maiden>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <108389762.nniJfEyVGO@iron-maiden>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
> index bc8e8d9f176b..8a3ee51e6c9f 100644
> --- a/drivers/atm/iphase.c
> +++ b/drivers/atm/iphase.c
> @@ -1246,8 +1246,8 @@ static void rx_intr(struct atm_dev *dev)
>                 ((iadev->rx_pkt_cnt - iadev->rx_tmp_cnt) == 0)) {
>          for (i = 1; i <= iadev->num_rx_desc; i++)
>                 free_desc(dev, i);
> -printk("Test logic RUN!!!!\n");
> -        writew( ~(RX_FREEQ_EMPT|RX_EXCP_RCVD),iadev->reass_reg+REASS_MASK_REG);
> +        printk("Test logic RUN!!!!\n");
> + 	writew( ~(RX_FREEQ_EMPT|RX_EXCP_RCVD),iadev->reass_reg+REASS_MASK_REG);
>          iadev->rxing = 1;
>       }

It looks like you turned a set of spaces into a tab for the writew()
line. Please don't make such whitespace changes in the same patch as
other changes.

Yes, lots of things to learn before you get your first patch accepted...

>> +++ b/drivers/atm/zatm.c
> @@ -664,7 +644,7 @@ static int do_tx(struct sk_buff *skb)
>  		EVENT("dsc (0x%lx)\n",(unsigned long) dsc,0);
>  	}
>  	else {
> -printk("NONONONOO!!!!\n");
> +		printk("NONONONOO!!!!\n");
>  		dsc = NULL;

This seems like an error message. So maybe

     pr_err("NONONONOO!!!!\n");

These ATM drivers don't appear to be netdev drivers. There does not
appear to be a struct device available, so you have to fall back to
pr_err(), pr_info() etc.

	  Andrew
