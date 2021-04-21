Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB06336673F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbhDUIrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:47:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:39432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhDUIrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:47:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D7ACB1AE;
        Wed, 21 Apr 2021 08:46:44 +0000 (UTC)
Date:   Wed, 21 Apr 2021 10:46:41 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <20210421084641.GG22456@linux>
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-5-osalvador@suse.de>
 <YH6zQ1Dty9kJFkuk@dhcp22.suse.cz>
 <20210421081546.GD22456@linux>
 <YH/ktDG/9o2OHNGj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH/ktDG/9o2OHNGj@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:39:16AM +0200, Michal Hocko wrote:
> Not that I would insist but I find it better to use common constructs
> when it doesn't hurt readability. The order evaluation can be even done
> in a trivial helper.

Uhm, I will have a look how it looks.
Maybe with a nice comment explaining what is going on can make it in.
If not, I can always keep what we have atm.

> As I've said I will not insist and this can be done in the follow up.
> You are iterating over memory blocks just to refuse to do an operation
> which can be split to several memory blocks. See
> http://lkml.kernel.org/r/YFtPxH0CT5QZsnR1@dhcp22.suse.cz and follow
> walk_memory_blocks(start, size, NULL, remove_memory_block_cb)

Ok, thanks for the link.
I will have a look, but I would rather do it as a follow-up.

-- 
Oscar Salvador
SUSE L3
