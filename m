Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D887134BDD7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhC1R5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 13:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231164AbhC1R51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 13:57:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A191361930;
        Sun, 28 Mar 2021 17:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616954247;
        bh=h7lWtpzr+nzRZm5zIxllBaJjD+FGFNmyTDDl8+aq6nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWdGrspgcZd4s0pFLcCeC1CHp1QWXfeRkGjOruxs9P1EQAI5u+zKmgeYn699xv0YM
         i/2IR7pvK+PNrYnRbj5Me9s1CsVJHMRD/44yYzz0L12lvqiORm7QbixxA1edgjkASr
         bXaf6H0oxrNRDyC1XTvlXA33bi2xd+lbQvz039DM=
Date:   Sun, 28 Mar 2021 19:57:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: (trivial) remove a duplicate comment
Message-ID: <YGDDhGvTfd3eGbCz@kroah.com>
References: <20210328175200.27069-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328175200.27069-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 07:52:00PM +0200, Martin Kaiser wrote:
> Keep the one that shows the wakeup capability.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/rtl8188eu/os_dep/usb_intf.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> index 91a3d34a1050..e18f1fff59ca 100644
> --- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> @@ -377,7 +377,6 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>  		dvobj->pusbdev->do_remote_wakeup = 1;
>  		pusb_intf->needs_remote_wakeup = 1;
>  		device_init_wakeup(&pusb_intf->dev, 1);
> -		pr_debug("\n  padapter->pwrctrlpriv.bSupportRemoteWakeup~~~~~~\n");
>  		pr_debug("\n  padapter->pwrctrlpriv.bSupportRemoteWakeup~~~[%d]~~~\n",

This does not match your subject line, it is not a comment.

thanks,

greg k-h
