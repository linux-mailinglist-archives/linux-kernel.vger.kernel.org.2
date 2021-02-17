Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB6331DCC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhBQPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:54:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233740AbhBQPya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:54:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8B9261606;
        Wed, 17 Feb 2021 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613577230;
        bh=gPXeb3O9D7B3pY2yqD54kVF5JalQzvyDKHkoN5VIJXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EID2ZN1YzyIb+Q8dUVwTLSLvAtlMzLQ88Iw5KwUuBpNpTT8L/nwaiv+paNoWC9yWs
         jDWRfcra49upqq7YBdMb6T6hEy2/zgpaqt1ERGZ6aCimF8BEK8kEtEE2o46R1CtGUw
         NtEpRFne6BDaQSmY4mJeDvW7+D93Wkl14Wlx5ZpU=
Date:   Wed, 17 Feb 2021 16:53:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pritthijit Nath <pritthijit.nath@icloud.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Fixed incorrect type warning in
 p80211netdev.c
Message-ID: <YC08DBQuxmNA1EWh@kroah.com>
References: <20210217154255.112115-1-pritthijit.nath@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217154255.112115-1-pritthijit.nath@icloud.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 09:12:55PM +0530, Pritthijit Nath wrote:
> This change fixes a sparse warning "incorrect type in argument 1
> (different address spaces)".
> 
> Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> ---
>  drivers/staging/wlan-ng/p80211netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
> index 6f9666dc0277..70570e8a5ad2 100644
> --- a/drivers/staging/wlan-ng/p80211netdev.c
> +++ b/drivers/staging/wlan-ng/p80211netdev.c
> @@ -569,7 +569,7 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
>  		goto bail;
>  	}
>  
> -	msgbuf = memdup_user(req->data, req->len);
> +	msgbuf = memdup_user((void __user *)req->data, req->len);

Odd.  Why isn't data tagged as a __user pointer to start with?

thanks,

greg k-h
