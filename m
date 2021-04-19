Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6323F363DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbhDSIuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:50:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:51377 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231307AbhDSIt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:49:59 -0400
IronPort-SDR: iUMdAe4uLSpmqqFQI98SsfBOOOwufji6iQnFDi2qnjugW0KuCxL6tB0b47yDXsk0oKkA7boqAN
 9t0Lu0So24Dg==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="195319908"
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="195319908"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 01:49:29 -0700
IronPort-SDR: 5pGzEFUPX9/KckEUEI2UzoMvgHjAX82IHL+o76QjBKXS3Ps0vKtR4+dn4vmU8aqimOtr5Ji2gP
 e7Qs5qdTMzcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="454219270"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 19 Apr 2021 01:49:25 -0700
Date:   Mon, 19 Apr 2021 16:49:24 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 04/13] mm/mempolicy: allow preferred code to take a
 nodemask
Message-ID: <20210419084924.GA25519@shbuild999.sh.intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
 <1615952410-36895-5-git-send-email-feng.tang@intel.com>
 <YHbmS6R+CpSDWtAD@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHbmS6R+CpSDWtAD@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 02:55:39PM +0200, Michal Hocko wrote:
> On Wed 17-03-21 11:40:01, Feng Tang wrote:
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> > 
> > Create a helper function (mpol_new_preferred_many()) which is usable
> > both by the old, single-node MPOL_PREFERRED and the new
> > MPOL_PREFERRED_MANY.
> > 
> > Enforce the old single-node MPOL_PREFERRED behavior in the "new"
> > version of mpol_new_preferred() which calls mpol_new_preferred_many().
> > 
> > v3:
> >   * fix a stack overflow caused by emty nodemask (Feng)
> > 
> > Link: https://lore.kernel.org/r/20200630212517.308045-5-ben.widawsky@intel.com
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  mm/mempolicy.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 1228d8e..6fb2cab 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -203,17 +203,34 @@ static int mpol_new_interleave(struct mempolicy *pol, const nodemask_t *nodes)
> >  	return 0;
> >  }
> >  
> > -static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
> > +static int mpol_new_preferred_many(struct mempolicy *pol,
> > +				   const nodemask_t *nodes)
> >  {
> >  	if (!nodes)
> >  		pol->flags |= MPOL_F_LOCAL;	/* local allocation */
> 
> Now you have confused me. I thought that MPOL_PREFERRED_MANY for NULL
> nodemask will be disallowed as it is effectively MPOL_PREFERRED aka
> MPOL_F_LOCAL. Or do I misread the code?

I think you are right, with current code, the 'nodes' can't be NULL for
MPOL_PREFERRED_MANY, we'll revisit this.

And I have to admit that I am confused by the current logic for MPOL_PREFERRED,
that the nodemask paramter changes between raw user input, empty nodes and NULL.

Maybe the following patch can make it more clear, as it doesn't play the
NULL nmask trick?

---
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index be160d4..9cabfca 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -200,12 +200,9 @@ static int mpol_new_interleave(struct mempolicy *pol, const nodemask_t *nodes)
 
 static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
 {
-	if (!nodes)
-		pol->flags |= MPOL_F_LOCAL;	/* local allocation */
-	else if (nodes_empty(*nodes))
+	if (nodes_empty(*nodes))
 		return -EINVAL;			/*  no allowed nodes */
-	else
-		pol->v.preferred_node = first_node(*nodes);
+	pol->v.preferred_node = first_node(*nodes);
 	return 0;
 }
 
@@ -239,9 +236,11 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 		  cpuset_current_mems_allowed, node_states[N_MEMORY]);
 
 	VM_BUG_ON(!nodes);
-	if (pol->mode == MPOL_PREFERRED && nodes_empty(*nodes))
-		nodes = NULL;	/* explicit local allocation */
-	else {
+	if (pol->mode == MPOL_PREFERRED && nodes_empty(*nodes)) {
+		/* explicit local allocation */
+		pol->flags |= MPOL_F_LOCAL;
+		return 0;
+	} else {
 		if (pol->flags & MPOL_F_RELATIVE_NODES)
 			mpol_relative_nodemask(&nsc->mask2, nodes, &nsc->mask1);
 		else
@@ -254,10 +253,7 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 						cpuset_current_mems_allowed;
 	}
 
-	if (nodes)
-		ret = mpol_ops[pol->mode].create(pol, &nsc->mask2);
-	else
-		ret = mpol_ops[pol->mode].create(pol, NULL);
+	ret = mpol_ops[pol->mode].create(pol, &nsc->mask2);
 	return ret;
 }


Thanks,
Feng


