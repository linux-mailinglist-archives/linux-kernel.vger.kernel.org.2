Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF45243201C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhJROpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232139AbhJROpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:45:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FA1061002;
        Mon, 18 Oct 2021 14:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634568173;
        bh=8Twwmbm1kE9MERg4kxNawQgXH8+ErW6k50ydSxxmnO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hd7fElt5K6nr/Fj7xwkoYe6dEILxSI85rlw+tgK2493/ln6ggV73MDtpUZdNljodr
         xEEYShHo2ZhXmYE7/B928LB28TFuek+Ib3QK5S5KYjPPr+2CNN04jacrZUnHpWaOLi
         g5efMYv83QbxlAC73WpzmUXbxHynToIBYWqc5C/0=
Date:   Mon, 18 Oct 2021 16:42:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: r8188eu: Remove redundant 'if' statement
Message-ID: <YW2H63JAWKcM6+hL@kroah.com>
References: <20211017142812.4656-1-fmdefrancesco@gmail.com>
 <20211017142812.4656-4-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017142812.4656-4-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 04:28:12PM +0200, Fabio M. De Francesco wrote:
> Remove a redundant 'if' statement.
> 
> Acked-by: Martin Kaiser <martin@kaiser.cx>
> Acked-by: Phillip Potter <phil@philpotter.co.uk>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 6 ------
>  1 file changed, 6 deletions(-)

Why is there not a "v2" in the subject line like the other patches in
this series?

> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 6fb79d711692..42084b029473 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -254,12 +254,6 @@ int rtw_cmd_thread(void *context)
>  	while (1) {
>  		wait_for_completion(&pcmdpriv->enqueue_cmd);
>  
> -		if (padapter->bDriverStopped ||
> -		    padapter->bSurpriseRemoved) {
> -			DBG_88E("%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
> -				__func__, padapter->bDriverStopped, padapter->bSurpriseRemoved, __LINE__);
> -			break;
> -		}


Why is this redundant?

It is not obvious from the diff what is going on so you should say a bit
more in the changelog text please.

thanks,

greg k-h
