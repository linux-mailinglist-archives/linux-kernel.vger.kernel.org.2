Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE693404BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCRLhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:37:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:44216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230040AbhCRLgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:36:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616067413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=24G/r1E30AsZUF/AX2sBqmyTAaBuuLlWiniW9BDlFVY=;
        b=dK4ZcYlITSWaT2BhBlATmz41BctAGbnEt7bb2lrk4k2Pi1sG4x1nDELIBTGwIFzWYR1u2/
        NmdwTs/JeEoCjoLsU41oGDNrn4cZHZ7uZ3K4iuFo5nyGB5fW9ZN6JT5B1L1QjK+99vntkM
        Lr/GO3lVtGgbsog/+1sOMPyxI3mFQeg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0CF08AC75;
        Thu, 18 Mar 2021 11:36:53 +0000 (UTC)
Date:   Thu, 18 Mar 2021 12:36:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] mm,compaction: Let
 isolate_migratepages_{range,block} return error codes
Message-ID: <YFM7VPo06EuzfN4b@dhcp22.suse.cz>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-3-osalvador@suse.de>
 <YFIOTTC7wgXHQRpy@dhcp22.suse.cz>
 <20210317143827.GA20965@linux>
 <YFIZVvQllaZHDgzW@dhcp22.suse.cz>
 <843f68e7-6fe6-54e7-976b-af8647482ac1@suse.cz>
 <YFMprphu2jEf+OY7@dhcp22.suse.cz>
 <5b294e86-e6a4-71ea-6a7e-1a611c6ccccf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b294e86-e6a4-71ea-6a7e-1a611c6ccccf@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-03-21 12:10:14, Vlastimil Babka wrote:
> On 3/18/21 11:22 AM, Michal Hocko wrote:
[...]
> > E.g. something like the following
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 1432feec62df..6c5a9066adf0 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -225,7 +225,13 @@ struct compact_control {
> >  	unsigned int nr_freepages;	/* Number of isolated free pages */
> >  	unsigned int nr_migratepages;	/* Number of pages to migrate */
> >  	unsigned long free_pfn;		/* isolate_freepages search base */
> > -	unsigned long migrate_pfn;	/* isolate_migratepages search base */
> > +	unsigned long migrate_pfn;	/* Acts as an in/out parameter to page
> > +					 * isolation.
> > +					 * isolate_migratepages uses it as a search base.
> > +					 * isolate_migratepages_block will update the
> > +					 * value the next pfn after the last isolated
> > +					 * one.
> > +					 */
> 
> Fair enough. I would even stop pretending we might cram something useful in the
> rest of the line, and move all the comments to blocks before the variables.
> There might be more of them that would deserve more thorough description.

Yeah, makes sense. I am not a fan of the above form of documentation.
Btw. maybe renaming the field would be even better, both from the
intention and review all existing users. I would go with pfn_iter or
something that wouldn't make it sound like migration specific.

-- 
Michal Hocko
SUSE Labs
