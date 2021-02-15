Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C140731B5F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 09:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBOIpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 03:45:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:42588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhBOIpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 03:45:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613378665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7p0ZgJ7y6ZYSp40cSR2HClicIs9V9AmTmeD/P0zrzfM=;
        b=jR+Ajl9qThbiHeigkerXV0mkqJhMebC+WU2WKgJwC+evDZjAkMvChSzoKIJTaZd1NNOzBm
        e055hpfXlrJirRBuSzYrMeJvD0SOeSNpaI4DPTAfe6l+UNcpINMj7gDQ0SzsxV1H6Uf7lb
        SeZrlXHJmXen2taNgw8BLT2CjlyeqpI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E0FC3AD78;
        Mon, 15 Feb 2021 08:44:24 +0000 (UTC)
Date:   Mon, 15 Feb 2021 09:44:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Ivan Safonov <insafonov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:wlan-ng: use memdup_user instead of
 kmalloc/copy_from_user
Message-ID: <YCo0aAMajx0AG7JM@dhcp22.suse.cz>
References: <20210213120527.451531-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210213120527.451531-1-insafonov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 13-02-21 15:05:28, Ivan Safonov wrote:
> memdup_user() is shorter and safer equivalent
> of kmalloc/copy_from_user pair.
> 
> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
> ---
>  drivers/staging/wlan-ng/p80211netdev.c | 28 ++++++++++++--------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
> index a15abb2c8f54..6f9666dc0277 100644
> --- a/drivers/staging/wlan-ng/p80211netdev.c
> +++ b/drivers/staging/wlan-ng/p80211netdev.c
> @@ -569,24 +569,22 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
>  		goto bail;
>  	}
>  
> -	/* Allocate a buf of size req->len */
> -	msgbuf = kmalloc(req->len, GFP_KERNEL);
> -	if (msgbuf) {
> -		if (copy_from_user(msgbuf, (void __user *)req->data, req->len))
> -			result = -EFAULT;
> -		else
> -			result = p80211req_dorequest(wlandev, msgbuf);
> +	msgbuf = memdup_user(req->data, req->len);

Move to memdup_user is definitely a right step. What is the range of
req->len though? If this can be larger than PAGE_SIZE then vmemdup_user
would be a better alternative.

-- 
Michal Hocko
SUSE Labs
