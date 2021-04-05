Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4C1353C24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 09:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhDEHDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 03:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231697AbhDEHDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 03:03:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FDC46127A;
        Mon,  5 Apr 2021 07:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617606180;
        bh=MdliucytokSp3MecjDPnzP9QyqT0IQR2NrcOeaanYOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AvNnPD7+YSQoJ7H6oIG30ii5ErPrBPyMzYTmhs9zeORFx8KzCgcwYdflq78cZK3DI
         rLDbow1JAxlJ09qjTMrEUk+yG1qUVLWqrIJqa4BRlM0qd57FLNmNDsrKvUKFjHr7rD
         1TiSWGHdiaIcsH/jpBeL5Oq4uhj4jwKugIi6jOmo=
Date:   Mon, 5 Apr 2021 09:02:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, balbi@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 1/4] usb: dwc3: of-simple: bail probe if no dwc3 child
 node
Message-ID: <YGq2IaygRQaAcLli@kroah.com>
References: <20210401213652.14676-1-jbx6244@gmail.com>
 <20210401213652.14676-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401213652.14676-2-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:36:49PM +0200, Johan Jonker wrote:
> For some of the dwc3-of-simple compatible SoCs we
> don't want to bind this driver to a dwc3 node,
> but bind that node to the 'snps,dwc3' driver instead.
> The kernel has no logic to decide which driver to bind
> to if there are 2 matching drivers, so bail probe if no
> dwc3 child node.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  drivers/usb/dwc3/dwc3-of-simple.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index 71fd620c5..8d3baa5df 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -38,6 +38,10 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  
>  	int			ret;
>  
> +	/* Bail probe if no dwc3 child node. */
> +	if (!of_get_compatible_child(dev->of_node, "snps,dwc3"))
> +		return -ENODEV;

Why is this part of the "convert to yaml" patch series?  Shouldn't this
be a separate, independant patch?

thanks,

greg k-h
