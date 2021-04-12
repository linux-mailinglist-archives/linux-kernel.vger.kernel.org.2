Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EE535C2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbhDLJsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238364AbhDLJeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:34:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 002A261248;
        Mon, 12 Apr 2021 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618220066;
        bh=9s3yiTLRat04T1hmQnybEmXExdwH0wgaqtOSw/eug/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=11Mojb249CyZdYFjl9AKDPyVnJtYa23EDXU1Q+L4H+/1nMYc7cfqapkDjauXxDE+N
         F9vklIMKQBdDcHPHDIwL/ivb6tNb/GR+7PeFPRWFjEFuY6vmvFsk1KHOwtlhLomWer
         7c8svJNnlth5B3oPgBGVYA0yo0hPNBSdZdaAlWnw=
Date:   Mon, 12 Apr 2021 11:34:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: rtl8723bs: Use existing arc4 implementation
Message-ID: <YHQUH+Nqc/zS14Tb@kroah.com>
References: <7e16c40d5baa007dca81a12b967a597ed00d8dd7.1618055514.git.christophe.jaillet@wanadoo.fr>
 <6a4aebf9feb9ece975734f2e51da5ecae2996cee.1618055514.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4aebf9feb9ece975734f2e51da5ecae2996cee.1618055514.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 03:35:52PM +0200, Christophe JAILLET wrote:
> Use functions provided by <crypto/arc4.h> instead of hand writing them.
> 
> The implementations are slightly different, but are equivalent. It has
> been checked with a test program which compares the output of the 2 sets of
> functions.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 101 ++++--------------
>  1 file changed, 21 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index 9587d89a6b24..86949a65e96f 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -6,6 +6,7 @@
>   ******************************************************************************/
>  #define  _RTW_SECURITY_C_
>  
> +#include <crypto/arc4.h>
>  #include <linux/crc32poly.h>
>  #include <drv_types.h>
>  #include <rtw_debug.h>
> @@ -31,66 +32,6 @@ const char *security_type_str(u8 value)
>  
>  /* WEP related ===== */
>  
> -struct arc4context {
> -	u32 x;
> -	u32 y;
> -	u8 state[256];
> -};
> -
> -
> -static void arcfour_init(struct arc4context	*parc4ctx, u8 *key, u32 key_len)
> -{
> -	u32 t, u;
> -	u32 keyindex;
> -	u32 stateindex;
> -	u8 *state;
> -	u32 counter;
> -
> -	state = parc4ctx->state;
> -	parc4ctx->x = 0;
> -	parc4ctx->y = 0;
> -	for (counter = 0; counter < 256; counter++)
> -		state[counter] = (u8)counter;
> -	keyindex = 0;
> -	stateindex = 0;
> -	for (counter = 0; counter < 256; counter++) {
> -		t = state[counter];
> -		stateindex = (stateindex + key[keyindex] + t) & 0xff;
> -		u = state[stateindex];
> -		state[stateindex] = (u8)t;
> -		state[counter] = (u8)u;
> -		if (++keyindex >= key_len)
> -			keyindex = 0;
> -	}
> -}
> -
> -static u32 arcfour_byte(struct arc4context	*parc4ctx)
> -{
> -	u32 x;
> -	u32 y;
> -	u32 sx, sy;
> -	u8 *state;
> -
> -	state = parc4ctx->state;
> -	x = (parc4ctx->x + 1) & 0xff;
> -	sx = state[x];
> -	y = (sx + parc4ctx->y) & 0xff;
> -	sy = state[y];
> -	parc4ctx->x = x;
> -	parc4ctx->y = y;
> -	state[y] = (u8)sx;
> -	state[x] = (u8)sy;
> -	return state[(sx + sy) & 0xff];
> -}
> -
> -static void arcfour_encrypt(struct arc4context *parc4ctx, u8 *dest, u8 *src, u32 len)
> -{
> -	u32 i;
> -
> -	for (i = 0; i < len; i++)
> -		dest[i] = src[i] ^ (unsigned char)arcfour_byte(parc4ctx);
> -}
> -
>  static signed int bcrc32initialized;
>  static u32 crc32_table[256];
>  
> @@ -150,7 +91,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  {																	/*  exclude ICV */
>  
>  	unsigned char crc[4];
> -	struct arc4context	 mycontext;
> +	struct arc4_ctx mycontext;

Are you sure you can declare that much space on the stack?  Is that what
other users of this api do?  In looking at the in-kernel users, they do
not :(

Can you fix up this series to not take up so much stack memory?

thanks,

greg k-h
