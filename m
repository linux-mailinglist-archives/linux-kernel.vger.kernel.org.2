Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CFF3A6939
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhFNOtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232798AbhFNOtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:49:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50B756054E;
        Mon, 14 Jun 2021 14:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623682003;
        bh=+o9b6y5kWybkxYBzKA6EBU6w59vTl9WPx7qNYYNQuqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2JTsY/mpVYRSuI8bgbBTK2QoLAz8VnT2unhc+OM7HqRwhTjR+NOZ7SdHkf16txPwt
         vI5MPtv3CXZqam1quJrb2bnG9Rw37z/ntye/BtpN0J+uEdskBox5fP3SU3pbdKUuYj
         X03z2/LJ1YQxEliUKkQPNPp7xxt0LZ9Mce6ZZGRs=
Date:   Mon, 14 Jun 2021 16:46:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/6] staging: rtl8188eu: fix usb_submit_urb error handling
Message-ID: <YMdr0alJDEGfsqOA@kroah.com>
References: <20210612180019.20387-1-martin@kaiser.cx>
 <20210612180019.20387-2-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612180019.20387-2-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 08:00:15PM +0200, Martin Kaiser wrote:
> -EPERM should be handled like any other error.

Why?  This is not "any other error" for the usb core, right?

> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
> index ec07b2017fb7..0ceb05f3884f 100644
> --- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
> +++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
> @@ -366,7 +366,6 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
>  	struct usb_device *pusbd = pdvobj->pusbdev;
>  	int err;
>  	unsigned int pipe;
> -	u32 ret = _SUCCESS;
>  
>  	if (adapter->bDriverStopped || adapter->bSurpriseRemoved ||
>  	    adapter->pwrctrlpriv.pnp_bstop_trx) {
> @@ -403,10 +402,10 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
>  			  precvbuf);/* context is precvbuf */
>  
>  	err = usb_submit_urb(purb, GFP_ATOMIC);
> -	if ((err) && (err != (-EPERM)))
> -		ret = _FAIL;

if -EPERM returns from this function, someone set the "reject" bit on
the urb.

Can this driver do that?  Where did this check originally come from, as
it feels like this was added for a good reason.

If this patch is "correct", I need a better changelog text explaining
why it is so :)

thanks,

greg k-h
