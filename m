Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA1631DAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 14:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbhBQNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 08:47:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:48182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232778AbhBQNre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 08:47:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AFCB2B761;
        Wed, 17 Feb 2021 13:46:51 +0000 (UTC)
Date:   Wed, 17 Feb 2021 14:46:49 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make alloc_contig_range handle in-use hugetlb
 pages
Message-ID: <20210217134649.GB32488@linux>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-3-osalvador@suse.de>
 <YC0b39IfoI+c0ts1@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC0b39IfoI+c0ts1@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 02:36:31PM +0100, Michal Hocko wrote:
> On Wed 17-02-21 11:08:16, Oscar Salvador wrote:
> > In-use hugetlb pages can be migrated as any other page (LRU
> > and Movable), so let alloc_contig_range handle them.
> > 
> > All we need is to succesfully isolate such page.
> 
> Again, this is missing a problem statement and a justification why we
> want/need this.

Heh, I was poor in words.

"alloc_contig_range() will fail miserably if it finds a HugeTLB page within
 the range without a chance to handle them. Since HugeTLB pages can be migrated
 as any other page (LRU and Movable), it does not make sense to bail out.
 Enable the interface to recognize in-use HugeTLB pages and have a chance
 to migrate them"

What about something along those lines?


-- 
Oscar Salvador
SUSE L3
