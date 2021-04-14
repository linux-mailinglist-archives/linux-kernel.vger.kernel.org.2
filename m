Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D4535F1EC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhDNLJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:09:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:39826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhDNLJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:09:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618398547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A4XaU4bKYdWfQby7bgwaXDNXIbPwsiRHLSOMBCceY2I=;
        b=R+ggOnLW2VETOpmWnn8lSrH82PleP7/FcY+IVP5t1CFbnxl2qyU21bFQP3bKmpVmAvXIlR
        Sm/EwKhP1p3ujRe1HnzhUzV5b+NBODprpzeWqFUc6YrYMupklNP7OCbgJk1KeWio/Izldh
        X/cYiFh/UhWaAVUPj52XyQ0dvWgOYTs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3576CAF45;
        Wed, 14 Apr 2021 11:09:07 +0000 (UTC)
Date:   Wed, 14 Apr 2021 13:09:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] mm,hugetlb: Clear HPageFreed outside of the lock
Message-ID: <YHbNUjU1Y4sqMVBd@dhcp22.suse.cz>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-4-osalvador@suse.de>
 <YHWbPjgPpsLoqGvL@dhcp22.suse.cz>
 <b8f36340-df56-1180-2a14-7b20cc1a0cda@oracle.com>
 <YHaF5efHcJJ71UP9@dhcp22.suse.cz>
 <20210414074132.GB20401@linux>
 <YHansW/OnNT6/i9d@dhcp22.suse.cz>
 <20210414100147.GD20886@linux>
 <YHbE2q/Otrdx1cgK@dhcp22.suse.cz>
 <20210414104953.GF20886@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414104953.GF20886@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-04-21 12:49:53, Oscar Salvador wrote:
> On Wed, Apr 14, 2021 at 12:32:58PM +0200, Michal Hocko wrote:
[...]
> > > I checked, and when we get there in __alloc_bootmem_huge_page, page->private is
> > > still zeroed, so I guess it should be safe to assume that we do not really need
> > > to clear the flag in __prep_new_huge_page() routine?
> > 
> > It would be quite nasty if the struct pages content would be undefined.
> > Maybe that is possible but then I would rather stick the initialization
> > into __alloc_bootmem_huge_page.
> 
> Yes, but I do not think that is really possible unless I missed something.

Yeah, it should be fine. I was thinking of a alloc, modify struct pages,
free back to the bootmem allocator sequence. But I do not remember ever
seeing sequence like that. Bootmem allocator users tend to be simple,
allocate storage and either retain it for the life time. Other than
PageReserved bit they do not touch metadata. If we want to be paranoid
then we can add VM_WARN_ON for unexpected state when allocating from the
bootmem. But I am not sure this is really worth it.
-- 
Michal Hocko
SUSE Labs
