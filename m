Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F075038E25B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhEXIeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:34:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:51102 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232429AbhEXIeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:34:20 -0400
IronPort-SDR: Qwl/gpdOeRNgaBD/neurS6iC2oO9QWkxIzrHA9FxP8iK2IXEZveYIX2bMWV4y0Ww3ogXsDjwBX
 cJmGGyEG91GQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="201627418"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201627418"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 01:32:49 -0700
IronPort-SDR: xKvBDVuvApWl8/zkNcSAeRGqfD+yyfzCpxzXwHSUPLa1jR8N7Z1KdvAgT1AtPxjtD8Fn4sht7p
 EBdWR4VfH2Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="442721576"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 24 May 2021 01:32:44 -0700
Date:   Mon, 24 May 2021 16:32:43 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [RFC Patch v2 2/4] mm/mempolicy: unify the preprocessing for
 mbind and set_mempolicy
Message-ID: <20210524083243.GA11142@shbuild999.sh.intel.com>
References: <1621499404-67756-1-git-send-email-feng.tang@intel.com>
 <1621499404-67756-3-git-send-email-feng.tang@intel.com>
 <7a58082-eb68-744c-93b7-1a688b3b27a@google.com>
 <20210524055939.GB48704@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524055939.GB48704@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 01:59:39PM +0800, Tang, Feng wrote:
> On Sun, May 23, 2021 at 10:16:11PM -0700, David Rientjes wrote:
> > On Thu, 20 May 2021, Feng Tang wrote:
> > 
> > > Currently the kernel_mbind() and kernel_set_mempolicy() do almost
> > > the same operation for parameter sanity check and preprocessing.
> > > 
> > > Add a macro to unify the code to reduce the redundancy, and make
> > > it easier for changing the pre-processing code in future.
> > > 
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > > ---
> > >  mm/mempolicy.c | 46 +++++++++++++++++++---------------------------
> > >  1 file changed, 19 insertions(+), 27 deletions(-)
> > > 
> > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > index 1964cca..0f5bf60 100644
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -1460,25 +1460,29 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
> > >  	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
> > >  }
> > >  
> > > +#define MPOL_PRE_PROCESS() \
> > 
> > This should be extracted to helper function returning bool, not a macro.
> 
> Yes, initially I did try it with an inline function, but as a function
> it has quite several input parameters and several output parameters, 
> which made the code still big and ugly.
> 
> But if community think it's the right direction to go, I can change it.

Following is a patch to unify the preprocssing by using a helper function,
please review, thanks

- Feng

---
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d79fa299b70c..8e4f47f925b6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1460,6 +1460,20 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
 
+static inline int mpol_pre_process(int *mode, const unsigned long __user *nmask, unsigned long maxnode, nodemask_t *nodes, unsigned short *flags)
+{
+	int ret;
+
+	*flags = *mode & MPOL_MODE_FLAGS;
+	*mode &= ~MPOL_MODE_FLAGS;
+	if ((unsigned int)(*mode) >= MPOL_MAX)
+		return -EINVAL;
+	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
+		return -EINVAL;
+	ret = get_nodes(nodes, nmask, maxnode);
+	return ret;
+}
+
 static long kernel_mbind(unsigned long start, unsigned long len,
 			 unsigned long mode, const unsigned long __user *nmask,
 			 unsigned long maxnode, unsigned int flags)
@@ -1467,19 +1481,14 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	nodemask_t nodes;
 	int err;
 	unsigned short mode_flags;
+	int lmode = mode;
 
-	start = untagged_addr(start);
-	mode_flags = mode & MPOL_MODE_FLAGS;
-	mode &= ~MPOL_MODE_FLAGS;
-	if (mode >= MPOL_MAX)
-		return -EINVAL;
-	if ((mode_flags & MPOL_F_STATIC_NODES) &&
-	    (mode_flags & MPOL_F_RELATIVE_NODES))
-		return -EINVAL;
-	err = get_nodes(&nodes, nmask, maxnode);
+	err = mpol_pre_process(&lmode, nmask, maxnode, &nodes, &mode_flags);
 	if (err)
 		return err;
-	return do_mbind(start, len, mode, mode_flags, &nodes, flags);
+
+	start = untagged_addr(start);
+	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
 }
 
 SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
@@ -1495,18 +1504,14 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 {
 	int err;
 	nodemask_t nodes;
-	unsigned short flags;
+	unsigned short mode_flags;
+	int lmode = mode;
 
-	flags = mode & MPOL_MODE_FLAGS;
-	mode &= ~MPOL_MODE_FLAGS;
-	if ((unsigned int)mode >= MPOL_MAX)
-		return -EINVAL;
-	if ((flags & MPOL_F_STATIC_NODES) && (flags & MPOL_F_RELATIVE_NODES))
-		return -EINVAL;
-	err = get_nodes(&nodes, nmask, maxnode);
+	err = mpol_pre_process(&lmode, nmask, maxnode, &nodes, &mode_flags);
 	if (err)
 		return err;
-	return do_set_mempolicy(mode, flags, &nodes);
+
+	return do_set_mempolicy(lmode, mode_flags, &nodes);
 }
 
 SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,


