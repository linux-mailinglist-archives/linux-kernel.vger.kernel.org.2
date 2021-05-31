Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095E93956D4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhEaIYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:24:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:50262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhEaIYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:24:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622449372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bOHyuw1oN2PhddhLWJ1zLVZJD6pR6eYc+6ecOHXcHOQ=;
        b=NxEY1WWgKOfXAUlZvH9NB1+ElC0v5onX2TtNn2XLr2rD8kvwGEJSs9V1pfNY2jSknnsiAZ
        0BYmldSutRoLVyvH8agb8W1wFK2YUmysPP1FTvIkSFo2bFLyKwtaF+ffdYBadnUZqtPtVO
        w5WV4bvcRqOwqrGhGXw0z5pj94BmqCA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B77DB4AC;
        Mon, 31 May 2021 08:22:52 +0000 (UTC)
Date:   Mon, 31 May 2021 10:22:51 +0200
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
Subject: Re: [PATCH v1 4/4] mm/mempolicy: kill MPOL_F_LOCAL bit
Message-ID: <YLSc2zzr1g+CTiAY@dhcp22.suse.cz>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
 <1622005302-23027-5-git-send-email-feng.tang@intel.com>
 <YK9WOKBRsaFESPfR@dhcp22.suse.cz>
 <20210527121041.GA7743@shbuild999.sh.intel.com>
 <YK+P8GDH2kn4FDsA@dhcp22.suse.cz>
 <20210527133436.GD7743@shbuild999.sh.intel.com>
 <YK+8IAphFzbCweHI@dhcp22.suse.cz>
 <20210528043954.GA32292@shbuild999.sh.intel.com>
 <YLSJiV0tLPvCTnjG@dhcp22.suse.cz>
 <20210531073252.GC56979@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531073252.GC56979@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31-05-21 15:32:52, Feng Tang wrote:
> On Mon, May 31, 2021 at 09:00:25AM +0200, Michal Hocko wrote:
[...]
> > I can see you have posted a newer version which I haven't seen yet but
> > this is really better to get resolved before building up more on top.
> > And let me be explicit. I do believe that rebinding preferred policy is
> > just bogus and it should be dropped altogether on the ground that a 
> > preference is a mere hint from userspace where to start the allocation. 
> 
> Yes, the current mpol_rebind_preferred()'s logic is confusing. Let me
> try to understand it correctly, are you suggesting to do nothing for
> 'prefer's rebinding regarding MPOL_F_STATIC_NODES and MPOL_F_RELATIVE_NODES,
> while just setting 'pol->w.cpuset_mems_allowed' to the new nodemask?

yes this is exactly what I've had in mind.

-- 
Michal Hocko
SUSE Labs
