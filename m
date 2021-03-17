Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C15533F4EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhCQQDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:03:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:59794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232045AbhCQQDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:03:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615993388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XDuPjp7BEes6OHtrHNguHTbGDgjyn3FaVWHB19dgYGI=;
        b=b8SaaMUNv2Cm99H31+5dvMWWSVbxBXdSY+AN9iWtLWu+urnoeyat2IcKpOlvIvClf+racZ
        bwo0AJKK3UDz4RYhHw3UOhpf8IMG8XhtkLjNQdQXsG9BDb1ahHnfT5qEgngFL9S6J8bvjp
        3NsSwUMNWglMT8Cz04J82aVw6aXnbVE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95EA0AE62;
        Wed, 17 Mar 2021 15:03:07 +0000 (UTC)
Date:   Wed, 17 Mar 2021 16:03:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] mm,page_alloc: Drop unnecessary checks from
 pfn_range_valid_contig
Message-ID: <YFIaKjg7X3jT2hhq@dhcp22.suse.cz>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-6-osalvador@suse.de>
 <YFISpUUxusP4T1xw@dhcp22.suse.cz>
 <ef5560a4-8633-39bd-e433-6aa8f6ea4bfc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef5560a4-8633-39bd-e433-6aa8f6ea4bfc@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 15:36:35, David Hildenbrand wrote:
> On 17.03.21 15:31, Michal Hocko wrote:
> > On Wed 17-03-21 12:12:51, Oscar Salvador wrote:
> > > pfn_range_valid_contig() bails out when it finds an in-use page or a
> > > hugetlb page, among other things.
> > > We can drop the in-use page check since __alloc_contig_pages can migrate
> > > away those pages, and the hugetlb page check can go too since
> > > isolate_migratepages_range is now capable of dealing with hugetlb pages.
> > > Either way, those checks are racy so let the end function handle it
> > > when the time comes.
> > 
> > I haven't realized PageHuge check is done this early. This means that
> > previous patches are not actually active until now which is not really
> > greate for bisectability. Can we remove the HugePage check earlier?
> 
> alloc_contig_pages() vs. alloc_contig_range(). The patches are active for
> virtio-mem and CMA AFAIKS.

yeah, I meant to say "are not actually fully active".
-- 
Michal Hocko
SUSE Labs
