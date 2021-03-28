Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A334BC47
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 14:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhC1MKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 08:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhC1MKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 08:10:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D72056195F;
        Sun, 28 Mar 2021 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616933406;
        bh=+YouyFeYmPrfjBr6cbnwvnPxSqWMJ1ubUecHxczCmY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SqnsOdPngr9u8D74ogFk0zsCECn138a1AmR9l7qkQyTE345xBoJBQXiLtcy50/gi4
         S23vdnvS8/0ZfxgkU4VgXUqqcNss93hf4qRf+0B+O2gD8utqHC3upsRLiEK+hWFPjt
         B3RrtkWai8ckl6zqKesvOmHaf/mDr33Klk3zs0Ow=
Date:   Sun, 28 Mar 2021 14:10:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/20] staging: rtl8723bs: include macro in a do -
 while loop in core/rtw_security.c
Message-ID: <YGByG/9r6yoylXJE@kroah.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
 <0f176b08b7a49d6649ff9d5468bd912e58c1db06.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f176b08b7a49d6649ff9d5468bd912e58c1db06.1616854134.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 03:24:18PM +0100, Fabio Aiuto wrote:
> fix the following checkpatch warning:
> 
> ERROR: Macros with multiple statements should be enclosed
> in a do - while loop
> 2014: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:2014:
> +#define ROUND(i, d, s) \
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index 0ddd7667a986..8a447e149438 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -2012,10 +2012,12 @@ static void rijndaelEncrypt(u32 rk[/*44*/], u8 pt[16], u8 ct[16])
>  	s3 = GETU32(pt + 12) ^ rk[3];
>  
>  #define ROUND(i, d, s) \
> -d##0 = TE0(s##0) ^ TE1(s##1) ^ TE2(s##2) ^ TE3(s##3) ^ rk[4 * i]; \
> -d##1 = TE0(s##1) ^ TE1(s##2) ^ TE2(s##3) ^ TE3(s##0) ^ rk[4 * i + 1]; \
> -d##2 = TE0(s##2) ^ TE1(s##3) ^ TE2(s##0) ^ TE3(s##1) ^ rk[4 * i + 2]; \
> -d##3 = TE0(s##3) ^ TE1(s##0) ^ TE2(s##1) ^ TE3(s##2) ^ rk[4 * i + 3]
> +	do { \
> +		d##0 = TE0(s##0) ^ TE1(s##1) ^ TE2(s##2) ^ TE3(s##3) ^ rk[4 * i]; \
> +		d##1 = TE0(s##1) ^ TE1(s##2) ^ TE2(s##3) ^ TE3(s##0) ^ rk[4 * i + 1]; \
> +		d##2 = TE0(s##2) ^ TE1(s##3) ^ TE2(s##0) ^ TE3(s##1) ^ rk[4 * i + 2]; \
> +		d##3 = TE0(s##3) ^ TE1(s##0) ^ TE2(s##1) ^ TE3(s##2) ^ rk[4 * i + 3]; \
> +	} while (0)

Why is this code not using the in-kernel crypto code instead?  I'll take
this but that should be something that is done to this code
eventually...

thanks,

greg k-h
