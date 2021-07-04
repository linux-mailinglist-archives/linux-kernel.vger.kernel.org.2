Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5A33BAE96
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 21:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhGDTH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 15:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhGDTH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 15:07:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54D20613E9;
        Sun,  4 Jul 2021 19:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625425519;
        bh=bgdsGMGObAW9A8lFULBXiXD9rfyq549JYTnGdEJu5GY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxppQv6L4RNDicDM8PV+dZSHvSE07/yl5DceRZdDnrdeEBQa5BZt11Q6EUX9jt2oD
         cN//+GGjOT/EefoqEdwl6ZLGYMviYh6/mdhp5oWB7OJbGtMP/QdLjdcGb7OLIHrc4d
         VbTn9whwlLvVnh2IFJW0vsw0zpIj1qkp84Qj/74A=
Date:   Sun, 4 Jul 2021 21:05:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jhih-Ming Huang <fbihjmeric@gmail.com>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        maqianga@uniontech.com, marcocesati@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7] rtw_security: fix cast to restricted __le32
Message-ID: <YOIGbc2ymnWrThVK@kroah.com>
References: <bdc0c31a7d28426995d229eb9014cd2b@AcuMS.aculab.com>
 <20210704103112.76962-1-fbihjmeric@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704103112.76962-1-fbihjmeric@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2021 at 06:31:12PM +0800, Jhih-Ming Huang wrote:
> This patch fixes the sparse warning of fix cast to restricted __le32.
> 
> There was a change for replacing private CRC-32 routines with in kernel
> ones.
> However, the author used le32_to_cpu to convert crc32_le(), and we
> should use cpu_to_le32.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jhih-Ming Huang <fbihjmeric@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index a99f439328f1..ff79e1aacd1a 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -92,7 +92,6 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
>  {
>  	/*  exclude ICV */
> -	u8 crc[4];
>  	signed int	length;
>  	u32 keylength;
>  	u8 *pframe, *payload, *iv, wepkey[16];
> @@ -119,10 +118,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
>  		/* decrypt payload include icv */
>  		arc4_setkey(ctx, wepkey, 3 + keylength);
>  		arc4_crypt(ctx, payload, payload,  length);
> -
> -		/* calculate icv and compare the icv */
> -		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> -
>  	}
>  }
>  
> @@ -537,7 +532,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>  	u32 pnh;
>  	u8   rc4key[16];
>  	u8   ttkey[16];
> -	u8 crc[4];
> +	__le32 crc;
>  	signed int			length;
>  
>  	u8 *pframe, *payload, *iv, *prwskey;
> @@ -618,10 +613,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>  			arc4_setkey(ctx, rc4key, 16);
>  			arc4_crypt(ctx, payload, payload, length);
>  
> -			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> +			crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
>  
> -			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
> -			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
> +			if (crc != get_unaligned_le32(payload + length - 4))
>  				res = _FAIL;
>  		} else {
>  			res = _FAIL;
> -- 
> 2.32.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
