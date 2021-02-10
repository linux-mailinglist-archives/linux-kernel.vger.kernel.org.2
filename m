Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9347315ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhBJFRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBJFRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:17:37 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32425C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 21:16:51 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id k10so753641otl.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 21:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Q8+AD77bMtoNW/HBzmZ8xMNYIgN4sAwD1/ADY3ZtEEk=;
        b=Fdroa3m70eD8+7KTxXuHTcUNnT7RKmI2+/ujf5yGEJfyh0W9IHuWdQ5VrHoRK6KiKO
         orVrw72k5YjskoOG5UvgLdG/VhwDwAzL+AT5d8n9kKs8NOrUjf1eD9km4BYGH86kloyE
         na4Au9OoCTeFEnN4rZy0olzery/o76zJWHL/F4q0Er3uC2Wu2BN/BydsGVBJ9vFNEjv3
         DGOM99xnrf4CLCxsyb52Jb4BBg+fytIkav8i4ZzrLv+joPRR4Zjr5LcjOKlhUVM9M64i
         yf1ht/CMGODtIeTCmM5Y/XlMCZ7q21rDcMYbIM7kF3RiQZGI0RCBgeQvIwBdMrMHhydS
         lARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Q8+AD77bMtoNW/HBzmZ8xMNYIgN4sAwD1/ADY3ZtEEk=;
        b=iCLECZHlXN5fpukKL5QVV6FnCq9SWp/wl3yMQjaztezbzKAhKJLunvDswnyOgT4Zrr
         hIwbH17jGS6pudFQQPjpj73kdSao3iwXwrZxStNwp6sk2W1f2PUYI1oPzkxcqr8bl3Gb
         Lgc5DArfHMl/+A75fyRsJKCzZCPtDiJ2Suzy/LZTGid1bFB6DcOmhoQ4F8vORgxEW70e
         +Wmrs7kR9B97LiUAPbeY1ClP4CO8I+n+8n066Ebmvf5Y/iQRrm3zNB3fGGABf1ZQz6aH
         7BMc3LT1P89HkCm6r5HA7Id7IA94A87EFl1xxQHf5q5yU5hP5zqe2JyaM8q+L7DBw4NG
         h44w==
X-Gm-Message-State: AOAM532d99ZWo6B+9E8eQUWA1Iw/CHNKnr8nK0h8fE4mDGpwgl4FnIvi
        USvtmbmAOO8EjVvuFnjbTQrm9g==
X-Google-Smtp-Source: ABdhPJwFPZeclIXiXIqkTT8I6kO/Wj7KR31FuttqTf7Yvbp8Oy2zwKu5VhmKY3vItcOqQSAJpwy2Rg==
X-Received: by 2002:a9d:5d02:: with SMTP id b2mr915507oti.148.1612934210367;
        Tue, 09 Feb 2021 21:16:50 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w2sm195062otq.9.2021.02.09.21.16.48
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2021 21:16:49 -0800 (PST)
Date:   Tue, 9 Feb 2021 21:16:37 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: page-writeback: simplify memcg handling in
 test_clear_page_writeback()
In-Reply-To: <20210209214543.112655-1-hannes@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.2102092058290.7553@eggly.anvils>
References: <20210209214543.112655-1-hannes@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021, Johannes Weiner wrote:

> Page writeback doesn't hold a page reference, which allows truncate to
> free a page the second PageWriteback is cleared. This used to require
> special attention in test_clear_page_writeback(), where we had to be
> careful not to rely on the unstable page->memcg binding and look up
> all the necessary information before clearing the writeback flag.
> 
> Since commit 073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and
> BUG_ON(PageWriteback)") test_clear_page_writeback() is called with an
> explicit reference on the page, and this dance is no longer needed.
> 
> Use unlock_page_memcg() and dec_lruvec_page_stat() directly.

s/stat()/state()/

This is a nice cleanup: I hadn't seen that connection at all.

But I think you should take it further:
__unlock_page_memcg() can then be static in mm/memcontrol.c,
and its declarations deleted from include/linux/memcontrol.h?

And further: delete __dec_lruvec_state() and dec_lruvec_state()
from include/linux/vmstat.h - unless you feel that every "inc"
ought to be matched by a "dec", even when unused.

> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/page-writeback.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index eb34d204d4ee..f6c2c3165d4d 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2722,12 +2722,9 @@ EXPORT_SYMBOL(clear_page_dirty_for_io);
>  int test_clear_page_writeback(struct page *page)
>  {
>  	struct address_space *mapping = page_mapping(page);
> -	struct mem_cgroup *memcg;
> -	struct lruvec *lruvec;
>  	int ret;
>  
> -	memcg = lock_page_memcg(page);
> -	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +	lock_page_memcg(page);
>  	if (mapping && mapping_use_writeback_tags(mapping)) {
>  		struct inode *inode = mapping->host;
>  		struct backing_dev_info *bdi = inode_to_bdi(inode);
> @@ -2755,11 +2752,11 @@ int test_clear_page_writeback(struct page *page)
>  		ret = TestClearPageWriteback(page);
>  	}
>  	if (ret) {
> -		dec_lruvec_state(lruvec, NR_WRITEBACK);
> +		dec_lruvec_page_state(page, NR_WRITEBACK);
>  		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
>  		inc_node_page_state(page, NR_WRITTEN);
>  	}
> -	__unlock_page_memcg(memcg);
> +	unlock_page_memcg(page);
>  	return ret;
>  }
>  
> -- 
> 2.30.0
