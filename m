Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B20316C45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhBJROy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:14:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:41250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232389AbhBJRNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:13:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 728D064D9D;
        Wed, 10 Feb 2021 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612977177;
        bh=IXFAvzAmj3bvyVOKaSl1kuAssl3nq4lfr+/YEDHum6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lAzuVrxqPHD+rKFJux21eUwES82mm3Sn7njP3HK9RNDwoxpc68I2bmrG+glYb/8sz
         ktaI3o/avT8+lc9zDOnZ+ZVyhtGg1XEzW0PGk7Oh+SlnM3wtUIKJi1CJS+9Xai1ANR
         /wa8qugzQ5onLgJXK1ikz22TjLTOKZhUwdP7VcUk=
Date:   Wed, 10 Feb 2021 18:12:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     devel@driverdev.osuosl.org, luk@wybcz.pl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: cleanup macros within
 include/rtw_debug.h
Message-ID: <YCQUFvhKW7rSR6qy@kroah.com>
References: <20210210170003.100880-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210170003.100880-1-phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 05:00:03PM +0000, Phillip Potter wrote:
> Remove do/while loops from DBG_871X, MSG_8192C and DBG_8192C. Also
> fix opening brace placements and trailing single statement layout within
> RT_PRINT_DATA, as well as making newline character placement more
> consistent and removing camel case where possible. Finally, add
> parentheses for DBG_COUNTER definition.
> 
> This fixes 3 checkpatch warnings, 5 checkpatch errors and 3 checkpatch
> checks.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/rtl8723bs/include/rtw_debug.h | 40 +++++++++----------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
> index c90adfb87261..d06ac9540cf7 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_debug.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
> @@ -201,19 +201,16 @@
>  #ifdef DEBUG
>  #if	defined(_dbgdump)
>  	#undef DBG_871X
> -	#define DBG_871X(...)     do {\
> -		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
> -	} while (0)
> +	#define DBG_871X(...)\
> +		_dbgdump(DRIVER_PREFIX __VA_ARGS__)
>  
>  	#undef MSG_8192C
> -	#define MSG_8192C(...)     do {\
> -		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
> -	} while (0)
> +	#define MSG_8192C(...)\
> +		_dbgdump(DRIVER_PREFIX __VA_ARGS__)
>  
>  	#undef DBG_8192C
> -	#define DBG_8192C(...)     do {\
> -		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
> -	} while (0)
> +	#define DBG_8192C(...)\
> +		_dbgdump(DRIVER_PREFIX __VA_ARGS__)

Odd, the do/while is correct here, why is checkpatch complaining about
it?

>  #endif /* defined(_dbgdump) */
>  #endif /* DEBUG */
>  
> @@ -235,25 +232,26 @@
>  
>  #if	defined(_dbgdump)
>  	#undef RT_PRINT_DATA
> -	#define RT_PRINT_DATA(_Comp, _Level, _TitleString, _HexData, _HexDataLen)			\
> -		if (((_Comp) & GlobalDebugComponents) && (_Level <= GlobalDebugLevel))	\
> -		{									\
> +	#define RT_PRINT_DATA(_comp, _level, _title_string, _hex_data, _hex_data_len)		\
> +	do {											\
> +		if (((_comp) & GlobalDebugComponents) && ((_level) <= GlobalDebugLevel)) {	\
>  			int __i;								\

This is not the same as the above stuff, when you find yourself writing
"also" in a changelog text, that's a huge hint you should break the
patch up into a patch series.

Please do that here, this is too much for one patch.

thanks,

greg k-h
