Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7691E32727D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 14:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhB1No0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 08:44:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:34778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhB1NoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 08:44:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0EC38AB7D;
        Sun, 28 Feb 2021 13:43:43 +0000 (UTC)
Date:   Sun, 28 Feb 2021 14:43:40 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: Make alloc_contig_range handle in-use hugetlb
 pages
Message-ID: <20210228134340.GA3292@localhost.localdomain>
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-3-osalvador@suse.de>
 <YDi1gSdDXErJ+SHK@dhcp22.suse.cz>
 <20210226102424.GA3557@linux>
 <YDjtnWxYoysUtSKs@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDjtnWxYoysUtSKs@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 01:46:21PM +0100, Michal Hocko wrote:
> Well, I will leave it to others. I do not feel strongly about this but
> to me it makes the code harder to think about because the situation is
> unstable and any of those condition can change as they are evaluated. So
> an explicit checks makes the code harder in the end. I would simply got
> with 
> 	if (isolate_huge_page(head, list) || !alloc_and_dissolve_huge_page())
> 		ret = true;
> 
> if either of the conditional needs a retry then it should be done
> internally. Like alloc_and_dissolve_huge_page already does to stabilize
> the PageFreed flag. An early bail out on non-free hugetlb page would
> also better be done inside alloc_and_dissolve_huge_page.

The retry could be done internally in alloc_and_dissolve_huge_page in
case someoen grabbed the page from under us, but calling
isolate_huge_page from there seemed a bit odd to me, that is why I
placed the logic in the outter function.
It looks more logic to me, but of course, that is just my taste.

I do not think it makes the code that hard to follow, but I will leave
it to the others.
If there is a consensus that a simplistic version is prefered, I do not
have a problem to go with that.

Mike, what is your take on this?

Thanks


-- 
Oscar Salvador
SUSE L3
