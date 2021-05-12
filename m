Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1341137B604
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 08:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhELGZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 02:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhELGZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 02:25:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8950561925;
        Wed, 12 May 2021 06:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620800671;
        bh=3TcRa33K/NKOSBtkiULfYg595iLod8JVM7DZRu7oqcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1b1EuxAwFNg+ROt+RhwezcnnwykVsdNNunrVHlHeFBC98NCQ+1D5v2AzvacYUcKLa
         Q+akqB7gFspXDaXRzq7wOpWSQuiv8+1/lV0QgpntwudFx5AC3B4mev4gTTrD9V0Aoa
         WLy+HdgqjhRsqVcJZYRA7Vk/KrfZsrYYRCigaWRY=
Date:   Wed, 12 May 2021 08:24:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: alcor_pci: fix null-ptr-deref when there is no
 PCI bridge
Message-ID: <YJt0nI8lG+2juL5S@kroah.com>
References: <YJrFib6BD8JcX3DM@kroah.com>
 <20210511212937.1269191-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511212937.1269191-1-ztong0001@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 05:29:38PM -0400, Tong Zhang wrote:
> Device might be attached to root complex directly. In this case,
> bus->self(bridge) will be NULL, so we'd better check before use it
> 
> [    1.246492] BUG: kernel NULL pointer dereference, address: 00000000000000c0
> [    1.248731] RIP: 0010:pci_read_config_byte+0x5/0x40
> [    1.253998] Call Trace:
> [    1.254131]  ? alcor_pci_find_cap_offset.isra.0+0x3a/0x100 [alcor_pci]
> [    1.254476]  alcor_pci_probe+0x169/0x2d5 [alcor_pci]
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> Co-Developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: check before calling alcor_pci_find_cap_offset()
> 
>  drivers/misc/cardreader/alcor_pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
> index cd402c89189e..175c6b06f7aa 100644
> --- a/drivers/misc/cardreader/alcor_pci.c
> +++ b/drivers/misc/cardreader/alcor_pci.c
> @@ -139,6 +139,9 @@ static void alcor_pci_init_check_aspm(struct alcor_pci_priv *priv)
>  	u32 val32;
>  
>  	priv->pdev_cap_off    = alcor_pci_find_cap_offset(priv, priv->pdev);
> +
> +	if (!priv->parent_pdev)
> +		return;

That feels wrong, you just prevented all of the remaining logic in this
call to not be set up.  Did you test this and did the driver and device
still work properly if it hits this check?

thanks,

greg k-h
