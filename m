Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A65F3AB220
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhFQLRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:17:49 -0400
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:32886 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232097AbhFQLRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:17:48 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id C97C5BAE5D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:15:39 +0100 (IST)
Received: (qmail 18185 invoked from network); 17 Jun 2021 11:15:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jun 2021 11:15:39 -0000
Date:   Thu, 17 Jun 2021 12:15:38 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mmotm v1] mm/hwpoison: disable pcp for
 page_handle_poison()
Message-ID: <20210617111538.GO30378@techsingularity.net>
References: <20210617092626.291006-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210617092626.291006-1-nao.horiguchi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 06:26:26PM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Recent changes by patch "mm/page_alloc: allow high-order pages to be
> stored on the per-cpu lists" makes kernels determine whether to use pcp
> by pcp_allowed_order(), which breaks soft-offline for hugetlb pages.
> 
> Soft-offline dissolves a migration source page, then removes it from
> buddy free list, so it's assumed that any subpage of the soft-offlined
> hugepage are recognized as a buddy page just after returning from
> dissolve_free_huge_page().  pcp_allowed_order() returns true for
> hugetlb, so this assumption is no longer true.
> 
> So disable pcp during dissolve_free_huge_page() and
> take_page_off_buddy() to prevent soft-offlined hugepages from linking to
> pcp lists.  Soft-offline should not be common events so the impact on
> performance should be minimal.  And I think that the optimization of
> Mel's patch could benefit to hugetlb so zone_pcp_disable() is called
> only in hwpoison context.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

I think this is ok, it'll remove a page that is to be poisoned from the
PCP lists and put them back in the page allocator. It's a heavy but rare
operation and identifying what PCP list a free page is on would be
tricky so

Acked-by: Mel Gorman <mgorman@techsingularity.net>

The alternative I guess would be specical casing update_and_free_page to
bypass the PCP but it'd be clumsy from an API point of view and I don't
think it's worth the effort.

-- 
Mel Gorman
SUSE Labs
