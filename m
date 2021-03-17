Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756BE33ED41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCQJoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:44:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:42194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhCQJnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:43:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22E7BAC75;
        Wed, 17 Mar 2021 09:43:54 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 17 Mar 2021 10:43:53 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 0/4] Make alloc_contig_range handle Hugetlb pages
In-Reply-To: <c7ba5bba-77fb-6c43-2067-2ebc83b014da@redhat.com>
References: <20210310150853.13541-1-osalvador@suse.de>
 <c7ba5bba-77fb-6c43-2067-2ebc83b014da@redhat.com>
User-Agent: Roundcube Webmail
Message-ID: <b04aaf5534f9ec0a40937e23a2500fdf@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-15 10:06, David Hildenbrand wrote:
> BTW, I stumbled yesterday over
> 
> alloc_contig_pages()->pfn_range_valid_contig():
> 
> 	if (page_count(page) > 0)
> 		rerurn false;
> 	if (PageHuge(page))
> 		return false;
> 
> As used by memtrace and for gigantic pages. We can now
> 
> a) Drop these check completely, as it's best-effort only and racy.
> alloc_contig_pages()/alloc_contig_range() will handle it properly.

I was preparing v5, and I wanted to be sure I understood you here.

Right you are that the in-use page check can be dropped, as those pages 
can
be migrated away, and the Hugetlb page check can also be dropped since
isolate_migratepages_range is now capable of dealing with those kind of 
pages.

> b) Similarly, check for gigantic pages and/or movability/migratability.

I lost you here.

isolate_or_dissolve_huge_page() already bails out on hugetlb-gigantic 
pages.

Or do you mean to place an upfront check here? (hstate_is_gigantic())?


-- 
Oscar Salvador
SUSE L3
