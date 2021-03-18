Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F2F3404C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhCRLiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:38:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:45646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhCRLiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:38:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616067482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5en59u2vhZFX9B//yzzeVhhgJpV6/PW65MgkV2h14ek=;
        b=t4zk6oPAgCfU9r48PlULtgbLpV0TdPucVWM4kwM5Yt7TGi1GFxiSgTklp2BU7u/5Wb1S1k
        5TxgV9gKvRS8Dhk1lbx1Syh9Ng1oNSA9yXzRFpxVAjdx0S/Jc+QV9YAdLWH8lcPj7Olpm2
        S33IKdc8eXKGeTw6WXrbotHPSUr0QOc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B49AACBF;
        Thu, 18 Mar 2021 11:38:02 +0000 (UTC)
Date:   Thu, 18 Mar 2021 12:37:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,page_alloc: Bail out earlier on -ENOMEM in
 alloc_contig_migrate_range
Message-ID: <YFM7iFnwlLFUSiAz@dhcp22.suse.cz>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-2-osalvador@suse.de>
 <YFIMtFu/g3jtGqA8@dhcp22.suse.cz>
 <YFMzoBpuzoA0EswZ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFMzoBpuzoA0EswZ@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-03-21 12:04:00, Oscar Salvador wrote:
> On Wed, Mar 17, 2021 at 03:05:40PM +0100, Michal Hocko wrote:
> > That being said, bailing out early makes sense to me. But now that
> > you've made me look into the migrate_pages excellent error state reporting
> > I suspect we have a bug here. Note the 
> > "Returns the number of pages that were not migrated, or an error code."
> > 
> > but I do not see putback_movable_pages for ret > 0 so it seems we might
> > leak some pages.
> 
> I fell for the same thing when looking at that code.
> It took a while until I realized what was really going on.
> 
> > > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > 
> > The patch itself looks reasonable but make sure to mention this is mere
> > cosmetic change unless there is a real problem fixed by this.
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> What about appending the following in the changelog:
> 
> "Note that this is not fixing a real issue, just a cosmetic change. Although
>  we can save some cycles by backing off ealier."

Sounds good to me.

-- 
Michal Hocko
SUSE Labs
