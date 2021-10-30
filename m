Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF00440824
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhJ3JSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 05:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230427AbhJ3JSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 05:18:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 270EE6101E;
        Sat, 30 Oct 2021 09:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635585330;
        bh=7wYyNA1NqK7aFI5a4edIpfAUHN9xvgC5EA9OQH2Kvjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZbVcbOYL0bNak9xJzGLyZa//TTebzPVAz2AtZL0vmq95jK7PXTqjo8LyCqdT+iT55
         +2IyMOfT5qm2jpBbBZH+yXo1XSvDH601v9CMk9n+X5L8DuJW0wguBdaoBYL+w602oz
         vKJTVVgT0jZtELaFTp8VYJ/wlQxFie3ZYTkOPw28=
Date:   Sat, 30 Oct 2021 11:15:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     dan.carpenter@oracle.com, will+git@drnd.me,
        mitaliborkar810@gmail.com, eduard.vintila47@gmail.com,
        zhaoxiao@uniontech.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8192e: remove condition with no effect
Message-ID: <YX0NMIuPUoX3GZB2@kroah.com>
References: <YXmap8VIxfOpqeEY@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXmap8VIxfOpqeEY@Sauravs-MacBook-Air.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 12:04:43AM +0530, Saurav Girepunje wrote:
> Remove the if and else code section for variable pHTInfo->bRegBW40MHz.
> Just before the if condition variable is assign with value 1.
> So if condition check for pHTInfo->bRegBW40MHz is always true.
> 
> Similarly for the variable pHTInfo->SelfMimoPs value '3' is assign.
> So if condition check with value '2' will never be true. Remove the
> if condition check for pHTInfo->SelfMimoPs.
> 
> Remove the extra blank lines from HTUpdateDefaultSetting function.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 3b8efaf9b88c..6925654dbc03 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -72,34 +72,20 @@ void HTUpdateDefaultSetting(struct rtllib_device *ieee)
>  	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
> 
>  	pHTInfo->bAcceptAddbaReq = 1;
> -
>  	pHTInfo->bRegShortGI20MHz = 1;
>  	pHTInfo->bRegShortGI40MHz = 1;
> -
>  	pHTInfo->bRegBW40MHz = 1;
> -
> -	if (pHTInfo->bRegBW40MHz)
> -		pHTInfo->bRegSuppCCK = 1;
> -	else
> -		pHTInfo->bRegSuppCCK = true;
> -
> +	pHTInfo->bRegSuppCCK = 1;
>  	pHTInfo->nAMSDU_MaxSize = 7935UL;
>  	pHTInfo->bAMSDU_Support = 0;
> -
>  	pHTInfo->bAMPDUEnable = 1;
>  	pHTInfo->AMPDU_Factor = 2;
>  	pHTInfo->MPDU_Density = 0;
> -
>  	pHTInfo->SelfMimoPs = 3;
> -	if (pHTInfo->SelfMimoPs == 2)
> -		pHTInfo->SelfMimoPs = 3;
>  	ieee->bTxDisableRateFallBack = 0;
>  	ieee->bTxUseDriverAssingedRate = 0;
> -
>  	ieee->bTxEnableFwCalcDur = 1;
> -
>  	pHTInfo->bRegRT2RTAggregation = 1;
> -
>  	pHTInfo->bRegRxReorderEnable = 1;
>  	pHTInfo->RxReorderWinSize = 64;
>  	pHTInfo->RxReorderPendingTime = 30;
> --
> 2.33.0
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
