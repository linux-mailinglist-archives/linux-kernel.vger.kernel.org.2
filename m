Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E009434015E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhCRIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:55:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:46116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhCRIzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:55:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616057710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/4pFDfP/glft/+5Jx7HbMWg7z3f0/MvYTeDWR+6SiE=;
        b=U3AGjFN9o3XLqj4JkDySjo5GVRubTzteN+lNS6aZXaR/pEPe04UN590LXcbv8O7pkSvgs3
        X+QO+cjZpbYUkL5sWZg5GkG7uiCVYSozBdbxk04ej/5gk+vHNZEkEIr2U8xpo06giuag9w
        2zax6K2cL8LfUrdRwa7PrPtUVYkglh0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88ABEACC6;
        Thu, 18 Mar 2021 08:55:10 +0000 (UTC)
Date:   Thu, 18 Mar 2021 09:55:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] mm,page_alloc: Drop unnecessary checks from
 pfn_range_valid_contig
Message-ID: <YFMVbUVwm+x2H88z@dhcp22.suse.cz>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-6-osalvador@suse.de>
 <YFISpUUxusP4T1xw@dhcp22.suse.cz>
 <ef5560a4-8633-39bd-e433-6aa8f6ea4bfc@redhat.com>
 <YFIaKjg7X3jT2hhq@dhcp22.suse.cz>
 <YFMS46AOeZWwCYeK@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFMS46AOeZWwCYeK@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-03-21 09:44:19, Oscar Salvador wrote:
> On Wed, Mar 17, 2021 at 04:03:06PM +0100, Michal Hocko wrote:
> > > alloc_contig_pages() vs. alloc_contig_range(). The patches are active for
> > > virtio-mem and CMA AFAIKS.
> > 
> > yeah, I meant to say "are not actually fully active".
> 
> We could place this patch earlier in this patchset.
> The only thing is that we would lose the prevalidation (at leat for
> HugeTLB page) which is done upfront to find later on that we do not
> support hugetlb handling in isolate_migratepates_block.
> So the bad thing about placing it earlier, is that wrt. hugetlb pages,
> alloc_gigantic_page will take longer to fail (when we already know that
> will fail).

From a bisactability POV this shouldn't be a major concern. If you are
too worried then just drop the HugePage check in the patch allowing to
migrate free hugetlb pages. It is unlikely that somebody will run with
that patch alone but if the said patch introduces some sort of bug it
would be good to bisect down to it.

> Then we have the page_count check, which is also racy and
> isolate_migratepages_block will take care of it.
> So I guess can think of this patch as a preparatory patch that removes racy
> checks that will be re-checked later on in the end function which does
> the actual handling.

TBH, I do not care much about the page count check. It is comletely
orthogonal to the migration changes in this series. So both preparatory
and follow up are ok.

-- 
Michal Hocko
SUSE Labs
