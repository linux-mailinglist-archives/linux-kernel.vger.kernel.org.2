Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3C236670D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhDUIgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:36:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:32956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234407AbhDUIgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:36:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 83531B143;
        Wed, 21 Apr 2021 08:35:28 +0000 (UTC)
Date:   Wed, 21 Apr 2021 10:35:26 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/8] mm,memory_hotplug: Factor out adjusting present
 pages into adjust_present_page_count()
Message-ID: <20210421083525.GF22456@linux>
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-4-osalvador@suse.de>
 <YH6i09ieDte+xog8@dhcp22.suse.cz>
 <20210421080036.GC22456@linux>
 <YH/i4nfrqt2k0mzZ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH/i4nfrqt2k0mzZ@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:31:30AM +0200, Michal Hocko wrote:
> > Given that {offline,online}_pages() is serialized by the memory_hotplug lock,
> > I would say that {node,zone}->{spanned,present}_pages is, at any time, stable?
> > So, no need for the lock even without considering this patch?
> 
> Yes. The resize lock is really only relevant to the parallel struct page
> initialization during early boot. The hotplug usage seems just a left
> over from the past or maybe it has never been really relevant in that
> context.

Ok, I will prepare a follow-up patch to remove the lock in such situations
when this work goes in.


-- 
Oscar Salvador
SUSE L3
