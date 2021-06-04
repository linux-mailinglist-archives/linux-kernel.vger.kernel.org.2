Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E8739B429
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFDHne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:43:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37290 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFDHne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:43:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9850B219E9;
        Fri,  4 Jun 2021 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622792507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OCJHiaHES5BuDs/gVUVDCwQLKeuhbXghDp90XR0ftTs=;
        b=T+/p15KxhWJpfWTtIvkPdqUYlCbUQfjJ06irGFuIk8wQHYJDxL+G7n2QLzzoSJyUkd0x2s
        IsW+8qyxY/VMAGjU5JaCH+vFvcAa16VNBuSTgbaPcVBgK1O+wh4ja0O9R1+vCU9hscDEkl
        8CCShoNSx4rG7Ze1lBUOETvhO+hzU6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622792507;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OCJHiaHES5BuDs/gVUVDCwQLKeuhbXghDp90XR0ftTs=;
        b=tPhbeY/dIw5Z9aXDsHMpJeJhLtwRDml85xhO1FXgmzOC/LdAJSXxyk39lhOFHfr+snCCf+
        VjcQleX4W9ySE8Ag==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 16B72118DD;
        Fri,  4 Jun 2021 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622792507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OCJHiaHES5BuDs/gVUVDCwQLKeuhbXghDp90XR0ftTs=;
        b=T+/p15KxhWJpfWTtIvkPdqUYlCbUQfjJ06irGFuIk8wQHYJDxL+G7n2QLzzoSJyUkd0x2s
        IsW+8qyxY/VMAGjU5JaCH+vFvcAa16VNBuSTgbaPcVBgK1O+wh4ja0O9R1+vCU9hscDEkl
        8CCShoNSx4rG7Ze1lBUOETvhO+hzU6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622792507;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OCJHiaHES5BuDs/gVUVDCwQLKeuhbXghDp90XR0ftTs=;
        b=tPhbeY/dIw5Z9aXDsHMpJeJhLtwRDml85xhO1FXgmzOC/LdAJSXxyk39lhOFHfr+snCCf+
        VjcQleX4W9ySE8Ag==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id gZpPAjvZuWDdQAAALh3uQQ
        (envelope-from <osalvador@suse.de>); Fri, 04 Jun 2021 07:41:47 +0000
Date:   Fri, 4 Jun 2021 09:41:45 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm,page_alloc: Use {get,put}_online_mems() to get
 stable zone's values
Message-ID: <20210604074140.GA25063@linux>
References: <20210602091457.17772-1-osalvador@suse.de>
 <20210602091457.17772-2-osalvador@suse.de>
 <39473305-6e91-262d-bcc2-76b745a5b14a@redhat.com>
 <ed17a39ad61edeb19b04c0f4308d5d36@suse.de>
 <YLiVAAsCTR7B6Db9@localhost.localdomain>
 <YLjO2YU2G5fTVB3x@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLjO2YU2G5fTVB3x@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 02:45:13PM +0200, Michal Hocko wrote:
> I believe we need to define the purpose of the locking first. The

If you ask me, this locking would be meant to make sure zone's zone_start_pfn
or spanned_pages do not change under us, in case we __need__ the value to be
stable.

> existing locking doesn't serve much purpose, does it? The state might

Well, half-way. Currently, the locking is taken in write mode whenever
the zone is expanded or shrinked, and in read mode when called from
bad_range()->page_outside_zone_boundaries() (only on VM_DEBUG).

But as you pointed out, such state might change right after the locking is
released and all the work would be for nothing.
So indeed, the __whole__ operation should be envolved by the lock in the caller
The way that stands right now is not optimal.

> change right after the lock is released and the caller cannot really
> rely on the result. So aside of the current implementation, I would
> argue that any locking has to be be done on the caller layer.
> 
> But the primary question is whether anybody actually cares about
> potential races in the first place.

I have been checking move_freepages_block() and alloc_contig_pages(), which
are two of the functions that call zone_spans_pfn().

move_freepages_block() uses it in a way to align the given pfn to pageblock
top and bottom, and then check that aligned pfns are still within the same zone.
From a memory-hotplug perspective that's ok as we know that we are offlining
PAGES_PER_SECTION (which implies whole pageblocks).

alloc_contig_pages() (used by the hugetlb gigantic allocator) runs through a
node's zonelist and checks whether zone->zone_start_pfn + nr_pages stays within
the same zone.
IMHO, the race with zone_spans_last_pfn() vs mem-hotplug would not be that bad,
as it will be caught afters by e.g: __alloc_contig_pages when pages cannot be
isolated because they are offline etc.

So, I would say we do not really need the lock, but I might be missing something.
But if we chose to care about this, then the locking should be done right, not
half-way as it is right now.


-- 
Oscar Salvador
SUSE L3
