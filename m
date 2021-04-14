Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971A135F1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhDNKuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:50:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:59058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233897AbhDNKuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:50:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24B63AE56;
        Wed, 14 Apr 2021 10:49:56 +0000 (UTC)
Date:   Wed, 14 Apr 2021 12:49:53 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] mm,hugetlb: Clear HPageFreed outside of the lock
Message-ID: <20210414104953.GF20886@linux>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-4-osalvador@suse.de>
 <YHWbPjgPpsLoqGvL@dhcp22.suse.cz>
 <b8f36340-df56-1180-2a14-7b20cc1a0cda@oracle.com>
 <YHaF5efHcJJ71UP9@dhcp22.suse.cz>
 <20210414074132.GB20401@linux>
 <YHansW/OnNT6/i9d@dhcp22.suse.cz>
 <20210414100147.GD20886@linux>
 <YHbE2q/Otrdx1cgK@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHbE2q/Otrdx1cgK@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 12:32:58PM +0200, Michal Hocko wrote:
> Well, to be precise it does the very same thing with memamp struct pages
> but that is before the initialization code you have pointed out above.
> In this context it just poisons the allocated content which is the GB
> page storage.

Right.

> > I checked, and when we get there in __alloc_bootmem_huge_page, page->private is
> > still zeroed, so I guess it should be safe to assume that we do not really need
> > to clear the flag in __prep_new_huge_page() routine?
> 
> It would be quite nasty if the struct pages content would be undefined.
> Maybe that is possible but then I would rather stick the initialization
> into __alloc_bootmem_huge_page.

Yes, but I do not think that is really possible unless I missed something.
Let us see what Mike thinks of it, if there are no objections, we can
get rid of the clearing flag right there.
 

-- 
Oscar Salvador
SUSE L3
