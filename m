Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144AF33F258
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhCQOMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:12:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:49300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231458AbhCQOMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:12:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615990350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aAUcDe4pvPLn4fC/tremYQrLTY4DcLiLDV9Wbabr0yI=;
        b=qNXoN1DKzjDs4kcMcCP/zoOlx/Kirf7ZUCuEqfN4VYQZULteWQVKHEH2MhKdOSTNaW1oVI
        mDPKxwGzmFNTsRmdmY4LwnIT06xCAookjzKr0fgdOWF+YD0gTjuKarNw39oe0+T5wCyoNS
        MUGbIBtvsjgWCb18AeOV7UmI2TZ94dU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20616AC47;
        Wed, 17 Mar 2021 14:12:30 +0000 (UTC)
Date:   Wed, 17 Mar 2021 15:12:29 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] mm,compaction: Let
 isolate_migratepages_{range,block} return error codes
Message-ID: <YFIOTTC7wgXHQRpy@dhcp22.suse.cz>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317111251.17808-3-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 12:12:48, Oscar Salvador wrote:
> Currently, isolate_migratepages_{range,block} and their callers use
> a pfn == 0 vs pfn != 0 scheme to let the caller know whether there was
> any error during isolation.
> This does not work as soon as we need to start reporting different error
> codes and make sure we pass them down the chain, so they are properly
> interpreted by functions like e.g: alloc_contig_range.
> 
> Let us rework isolate_migratepages_{range,block} so we can report error
> codes.

Yes this is an improvement.

> Since isolate_migratepages_block will stop returning the next pfn to be
> scanned, we reuse the cc->migrate_pfn field to keep track of that.

This looks hakish and I cannot really tell that users of cc->migrate_pfn
work as intended.
> @@ -810,6 +811,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  	unsigned long next_skip_pfn = 0;
>  	bool skip_updated = false;
>  
> +	cc->migrate_pfn = low_pfn;
> +
>  	/*
>  	 * Ensure that there are not too many pages isolated from the LRU
>  	 * list by either parallel reclaimers or compaction. If there are,
> @@ -818,16 +821,16 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  	while (unlikely(too_many_isolated(pgdat))) {
>  		/* stop isolation if there are still pages not migrated */
>  		if (cc->nr_migratepages)
> -			return 0;
> +			return -EINTR;
>  
>  		/* async migration should just abort */
>  		if (cc->mode == MIGRATE_ASYNC)
> -			return 0;
> +			return -EINTR;

EINTR for anything other than signal based bail out is really confusing.
-- 
Michal Hocko
SUSE Labs
