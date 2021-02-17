Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A81131DA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 14:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhBQNdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 08:33:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:39996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233061AbhBQNbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 08:31:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613568645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SETwTKFY3v+orwvahxTNxIwQK9vE3JMDX1v8ML7p/dI=;
        b=N1vhK3c89g1umX8EeWbZlXuiLIAD7rTi0xuYJtvpD8m11GMxlzz3PV1pHcythf0W0H3LW5
        vVOkYKXZhzctrn0bzDJwrpdKyFB14tgs8hCzm0Mx/vSyrKE5NkvRakLmc9P7YhFFjCDLVE
        cdlv2ka8MLG3rUmjVvsJ3Xa6jwKDFL4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D265B1D7;
        Wed, 17 Feb 2021 13:30:45 +0000 (UTC)
Date:   Wed, 17 Feb 2021 14:30:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <YC0agxVWYRKGm5IO@dhcp22.suse.cz>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217100816.28860-2-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-02-21 11:08:15, Oscar Salvador wrote:
> Free hugetlb pages are tricky to handle so as to no userspace application
> notices disruption, we need to replace the current free hugepage with
> a new one.
> 
> In order to do that, a new function called alloc_and_dissolve_huge_page
> is introduced.
> This function will first try to get a new fresh hugetlb page, and if it
> succeeds, it will dissolve the old one.
> 
> With regard to the allocation, since we do not know whether the old page
> was allocated on a specific node on request, the node the old page belongs
> to will be tried first, and then we will fallback to all nodes containing
> memory (N_MEMORY).

I do not think fallback to a different zone is ok. If yes then this
really requires a very good reasoning. alloc_contig_range is an
optimistic allocation interface at best and it shouldn't break carefully
node aware preallocation done by administrator.

> Note that gigantic hugetlb pages are fenced off since there is a cyclic
> dependency between them and alloc_contig_range.

Why do we need/want to do all this in the first place?
-- 
Michal Hocko
SUSE Labs
