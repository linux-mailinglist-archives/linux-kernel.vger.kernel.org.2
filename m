Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06521422259
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhJEJfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:35:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35564 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJEJfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:35:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46A3A223DC;
        Tue,  5 Oct 2021 09:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633426403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HAkjnMZVZvrpnMAU3yhNhqnfSKBwfeJfs42ZqvYDQ1Y=;
        b=1KumHG76VHzfHN2eakwr7m9Rc6GOy1OJfBHrjb4jpEMb/HbyLu/N1YH3r+9su3ixr8o3Up
        6D46D8zPhUq34xHqEqWG7UiVVa2qPiS48BCjSrcLEa9Id7DXSDK0q1Y3tNvrhzUiP+F8Fu
        EiRepmwDV4fLz8vk15FbI5UzdxLHpVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633426403;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HAkjnMZVZvrpnMAU3yhNhqnfSKBwfeJfs42ZqvYDQ1Y=;
        b=OO6tJsgZZ+3OA7Loi8gYvviGwUKYllMZVI9QLngFAXg5XYSQCi6OuBdODB6ZqC8NTBaI8q
        7+STM7QX4c2hwqDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA6C713C1E;
        Tue,  5 Oct 2021 09:33:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g4cOJ+IbXGGKBQAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 05 Oct 2021 09:33:22 +0000
Date:   Tue, 5 Oct 2021 11:33:21 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/5] hugetlb: be sure to free demoted CMA pages to CMA
Message-ID: <20211005093320.GC20412@linux>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001175210.45968-4-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 10:52:08AM -0700, Mike Kravetz wrote:
> When huge page demotion is fully implemented, gigantic pages can be
> demoted to a smaller huge page size.  For example, on x86 a 1G page
> can be demoted to 512 2M pages.  However, gigantic pages can potentially
> be allocated from CMA.  If a gigantic page which was allocated from CMA
> is demoted, the corresponding demoted pages needs to be returned to CMA.
> 
> Use the new interface cma_pages_valid() to determine if a non-gigantic
> hugetlb page should be freed to CMA.  Also, clear mapping field of these
> pages as expected by cma_release.
> 
> This also requires a change to CMA reservations for gigantic pages.
> Currently, the 'order_per_bit' is set to the gigantic page size.
> However, if gigantic pages can be demoted this needs to be set to the
> order of the smallest huge page.  At CMA reservation time we do not know

to the smallest, or to the next smaller? Would you mind elaborating why?

> @@ -3003,7 +3020,8 @@ static void __init hugetlb_init_hstates(void)
>  		 *   is not supported.
>  		 */
>  		if (!hstate_is_gigantic(h) ||
> -		    gigantic_page_runtime_supported()) {
> +		    gigantic_page_runtime_supported() ||
> +		    !hugetlb_cma_size || !(h->order <= HUGETLB_PAGE_ORDER)) {

I am bit lost in the CMA area, so bear with me.
We do not allow to demote if we specify we want hugetlb pages from the CMA?
Also, can h->order be smaller than HUGETLB_PAGE_ORDER? I though
HUGETLB_PAGE_ORDER was the smallest one.

The check for HUGETLB_PAGE_ORDER can probably be squashed into patch#1.


>  			for_each_hstate(h2) {
>  				if (h2 == h)
>  					continue;
> @@ -3555,6 +3573,8 @@ static ssize_t demote_size_store(struct kobject *kobj,
>  	if (!t_hstate)
>  		return -EINVAL;
>  	demote_order = t_hstate->order;
> +	if (demote_order < HUGETLB_PAGE_ORDER)
> +		return -EINVAL;

This could probably go in the first patch.


-- 
Oscar Salvador
SUSE Labs
