Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DB531EF05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhBRSxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:53:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:39468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233430AbhBRQyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:54:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4BDE2ACD4;
        Thu, 18 Feb 2021 16:53:28 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 18 Feb 2021 17:53:26 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
In-Reply-To: <YC5yzNB9xT76fkod@dhcp22.suse.cz>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de> <YC0ve4PP+VTrEEtw@dhcp22.suse.cz>
 <20210218100917.GA4842@localhost.localdomain>
 <YC5jFrwegRVkMkBQ@dhcp22.suse.cz>
 <20210218133250.GA7983@localhost.localdomain>
 <YC5yzNB9xT76fkod@dhcp22.suse.cz>
User-Agent: Roundcube Webmail
Message-ID: <21c17c7429896cc259255340c6e3d61b@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-18 14:59, Michal Hocko wrote:
> As I've said. Page allocator can cope with NULL nodemask just fine.
> I have checked the code and now remember the tricky part. It is
> alloc_gigantic_page which cannot work with NULL nodemask because it
> relies on for_each_node_mask and that, unlike zonelist iterator, cannot
> cope with NULL node mask. This is the case only for !GFP_THISNODE.

Ok, thanks for the clarification.

> OK, I see the problem now. And your above solution is not really
> optimal either. Your put_page would add the page to the pool and so it
> could be used by somebody. One

Yeah, that is right.

> way around it would be either directly
> manipulating reference count which is fugly or you can make it a
> temporal page (alloc_migrate_huge_page) or maybe even better not 
> special
> case this here but rather allow migrating free hugetlb pages in the
> migrate_page path.

I will have a look into it to see how what would look.

Thanks for the feedback

-- 
Oscar Salvador
SUSE L3
