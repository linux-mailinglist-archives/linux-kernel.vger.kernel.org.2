Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9553A74F7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhFODWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:22:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:46188 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhFODWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:22:42 -0400
IronPort-SDR: 1c8071spFasEp8Nuku5vMKjWnEAOnjOjLNL7+nN6ckwiJ2xvnLy6KX9WX9fpDZ31BZqjvHXxXJ
 acWV9VCUH9Vw==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="205862619"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="205862619"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 18:11:06 -0700
IronPort-SDR: /sxm9bRqYIa+f0QOYbxLqrhu5qKS1DBi2hF+SiQXWVT9sAmF1B7FtoQ7dSLRaeqdPkijPVo6Vp
 hZf4sSp7i5xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="451793981"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2021 18:11:03 -0700
Date:   Tue, 15 Jun 2021 09:11:03 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] mm: relocate 'write_protect_seq' in struct mm_struct
Message-ID: <20210615011102.GA38780@shbuild999.sh.intel.com>
References: <1623376482-92265-1-git-send-email-feng.tang@intel.com>
 <20210611170917.GW1002214@nvidia.com>
 <20210614032738.GA72794@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614032738.GA72794@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 11:27:39AM +0800, Feng Tang wrote:
> > 
> > It seems Ok to me, but didn't we earlier add the has_pinned which
> > would have changed the layout too? Are we chasing performance delta's
> > nobody cares about?
> 
> Good point! I checked my email folder for 0day's reports, and haven't
> found a report related with Peter's commit 008cfe4418b3 ("mm: Introduce
> mm_struct.has_pinned) which adds 'has_pinned' field. 
> 
> Will run the same test for it and report back.

I run the same will-it-scale/mmap1 case for Peter's commit 008cfe4418b3
and its parent commit, and there is no obvious performance diff:

a1bffa48745afbb5 008cfe4418b3dbda2ff820cdd7b 
---------------- --------------------------- 

    344353            -0.4%     342929        will-it-scale.48.threads
      7173            -0.4%       7144        will-it-scale.per_thread_ops

And from the pahole info for the 2 kernels, Peter's commit adds the
'has_pinned' is put into an existing 4 bytes hole, so all other following 
fields keep their alignment unchanged. Peter may do it purposely 
considering the alignment. So no performance change is expected.

Pahole info for kernel before 008cfe4418b3:

struct mm_struct {
	...
	/* --- cacheline 1 boundary (64 bytes) --- */
	long unsigned int  task_size;            /*    64     8 */
	long unsigned int  highest_vm_end;       /*    72     8 */
	pgd_t *            pgd;                  /*    80     8 */
	atomic_t           membarrier_state;     /*    88     4 */
	atomic_t           mm_users;             /*    92     4 */
	atomic_t           mm_count;             /*    96     4 */

	/* XXX 4 bytes hole, try to pack */

	atomic_long_t      pgtables_bytes;       /*   104     8 */
	int                map_count;            /*   112     4 */
	spinlock_t         page_table_lock;      /*   116     4 */
	struct rw_semaphore mmap_lock;           /*   120    40 */
	/* --- cacheline 2 boundary (128 bytes) was 32 bytes ago --- */

pahold info with 008cfe4418b3:

struct mm_struct {
	...
	/* --- cacheline 1 boundary (64 bytes) --- */
	long unsigned int  task_size;            /*    64     8 */
	long unsigned int  highest_vm_end;       /*    72     8 */
	pgd_t *            pgd;                  /*    80     8 */
	atomic_t           membarrier_state;     /*    88     4 */
	atomic_t           mm_users;             /*    92     4 */
	atomic_t           mm_count;             /*    96     4 */
	atomic_t           has_pinned;           /*   100     4 */
	atomic_long_t      pgtables_bytes;       /*   104     8 */
	int                map_count;            /*   112     4 */
	spinlock_t         page_table_lock;      /*   116     4 */
	struct rw_semaphore mmap_lock;           /*   120    40 */
	/* --- cacheline 2 boundary (128 bytes) was 32 bytes ago --- */
	
Thanks,
Feng

 

