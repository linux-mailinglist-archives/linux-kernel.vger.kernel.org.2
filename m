Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B72367CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhDVIlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbhDVIlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:41:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05FD06144A;
        Thu, 22 Apr 2021 08:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619080871;
        bh=2yGywPrUo03vY3xZ2R6XXxLg61x7f9ucCEmvSGTQvq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpRtIyWz2n6iB1jjXRjLpP1DajsQ3Lz8VfrJBWbhqOoMRB9llhX4IlZGOleZV+649
         hUUr6WxQ0Xe1jIYobqaK3SfDtPy6Di5vWq0/XhDlLon9Y+JOXaNvQafLI4BAXZaubA
         3XuUN8sP5rtLTXjLoWzEIHtQa8VYCTxp1PEBuBcg=
Date:   Thu, 22 Apr 2021 10:41:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     fabioaiuto83@gmail.com, john.oldman@polehill.co.uk,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: remove unneeded variable ret
Message-ID: <YIE2o/T9rKgm7TWm@kroah.com>
References: <20210418164813.GA57451@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418164813.GA57451@user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 10:18:13PM +0530, Saurav Girepunje wrote:
> Fix the following coccicheck warning:
> 
> drivers/staging/rtl8723bs/os_dep/os_intfs.c:1156:5-8:
> Unneeded variable: "ret". Return "0" on line 1199
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@google.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/os_intfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> index 1f34cb2e367c..920ec25c9a4f 100644
> --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> @@ -1153,7 +1153,6 @@ int rtw_suspend_common(struct adapter *padapter)
>  	struct pwrctrl_priv *pwrpriv = dvobj_to_pwrctl(psdpriv);
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  
> -	int ret = 0;
>  	unsigned long start_time = jiffies;
>  
>  	DBG_871X_LEVEL(_drv_always_, " suspend start\n");
> @@ -1196,7 +1195,7 @@ int rtw_suspend_common(struct adapter *padapter)
>  
>  exit:
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int rtw_resume_process_normal(struct adapter *padapter)
> -- 
> 2.25.1
> 
> 

If this function can only ever return 0, why is it returning anything at
all?  Please fix it up to not do that.

thanks,

greg k-h
