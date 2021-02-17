Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4073831DC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhBQPgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:36:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:34540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233796AbhBQPeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:34:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613575999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hCBgHM4amvMq1RZhVFfqI5/k6rnctVz0mSPnP6VO024=;
        b=QLelsKVm0tD9UY459hVPsxLPQkia4vIfh+mHV1/PpJPPL69yvR23qTpgV8mq1UgYCBQY8R
        L1LBgLOnsSGm5ar+HyjlTodPPISDMQgPoYM+qK+h3KU+JG7seWe0VM64Q0q7Je4bmBsnXB
        UmhRzk/h3Ubp0fQc0WPtHJZ98qghm08=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 94B90B8FE;
        Wed, 17 Feb 2021 15:33:19 +0000 (UTC)
Date:   Wed, 17 Feb 2021 16:33:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make alloc_contig_range handle in-use hugetlb
 pages
Message-ID: <YC03Pmb6/ePK2UPn@dhcp22.suse.cz>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-3-osalvador@suse.de>
 <YC0xAmuJLJ6yNbCD@dhcp22.suse.cz>
 <66332742e9f44697212f25061790291e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66332742e9f44697212f25061790291e@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-02-21 16:27:27, Oscar Salvador wrote:
> On 2021-02-17 16:06, Michal Hocko wrote:
> > I do not follow. You have successfully isolated huge pages so why don't
> > you add that page to the migratepages list to be migrated?
> 
> It is added. Note that I pass de list (cc->migratepages) to
> isolate_or_dissolve_huge_page().
> It is done this way because we have to pass the list to isolate_huge_page()
> directly.
> That is why I jump to isolate_success_no_list instead of isolate_sucess.
> 
> I know it is subtle, but I could not come up with a better name at that
> time.

OK, I have missed that. Maybe just extend the comment. 

	/*
	 * Hugepage was succesfully isolated and on the tmigratepages
	 * list 
	 */
-- 
Michal Hocko
SUSE Labs
