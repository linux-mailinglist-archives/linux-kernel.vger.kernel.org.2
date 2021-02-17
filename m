Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C6C31D74C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 11:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhBQKJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 05:09:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:50700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231933AbhBQKJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 05:09:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1BC93AFE1;
        Wed, 17 Feb 2021 10:08:26 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/2] Make alloc_contig_range handle Hugetlb pages
Date:   Wed, 17 Feb 2021 11:08:14 +0100
Message-Id: <20210217100816.28860-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

this is the new version of [1].

 RFC -> v1:
 - Drop RFC
 - Addressed feedback from David and Mike
 - Fence off gigantic pages as there is a cyclic dependency between
   them and alloc_contig_range
 - Re-organize the code to make race-window smaller and to put
   all details in hugetlb code
 - Drop nodemask initialization. First a node will be tried and then we
   will back to other nodes containing memory (N_MEMORY). Details in
   patch#1's changelog
 - Count new page as surplus in case we failed to dissolve the old page
   and the new one. Details in patch#1.

I already have a patch that uses the new alloc_and_dissolve() from hotplug
code, but I decided to leave that patch out until this patchset is settled.

[1] https://patchwork.kernel.org/project/linux-mm/list/?series=429833

Oscar Salvador (2):
  mm: Make alloc_contig_range handle free hugetlb pages
  mm: Make alloc_contig_range handle in-use hugetlb pages

 include/linux/hugetlb.h |  7 ++++
 mm/compaction.c         | 21 +++++++++++
 mm/hugetlb.c            | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c             |  5 +--
 4 files changed, 124 insertions(+), 2 deletions(-)

-- 
2.16.3

