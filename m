Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB92639A2F7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhFCOYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:24:17 -0400
Received: from outbound-smtp50.blacknight.com ([46.22.136.234]:33135 "EHLO
        outbound-smtp50.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230044AbhFCOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:24:17 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp50.blacknight.com (Postfix) with ESMTPS id 77F82FAAA2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 15:22:31 +0100 (IST)
Received: (qmail 27887 invoked from network); 3 Jun 2021 14:22:30 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 3 Jun 2021 14:22:30 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/2] Allow high order pages to be stored on PCP v2
Date:   Thu,  3 Jun 2021 15:22:18 +0100
Message-Id: <20210603142220.10851-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since v1
o Better comments and macros					(vbabka)
o Fix pindex_to_order						(vbabka)

The per-cpu page allocator (PCP) only handles order-0 pages. With the
series "Use local_lock for pcp protection and reduce stat overhead"
and "Calculate pcp->high based on zone sizes and active CPUs", it's now
feasible to store high-order pages on PCP lists.

This small series allows PCP to store "cheap" orders where cheap is
determined by PAGE_ALLOC_COSTLY_ORDER and THP-sized allocations. For
convenience, the series with the prerequisites are at

git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-pcphighorder-v2r1

The baseline is 5.13-rc2 because that is what I tested with but the
patches rebase cleanly to mmots.

 include/linux/mmzone.h |  20 ++++-
 mm/internal.h          |   2 +-
 mm/page_alloc.c        | 171 +++++++++++++++++++++++++++++------------
 mm/swap.c              |   2 +-
 4 files changed, 141 insertions(+), 54 deletions(-)

-- 
2.26.2

