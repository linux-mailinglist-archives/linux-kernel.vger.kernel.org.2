Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D250D37F9DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhEMOnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:43:23 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40517 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234559AbhEMOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:43:17 -0400
Received: (qmail 968956 invoked by uid 1000); 13 May 2021 10:42:06 -0400
Date:   Thu, 13 May 2021 10:42:06 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Gopalakrishnan Santhanam <gsanthan@cisco.com>
Cc:     danielwa@cisco.com, hramdasi@cisco.com,
        christian.engelmayer@frequentis.com, xe-linux-external@cisco.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fsl-usb: add need_oc_pp_cycle flag for 85xx also
Message-ID: <20210513144206.GG967812@rowland.harvard.edu>
References: <20210507172300.3075939-1-danielwa@cisco.com>
 <20210513083225.68912-1-gsanthan@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513083225.68912-1-gsanthan@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 02:02:25PM +0530, Gopalakrishnan Santhanam wrote:
> Commit e6604a7fd71f9 ("EHCI: Quirk flag for port power handling
> on overcurrent.") activated the quirks handling (flag need_oc_pp_cycle)
> for Freescale 83xx based boards.
> Activate same for 85xx based boards as well.
> 
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Gopalakrishnan Santhanam <gsanthan@cisco.com>
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ehci-fsl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index 6f7bd6641694..385be30baad3 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -387,11 +387,11 @@ static int ehci_fsl_setup(struct usb_hcd *hcd)
>  	/* EHCI registers start at offset 0x100 */
>  	ehci->caps = hcd->regs + 0x100;
>  
> -#ifdef CONFIG_PPC_83xx
> +#if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_85xx)
>  	/*
> -	 * Deal with MPC834X that need port power to be cycled after the power
> -	 * fault condition is removed. Otherwise the state machine does not
> -	 * reflect PORTSC[CSC] correctly.
> +	 * Deal with MPC834X/85XX that need port power to be cycled
> +	 * after the power fault condition is removed. Otherwise the
> +	 * state machine does not reflect PORTSC[CSC] correctly.
>  	 */
>  	ehci->need_oc_pp_cycle = 1;
>  #endif
> -- 
> 2.26.2.Cisco
> 
