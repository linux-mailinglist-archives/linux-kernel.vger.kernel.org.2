Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163C43CA037
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbhGOOIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:08:37 -0400
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:43115 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232011AbhGOOIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:08:37 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 1BE141C3DF4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 15:05:43 +0100 (IST)
Received: (qmail 4167 invoked from network); 15 Jul 2021 14:05:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Jul 2021 14:05:42 -0000
Date:   Thu, 15 Jul 2021 15:05:41 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     ?????? <link@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel@vivo.com,
        syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com,
        Wang Qing <wangqing@vivo.com>
Subject: Re: Re: [PATCH v2] mm/page_alloc: fix
 alloc_pages_bulk/set_page_owner panic on irq disabled
Message-ID: <20210715140541.GT3809@techsingularity.net>
References: <20210715115731.GS3809@techsingularity.net>
 <AHYA9ADdD1ErH8DLzqN8tqrS.3.1626354134777.Hmail.link@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <AHYA9ADdD1ErH8DLzqN8tqrS.3.1626354134777.Hmail.link@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 09:02:14PM +0800, ?????? wrote:
> >> Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the bulk page allocator")
> >> Reported-by: syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com
> >> Suggested-by: Wang Qing <wangqing@vivo.com>
> >> Signed-off-by: Yang Huan <link@vivo.com>
> >
> >https://lore.kernel.org/lkml/20210713152100.10381-2-mgorman@techsingularity.net/
> >is now part of a series that has being sent to Linus. Hence, the Fixes
> >part is no longer applicable and the patch will no longer be addresing
> >an atomic sleep bug.  This patch should be treated as an enhancement
>
> Hi Mel Gorman, thanks for your reply.
> I see the fix patch, it fix this bug by abandon alloc bulk feature when page_owner is set. 
> But in my opinion, it can't really fix this bug, it's a circumvention plan.

Yes, it's a circumvention plan for reasons as laid out in the changelog.

> >to allow bulk allocations when PAGE_OWNER is set. For that, it should
> >include a note on the performance if PAGE_OWNER is used with either NFS
> >or high-speed networking to justify the additional complexity.
>
> My patch just split the prep_new_page page_gfp into alloc_gfp(for alloc bulk is GFP_ATOMIC,
> for other's no change) and trace page gfp.  So, we will not use the error way to get memory. 
> So, I think this will not affect alloc bulk performance when page_owner is on(compare with origin patch) but
> can really fix this  bug rather than evade.
> And this patch can let alloc bulk feature and page_owner feature work togher
> So, I will send patch again based on the fix patch.

Your fix should revert the workaround. Also your changelog should note
that in some cases that PAGE_OWNER information will be lost if the
GFP_ATOMIC allocation from bulk allocation context fails.

-- 
Mel Gorman
SUSE Labs
