Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32E367CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhDVInw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235156AbhDVInw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:43:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDD1461426;
        Thu, 22 Apr 2021 08:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619080996;
        bh=doOimx+KZm3Jwz7JUFrZDjSx/2XdjrMNoBga2za7QLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tZC57jpCX0UhevlgvfIB2H2yaoXP4U6C8WLYMEMYNShRO3noMWOKMbdSVFVjsIYns
         LZmlNTA4Uz2bMNmdRjVbPEi6xNaV0EZ6sgQh+5ZktUcTIsja4YIZR+mfDXFQs3wI+D
         u9Y/YXC6kIsFT8Ie/Vix6ZC199Gciq7DW8s2zyPI=
Date:   Thu, 22 Apr 2021 10:43:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ashish Kalra <eashishkalra@gmail.com>
Cc:     Abheek Dhawan <adawesomeguy222@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Romain Perier <romain.perier@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: silence incorrect type in argument 1
 (different address spaces) warning
Message-ID: <YIE3IffGcjrkz4ZE@kroah.com>
References: <20210420090142.GA4086@ashish-NUC8i5BEH>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420090142.GA4086@ashish-NUC8i5BEH>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 02:31:42PM +0530, Ashish Kalra wrote:
> Upon running sparse, "warning: incorrect type in argument 1 (different address spaces)
> is brought to notice for this file.let's add correct typecast to make it cleaner and
> silence the Sparse warning.
> 
> Signed-off-by: Ashish Kalra <eashishkalra@gmail.com>
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

Why isn't data being declared as a __user pointer to start with?  Why is
the cast needed here?

This feels wrong as if it is papering over the real problem.

thanks,

greg k-h
