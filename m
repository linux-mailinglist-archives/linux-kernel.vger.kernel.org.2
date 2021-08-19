Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B223F1BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbhHSOyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238590AbhHSOyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:54:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FAC9610A1;
        Thu, 19 Aug 2021 14:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629384844;
        bh=NVt73+uhyzycuJMSmssj+lxbw6moSbp+k7jA2dLxJX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Xb0fhDgt4ezDWxhSKMQAZ7YukIXUtqenZ3/6mMryM+rU8t4Srzqbyz/Vui42QO7N
         wk2i7ObTpXk6hZnt3J/sRKvURV261jclrUus853dwcSZdjb+WUaBYnApaKTgw1gu7h
         E3Yo87xlWNx7PGMQ99Cpc+3CLYcWfHlahIPGVoSs=
Date:   Thu, 19 Aug 2021 16:54:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Remove _enter/_exit_critical_mutex()
Message-ID: <YR5wiOgWXXFqVDH+@kroah.com>
References: <20210819124955.25540-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819124955.25540-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 02:49:55PM +0200, Fabio M. De Francesco wrote:
> Remove _enter_critical_mutex() and _exit_critical_mutex(). They are
> unnecessary wrappers, respectively to mutex_lock_interruptible() and
> to mutex_unlock(). They also have an odd interface that takes an
> unused argument named pirqL of type unsigned long.
> Replace them with the in-kernel API. Ignore return values as it was
> in the old code.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v2: Ignore return values from Mutexes API.
> 
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c     |  5 +++--
>  drivers/staging/r8188eu/hal/usb_ops_linux.c     |  5 +++--
>  drivers/staging/r8188eu/include/osdep_service.h | 13 -------------
>  drivers/staging/r8188eu/os_dep/os_intfs.c       |  5 +++--
>  4 files changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 5325fe41fbee..9f53cab33333 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -4359,7 +4359,8 @@ s32 dump_mgntframe_and_wait_ack(struct adapter *padapter, struct xmit_frame *pmg
>  	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
>  		return -1;
>  
> -	_enter_critical_mutex(&pxmitpriv->ack_tx_mutex, NULL);
> +	if (mutex_lock_interruptible(&pxmitpriv->ack_tx_mutex))
> +		;	/*ignore return value */

Ick, no.  (not to mention the wrong comment style...)

If this really is "criticial", why can it be interrupted?

The existing code is such that the code can be interrupted, but if it
fails, the lock is not gotten, and the CODE CONTINUES AS IF IT IS OK!

So either this is never interruptable (my guess, one almost never needs
interruptable locks in a driver) and should just do a normal mutex lock,
or the code is totally broken and the locking should be revisited
entirely.

But a "blind" change like this is not good, let's get it right...

thanks,

greg k-h
