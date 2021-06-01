Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046D2396A84
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 02:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhFAA46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 20:56:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:55237 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231714AbhFAA46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 20:56:58 -0400
IronPort-SDR: tMDmaxGQfaG8DCAbVePZ/zOLlzcS8kokPFyz8cbWyu3dTsM3rzSnOahJO9q7cHdHuQ0rdqr2Es
 nefgwCaxXfcg==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="224717835"
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="224717835"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 17:55:17 -0700
IronPort-SDR: Lb05pGGMDVCHUzbYxbAuc3yv31Gl68Ovcs1wQxU9doNNNRp7pnC2Z8YKmSRh/SCAhKiF6HCYOP
 bSpcnqNXpqWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="445137100"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga008.jf.intel.com with ESMTP; 31 May 2021 17:55:13 -0700
Date:   Tue, 1 Jun 2021 08:55:13 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [v3 PATCH 0/3] mm/mempolicy: some fix and semantics cleanup
Message-ID: <20210601005513.GA15828@shbuild999.sh.intel.com>
References: <1622469956-82897-1-git-send-email-feng.tang@intel.com>
 <20210531144128.e69aaf2904e83ae170f00f06@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531144128.e69aaf2904e83ae170f00f06@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for reviewing and taking the patches.

On Mon, May 31, 2021 at 02:41:28PM -0700, Andrew Morton wrote:
> On Mon, 31 May 2021 22:05:53 +0800 Feng Tang <feng.tang@intel.com> wrote:
> 
> > We've posted v4 patchset introducing a new "perfer-many" memory policy
> > https://lore.kernel.org/lkml/1615952410-36895-1-git-send-email-feng.tang@intel.com/ ,
> > for which Michal Hocko gave many comments while pointing out some
> > problems, and we also found some semantics confusion about 'prefer'
> > and 'local' policy, as well as some duplicated code. This patchset
> > tries to address them. Please help to review, thanks!
> > 
> > The patchset has been run with some sanity test like 'stress-ng'
> > and 'ltp', and no problem found.
> 
> None of the above is suitable for the [0/n] overall description.  I
> copied-n-pasted the v1 cover letter from the above link.  Please check
> that it is all still correct and up to date.  If not, please send along
> replacement text, thanks.

I should make the cover-letter more descriptive. The link above is another
patchset to introduce a new memory policy MPOL_PREFERRED_MANY, while these
3 patches are preparation work for it, to make it easier for a new policy
to be hooked in.

So how about the following text:

Current memory policy code has some confusing and ambiguous part about
MPOL_LOCAL policy, as it is handled as a faked MPOL_PREFERRED one, and
there are many places having to distinguish them. Also the nodemask
intersection check needs cleanup to be more explicit for OOM use, and
handle MPOL_INTERLEAVE correctly. This patchset cleans up these and
unifies the parameter sanity check for mbind() and set_mempolicy().

Please feel free to modify it, thanks!

- Feng
