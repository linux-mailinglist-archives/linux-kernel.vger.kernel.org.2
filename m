Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2827332208
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhCIJdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:33:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:44372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhCIJcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:32:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615282372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5znd/pgvgMNDcAR2+Aut9Ydbw5Kn9mq5Jdv+6AENPIo=;
        b=PxEHMEWiyjt9cIYVsi5TIqt7RDy732YHueBM2A4Cau0bjmbTmk4pJNNQQ5uppLFn9AHxNR
        rSy9U7gucB5fdjTUSaQn0Ekt7Xn4Y9MX+qR8u6Qp7SwACo7KKm61fephhAd2CUs1Bij9tw
        bUXTmZ5U6QVTvq/W7Ipy+74wtGaWsks=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90CECAD73;
        Tue,  9 Mar 2021 09:32:52 +0000 (UTC)
Date:   Tue, 9 Mar 2021 10:32:51 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
References: <20210308202047.1903802-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308202047.1903802-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08-03-21 12:20:47, Minchan Kim wrote:
> alloc_contig_range is usually used on cma area or movable zone.
> It's critical if the page migration fails on those areas so
> dump more debugging message.

I disagree with this statement. alloc_contig_range is not a reliable
allocator. Any user, be it CMA or direct users of alloc_contig_range
have to deal with allocation failures. Debugging information can be
still useful but considering migration failures critical is
overstatement to say the least.

> page refcount, mapcount with page flags on dump_page are
> helpful information to deduce the culprit. Furthermore,
> dump_page_owner was super helpful to find long term pinner
> who initiated the page allocation.
> 
> Admin could enable the dump like this(by default, disabled)
> 
> 	echo "func dump_migrate_failure_pages +p" > control
> 
> Admin could disable it.
> 
> 	echo "func dump_migrate_failure_pages =_" > control

My original idea was to add few pr_debug and -DDYNAMIC_DEBUG_MODULE for
page_alloc.c. It makes sense to enable a whole bunch at once though.
The naming should better reflect this is alloc_contig_rage related
because the above sounds like a generic migration failure thing.

Somebody more familiar with the dynamic debugging infrastructure needs
to have a look but from from a quick look it seems ok.

Do we really need all the ugly ifdefery, though? Don't we want to have
this compiled in all the time and just rely on the static branch managed
by the dynamic debugging framework?
 
[...]
> +void dump_migrate_failure_pages(struct list_head *page_list)
> +{
> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> +			"migrate failure");
> +	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&
> +			alloc_contig_ratelimit()) {
> +		struct page *page;
> +
> +		WARN(1, "failed callstack");
> +		list_for_each_entry(page, page_list, lru)
> +			dump_page(page, "migration failure");
> +	}

Apart from the above, do we have to warn for something that is a
debugging aid? A similar concern wrt dump_page which uses pr_warn and
page owner is using even pr_alert.
Would it make sense to add a loglevel parameter both into __dump_page
and dump_page_owner?
-- 
Michal Hocko
SUSE Labs
