Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6DD39288F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhE0Hbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:31:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:39676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234639AbhE0Hbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:31:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622100601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aE0dvW9c3iBnlniLVw4vbi/CrxQFHGZcwfM/wq3ucwg=;
        b=pdvXSoaYoAV/yMnLFqU7Zxp56oHKQRKjczewKSnITuCek8T3TsZYZmaPlOZldHv7xBbdS0
        nlgJiisXfL3MSVxd5AB3LQJT315JZxnAbAt2JFPxonKm8abUs0iTu/Dhtd2J8zr/g7PP9J
        MFAOJ1TttQ1JecK42EIb6Srvad7Doic=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3AAD5AAA6;
        Thu, 27 May 2021 07:30:01 +0000 (UTC)
Date:   Thu, 27 May 2021 09:30:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v1 1/4] mm/mempolicy: skip nodemask intersect check for
 'interleave' when oom
Message-ID: <YK9KeOmXhuuZMEHy@dhcp22.suse.cz>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
 <1622005302-23027-2-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622005302-23027-2-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-05-21 13:01:39, Feng Tang wrote:
> mempolicy_nodemask_intersects() is used in oom case to check if a
> task may have memory allocated on some memory nodes.
> 
> Currently, the nodes_intersects() is run for both 'bind' and 'interleave'
> policies. But they are different regarding memory allocation, the nodemask
> is a forced requirement for 'bind', while just a hint for 'interleave'.
> Like in alloc_pages_vma():
> 
> 	nmask = policy_nodemask(gfp, pol);
>         preferred_nid = policy_node(gfp, pol, node);
>         page = __alloc_pages(gfp, order, preferred_nid, nmask);
> 
> in plicy_nodemask(), only 'bind' policy may return its desired nodemask,
> while others return NULL.  And this 'NULL' enables the 'interleave' policy
> can get memory from other nodes than its nodemask.
> 
> So skip the nodemask intersect check for 'interleave' policy.

The changelog is not really clear on the actual effect of the
patch and the above reference to alloc_pages_vma looks misleading to me
because that path is never called for interleaved policy.

This is very likely my fault because I was rather vague. The existing
code in its current form is confusing but it _works_ properly. The
problem is that it sounds like a general helper and in that regards
the function is correct for the interleaved policy and your proposed
preferred-many. But its only existing caller wants a different semantic.

Until now this was not a real problem even for OOM context because
alloc_page_interleave is always used for the interleaving policy
and that one doesn't use any node mask so the code is not really
exercised. With your MPOL_PREFERRED this would no longer be the case.

Your patch makes the code more robust for the oom context but it can
confuse other users who really want to do an intersect logic. So I think
it would really be best to rename the function and make it oom specific.
E.g. mempolicy_in_oom_domain(tsk, mask) this would make it clear that
this is not a general purpose function.

The changelog should be clear that this is just a code cleanup rather
than fix.

-- 
Michal Hocko
SUSE Labs
