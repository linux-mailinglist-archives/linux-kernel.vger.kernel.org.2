Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD44394C07
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 13:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhE2L16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 07:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhE2L15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 07:27:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58A1E61284;
        Sat, 29 May 2021 11:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622287580;
        bh=kmI/gnz+w3lRX666nc7l7KP6GPGuXS6lcDeSQh1DVuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHFvYT83qlx0kVABFOgEvb7SSD5lJU8ejEL2+goR7iaHzxaZ888ZGOVF91CgI/R5Z
         zdGmvJGLFj0EWQnbqZMyiT4vrCVS8NxoZgRBJ6vAjQ9yhg35xYN4zjxxTJgHrMsWJ8
         ky8inNSbo6vUBxGReXxyd/jVuNa/Iac1IcZdsRko=
Date:   Sat, 29 May 2021 13:26:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     fabioaiuto83@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH V2] staging: rtl8723bs: core: rtw_mlme_ext.c: remove
 deadcode
Message-ID: <YLIk2aE3vE3Vr1E8@kroah.com>
References: <20210529100137.GA1416@agape.jhs>
 <20210529102431.3173753-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210529102431.3173753-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 06:24:31PM +0800, Yu Kuai wrote:
> 'CHECK_EVENT_SEQ' is not defined anywhere, remove the deadcode.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 97b3c2965770..2b95a49ab469 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -6006,7 +6006,7 @@ static struct fwevent wlanevents[] = {
>  
>  u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
>  {
> -	u8 evt_code, evt_seq;
> +	u8 evt_code;
>  	u16 evt_sz;
>  	uint	*peventbuf;
>  	void (*event_callback)(struct adapter *dev, u8 *pbuf);
> @@ -6017,19 +6017,8 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
>  
>  	peventbuf = (uint *)pbuf;
>  	evt_sz = (u16)(*peventbuf&0xffff);
> -	evt_seq = (u8)((*peventbuf>>24)&0x7f);
>  	evt_code = (u8)((*peventbuf>>16)&0xff);
>  
> -
> -	#ifdef CHECK_EVENT_SEQ
> -	/*  checking event sequence... */
> -	if (evt_seq != (atomic_read(&pevt_priv->event_seq) & 0x7f)) {
> -		pevt_priv->event_seq = (evt_seq+1)&0x7f;
> -
> -		goto _abort_event_;
> -	}
> -	#endif
> -
>  	/*  checking if event code is valid */
>  	if (evt_code >= MAX_C2HEVT)
>  		goto _abort_event_;
> -- 
> 2.25.4
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
