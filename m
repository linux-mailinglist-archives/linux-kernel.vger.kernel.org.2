Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701C9392F32
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbhE0NQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:16:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:52090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235996AbhE0NQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:16:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622121308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NWh10ATxyrNz9Z6Ew/1MC4tHYel7uPGah1gbH11QuB4=;
        b=q0RMs+CZTPYRVo07bfTkV9yM8bbBiS+U2g4J8uPB7fbTbQO8Iv5JQppG+PujD1FSH0pSj+
        t65H8NMpWPZFULTkg1LAeOqZr8mtGyy6qDyhAVcGpXQiodUQRf8ezZqrAAECkrvvVClqw7
        Qahwx3UV1nFRgDP/aPRu+CQvVuOs+EU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5137AE86;
        Thu, 27 May 2021 13:15:07 +0000 (UTC)
Date:   Thu, 27 May 2021 15:15:04 +0200
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
Message-ID: <YK+bWP5TalB50v0S@dhcp22.suse.cz>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
 <1622005302-23027-2-git-send-email-feng.tang@intel.com>
 <YK9KeOmXhuuZMEHy@dhcp22.suse.cz>
 <20210527130501.GC7743@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527130501.GC7743@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-05-21 21:05:01, Feng Tang wrote:
> On Thu, May 27, 2021 at 09:30:00AM +0200, Michal Hocko wrote:
[...]
> > Until now this was not a real problem even for OOM context because
> > alloc_page_interleave is always used for the interleaving policy
> > and that one doesn't use any node mask so the code is not really
> > exercised. With your MPOL_PREFERRED this would no longer be the case.
>  
> Given the 'interleave' task may have memory allocated from all nodes,
> shouldn't the mempolicy_nodemask_intersects() return true for 'interleave'?
> or I'm still missing something?

Well, if you go with the renaming then it should be quite obvious that
any policies which are not a hard binding should return true. 

-- 
Michal Hocko
SUSE Labs
