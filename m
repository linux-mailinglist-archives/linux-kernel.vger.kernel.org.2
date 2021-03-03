Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC7D32BD7F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384708AbhCCQI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:08:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:47150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233560AbhCCLlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:41:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614771603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/0ADgNDESPnWNN/oQj1Z1pQMpSA2u1PUuIFJNPh0PdE=;
        b=Z0fL32v3uoFnrNsSJM9jrH3D21lchZOXqg4FNMgPgDbtpu5U788eCxH1oCmNVg1XaVsxYH
        9QgruwEJImbeNT8nSyzGT6JMKK8mKcUmGMp16k8xoLVRyFxC6UzQXgz7i96xFnNZuWAtEE
        smv6eJrU6mX6+yiKxXJ1pH6R1JcMvyA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7FD99AD5C;
        Wed,  3 Mar 2021 11:40:03 +0000 (UTC)
Date:   Wed, 3 Mar 2021 12:39:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi leen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 RFC 14/14] mm: speedup page alloc for
 MPOL_PREFERRED_MANY by adding a NO_SLOWPATH gfp bit
Message-ID: <YD91jTMssJUCupJm@dhcp22.suse.cz>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
 <1614766858-90344-15-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614766858-90344-15-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-03-21 18:20:58, Feng Tang wrote:
> When doing broader test, we noticed allocation slowness in one test
> case that malloc memory with size which is slightly bigger than free
> memory of targeted nodes, but much less then the total free memory
> of system.
> 
> The reason is the code enters the slowpath of __alloc_pages_nodemask(),
> which takes quite some time. As alloc_pages_policy() will give it a 2nd
> try with NULL nodemask, so there is no need to enter the slowpath for
> the first try. Add a new gfp bit to skip the slowpath, so that user cases
> like this can leverage.
> 
> With it, the malloc in such case is much accelerated as it never enters
> the slowpath.
> 
> Adding a new gfp_mask bit is generally not liked, and another idea is to
> add another nodemask to struct 'alloc_context', so it has 2: 'preferred-nmask'
> and 'fallback-nmask', and they will be tried in turn if not NULL, with
> it we can call __alloc_pages_nodemask() only once.

Yes, it is very much disliked. Is there any reason why you cannot use
GFP_NOWAIT for that purpose?
-- 
Michal Hocko
SUSE Labs
