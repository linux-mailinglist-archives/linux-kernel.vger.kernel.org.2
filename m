Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A96399D8E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhFCJTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhFCJTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:19:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85CCA613B1;
        Thu,  3 Jun 2021 09:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622711890;
        bh=WqviaEw0MhFnTIUiBpw9FNDr4EIuI8nWVOUPL+95mXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7f4gM7GCEjZS6LKqPXsf0wIuLgS+ELxRJRwFwN9HEY42VlPVtvIvGOjutKRoIV7l
         F0K2tSZ9t2ptxpokANes81IHcQSKplrzqOD1bojZ/s4Qfzq36wo2x5XE1P5ylscG6n
         SO4ly2QA5z8G3SE/4/wi1TRM3mHsQOgXyqxvEGd4=
Date:   Thu, 3 Jun 2021 11:18:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Qiang Ma <maqianga@uniontech.com>,
        Marco Cesati <marcocesati@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: core: fix some incorrect type
 warnings
Message-ID: <YLieT3W39eSdwNZr@kroah.com>
References: <1622708703-8561-1-git-send-email-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622708703-8561-1-git-send-email-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 04:24:59PM +0800, Wan Jiabing wrote:
> Fix some "incorrect type in assignment" in rtw_security.c.
> 
> The sparse warings:
> drivers/staging//rtl8723bs/core/rtw_security.c:72:50: warning: incorrect type in assignment
> drivers/staging//rtl8723bs/core/rtw_security.c:72:50:    expected restricted __le32 [usertype]
> drivers/staging//rtl8723bs/core/rtw_security.c:72:50:    got unsigned int
> drivers/staging//rtl8723bs/core/rtw_security.c:80:50: warning: incorrect type in assignment
> drivers/staging//rtl8723bs/core/rtw_security.c:80:50:    expected restricted __le32 [usertype]
> drivers/staging//rtl8723bs/core/rtw_security.c:80:50:    got unsigned int
> drivers/staging//rtl8723bs/core/rtw_security.c:124:33: warning: cast to restricted __le32
> drivers/staging//rtl8723bs/core/rtw_security.c:509:58: warning: incorrect type in assignment
> drivers/staging//rtl8723bs/core/rtw_security.c:509:58:    expected restricted __le32 [usertype]
> drivers/staging//rtl8723bs/core/rtw_security.c:509:58:    got unsigned int
> drivers/staging//rtl8723bs/core/rtw_security.c:517:58: warning: incorrect type in assignment
> drivers/staging//rtl8723bs/core/rtw_security.c:517:58:    expected restricted __le32 [usertype]
> drivers/staging//rtl8723bs/core/rtw_security.c:517:58:    got unsigned int
> drivers/staging//rtl8723bs/core/rtw_security.c:621:41: warning: cast to restricted __le32
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index a99f439..4760999 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -36,7 +36,7 @@ const char *security_type_str(u8 value)
>  void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  {																	/*  exclude ICV */
>  
> -	unsigned char crc[4];
> +	u8 crc[4];

Why change this?

>  
>  	signed int	curfragnum, length;
>  	u32 keylength;
> @@ -69,7 +69,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  
>  				length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
>  
> -				*((__le32 *)crc) = ~crc32_le(~0, payload, length);
> +				*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length));

Are you sure this does what you think it does?

What exactly is this doing now?

>  
>  				arc4_setkey(ctx, wepkey, 3 + keylength);
>  				arc4_crypt(ctx, payload, payload, length);
> @@ -77,7 +77,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  
>  			} else {
>  				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
> -				*((__le32 *)crc) = ~crc32_le(~0, payload, length);
> +				*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length));
>  				arc4_setkey(ctx, wepkey, 3 + keylength);
>  				arc4_crypt(ctx, payload, payload, length);
>  				arc4_crypt(ctx, payload + length, crc, 4);
> @@ -121,7 +121,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
>  		arc4_crypt(ctx, payload, payload,  length);
>  
>  		/* calculate icv and compare the icv */
> -		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> +		*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length - 4));

This odd casting feels wrong, why is it correct now?

thanks,

greg k-h
