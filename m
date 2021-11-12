Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F05444E9A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhKLPMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:12:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231553AbhKLPMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636729788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m8wjvVSjO04BUbkKGsTBTVULT6cd2cgB0v+0Q9ngovI=;
        b=Mej/WZInPu2TZJ5djUJKsEuIy3gUE46Kn9MfwhrUOgnPnpCLIwazV1XHj+O8KytTvh9b7U
        /gGiTjnsOK3AoKYhXBGQFL1Sgngg0nOui37DK5wlycXixJSTXL1/S6YruXPIgwrd9VIR5e
        YVSigl0v2Z2J8TBZ5VDKUdgW05Ub45Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-CQvq5MHnNVWGCSwdfgneNg-1; Fri, 12 Nov 2021 10:09:45 -0500
X-MC-Unique: CQvq5MHnNVWGCSwdfgneNg-1
Received: by mail-qt1-f199.google.com with SMTP id i5-20020ac85c05000000b002ae12b76e64so7412073qti.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 07:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m8wjvVSjO04BUbkKGsTBTVULT6cd2cgB0v+0Q9ngovI=;
        b=Grw+Vlfd9E3Uob/latECQ14EZAJmRMW5c5bJUY3xbvmHGu84ZOeKfJttR4mHDQgY5Q
         qS7+MuH0IwP+jJ9t/JO5EAvU++RaWDXKXlrI/Gf/0S7V+U6ndyge4kmURulzMBBpI8Qq
         r+proA2pr9LdYYR0gzTmoVknRpgEKIIU+MpVnFJNhfey/mlyq2MWVtkL49tPYjhSB+zA
         LFs47FfIlAf4rFMgXOwwxoEg5YiHST/1PlIWMPti2YVYukcrOFEqaA7rRuSmTy0Fmgoz
         nYmCxRcT346xDKdefjdvlzmHdY5zuvTkxaYxwq8ejELxPrsnt/Wer6ibeaCESJ6dsH8Q
         xQvw==
X-Gm-Message-State: AOAM533ZaP4gI5VcMOu2eHMdN8qkmzLeDJb5XC2+D8uTH0hT2ZHLJ/JH
        NW4YlwSQecq0kIgiVeyXnG1JQ/c26QuPR5ombU5EkcbcsVp0fLooTedMU/j5MaQFtOiSllD54sM
        yatmZCUJDhScYZOfmyVfP2uM=
X-Received: by 2002:a05:620a:280d:: with SMTP id f13mr12862073qkp.31.1636729784793;
        Fri, 12 Nov 2021 07:09:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyonI7are665jPN4yxD09tOYZibEQWeHpUqQ6sWWPo/7YEoc54YCv4QEI2cQ78SIsxGcGbCsQ==
X-Received: by 2002:a05:620a:280d:: with SMTP id f13mr12862056qkp.31.1636729784622;
        Fri, 12 Nov 2021 07:09:44 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id s22sm2983160qko.88.2021.11.12.07.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:09:44 -0800 (PST)
Date:   Fri, 12 Nov 2021 10:09:43 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     cgel.zte@gmail.com
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: dm: remove unneeded variable
Message-ID: <YY6Dt+Wy4rfHwgXw@redhat.com>
References: <20211111075331.158061-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111075331.158061-1-ran.jianping@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11 2021 at  2:53P -0500,
cgel.zte@gmail.com <cgel.zte@gmail.com> wrote:

> From: ran jianping <ran.jianping@zte.com.cn>
> 
> Fix the following coccicheck review:
> ./drivers/md/dm-ps-round-robin.c:91:5-7:Unneeded variable
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
> ---
>  drivers/md/dm-ps-round-robin.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-ps-round-robin.c b/drivers/md/dm-ps-round-robin.c
> index 27f44c5fa04e..455fc02af1cf 100644
> --- a/drivers/md/dm-ps-round-robin.c
> +++ b/drivers/md/dm-ps-round-robin.c
> @@ -88,7 +88,6 @@ static int rr_status(struct path_selector *ps, struct dm_path *path,
>  		     status_type_t type, char *result, unsigned int maxlen)
>  {
>  	struct path_info *pi;
> -	int sz = 0;
>  
>  	if (!path)
>  		DMEMIT("0 ");
> @@ -107,7 +106,7 @@ static int rr_status(struct path_selector *ps, struct dm_path *path,
>  		}
>  	}
>  
> -	return sz;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.25.1
> 

You clearly didn't even	compile	test this (hint: DMEMIT macro uses it).

Nacked-by: Mike Snitzer <snitzer@redhat.com>

