Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F17F3C1476
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhGHNmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:42:53 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59245 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231883AbhGHNmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:42:51 -0400
Received: (qmail 208127 invoked by uid 1000); 8 Jul 2021 09:40:08 -0400
Date:   Thu, 8 Jul 2021 09:40:08 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] USB: EHCI: ehci-mv: improve error handling in
 mv_ehci_enable()
Message-ID: <20210708134008.GA207717@rowland.harvard.edu>
References: <20210708083056.21543-1-novikov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708083056.21543-1-novikov@ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 11:30:56AM +0300, Evgeny Novikov wrote:
> mv_ehci_enable() did not disable and unprepare clocks in case of
> failures of phy_init(). Besides, it did not take into account failures
> of ehci_clock_enable() (in effect, failures of clk_prepare_enable()).
> The patch fixes both issues and gets rid of redundant wrappers around
> clk_prepare_enable() and clk_disable_unprepare() to simplify this a bit.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ehci-mv.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
> index cffdc8d01b2a..8fd27249ad25 100644
> --- a/drivers/usb/host/ehci-mv.c
> +++ b/drivers/usb/host/ehci-mv.c
> @@ -42,26 +42,25 @@ struct ehci_hcd_mv {
>  	int (*set_vbus)(unsigned int vbus);
>  };
>  
> -static void ehci_clock_enable(struct ehci_hcd_mv *ehci_mv)
> +static int mv_ehci_enable(struct ehci_hcd_mv *ehci_mv)
>  {
> -	clk_prepare_enable(ehci_mv->clk);
> -}
> +	int retval;
>  
> -static void ehci_clock_disable(struct ehci_hcd_mv *ehci_mv)
> -{
> -	clk_disable_unprepare(ehci_mv->clk);
> -}
> +	retval = clk_prepare_enable(ehci_mv->clk);
> +	if (retval)
> +		return retval;
>  
> -static int mv_ehci_enable(struct ehci_hcd_mv *ehci_mv)
> -{
> -	ehci_clock_enable(ehci_mv);
> -	return phy_init(ehci_mv->phy);
> +	retval = phy_init(ehci_mv->phy);
> +	if (retval)
> +		clk_disable_unprepare(ehci_mv->clk);
> +
> +	return retval;
>  }
>  
>  static void mv_ehci_disable(struct ehci_hcd_mv *ehci_mv)
>  {
>  	phy_exit(ehci_mv->phy);
> -	ehci_clock_disable(ehci_mv);
> +	clk_disable_unprepare(ehci_mv->clk);
>  }
>  
>  static int mv_ehci_reset(struct usb_hcd *hcd)
> -- 
> 2.26.2
> 
