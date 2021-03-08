Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C875E330EA5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhCHMtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:49:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:54596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhCHMtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:49:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615207752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I3MA4O9DPW7El1WvYUSmQ4/nQjjkpDOwqQCrp1Pj6HE=;
        b=r9PKsI+ds0ZUgOainH1rJRz753YW+3pgUswiqXlZU6WuyUF/tz9RrM7Fbqdv3kreUXNfZK
        rFySYes+vasGUysSslddJeY+oFcyHLOim7Y18mRDUAEwwd0mSZkfPys2wXFp9lrBZ0p5AG
        Wu9hBRt+9I78DaBoELb7hG8e0C2Fz/g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCEC4AC0C;
        Mon,  8 Mar 2021 12:49:11 +0000 (UTC)
Date:   Mon, 8 Mar 2021 13:49:11 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YEYdR8azcawau9Rl@dhcp22.suse.cz>
References: <YC+ErI8KIJV4Wd7u@dhcp22.suse.cz>
 <YD50pcPuwV456vwm@google.com>
 <YEEES/K8cNi8qOJe@google.com>
 <d83a03dd-fdff-ed62-a2ad-77b25d8249f0@redhat.com>
 <YEEJf0itS/8vn8Iy@google.com>
 <d3095ead-a762-61cd-0990-702e14e03d10@redhat.com>
 <YEEUq8ZRn4WyYWVx@google.com>
 <c08662f3-6ae1-4fb5-1c4f-840a70fad035@redhat.com>
 <YEEi1+TREGBElE5H@google.com>
 <YEEle5xBAc7FUDNI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEEle5xBAc7FUDNI@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-03-21 10:22:51, Minchan Kim wrote:
[...]
> How about this?
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 238d0fc232aa..489e557b9390 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8481,7 +8481,8 @@ static inline void dump_migrate_failure_pages(struct list_head *page_list)
> 
>  /* [start, end) must belong to a single zone. */
>  static int __alloc_contig_migrate_range(struct compact_control *cc,
> -                                       unsigned long start, unsigned long end)
> +                                       unsigned long start, unsigned long end,
> +                                       bool nofail)

This sounds like a very bad idea to me. Your nofail definition might
differ from what we actually define as __GFP_NOFAIL but I do not think
this interface should ever promise anything that strong.
Sure movable, cma regions should effectively never fail but there will
never be any _guarantee_ for that.

Earlier in the discussion I have suggested dynamic debugging facility.
Documentation/admin-guide/dynamic-debug-howto.rst. Have you tried to
look into that direction?

>  {
>         /* This function is based on compact_zone() from compaction.c. */
>         unsigned int nr_reclaimed;
> @@ -8522,7 +8523,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>                                 NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
>         }
>         if (ret < 0) {
> -               dump_migrate_failure_pages(&cc->migratepages);
> +               if (ret == -EBUSY && nofail)
> +                       dump_migrate_failure_pages(&cc->migratepages);
>                 putback_movable_pages(&cc->migratepages);
>                 return ret;
>         }
> @@ -8610,7 +8612,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>          * allocated.  So, if we fall through be sure to clear ret so that
>          * -EBUSY is not accidentally used or returned to caller.
>          */
> -       ret = __alloc_contig_migrate_range(&cc, start, end);
> +       ret = __alloc_contig_migrate_range(&cc, start, end,
> +                                       migratetype == CMA ||
> +                                       zone_idx(cc.zone) == ZONE_MOVABLE);
>         if (ret && ret != -EBUSY)
>                 goto done;
>         ret =0;

-- 
Michal Hocko
SUSE Labs
