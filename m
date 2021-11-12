Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F187F44E996
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhKLPMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:12:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229509AbhKLPMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636729750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M10JDtvNwjvlnkeGVOpBppOKaiUG/M9CfxdoBw1FJ1Q=;
        b=aR5weT0M1dEN9iVFVNIjATOzwUMBpeHc1zdQ8pYhKYtp+CgG/onqXqptoE2o+At4aBX/dp
        yyBw4KJBsX9jSAY12ltC/LvYAhBjG0jMJ/Ro33tbcxQS1+tHdswHlSUwatwpI5dxS7iAVk
        rv0n59FdnCgCnyPAKG5ENTnnzW0W/vw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-1wX3dwtDP6SnhAhzm4wqJw-1; Fri, 12 Nov 2021 10:09:09 -0500
X-MC-Unique: 1wX3dwtDP6SnhAhzm4wqJw-1
Received: by mail-qk1-f199.google.com with SMTP id m19-20020a05620a221300b00467cb90a8e2so6592817qkh.18
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 07:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M10JDtvNwjvlnkeGVOpBppOKaiUG/M9CfxdoBw1FJ1Q=;
        b=cX/KBEAZeZwPvK6loGWSfiBF7avKGRyZC6+BQ9FQ7s8gSDbm+9n6+yPnBNeTNKl0QC
         oXVJZJIAsPR4qZCr36uFHhlTBHT/f6aGPvliRLJ1s5xfYBQBaSGN4+EsWRrYC9TAOZfv
         d0AzPP1aXHvmCWv7czL1FRFZ+l30PPh9xO6Ubc2Jxte134EK2bmhJ4g/0HpGblNjZDfP
         0t+oBSx6DtXWnyHFvjCGtjpKLht3VvkbHKNkSADysk8ccYu6zzrwjWXo96aR4e9kRBx1
         kaE5cogcab6lyQwBxQNQon/q0POWMYIxsiYvEr1DIMK970itQvQh3MpYMUwD80zlU1G1
         wrxg==
X-Gm-Message-State: AOAM530bEK8XAkjk+cYM1W1T8ZzIpYFPsyyG1kKrOi2LWaAJS/snpR1o
        cvZttC1/Q7w7Q/ZaT+u76vgNT+uSwSkqnE+gOo9RgrTf+IJXBLyHf3ownW4NTecAqOSGV0MaYyC
        HtdXVIfLUGlseJ5lwhznnv2o=
X-Received: by 2002:a05:622a:178c:: with SMTP id s12mr4207072qtk.43.1636729749102;
        Fri, 12 Nov 2021 07:09:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmFsBQzyEWJpJEozEoeqjviaanWHxvfbd5LPTmTA2qoHP6BZRuewV/ctP4yDWvtHp2zQYKpQ==
X-Received: by 2002:a05:622a:178c:: with SMTP id s12mr4207040qtk.43.1636729748874;
        Fri, 12 Nov 2021 07:09:08 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id b2sm2988808qtg.88.2021.11.12.07.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:09:08 -0800 (PST)
Date:   Fri, 12 Nov 2021 10:09:07 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     cgel.zte@gmail.com
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: dm snapshot: remove unneeded variable
Message-ID: <YY6Dk0TEQzorBlOU@redhat.com>
References: <20211111075659.158155-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111075659.158155-1-ran.jianping@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11 2021 at  2:56P -0500,
cgel.zte@gmail.com <cgel.zte@gmail.com> wrote:

> From: ran jianping <ran.jianping@zte.com.cn>
> 
> Fix the following coccicheck review:
> ./drivers/md/dm-snap-transient.c:91:10-12: Unneeded variable
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
> ---
>  drivers/md/dm-snap-transient.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-snap-transient.c b/drivers/md/dm-snap-transient.c
> index 0e0ae4c36b37..d95b59855da0 100644
> --- a/drivers/md/dm-snap-transient.c
> +++ b/drivers/md/dm-snap-transient.c
> @@ -88,7 +88,6 @@ static unsigned transient_status(struct dm_exception_store *store,
>  				 status_type_t status, char *result,
>  				 unsigned maxlen)
>  {
> -	unsigned sz = 0;
>  
>  	switch (status) {
>  	case STATUSTYPE_INFO:
> @@ -101,7 +100,7 @@ static unsigned transient_status(struct dm_exception_store *store,
>  		break;
>  	}
>  
> -	return sz;
> +	return 0;
>  }
>  
>  static struct dm_exception_store_type _transient_type = {
> -- 
> 2.25.1
> 

You clearly didn't even compile test this.

Nacked-by: Mike Snitzer <snitzer@redhat.com>

