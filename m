Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DF339B38A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFDHGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:06:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:50770 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhFDHGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:06:04 -0400
IronPort-SDR: c3DT8wuETQzVAG/NKvET1lfd3CGY6cVkAtNF/S5hbmwjM+TVySbIldXp66pP7ppmcXMkGAIfD/
 TtNbUuNaAYEA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="289867577"
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="289867577"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 00:04:18 -0700
IronPort-SDR: NN3ljDLW+9P4TngMZqG5jDTOvHKsY/r7PmXj3JW2/9j2L51QvzslxHEd9QnBS+JY8FrIGX9BHO
 RmprNRyVenew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="448162484"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2021 00:04:12 -0700
Date:   Fri, 4 Jun 2021 15:04:11 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, zhengjun.xing@intel.com
Subject: Re: [mm/gup] 57efa1fe59: will-it-scale.per_thread_ops -9.2%
 regression
Message-ID: <20210604070411.GA8221@shbuild999.sh.intel.com>
References: <20210525031636.GB7744@xsang-OptiPlex-9020>
 <CAHk-=whTEC_GVYu=WfvUagNvHdoTALEDg8uqK3V6aMDwg2KMRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whTEC_GVYu=WfvUagNvHdoTALEDg8uqK3V6aMDwg2KMRA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry for the late response.

On Mon, May 24, 2021 at 05:11:37PM -1000, Linus Torvalds wrote:
> On Mon, May 24, 2021 at 5:00 PM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > FYI, we noticed a -9.2% regression of will-it-scale.per_thread_ops due to commit:
> > commit: 57efa1fe5957694fa541c9062de0a127f0b9acb0 ("mm/gup: prevent gup_fast from racing with COW during fork")
> 
> Hmm. This looks like one of those "random fluctuations" things.
> 
> It would be good to hear if other test-cases also bisect to the same
> thing, but this report already says:
> 
> > In addition to that, the commit also has significant impact on the following tests:
> >
> > +------------------+---------------------------------------------------------------------------------+
> > | testcase: change | will-it-scale: will-it-scale.per_thread_ops 3.7% improvement                    |
> 
> which does kind of reinforce that "this benchmark gives unstable numbers".
> 
> The perf data doesn't even mention any of the GUP paths, and on the
> pure fork path the biggest impact would be:
> 
>  (a) maybe "struct mm_struct" changed in size or had a different cache layout

Yes, this seems to be the cause of the regression.

The test case is many thread are doing map/unmap at the same time,
so the process's rw_semaphore 'mmap_lock' is highly contended.

Before the patch (with 0day's kconfig), the mmap_lock is separated
into 2 cachelines, the 'count' is in one line, and the other members
sit in the next line, so it luckily avoid some cache bouncing. After
the patch, the 'mmap_lock' is pushed into one cacheline, which may
cause the regression.

Below is the pahole info:

- before the patch

	spinlock_t         page_table_lock;      /*   116     4 */
	struct rw_semaphore mmap_lock;           /*   120    40 */
	/* --- cacheline 2 boundary (128 bytes) was 32 bytes ago --- */
	struct list_head   mmlist;               /*   160    16 */
	long unsigned int  hiwater_rss;          /*   176     8 */

- after the patch

	spinlock_t         page_table_lock;      /*   124     4 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	struct rw_semaphore mmap_lock;           /*   128    40 */
	struct list_head   mmlist;               /*   168    16 */
	long unsigned int  hiwater_rss;          /*   184     8 */

perf c2c log can also confirm this.

Thanks,
Feng

>  (b) two added (nonatomic) increment operations in the fork path due
> to the seqcount
> 
> and I'm not seeing what would cause that 9% change. Obviously cache
> placement has done it before.
> 
> If somebody else sees something that I'm missing, please holler. But
> I'll ignore this as "noise" otherwise.
> 
>             Linus
