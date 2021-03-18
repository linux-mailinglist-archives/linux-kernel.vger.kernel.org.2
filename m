Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECD7340426
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhCRLES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:04:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:52304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhCRLEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:04:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DBB43AC1E;
        Thu, 18 Mar 2021 11:04:02 +0000 (UTC)
Date:   Thu, 18 Mar 2021 12:04:00 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,page_alloc: Bail out earlier on -ENOMEM in
 alloc_contig_migrate_range
Message-ID: <YFMzoBpuzoA0EswZ@localhost.localdomain>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-2-osalvador@suse.de>
 <YFIMtFu/g3jtGqA8@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFIMtFu/g3jtGqA8@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 03:05:40PM +0100, Michal Hocko wrote:
> That being said, bailing out early makes sense to me. But now that
> you've made me look into the migrate_pages excellent error state reporting
> I suspect we have a bug here. Note the 
> "Returns the number of pages that were not migrated, or an error code."
> 
> but I do not see putback_movable_pages for ret > 0 so it seems we might
> leak some pages.

I fell for the same thing when looking at that code.
It took a while until I realized what was really going on.

> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> The patch itself looks reasonable but make sure to mention this is mere
> cosmetic change unless there is a real problem fixed by this.
> Acked-by: Michal Hocko <mhocko@suse.com>

What about appending the following in the changelog:

"Note that this is not fixing a real issue, just a cosmetic change. Although
 we can save some cycles by backing off ealier."


-- 
Oscar Salvador
SUSE L3
