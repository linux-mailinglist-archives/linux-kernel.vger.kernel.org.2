Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81903401062
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbhIEOtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 10:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhIEOtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 10:49:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E839E60F5E;
        Sun,  5 Sep 2021 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630853286;
        bh=Ml6h4k7pc7nhRrmhLJIKHEX5HhqaFagSdme0GwtDJWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3FwZ5JGx5uDlYlbF26JN9f2eJdulDA8fw1YIntCNoFowXdZ20MDmF+t7ETAPSc7P
         uDgkzU29g0S89ZgF7jcumMIP17S9dGnyLROmstyfXAkSgtwcZXgFYL/yJUtrKGnGU/
         fv8giwbl7IrxDQA7+C1h+6WhFy808Mwzx9oeJBbk=
Date:   Sun, 5 Sep 2021 16:48:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx, nathan@kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH v2] staging: r8188eu: os_dep: simplifiy the rtw_resume
 function
Message-ID: <YTTYo2BSG/JTuijx@kroah.com>
References: <YTNjNLcNvPfD9+5Z@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTNjNLcNvPfD9+5Z@user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2021 at 05:44:44PM +0530, Saurav Girepunje wrote:
> Remove unused variable ret and pwrpriv.
> Remove the condition with no effect (if == else) in usb_intf.c
> file.
> Remove rtw_resume_process() and move whole thing to rtw_resume().
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
> 
> ChangeLog V2:
> - Remove rtw_resume_process() and move whole thing to rtw_resume().
> ---
>  drivers/staging/r8188eu/include/usb_osintf.h |  2 --
>  drivers/staging/r8188eu/os_dep/usb_intf.c    | 12 ------------
>  2 files changed, 14 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/usb_osintf.h b/drivers/staging/r8188eu/include/usb_osintf.h
> index d1a1f739309c..34229b1cb081 100644
> --- a/drivers/staging/r8188eu/include/usb_osintf.h
> +++ b/drivers/staging/r8188eu/include/usb_osintf.h
> @@ -24,6 +24,4 @@ void *scdb_findEntry(struct adapter *priv, unsigned char *macAddr,
>  void nat25_db_expire(struct adapter *priv);
>  int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method);
> 
> -int rtw_resume_process(struct adapter *padapter);
> -
>  #endif
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index bb85ab77fd26..77b03e7631b7 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -493,18 +493,6 @@ static int rtw_resume(struct usb_interface *pusb_intf)
>  {
>  	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
>  	struct adapter *padapter = dvobj->if1;
> -	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
> -	int ret = 0;
> -
> -	if (pwrpriv->bInternalAutoSuspend)
> -		ret = rtw_resume_process(padapter);
> -	else
> -		ret = rtw_resume_process(padapter);
> -	return ret;
> -}
> -
> -int rtw_resume_process(struct adapter *padapter)
> -{
>  	struct net_device *pnetdev;
>  	struct pwrctrl_priv *pwrpriv = NULL;
>  	int ret = -1;

You can also remove the test for padapter being NULL in this function,
as you just proved it could never be null otherwise the above function
you removed would have crashed, right?  You should do that all at once
so we remember why that test was removed.

thanks,

greg k-h
