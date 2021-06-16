Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838313A8E94
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhFPBx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:53:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:45257 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbhFPBxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:53:25 -0400
IronPort-SDR: GdgDF8a2aED4qQM0jr8u2dnaPWEfO3uTzE8qlYywc0dYEcPEtn/nVsERQlAHYqRdSz3v13YHwd
 UQzjGlitm2tg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="205917409"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="205917409"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 18:51:20 -0700
IronPort-SDR: U5fC1bgIU8nt2ppwlZbxbXYV1JHh+KiKdHS5yY6JJPRGtkAQsZ0RqHBJDo76W7L2SmjvhpGbIt
 QYwplAfkgRHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="421319755"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga002.jf.intel.com with ESMTP; 15 Jun 2021 18:51:18 -0700
Date:   Wed, 16 Jun 2021 09:51:17 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [PATCH] mm: relocate 'write_protect_seq' in struct mm_struct
Message-ID: <20210616015117.GA55795@shbuild999.sh.intel.com>
References: <1623376482-92265-1-git-send-email-feng.tang@intel.com>
 <20210611170917.GW1002214@nvidia.com>
 <20210614032738.GA72794@shbuild999.sh.intel.com>
 <20210615011102.GA38780@shbuild999.sh.intel.com>
 <YMj3AeGMzEme/tcp@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMj3AeGMzEme/tcp@t490s>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Jun 15, 2021 at 02:52:49PM -0400, Peter Xu wrote:
> On Tue, Jun 15, 2021 at 09:11:03AM +0800, Feng Tang wrote:
> > On Mon, Jun 14, 2021 at 11:27:39AM +0800, Feng Tang wrote:
> > > > 
> > > > It seems Ok to me, but didn't we earlier add the has_pinned which
> > > > would have changed the layout too? Are we chasing performance delta's
> > > > nobody cares about?
> > > 
> > > Good point! I checked my email folder for 0day's reports, and haven't
> > > found a report related with Peter's commit 008cfe4418b3 ("mm: Introduce
> > > mm_struct.has_pinned) which adds 'has_pinned' field. 
> > > 
> > > Will run the same test for it and report back.
> > 
> > I run the same will-it-scale/mmap1 case for Peter's commit 008cfe4418b3
> > and its parent commit, and there is no obvious performance diff:
> > 
> > a1bffa48745afbb5 008cfe4418b3dbda2ff820cdd7b 
> > ---------------- --------------------------- 
> > 
> >     344353            -0.4%     342929        will-it-scale.48.threads
> >       7173            -0.4%       7144        will-it-scale.per_thread_ops
> > 
> > And from the pahole info for the 2 kernels, Peter's commit adds the
> > 'has_pinned' is put into an existing 4 bytes hole, so all other following 
> > fields keep their alignment unchanged. Peter may do it purposely 
> > considering the alignment. So no performance change is expected.
> 
> Thanks for verifying this.  I didn't do it on purpose at least for the initial
> version, but I do remember some comment to fill up that hole, so it may have
> got moved around.
> 
> Also note that if nothing goes wrong, has_pinned will be gone in the next
> release with commit 3c0c4cda6d48 ("mm: gup: pack has_pinned in MMF_HAS_PINNED",
> 2021-05-26); it's in -mm-next but not reaching the main branch yet.  So then I
> think the 4 bytes hole should come back to us again, with no perf loss either.
 
Thanks for the heads up.

> What I'm thinking is whether we should move some important (and especially
> CONFIG_* irrelevant) fields at the top of the whole struct define, make sure
> they're most optimal for the common workload and make them static.  Then
> there'll be less or no possibility some new field regress some common workload
> by accident.  Not sure whether it makes sense to do so.

Yep, it makes sense to me, as it makes the alignment more predictable and
controllable.  But usually we dare not to move the fields around, as it could
cause improvments to some cases and regressions to other cases, given different
benchmarks can see different hotspots.  And most of our patches changing 
data structure's layout are mostly regression driven :)

Thanks,
Feng

> Thanks,
> 
> -- 
> Peter Xu
