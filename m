Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D62A33EE0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhCQKHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:07:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:35800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhCQKGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:06:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C410AC1F;
        Wed, 17 Mar 2021 10:06:40 +0000 (UTC)
Date:   Wed, 17 Mar 2021 11:06:37 +0100
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
Message-ID: <20210317100637.GB16479@linux>
References: <20210310150853.13541-1-osalvador@suse.de>
 <c7ba5bba-77fb-6c43-2067-2ebc83b014da@redhat.com>
 <b04aaf5534f9ec0a40937e23a2500fdf@suse.de>
 <01d2ee6a-f0aa-4580-b1f4-f0e8a2ded4f8@redhat.com>
 <20210317100518.GA16479@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317100518.GA16479@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 11:05:23AM +0100, Oscar Salvador wrote:
> From e97175b7d4970cbdcbafcf8c398f72a571e817b0 Mon Sep 17 00:00:00 2001
> From: Oscar Salvador <osalvador@suse.de>
> Date: Thu, 18 Mar 2021 05:03:18 +0100
> Subject: [PATCH] mm,page_alloc: Drop unnecesary checks from
>  pfn_range_valid_contig
> 
> pfn_range_valid_contig() bails out when it finds an in-use page or a
> hugetlb page, among other things.
> We can drop the in-use page check since __alloc_contig_pages can migrate
> away those pages, and the hugetlb page check can go too since
> isolate_migratepages_range is now capable of dealing with hugetlb pages.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Of course, missing a Suggested-by: David Hildenbrand <david@redhat.com>

 

-- 
Oscar Salvador
SUSE L3
