Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A654197D3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbhI0P0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235132AbhI0P0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:26:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5B4760F91;
        Mon, 27 Sep 2021 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632756285;
        bh=7/Q3pvm2QgnHLGYBpQKosCV/ZKLrIZKjoJ2FMEa+HaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3lf4pOo0vn5KdjvqRvgs18pnoGF59KlTByLSWc2cM5ujEggrUxXquaqdEgTkQ4PY
         2y9wM+Zt8nWnunj+wNABAJyvSGfwU4fMJxygMDLCiQ1efXDa4d5h1s5gvNvsJBGAeF
         YsaER5oE5cizWHy1vCwukVOBEm+OuhYw3Vnc/q7Q=
Date:   Mon, 27 Sep 2021 17:24:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longji Guo <guolongji@uniontech.com>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, hdegoede@redhat.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove meaningless pstat->passoc_req
 check in OnAssocReq()
Message-ID: <YVHiOsvON03xHxui@kroah.com>
References: <20210927033056.27503-1-guolongji@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927033056.27503-1-guolongji@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:30:56AM +0800, Longji Guo wrote:
> kfree(NULL) is safe and the check 'if (pstat->passoc_req)' before kfree
> is not necessary.
> 
> Signed-off-by: Longji Guo <guolongji@uniontech.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 375d2a742dd2..a46ab97524aa 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -1344,11 +1344,9 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
>  			issue_asocrsp(padapter, status, pstat, WIFI_REASSOCRSP);
>  
>  		spin_lock_bh(&pstat->lock);
> -		if (pstat->passoc_req) {
> -			kfree(pstat->passoc_req);
> -			pstat->passoc_req = NULL;
> -			pstat->assoc_req_len = 0;
> -		}
> +		kfree(pstat->passoc_req);
> +		pstat->passoc_req = NULL;
> +		pstat->assoc_req_len = 0;
>  
>  		pstat->passoc_req =  rtw_zmalloc(pkt_len);
>  		if (pstat->passoc_req) {
> -- 
> 2.20.1
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
