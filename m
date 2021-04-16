Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289DA361D60
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242065AbhDPJty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232022AbhDPJty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618566569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pL4/0WJEqGhEKqqgK/B3s9Ma+T2AYRInru9aztuxIYY=;
        b=Jx/o+UdlJHlTVBSGZY0cLX5+aogIIYs2D2vEJykfGX1QCbVtAAbdMJ3vOYmGypvXFxMKMN
        yGMba/MmMNpyPbSJdr3KiNWp2OlRikLM6bljvxMWP0BvDZC1RCEJE5ozLC9Ka60sOf0UWz
        CaBBHNAiqQXkwUGozA1wDwdUt+jR8oQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-mW1SmpBpNbC06zBXKRyOag-1; Fri, 16 Apr 2021 05:49:27 -0400
X-MC-Unique: mW1SmpBpNbC06zBXKRyOag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7A036D246;
        Fri, 16 Apr 2021 09:49:25 +0000 (UTC)
Received: from localhost (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04F6E6294D;
        Fri, 16 Apr 2021 09:49:22 +0000 (UTC)
Date:   Fri, 16 Apr 2021 17:49:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v9 5/7] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <20210416094920.GA8560@MiWiFi-R3L-srv>
References: <20210416070023.4742-1-osalvador@suse.de>
 <20210416070023.4742-6-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416070023.4742-6-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/21 at 09:00am, Oscar Salvador wrote:
...  
> +/*
> + * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
> + * @h: struct hstate old page belongs to
> + * @old_page: Old page to dissolve
> + * Returns 0 on success, otherwise negated error.
> + */
> +static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
> +{
> +	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
> +	int nid = page_to_nid(old_page);
> +	struct page *new_page;
> +	int ret = 0;
> +
> +	/*
> +	 * Before dissolving the page, we need to allocate a new one for the
> +	 * pool to remain stable. Using alloc_buddy_huge_page() allows us to
> +	 * not having to deal with prep_new_page() and avoids dealing of any
				   ~ prep_new_huge_page() ?
> +	 * counters. This simplifies and let us do the whole thing under the
> +	 * lock.
> +	 */
> +	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
> +	if (!new_page)
> +		return -ENOMEM;
> +
> +retry:
> +	spin_lock_irq(&hugetlb_lock);
...

