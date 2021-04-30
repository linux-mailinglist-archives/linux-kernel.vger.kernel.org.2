Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E0736F668
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhD3HaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhD3HaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:30:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B005613B3;
        Fri, 30 Apr 2021 07:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619767757;
        bh=UOwbjp9n6THAwLNXnYFCjvVARM6laoU+YRJMD42KQK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gU4BEDg0/+ToTZ2RLKPtxpLCkg1nhxGnQ8RspU3df5YPn62XPsoMgFcKABoGFTnx7
         YUIfcIP6MgesZP9FsgkR7YT08dqiAwb8Cv2LhNv2B1USKPFknp/7VsE5Sy+yKcDRVx
         QJFIR5QVt7Lu3Aa5x8NalJDFND8ufOJeLUfFHgdk=
Date:   Fri, 30 Apr 2021 09:29:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 1/3] usb: xhci-mtk: use bitfield instead of bool
Message-ID: <YIuxy9OtlNzq7zwM@kroah.com>
References: <20210430071532.51794-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430071532.51794-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 03:15:30PM +0800, Chunfeng Yun wrote:
> Use bitfield instead of bool in struct

That says what you did, but not why you did it.

Why?

> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/host/xhci-mtk.c | 2 --
>  drivers/usb/host/xhci-mtk.h | 8 ++++----
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index b2058b3bc834..2548976bcf05 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -495,8 +495,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>  			goto put_usb2_hcd;
>  		}
>  		mtk->has_ippc = true;
> -	} else {
> -		mtk->has_ippc = false;

Why did you remove this chunk?  That is not described in the changelog
at all.

thanks,

greg k-h
