Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA224461A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 10:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhKEJy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 05:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232926AbhKEJyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 05:54:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F2D261244;
        Fri,  5 Nov 2021 09:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636105935;
        bh=w/GVcEOxMPFyEJIF3yroSEVnpOUUdFNp520ko3d1cXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RaR0qjLJAoRDTnI2yPpKe5MDAHdJA+nsB9zms+N08RT+nK2q4a3CJVkzPJ70Qcy4B
         sEm8UNawNgLvse88A3XWocyUENjENxbRdwtxEiZ4lfLEV3HR5Mlc6wrxwghUuT61Ay
         0zMsgNgq1Bg4Al3DnOAp+BAkclgwpT/gPOLUF4Fc=
Date:   Fri, 5 Nov 2021 10:52:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     hoshinomorimorimo@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Remove redundant indentation
Message-ID: <YYT+zNJ1synjMCib@kroah.com>
References: <6180f31a.1c69fb81.7f7e.541c@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6180f31a.1c69fb81.7f7e.541c@mx.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 04:12:59PM +0800, hoshinomorimorimo@gmail.com wrote:
> From: Hoshinomori-Owari <hoshinomorimorimo@gmail.com>
> 
> Remove redundant indentation in
> drivers/staging/rtl8723bs/core/rtw_ap.c:1139.
> Issue found by checkpatch.pl
> 
> Signed-off-by: Hoshinomori-Owari <hoshinomorimorimo@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index a76e81330756..4345dca1b552 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -1137,7 +1137,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  		}
>  
>  		if ((p == NULL) || (ie_len == 0))
> -				break;
> +			break;
>  	}
>  
>  	/* wmm */
> -- 
> 2.31.1

This does not apply to my tree (or Linus's tree) at all.  Always make
sure you work against linux-next so you do not duplicate other people's
work that has already been done.

thanks,

greg k-h
