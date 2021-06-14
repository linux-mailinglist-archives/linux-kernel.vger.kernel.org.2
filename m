Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428623A5BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 05:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhFND3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 23:29:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:52852 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232234AbhFND3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 23:29:45 -0400
IronPort-SDR: KupOB5hfxB3oaNnpdZ9ToTGjvWW+wGcjTXM70cf7HazX0WVrjKbRBMDEustZAn6eOAGQ6Mtc7T
 BUv/2SiRO79A==
X-IronPort-AV: E=McAfee;i="6200,9189,10014"; a="227203653"
X-IronPort-AV: E=Sophos;i="5.83,272,1616482800"; 
   d="scan'208";a="227203653"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2021 20:27:42 -0700
IronPort-SDR: EjXik5Pp2tDTDfva1Kobz5H0HHfNfIo0XIblIn7buh4lDzbfCxOktC6k2znQvY+Uibbl9fiQaF
 XZWULawo/jwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,272,1616482800"; 
   d="scan'208";a="483947534"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2021 20:27:39 -0700
Date:   Mon, 14 Jun 2021 11:27:39 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] mm: relocate 'write_protect_seq' in struct mm_struct
Message-ID: <20210614032738.GA72794@shbuild999.sh.intel.com>
References: <1623376482-92265-1-git-send-email-feng.tang@intel.com>
 <20210611170917.GW1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611170917.GW1002214@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Jun 11, 2021 at 02:09:17PM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 11, 2021 at 09:54:42AM +0800, Feng Tang wrote:
> > 0day robot reported a 9.2% regression for will-it-scale mmap1 test
> > case[1], caused by commit 57efa1fe5957 ("mm/gup: prevent gup_fast
> > from racing with COW during fork").
> > 
> > Further debug shows the regression is due to that commit changes
> > the offset of hot fields 'mmap_lock' inside structure 'mm_struct',
> > thus some cache alignment changes.
> > 
> > From the perf data, the contention for 'mmap_lock' is very severe
> > and takes around 95% cpu cycles, and it is a rw_semaphore
> > 
> >         struct rw_semaphore {
> >                 atomic_long_t count;	/* 8 bytes */
> >                 atomic_long_t owner;	/* 8 bytes */
> >                 struct optimistic_spin_queue osq; /* spinner MCS lock */
> >                 ...
> > 
> > Before commit 57efa1fe5957 adds the 'write_protect_seq', it
> > happens to have a very optimal cache alignment layout, as
> > Linus explained:
> > 
> >  "and before the addition of the 'write_protect_seq' field, the
> >   mmap_sem was at offset 120 in 'struct mm_struct'.
> > 
> >   Which meant that count and owner were in two different cachelines,
> >   and then when you have contention and spend time in
> >   rwsem_down_write_slowpath(), this is probably *exactly* the kind
> >   of layout you want.
> > 
> >   Because first the rwsem_write_trylock() will do a cmpxchg on the
> >   first cacheline (for the optimistic fast-path), and then in the
> >   case of contention, rwsem_down_write_slowpath() will just access
> >   the second cacheline.
> > 
> >   Which is probably just optimal for a load that spends a lot of
> >   time contended - new waiters touch that first cacheline, and then
> >   they queue themselves up on the second cacheline."
> > 
> > After the commit, the rw_semaphore is at offset 128, which means
> > the 'count' and 'owner' fields are now in the same cacheline,
> > and causes more cache bouncing.
> > 
> > Currently there are 3 "#ifdef CONFIG_XXX" before 'mmap_lock' which
> > will affect its offset:
> > 
> >   CONFIG_MMU
> >   CONFIG_MEMBARRIER
> >   CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
> > 
> > The layout above is on 64 bits system with 0day's default kernel
> > config (similar to RHEL-8.3's config), in which all these 3 options
> > are 'y'. And the layout can vary with different kernel configs.
> > 
> > Relayouting a structure is usually a double-edged sword, as sometimes
> > it can helps one case, but hurt other cases. For this case, one
> > solution is, as the newly added 'write_protect_seq' is a 4 bytes long
> > seqcount_t (when CONFIG_DEBUG_LOCK_ALLOC=n), placing it into an
> > existing 4 bytes hole in 'mm_struct' will not change other fields'
> > alignment, while restoring the regression. 
> > 
> > [1]. https://lore.kernel.org/lkml/20210525031636.GB7744@xsang-OptiPlex-9020/
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/mm_types.h | 27 ++++++++++++++++++++-------
> >  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> It seems Ok to me, but didn't we earlier add the has_pinned which
> would have changed the layout too? Are we chasing performance delta's
> nobody cares about?

Good point! I checked my email folder for 0day's reports, and haven't
found a report related with Peter's commit 008cfe4418b3 ("mm: Introduce
mm_struct.has_pinned) which adds 'has_pinned' field. 

Will run the same test for it and report back.

> Still it is mechanically fine, so:
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks for the review!

- Feng

> Jason
