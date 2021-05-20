Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5138B74D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbhETTVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbhETTVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:21:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B4EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:19:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v12so9656817plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sAQXDqHg+QqOGKOJDjzmLWV7mdQnspavEi3kfD9gWIQ=;
        b=LcLMvABXBv5ssd8bBL16v2rmmU6poAzb8jnXwjRqhVULOejJ17dTRYHjQ95sldLyhQ
         EDkVbm00GBaTsS1JMySlM1Sz/N+3xFfJCW+K2MdrAiP1C7ZEqVSgfjQGsP2yoXYqefhf
         qE0fuyqYkKwH3gsADK+p96u9ltd4jRqp5G5R4O/RfdXCKQWnLBRJbneh2aw/23DVqSDM
         ClNy1kR62nD0QmugvWd+ViPAs+fJtH8rMijXVsgWA7RwEyv14PbpBBEyh9RKcP5NYP3c
         1nwjYIZ7A95sb+jMJlAaMvInQuxpsOFTwknCyXzdXZAu4c5NMELQIaAkLx811v7/h9lT
         6d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sAQXDqHg+QqOGKOJDjzmLWV7mdQnspavEi3kfD9gWIQ=;
        b=oU1Qh4Y+p+a+9+DGfWCwNMUJpUxbEM1DTQakCCsgutXa4S+Rf3NG3TJEE1odGX3Th/
         5T3vWuSqjYGK3TmuNlCd2O+Tyu92bU2xspFfQRek3rxsIMXQCqeygsFBaku6aLEJK5fi
         XIKfognD8fwt7kHzKE2E6BASZzegdS6jKffghho5jQZhdxCxL7T1fBtcjrbonunHo9it
         3ycBDhQVExyxgz6UP6WnmrhN2pOOWdeymT10I5OujCI+MbJ4lf58/EFzotAmP/Usyr4M
         /3OZnhWlf+3wy0MLQKEBqnrOBlc4Odm3+CYVYP6NfnktHvDrlBtrojMnO8JuFsKwnDN1
         N7TQ==
X-Gm-Message-State: AOAM530H7X4b00MDCgStanuz5JUAV1Cq/GLStQLTyQq+5WpJHWfIRusq
        zwobPTK/jg7FI7LXYIrJgmk=
X-Google-Smtp-Source: ABdhPJyYIIyIs0/OH0gsyJGAd3roUCX7k/v+yE4krIf+WxGBQ1evaiaQo8bj/Av86C7pt3cd20qAOw==
X-Received: by 2002:a17:90b:201:: with SMTP id fy1mr6755194pjb.119.1621538397947;
        Thu, 20 May 2021 12:19:57 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:f248:e9e3:9874:9116])
        by smtp.gmail.com with ESMTPSA id c9sm2461371pfl.169.2021.05.20.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:19:57 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 20 May 2021 12:19:55 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: page_alloc: dump migrate-failed pages only at -EBUSY
Message-ID: <YKa2Wyo9xqIErpfa@google.com>
References: <20210519213341.2620708-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519213341.2620708-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 02:33:41PM -0700, Minchan Kim wrote:
> alloc_contig_dump_pages aims for helping debugging page migration
> failure by page refcount mismatch or something else of page itself
> from migration handler function. However, in -ENOMEM case, there is
> nothing to get clue from page descriptor information so just
> dump pages only when -EBUSY happens.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3100fcb08500..c0a2971dc755 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8760,7 +8760,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  
>  	lru_cache_enable();
>  	if (ret < 0) {
> -		alloc_contig_dump_pages(&cc->migratepages);
> +		if (ret == -EBUSY)
> +			alloc_contig_dump_pages(&cc->migratepages);
>  		putback_movable_pages(&cc->migratepages);
>  		return ret;
>  	}
> -- 
> 2.31.1.751.gd2f1c929bd-goog
> 

Resend with a little modifying description.

From c5a2fea291cf46079b87cc9ac9a25fc7f819d0fd Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Wed, 19 May 2021 14:22:18 -0700
Subject: [PATCH] mm: page_alloc: dump migrate-failed pages only at -EBUSY

alloc_contig_dump_pages aims for helping debugging page migration
failure by elevated page refcount compared to expected_count.
(for the detail, please look at migrate_page_move_mapping)

However, -ENOMEM is just the case that system is under memory
pressure state, not relevant with page refcount at all. Thus,
the dumping page list is not helpful for the debugging point of view.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3100fcb08500..c0a2971dc755 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8760,7 +8760,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 
 	lru_cache_enable();
 	if (ret < 0) {
-		alloc_contig_dump_pages(&cc->migratepages);
+		if (ret == -EBUSY)
+			alloc_contig_dump_pages(&cc->migratepages);
 		putback_movable_pages(&cc->migratepages);
 		return ret;
 	}
-- 
2.31.1.818.g46aad6cb9e-goog

