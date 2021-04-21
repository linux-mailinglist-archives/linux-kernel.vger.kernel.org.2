Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5D2366651
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbhDUHiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:38:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:56036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235107AbhDUHiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:38:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A70FB118;
        Wed, 21 Apr 2021 07:37:47 +0000 (UTC)
Date:   Wed, 21 Apr 2021 09:37:44 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/8] mm,memory_hotplug: Relax fully spanned sections
 check
Message-ID: <20210421073744.GB22456@linux>
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-3-osalvador@suse.de>
 <YH6hoieSEFtSUfMQ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH6hoieSEFtSUfMQ@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 11:40:50AM +0200, Michal Hocko wrote:
> On Fri 16-04-21 13:24:05, Oscar Salvador wrote:
> > When using self-hosted vmemmap pages, the number of pages passed to
> > {online,offline}_pages might not fully span sections, but they always
> > fully span pageblocks.
> > Relax the check account for that case.
> 
> It would be good to call those out explicitly.  It would be also
> great to explain why pageblock_nr_pages is an actual constrain. There
> shouldn't be any real reason for that except for "we want online_pages
> to operate on whole memblocks and memmap_on_memory will poke
> pageblock_nr_pages aligned holes in the beginning which is a special
> case we want to allow."

Sounds good.

> 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> With the changelog extended and the comment clarification (se below)
> feel free to add

Ok, thanks for the suggestion Michal.

> Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Oscar Salvador
SUSE L3
