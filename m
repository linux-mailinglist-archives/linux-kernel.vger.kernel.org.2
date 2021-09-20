Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662A04113C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhITLuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235612AbhITLus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:50:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 671DA6108C;
        Mon, 20 Sep 2021 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632138562;
        bh=BjroITAddm7I+ffIPTRs/UzUiie3IMgyS+DyuPVzNyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIEcny45rYiZOxoXmZ2hSdyTXf10UHv+a8FsaHKU82XN23/wvuIGsjsuicARjmW2T
         zmIzNDEJAnNAVjsImFEL+aWhNfMsddj7JRHCpXnNxLYDdcfJtqTHzLDXix0On4CD+H
         BkxhZ4dC7N7ihBJjiNeibT8zt9Uf7063B3zX7pKY=
Date:   Mon, 20 Sep 2021 13:49:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 08/19] staging: r8188eu: fix grammar mistake in
 usbctrl_vendorreq()
Message-ID: <YUh1P+AojRvILcP2@kroah.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
 <20210919235356.4151-9-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919235356.4151-9-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:53:45AM +0200, Fabio M. De Francesco wrote:
> Fix a grammar mistake in usbctrl_vendorreq(): "checksumed" =>
> "checksummed".
> 
> Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index fc3da0fbf474..3ca2959f4bcd 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -85,7 +85,7 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
>  
>  		}
>  
> -		/*  firmware download is checksumed, don't retry */
> +		/*  firmware download is checksummed, don't retry */

When touching this line, also remove the leading ' ' characters in the
comment that are not needed please.

thanks,

greg k-h
