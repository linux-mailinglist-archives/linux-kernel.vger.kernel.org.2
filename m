Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4B3B8D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 07:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhGAGAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 02:00:37 -0400
Received: from mxout70.expurgate.net ([194.37.255.70]:54955 "EHLO
        mxout70.expurgate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhGAGAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:00:35 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2021 02:00:35 EDT
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <ms@dev.tdt.de>)
        id 1lypbW-0007dN-3f; Thu, 01 Jul 2021 07:51:14 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ms@dev.tdt.de>)
        id 1lypbV-0006N8-0t; Thu, 01 Jul 2021 07:51:13 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 5D002240041;
        Thu,  1 Jul 2021 07:51:12 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id E701B240040;
        Thu,  1 Jul 2021 07:51:11 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id EDC46201CA;
        Thu,  1 Jul 2021 07:51:10 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Jul 2021 07:51:10 +0200
From:   Martin Schiller <ms@dev.tdt.de>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: x25: Optimize the code in
 {compat_}x25_subscr_ioctl()
Organization: TDT AG
In-Reply-To: <20210630091521.15568-1-yajun.deng@linux.dev>
References: <20210630091521.15568-1-yajun.deng@linux.dev>
Message-ID: <c9af2f27b8459af35c91ec3347a96d6d@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.16
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
X-purgate-ID: 151534::1625118673-00003E95-377AFA87/0/0
X-purgate-type: clean
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-30 11:15, Yajun Deng wrote:
> Combine the redundant return values, make it more concise.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  net/x25/af_x25.c   | 19 ++++++++-----------
>  net/x25/x25_link.c | 21 ++++++++++-----------
>  2 files changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index 3583354a7d7f..53c40fc7c1fd 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -1625,21 +1625,19 @@ static int compat_x25_subscr_ioctl(unsigned int 
> cmd,
>  	struct net_device *dev;
>  	int rc = -EINVAL;
> 
> -	rc = -EFAULT;
> -	if (copy_from_user(&x25_subscr, x25_subscr32, sizeof(*x25_subscr32)))
> +	if (copy_from_user(&x25_subscr, x25_subscr32, sizeof(*x25_subscr32))) 
> {
> +		rc = -EFAULT;
>  		goto out;
> +	}
> 
> -	rc = -EINVAL;
>  	dev = x25_dev_get(x25_subscr.device);
> -	if (dev == NULL)
> +	if (!dev)
>  		goto out;
> 
>  	nb = x25_get_neigh(dev);
> -	if (nb == NULL)
> +	if (!nb)
>  		goto out_dev_put;
> 
> -	dev_put(dev);
> -
>  	if (cmd == SIOCX25GSUBSCRIP) {
>  		read_lock_bh(&x25_neigh_list_lock);
>  		x25_subscr.extended = nb->extended;
> @@ -1648,7 +1646,6 @@ static int compat_x25_subscr_ioctl(unsigned int 
> cmd,
>  		rc = copy_to_user(x25_subscr32, &x25_subscr,
>  				sizeof(*x25_subscr32)) ? -EFAULT : 0;
>  	} else {
> -		rc = -EINVAL;
>  		if (x25_subscr.extended == 0 || x25_subscr.extended == 1) {
>  			rc = 0;
>  			write_lock_bh(&x25_neigh_list_lock);
> @@ -1658,11 +1655,11 @@ static int compat_x25_subscr_ioctl(unsigned int 
> cmd,
>  		}
>  	}
>  	x25_neigh_put(nb);
> -out:
> -	return rc;
> +
>  out_dev_put:
>  	dev_put(dev);
> -	goto out;
> +out:
> +	return rc;
>  }
> 
>  static int compat_x25_ioctl(struct socket *sock, unsigned int cmd,
> diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
> index 5460b9146dd8..01a13ec88ce8 100644
> --- a/net/x25/x25_link.c
> +++ b/net/x25/x25_link.c
> @@ -360,19 +360,19 @@ int x25_subscr_ioctl(unsigned int cmd, void 
> __user *arg)
>  	if (cmd != SIOCX25GSUBSCRIP && cmd != SIOCX25SSUBSCRIP)
>  		goto out;
> 
> -	rc = -EFAULT;
> -	if (copy_from_user(&x25_subscr, arg, sizeof(x25_subscr)))
> +	if (copy_from_user(&x25_subscr, arg, sizeof(x25_subscr))) {
> +		rc = -EFAULT;
>  		goto out;
> +	}
> 
> -	rc = -EINVAL;
> -	if ((dev = x25_dev_get(x25_subscr.device)) == NULL)
> +	dev = x25_dev_get(x25_subscr.device);
> +	if (!dev)
>  		goto out;
> 
> -	if ((nb = x25_get_neigh(dev)) == NULL)
> +	nb = x25_get_neigh(dev);
> +	if (!nb)
>  		goto out_dev_put;
> 
> -	dev_put(dev);
> -
>  	if (cmd == SIOCX25GSUBSCRIP) {
>  		read_lock_bh(&x25_neigh_list_lock);
>  		x25_subscr.extended	     = nb->extended;
> @@ -381,7 +381,6 @@ int x25_subscr_ioctl(unsigned int cmd, void __user 
> *arg)
>  		rc = copy_to_user(arg, &x25_subscr,
>  				  sizeof(x25_subscr)) ? -EFAULT : 0;
>  	} else {
> -		rc = -EINVAL;
>  		if (!(x25_subscr.extended && x25_subscr.extended != 1)) {
>  			rc = 0;
>  			write_lock_bh(&x25_neigh_list_lock);
> @@ -391,11 +390,11 @@ int x25_subscr_ioctl(unsigned int cmd, void 
> __user *arg)
>  		}
>  	}
>  	x25_neigh_put(nb);
> -out:
> -	return rc;
> +
>  out_dev_put:
>  	dev_put(dev);
> -	goto out;
> +out:
> +	return rc;
>  }

Looks good to me.

Acked-by: Martin Schiller <ms@dev.tdt.de>
