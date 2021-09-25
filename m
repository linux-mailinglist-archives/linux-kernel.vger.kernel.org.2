Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED74182D0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 16:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245152AbhIYOqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 10:46:49 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52969 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234173AbhIYOqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 10:46:48 -0400
Received: (qmail 309059 invoked by uid 1000); 25 Sep 2021 10:45:13 -0400
Date:   Sat, 25 Sep 2021 10:45:13 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: ehci: Fix a function name in comments
Message-ID: <20210925144513.GA308698@rowland.harvard.edu>
References: <20210925124920.1564-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925124920.1564-1-caihuoqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 08:49:17PM +0800, Cai Huoqing wrote:
> Use dma_map_single() instead of pci_map_single(),
> because only dma_map_single() is called here.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
>  drivers/usb/host/ehci-hcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 144080321629..3d82e0b853be 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -588,7 +588,7 @@ static int ehci_run (struct usb_hcd *hcd)
>  	 * hcc_params controls whether ehci->regs->segment must (!!!)
>  	 * be used; it constrains QH/ITD/SITD and QTD locations.
>  	 * dma_pool consistent memory always uses segment zero.
> -	 * streaming mappings for I/O buffers, like pci_map_single(),
> +	 * streaming mappings for I/O buffers, like dma_map_single(),
>  	 * can return segments above 4GB, if the device allows.
>  	 *
>  	 * NOTE:  the dma mask is visible through dev->dma_mask, so
> -- 
> 2.25.1
> 
