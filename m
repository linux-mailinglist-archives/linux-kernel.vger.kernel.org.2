Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE7326076
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBZJsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:48:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:47512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhBZJsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:48:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6120CACF6;
        Fri, 26 Feb 2021 09:48:10 +0000 (UTC)
Date:   Fri, 26 Feb 2021 10:48:07 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <20210226094807.GC3240@linux>
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-2-osalvador@suse.de>
 <d7f6176d-10d8-be8a-0b7f-70d0efcd321e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f6176d-10d8-be8a-0b7f-70d0efcd321e@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:03:18PM -0800, Mike Kravetz wrote:
> Thanks Oscar,
> 
> I spent a bunch of time looking for possible race issues.  Thankfully,
> the recent code from Muchun dealing with free lists helps. In addition,
> all the hugetlb acounting looks good.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

thanks for having a look Mike ;-)

> 
> > ---
> >  include/linux/hugetlb.h |   6 +++
> >  mm/compaction.c         |  12 ++++++
> >  mm/hugetlb.c            | 111 +++++++++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 127 insertions(+), 2 deletions(-)
> -- 
> Mike Kravetz

-- 
Oscar Salvador
SUSE L3
