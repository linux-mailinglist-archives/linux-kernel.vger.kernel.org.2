Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4594433AFF7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCOK2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:28:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhCOK1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:27:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8737DAD72;
        Mon, 15 Mar 2021 10:27:43 +0000 (UTC)
Date:   Mon, 15 Mar 2021 11:27:40 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 0/4] Make alloc_contig_range handle Hugetlb pages
Message-ID: <20210315102740.GB25101@linux>
References: <20210310150853.13541-1-osalvador@suse.de>
 <c7ba5bba-77fb-6c43-2067-2ebc83b014da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7ba5bba-77fb-6c43-2067-2ebc83b014da@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:06:40AM +0100, David Hildenbrand wrote:
> 
> BTW, I stumbled yesterday over
> 
> alloc_contig_pages()->pfn_range_valid_contig():
> 
> 	if (page_count(page) > 0)
> 		rerurn false;
> 	if (PageHuge(page))
> 		return false;
> 
> As used by memtrace and for gigantic pages. We can now
> 
> a) Drop these check completely, as it's best-effort only and racy.
> alloc_contig_pages()/alloc_contig_range() will handle it properly.
> 
> b) Similarly, check for gigantic pages and/or movability/migratability.
> 
> Dropping both checks might be the right thing to do: might significantly
> increase allocation chances -- as we actually end up migrating busy pages
> ...

Oh, sorry David, my mail client tricked me and I did not see this till now.

I will have a look, but I would like to collect some more feedback from all
pieces before going any further and write a new version.
Vlastimil patch#1 and patch#2 and he was ok with them, but let see what others
think as well.

 

-- 
Oscar Salvador
SUSE L3
