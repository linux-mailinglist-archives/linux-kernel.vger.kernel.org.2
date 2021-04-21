Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37106366654
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhDUHlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:41:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:57540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235209AbhDUHlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:41:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 929D6B13D;
        Wed, 21 Apr 2021 07:40:50 +0000 (UTC)
Date:   Wed, 21 Apr 2021 08:40:47 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH -V3] NUMA balancing: reduce TLB flush via delaying
 mapping on hint page fault
Message-ID: <20210421074047.GD15768@suse.de>
References: <20210408132236.1175607-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210408132236.1175607-1-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 09:22:36PM +0800, Huang Ying wrote:
> With NUMA balancing, in hint page fault handler, the faulting page
> will be migrated to the accessing node if necessary.  During the
> migration, TLB will be shot down on all CPUs that the process has run
> on recently.  Because in the hint page fault handler, the PTE will be
> made accessible before the migration is tried.  The overhead of TLB
> shooting down can be high, so it's better to be avoided if possible.
> In fact, if we delay mapping the page until migration, that can be
> avoided.  This is what this patch doing.
> 

<SNIP>

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Mel Gorman <mgorman@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: "Matthew Wilcox" <willy@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: Arjun Roy <arjunroy@google.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Hi Andrew,

I do not see this in the mmots tree. Was something missed in this patch
that needs fixing or did it just fall through the cracks?

Thanks.

-- 
Mel Gorman
SUSE Labs
