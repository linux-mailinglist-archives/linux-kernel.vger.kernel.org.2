Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CB4367633
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 02:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbhDVAW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 20:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244166AbhDVAWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:22:51 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0248CC06138C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:22:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id z16so31567080pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p8niERqEMmt8YjmaM1PtQAVz464O833KbGembPi2y0E=;
        b=UefOwOup5y0pyfH32nf6OFSEEkcVRVF2OscZznFH7JBu9toj/FtY7EtRGbK+sT4NUf
         Nytki2qej3Z7kUdfYxWEV5tQu+wTtewDk3htdtON2LhsZUBgkLqDKh++3TFbdORVQIdm
         DT9xI9i5rjOyO9p7LJzhozfRr9AWY/dPxee54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p8niERqEMmt8YjmaM1PtQAVz464O833KbGembPi2y0E=;
        b=OZDMX48OkduU+6i7oEaO6fNXdFNqnoS4QDe92NSDg4ej7+7dqOVkhbtsBYu3FcmuKZ
         uSiyLdV/nf005H8BLk/UG+OOTOR2h0oo0uUyEe/PdAxUOToobFI6v4gPEEfFwOvXWMDk
         x9ACwL7C/0ZE65TxjXN3QR+aPqGAlKLJArLcM7d7w2xFUffPrw9eFA5nlDLOsf9cMyg2
         oeJY1m+Wa+BYyYisGzP37uD6oe+Rzq7/lhoyMBZR+5vJ+rAgCHRUhDklEV/jpDvkC5Io
         URsWaLIVY3LkfOLVedzEWEemZoWFMABLuGw/tqpQWcPJ7L+QtP+poBPTjLad+0qAK/xN
         t3hA==
X-Gm-Message-State: AOAM531Sg8JihhwzAb2uQVAhH8D9jj8t4txPBOIUMj5rd/zzupYRdp6b
        2r4MITIQ4CwfAxIzdWsJKc819k4QYIBcSQ==
X-Google-Smtp-Source: ABdhPJxS8aW6dywteQ1+rUTpiZb9cufwwyO3HwUBb/h/q1y+aJMsTzS6/dcL2MAoZRfuLotwCLRp2g==
X-Received: by 2002:a63:483:: with SMTP id 125mr750968pge.406.1619050935402;
        Wed, 21 Apr 2021 17:22:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i18sm340349pfq.59.2021.04.21.17.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 17:22:14 -0700 (PDT)
Date:   Wed, 21 Apr 2021 17:22:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wireless: wext-spy: Fix out-of-bounds warning
Message-ID: <202104211722.C35B177936@keescook>
References: <20210421234337.GA127225@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421234337.GA127225@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:43:37PM -0500, Gustavo A. R. Silva wrote:
> Fix the following out-of-bounds warning:
> 
> net/wireless/wext-spy.c:178:2: warning: 'memcpy' offset [25, 28] from the object at 'threshold' is out of the bounds of referenced subobject 'low' with type 'struct iw_quality' at offset 20 [-Warray-bounds]
> 
> The problem is that the original code is trying to copy data into a
> couple of struct members adjacent to each other in a single call to
> memcpy(). This causes a legitimate compiler warning because memcpy()
> overruns the length of &threshold.low and &spydata->spy_thr_low. As
> these are just a couple of members, fix this by copying each one of
> them in separate calls to memcpy().
> 
> Also, while there, use sizeof(threshold.qual) instead of
> sizeof(struct iw_quality)) in another call to memcpy()
> above.
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> Link: https://github.com/KSPP/linux/issues/109
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  net/wireless/wext-spy.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/wireless/wext-spy.c b/net/wireless/wext-spy.c
> index 33bef22e44e9..bb2de7c6bee4 100644
> --- a/net/wireless/wext-spy.c
> +++ b/net/wireless/wext-spy.c
> @@ -120,8 +120,8 @@ int iw_handler_set_thrspy(struct net_device *	dev,
>  		return -EOPNOTSUPP;
>  
>  	/* Just do it */
> -	memcpy(&(spydata->spy_thr_low), &(threshold->low),
> -	       2 * sizeof(struct iw_quality));
> +	memcpy(&spydata->spy_thr_low, &threshold->low, sizeof(threshold->low));
> +	memcpy(&spydata->spy_thr_high, &threshold->high, sizeof(threshold->high));
>  
>  	/* Clear flag */
>  	memset(spydata->spy_thr_under, '\0', sizeof(spydata->spy_thr_under));
> @@ -173,10 +173,10 @@ static void iw_send_thrspy_event(struct net_device *	dev,
>  	memcpy(threshold.addr.sa_data, address, ETH_ALEN);
>  	threshold.addr.sa_family = ARPHRD_ETHER;
>  	/* Copy stats */
> -	memcpy(&(threshold.qual), wstats, sizeof(struct iw_quality));
> +	memcpy(&threshold.qual, wstats, sizeof(threshold.qual));
>  	/* Copy also thresholds */
> -	memcpy(&(threshold.low), &(spydata->spy_thr_low),
> -	       2 * sizeof(struct iw_quality));
> +	memcpy(&threshold.low, &spydata->spy_thr_low, sizeof(threshold.low));
> +	memcpy(&threshold.high, &spydata->spy_thr_high, sizeof(threshold.high));
>  
>  	/* Send event to user space */
>  	wireless_send_event(dev, SIOCGIWTHRSPY, &wrqu, (char *) &threshold);
> -- 
> 2.27.0
> 

-- 
Kees Cook
