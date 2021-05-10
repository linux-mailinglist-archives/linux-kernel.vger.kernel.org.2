Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACD837910D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhEJOkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhEJOht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:37:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA3AC61278;
        Mon, 10 May 2021 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620657403;
        bh=mf8DFzyfgaOH7v8vx3Q7uibWS6woT6FrAkjhvPqyz58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toBIj0XzYalOJTP3F0ClgNxp84aoAgoeX2n0tkp0z3ZYQ6CA07V3HpYCynOIhFqk3
         SrxQDMDp+yo4Q3bpDJ2EKdeYC3mIe488HPU+XGGKbjUggOy/5yXx+vq0OehZbarvLX
         MpselLlCHJ3neQnFistSgYFIAPsMM+DFCbUqjfDw=
Date:   Mon, 10 May 2021 16:36:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: alcor_pci: fix null-ptr-deref when there is no PCI
 bridge
Message-ID: <YJlE+Z2VKhamVWaw@kroah.com>
References: <20210426220728.1230340-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426220728.1230340-1-ztong0001@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 06:07:27PM -0400, Tong Zhang wrote:
> the PCI bridge might be NULL, so we'd better check before use it
> 
> [    1.246492] BUG: kernel NULL pointer dereference, address: 00000000000000c0
> [    1.248731] RIP: 0010:pci_read_config_byte+0x5/0x40
> [    1.253998] Call Trace:
> [    1.254131]  ? alcor_pci_find_cap_offset.isra.0+0x3a/0x100 [alcor_pci]
> [    1.254476]  alcor_pci_probe+0x169/0x2d5 [alcor_pci]
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/misc/cardreader/alcor_pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
> index cd402c89189e..1c33453fd5c7 100644
> --- a/drivers/misc/cardreader/alcor_pci.c
> +++ b/drivers/misc/cardreader/alcor_pci.c
> @@ -102,6 +102,9 @@ static int alcor_pci_find_cap_offset(struct alcor_pci_priv *priv,
>  	u8 val8;
>  	u32 val32;
>  
> +	if (!pci)
> +		return 0;
> +
>  	where = ALCOR_CAP_START_OFFSET;
>  	pci_read_config_byte(pci, where, &val8);
>  	if (!val8)
> -- 
> 2.25.1
> 

I do not understand, how can pci ever be NULL?  There is only 1 way this
function can be called, and it's through the alcor_pci_probe() call,
which should have always set up the parent and pci pointers that get
passed to this function.

How can that not happen?  If it can happen, then something earlier than
this should be fixed instead of papering over the root problem here.

How did you duplicate the crash you list above?

thanks,

greg k-h
