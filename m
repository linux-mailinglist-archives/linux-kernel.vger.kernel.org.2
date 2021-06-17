Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C643AB24E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhFQLTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:19:07 -0400
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:34155 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232480AbhFQLTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:19:05 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id DE3EE1C7C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:16:56 +0100 (IST)
Received: (qmail 15591 invoked from network); 17 Jun 2021 11:16:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jun 2021 11:16:56 -0000
Date:   Thu, 17 Jun 2021 12:16:55 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mmotm v1] mm/hwpoison: disable pcp for
 page_handle_poison()
Message-ID: <20210617111655.GP30378@techsingularity.net>
References: <20210617092626.291006-1-nao.horiguchi@gmail.com>
 <e7f75111-5b65-8756-2764-f5c98c4747ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e7f75111-5b65-8756-2764-f5c98c4747ea@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:28:49AM +0200, David Hildenbrand wrote:
> On 17.06.21 11:26, Naoya Horiguchi wrote:
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > 
> > Recent changes by patch "mm/page_alloc: allow high-order pages to be
> > stored on the per-cpu lists" makes kernels determine whether to use pcp
> > by pcp_allowed_order(), which breaks soft-offline for hugetlb pages.
> > 
> > Soft-offline dissolves a migration source page, then removes it from
> > buddy free list, so it's assumed that any subpage of the soft-offlined
> > hugepage are recognized as a buddy page just after returning from
> > dissolve_free_huge_page().  pcp_allowed_order() returns true for
> > hugetlb, so this assumption is no longer true.
> > 
> > So disable pcp during dissolve_free_huge_page() and
> > take_page_off_buddy() to prevent soft-offlined hugepages from linking to
> > pcp lists.  Soft-offline should not be common events so the impact on
> > performance should be minimal.  And I think that the optimization of
> > Mel's patch could benefit to hugetlb so zone_pcp_disable() is called
> > only in hwpoison context.
> 
> Mel, Oscar, does alloc_contig_range() now have similar issues or is it
> avoided because the pageblock(s) are set MIGRATE_ISOLATE?
> 

I'd expect MIGRATE_ISOLATE to be sufficient because they should bypass
the PCP list in free_unref_page.

-- 
Mel Gorman
SUSE Labs
