Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072AF37698B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 19:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhEGRiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 13:38:01 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44615 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231745AbhEGRiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 13:38:00 -0400
Received: (qmail 784164 invoked by uid 1000); 7 May 2021 13:36:59 -0400
Date:   Fri, 7 May 2021 13:36:59 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     HEMANT RAMDASI <hramdasi@cisco.com>,
        Christian Engelmayer <christian.engelmayer@frequentis.com>,
        Gopalakrishnan Santhanam <gsanthan@cisco.com>,
        xe-linux-external@cisco.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsl-usb: add need_oc_pp_cycle flag for 85xx also
Message-ID: <20210507173659.GA784066@rowland.harvard.edu>
References: <20210507172300.3075939-1-danielwa@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507172300.3075939-1-danielwa@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 10:23:00AM -0700, Daniel Walker wrote:
> From: Gopalakrishnan Santhanam <gsanthan@cisco.com>
> 
> Commit e6604a7fd71f9 ("EHCI: Quirk flag for port power handling on overcurrent.")
> activated the quirks handling (flag need_oc_pp_cycle) for Freescale 83xx
> based boards.
> Activate same for 85xx based boards as well.
> 
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Gopalakrishnan Santhanam <gsanthan@cisco.com>
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---
>  drivers/usb/host/ehci-fsl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index 6f7bd6641694..c7d74c1a23f5 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -387,7 +387,7 @@ static int ehci_fsl_setup(struct usb_hcd *hcd)
>  	/* EHCI registers start at offset 0x100 */
>  	ehci->caps = hcd->regs + 0x100;
>  
> -#ifdef CONFIG_PPC_83xx
> +#if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_85xx)
>  	/*
>  	 * Deal with MPC834X that need port power to be cycled after the power
-------------------------^

Shouldn't this comment be changed as well?

Alan Stern

>  	 * fault condition is removed. Otherwise the state machine does not
> -- 
> 2.25.1
> 
