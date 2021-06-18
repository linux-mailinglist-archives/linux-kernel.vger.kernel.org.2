Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3433AD4BF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 00:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbhFRWFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 18:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbhFRWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 18:05:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88097C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 15:02:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h16so6532272pjv.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 15:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D+d95UFbto6KXdVd780meGT/TKamJEDF0mnEvN0JNDg=;
        b=X8rlseAwjYPGPDK0H2ZNAkFuY3/RNYiE3elogj4FmPGQFys9B3d7RoCIaJJuISqm/c
         Ke7xUdgt7PNMNbWM8/1Y2KJQyMOx+rDTKwBxWRWH2rOObj4Oj33180/D/jyLT5ywbXCT
         jRxtPgyy0qpU/SLu6C6LMFNCChycK6rYAn1q6pw2iiMhqyqa66npEEI9bRmlHyryrFZO
         tcG2YjPluLljoCrvuU8ehkygSeIdmQ0vto01R1utba2n4ENH3dOywFGAF4eBq0hEMITz
         bhxODZ3aUsl+NdNY+9V2pvhqwvONx784lNs6g+2eihcJodxnj7SXjpOdnyS7CH9SSt9f
         W6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=D+d95UFbto6KXdVd780meGT/TKamJEDF0mnEvN0JNDg=;
        b=rLcD2BkatWEjzACZ75HTXzLkI/vok2CzbxikeEYp+duai72924wHxI6n+R4tuLvdwd
         axw2TT36rVlTgmE6xr7VjwM24Xt4XUD4wIG/BA5m9mEq6RxwFiAScf0xNGFEzpOQoku1
         FGiduRguDwlLgXm3/ddwSzK23QmwEQgQx/NQeBtXHSPP5PgA1tlaGJih52nlHs2s3BZT
         bsAtW02tvZX78vekVm7GrnMilx9HI/NfxTNsc6CDR5oUXPGfkAifXJ0W793YCZW0pUHG
         0H+hjCFci8K+9rzdyj4SJ8nu+XLpnexMIP7WI/kdEIaAFl5xw9zp7O054coWdtiQjut4
         uUeA==
X-Gm-Message-State: AOAM532wQynpCcpWIkVxDuCS3ehcvACBf6xIZnYcyX32LiUCtC7kXfRi
        Cm/v4g+qurEB4TpIpZY06UI=
X-Google-Smtp-Source: ABdhPJzVVXF93+4vNa6tkKMZXjgyxTMobN3PBpgnbX2TrCPQ0Yp/kKxDfK7FfU4aNdZjqJO7UZ0syA==
X-Received: by 2002:a17:90b:3b92:: with SMTP id pc18mr12952663pjb.100.1624053770099;
        Fri, 18 Jun 2021 15:02:50 -0700 (PDT)
Received: from google.com (c-67-188-94-199.hsd1.ca.comcast.net. [67.188.94.199])
        by smtp.gmail.com with ESMTPSA id y8sm3644306pfe.162.2021.06.18.15.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 15:02:49 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 18 Jun 2021 15:02:47 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm: zram: amend SLAB_RECLAIM_ACCOUNT on zspage_cachep
Message-ID: <YM0YB6p2i346Zzhz@google.com>
References: <1623137297-29685-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623137297-29685-1-git-send-email-huangzhaoyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 03:28:17PM +0800, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Zspage_cachep is found be merged with other kmem cache during test, which
> is not good for debug things(zs_pool->zspage_cachep present to be another
> kmem cache in memory dumpfile). It is also neccessary to do so as shrinker has

It's not a only problem of zsmalloc because slab want to minimize
fragmentation so try to merge several objects if it's allowed.
So I don't think it's particular problem of zsmalloc.
I guess slub has some option maybe "nomerge" if you want it.

> been registered for zspage. Amending this flag can help kernel to calculate
> SLAB_RECLAIMBLE correctly.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/zsmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 19b563b..0b0addd 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -328,7 +328,7 @@ static int create_cache(struct zs_pool *pool)
>  		return 1;
>  
>  	pool->zspage_cachep = kmem_cache_create("zspage", sizeof(struct zspage),
> -					0, 0, NULL);
> +					0, SLAB_RECLAIM_ACCOUNT, NULL);

How does zspage become SLAB_RECLAIM_ACCOUNT?

I took the flag as "cacheable" object. IOW, when the shrinker
ask to reclaim the object, it should reclaim(e.g., discarding)
those objects for reclaming. However, that's not the case
in zsmalloc.
