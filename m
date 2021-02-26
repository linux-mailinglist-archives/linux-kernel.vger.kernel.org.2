Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFF5325F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhBZIrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:47:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:50378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230199AbhBZIro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:47:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614329218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j6G83ahZDtYiFerun3sUeslIIVf/Z0b4Gpz4M3WMigY=;
        b=fSkzNTJtCQTQ/qzBGXzntlfnpi6JPRoSY8ESSQfRMKUq/K+0gW/MW+37fIbDrriunt/2vq
        0CiQy0aKPz6vd+SwWb4tsLFMxd1u8ajmPMD10dgwWT/U/Fr/bTnW8sLA5rSOyHl1JOdQus
        W8O2MjYv5/ZsoRCVmVvIQCI+mKod9HQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D742AC6E;
        Fri, 26 Feb 2021 08:46:58 +0000 (UTC)
Date:   Fri, 26 Feb 2021 09:46:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: Make alloc_contig_range handle in-use hugetlb
 pages
Message-ID: <YDi1gSdDXErJ+SHK@dhcp22.suse.cz>
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222135137.25717-3-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-02-21 14:51:37, Oscar Salvador wrote:
[...]
> @@ -2394,9 +2397,19 @@ bool isolate_or_dissolve_huge_page(struct page *page)
>  	 */
>  	if (hstate_is_gigantic(h))
>  		return ret;
> -
> -	if (!page_count(head) && alloc_and_dissolve_huge_page(h, head))
> +retry:
> +	if (page_count(head) && isolate_huge_page(head, list)) {
>  		ret = true;
> +	} else if (!page_count(head)) {

This is rather head spinning. Do we need to test page_count in the else
branch? Do you want to optimize for a case where the page cannot be
isolated because of page_huge_active?

> +		int err = alloc_and_dissolve_huge_page(h, head);
> +
> +		if (!err) {
> +			ret = true;
> +		} else if (err == -EBUSY && try_again) {
> +			try_again = false;
> +			goto retry;
> +		}

Is this retry once logic really needed? Does it really give us any real
benefit? alloc_and_dissolve_huge_page already retries when the page is
being freed.

-- 
Michal Hocko
SUSE Labs
