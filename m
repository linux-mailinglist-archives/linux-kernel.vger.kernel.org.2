Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206C63C70BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 14:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhGMMxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 08:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236135AbhGMMxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:53:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18FC560E08;
        Tue, 13 Jul 2021 12:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626180650;
        bh=xhnvDq97WUasYvJzd+6FvodbPY+APIjpa2otRQhsHCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KpaDFPjPh4yAgP3oI1soc9SANB16fRdYZSfNk/3OT2ooQJLMVqIY9zWhB8il/Bs3z
         lJGGEXclCDm/uQhs62CfbAJv/OCKTimu6MUmcKPc/F/A6KVCwcEkYlk1AlFM4LE0qW
         yCealiMIH+lwGuWtpHsz0TrcNmM38YlIpMWWtrv4=
Date:   Tue, 13 Jul 2021 14:50:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Replace a custom function with
 crc32_le()
Message-ID: <YO2MJ97grAbMQ1ms@kroah.com>
References: <20210701133809.26534-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701133809.26534-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 03:38:09PM +0200, Fabio M. De Francesco wrote:
> Use crc32_le in place of the custom getcrc32. This change makes GCC
> to warn about incorrect castings to the restricted type __le32, but
> they can be safely ignored because crc32_le calculates bitwise
> little-endian Ethernet AUTODIN II CRC32.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_security.c | 22 ++++---------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
> index 1b2cb6196463..5f010cb66970 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_security.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_security.c
> @@ -111,21 +111,6 @@ static void crc32_init(void)
>  	bcrc32initialized = 1;
>  }
>  
> -static __le32 getcrc32(u8 *buf, int len)
> -{
> -	u8 *p;
> -	u32  crc;
> -
> -	if (bcrc32initialized == 0)
> -		crc32_init();
> -
> -	crc = 0xffffffff;       /* preload shift register, per CRC-32 spec */
> -
> -	for (p = buf; len > 0; ++p, --len)
> -		crc = crc32_table[(crc ^ *p) & 0xff] ^ (crc >> 8);
> -	return cpu_to_le32(~crc);    /* transmit complement, per CRC-32 spec */
> -}
> -
>  /* Need to consider the fragment  situation */
>  void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
>  {
> @@ -609,14 +594,15 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
>  
>  				if ((curfragnum + 1) == pattrib->nr_frags) {	/* 4 the last fragment */
>  					length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
> -					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
> +					*((__le32 *)crc) = ~crc32_le(~0, payload, length);

Why are you casting a native endian return value to a little endian
pointer?  Are you _SURE_ that is correct?

We can not just ignore warnings, they are there for a reason.  Or if
not, then fix the code up to not have the warnings, but I can't take
this as-is, sorry.

thanks,

greg k-h
