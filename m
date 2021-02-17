Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF8E31DC34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhBQPcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:32:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:60420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233733AbhBQP2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:28:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DEF20B8FE;
        Wed, 17 Feb 2021 15:27:27 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 17 Feb 2021 16:27:27 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make alloc_contig_range handle in-use hugetlb
 pages
In-Reply-To: <YC0xAmuJLJ6yNbCD@dhcp22.suse.cz>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-3-osalvador@suse.de> <YC0xAmuJLJ6yNbCD@dhcp22.suse.cz>
User-Agent: Roundcube Webmail
Message-ID: <66332742e9f44697212f25061790291e@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-17 16:06, Michal Hocko wrote:
> I do not follow. You have successfully isolated huge pages so why don't
> you add that page to the migratepages list to be migrated?

It is added. Note that I pass de list (cc->migratepages) to 
isolate_or_dissolve_huge_page().
It is done this way because we have to pass the list to 
isolate_huge_page() directly.
That is why I jump to isolate_success_no_list instead of isolate_sucess.

I know it is subtle, but I could not come up with a better name at that 
time.

-- 
Oscar Salvador
SUSE L3
