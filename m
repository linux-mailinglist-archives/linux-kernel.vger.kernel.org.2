Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EB43C1649
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 17:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhGHPuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 11:50:52 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46408 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232073AbhGHPuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 11:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=idm2824af4WvDweWDAByXt9zmw699TMPDqruecxrjVQ=; b=33ssX0aPQkjpRTibNDxYyAJUEF
        Ma5327BtIUPyz40/ZSKrFWwiFFVNUeYEvTz3rrN+iZDS79niDj6c4+/RmeJLjymkev/EPkPjZJLJB
        LYMzsvQmYm9fWgJFerv1+QSDrgB2OlecLABrsQO32Agg/OnKqg834JfqbwZtyonl2024=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1m1WFw-00CeiP-V6; Thu, 08 Jul 2021 17:48:04 +0200
Date:   Thu, 8 Jul 2021 17:48:04 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: atm: Follow the indentation coding standard on
 printks
Message-ID: <YOceNJYQJiPh3qhc@lunn.ch>
References: <2784471.e9J7NaK4W3@iron-maiden>
 <YOcOWDqlONm69zwo@kroah.com>
 <5630870.MhkbZ0Pkbq@iron-maiden>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5630870.MhkbZ0Pkbq@iron-maiden>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 11:19:19AM -0400, Carlos Bilbao wrote:
> Fix indentation of printks that start at the beginning of the line. Change this 
> for the right number of space characters, or tabs if the file uses them. 
> 
> Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
> ---
> Changelog: Replaced printk for DPRINTK on suni.c
> ---
>  drivers/atm/eni.c                      | 2 +-
>  drivers/atm/iphase.c                   | 2 +-
>  drivers/atm/suni.c                     | 4 ++--
>  drivers/atm/zatm.c                     | 8 ++++----
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
> index 422753d52244..6d10fd62ba7e 100644
> --- a/drivers/atm/eni.c
> +++ b/drivers/atm/eni.c
> @@ -1456,7 +1456,7 @@ static int start_tx(struct atm_dev *dev)
>  
>  static void foo(void)
>  {
> -printk(KERN_INFO
> +  printk(KERN_INFO
>    "tx_complete=%d,dma_complete=%d,queued=%d,requeued=%d,sub=%d,\n"
>    "backlogged=%d,rx_enqueued=%d,rx_dequeued=%d,putting=%d,pushed=%d\n",
>    tx_complete,dma_complete,queued,requeued,submitted,backlogged,

Did you just blindly fix the warning, or look at the surrounding code
and think a bit?

There is the comment:

/* may become useful again when tuning things */

What does git log show? When was the last tuning? When was the last
serious change made to this driver which was not an automated/manual
cleanup? My guess is, you need to go back to at least 2005.

So maybe it is time to remove this #if 0 code?

Please also read

https://www.kernel.org/doc/Documentation/process/submitting-patches.rst

and

https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html

	Andrew
