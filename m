Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDFE340124
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhCRIol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:44:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:57478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229806AbhCRIoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:44:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62B29AC17;
        Thu, 18 Mar 2021 08:44:22 +0000 (UTC)
Date:   Thu, 18 Mar 2021 09:44:19 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] mm,page_alloc: Drop unnecessary checks from
 pfn_range_valid_contig
Message-ID: <YFMS46AOeZWwCYeK@localhost.localdomain>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-6-osalvador@suse.de>
 <YFISpUUxusP4T1xw@dhcp22.suse.cz>
 <ef5560a4-8633-39bd-e433-6aa8f6ea4bfc@redhat.com>
 <YFIaKjg7X3jT2hhq@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFIaKjg7X3jT2hhq@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 04:03:06PM +0100, Michal Hocko wrote:
> > alloc_contig_pages() vs. alloc_contig_range(). The patches are active for
> > virtio-mem and CMA AFAIKS.
> 
> yeah, I meant to say "are not actually fully active".

We could place this patch earlier in this patchset.
The only thing is that we would lose the prevalidation (at leat for
HugeTLB page) which is done upfront to find later on that we do not
support hugetlb handling in isolate_migratepates_block.
So the bad thing about placing it earlier, is that wrt. hugetlb pages,
alloc_gigantic_page will take longer to fail (when we already know that
will fail).

Then we have the page_count check, which is also racy and
isolate_migratepages_block will take care of it.
So I guess can think of this patch as a preparatory patch that removes racy
checks that will be re-checked later on in the end function which does
the actual handling.

What do you think?

-- 
Oscar Salvador
SUSE L3
