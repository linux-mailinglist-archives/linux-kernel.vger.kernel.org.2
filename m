Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCBC34A3D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCZJMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:51642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhCZJLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:11:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616749911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v3Fgha7MpTSL8OTwDMUJAwK0cmAs0bMFt44LOcSj2mU=;
        b=c976bR14od94zSckadW8vjQ8Zci7Wj5DGuL8+T3jheSTsTWtvw4fJY00fcz3SXs4SsfWf6
        +XN4O3Bz6G7mxnNZ0AtXtlhk+f8YWPRxS+tj1ary5ArZj6zfFgZs+rG0tK1P1vZqPM12Rc
        XsD12oNpMHMyydTu3qiSN0AKBuOBaWw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98AFBAA55;
        Fri, 26 Mar 2021 09:11:51 +0000 (UTC)
Date:   Fri, 26 Mar 2021 10:11:51 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YF2lV8ow7zqgUVqV@dhcp22.suse.cz>
References: <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz>
 <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz>
 <YFy+olsdS4iwrovN@dhcp22.suse.cz>
 <YF0JerCFXzcmMKzp@localhost.localdomain>
 <YF2ct/UZUBG1GcM3@dhcp22.suse.cz>
 <YF2hZ5Q27yb6jC7w@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YF2hZ5Q27yb6jC7w@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-03-21 09:55:03, Oscar Salvador wrote:
> On Fri, Mar 26, 2021 at 09:35:03AM +0100, Michal Hocko wrote:
[...]
> > Yes this is much better! Just a minor suggestion would be to push
> > memory_block all the way to memory_block_online (it oline a memory
> > block). I would also slightly prefer to provide 2 helpers that would make
> > it clear that this is to reserve/cleanup the vmemamp space (defined in
> > the memory_hotplug proper).
> 
> Glad to hear that!
> By pushing memory_block all the way to memory_block_{online,offline}, you
> mean passing the memblock struct together with nr_vmemmap_pages,
> only_type and nid to memory_block_{offline,online}, and derive in there
> the start_pfn and nr_pages?

memory_block + online_type should be sufficient.
-- 
Michal Hocko
SUSE Labs
