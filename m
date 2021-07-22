Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCBB3D2AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhGVQOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235148AbhGVQLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:11:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D3AE6052B;
        Thu, 22 Jul 2021 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626972715;
        bh=JHxY2G9vBdeDxHTAdoaoPweCFGidPsKxUDCIIhoKzu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ja0lbdba8Wq7UI1Zo689PACLPuLBf6mhfbS5jERyQ0vQqryfZ3PQDefBcF657yNRg
         azqQmrlhXY4eXVIvme/MUdEeGunc6LRUo7Zk6d8/lXm+wH53BsJdnqCAjl93HSRSmy
         HgKkm991WRK2BcDKaW4Zb3DclysEMStrlSQ6Hu7c=
Date:   Thu, 22 Jul 2021 18:46:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jignesh Patel <jigs0101@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Paul McQuade <paulmcquad@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Line over 100 characters
Message-ID: <YPmhA3JbzlwE66NL@kroah.com>
References: <20210722164144.377781-1-jigs0101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722164144.377781-1-jigs0101@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 10:11:37PM +0530, Jignesh Patel wrote:
> Break various lines into multiple lines to respect 100 character width limit.
> Reported by checkpatch.pl
> 
> Signed-off-by: Jignesh Patel <jigs0101@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_ap.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
> index b817aa8b9de4..b83d6da01b7c 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_ap.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
> @@ -254,9 +254,12 @@ void expire_timeout_chk(struct adapter *padapter)
>  			updated = ap_free_sta(padapter, psta, true,
>  					      WLAN_REASON_DEAUTH_LEAVING);
>  		} else {
> -			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
> +			/** TODO: Aging mechanism to digest frames in

Does this line look correct now?

Please look at how comments are formatted...

thanks,

greg k-h
