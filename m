Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83973312F6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhBHKs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:48:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:57490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231860AbhBHKi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:38:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 254E3AE74;
        Mon,  8 Feb 2021 10:38:15 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 0/2] Make alloc_contig_range handle Hugetlb pages
Date:   Mon,  8 Feb 2021 11:38:10 +0100
Message-Id: <20210208103812.32056-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I promised to Mike to have a look into this a few weeks ago.
This is my first attempt.

I carried out some tests with a module that tries to allocate with
alloc_contig_range() from a range where we have free and in-use hugetlb
pages.
So far I did not spot any problem and it worked.

Please, note that it is not fully completed, as some things remain to be sorted
out (see list below), but I wanted to publish it to see whether the way I am
going makes sense to people, or I am doing something worrisome.

E.g:
 - What happens when we allocated a new hugetlb page, but we cannot dissolve
   the old one? (should not really happen (tm))
 - When allocating the new hugetlb page I try to do it in the same node
   the old one is. Should we be more flexible and allow to fallback to
   other nodes?
   Userspace can request hugetlb on specific nodes [1], but it can also
   request them through generic interfaces [2].
 - Problems I did not foresee yet

 [1] /sys/devices/system/node/nodeX/hugepages/*
 [2] /proc/sys/vm/nr_hugepages or /sys/kernel/mm/hugepages/*

Oscar Salvador (2):
  mm,page_alloc: Make alloc_contig_range handle in-use hugetlb pages
  mm,page_alloc: Make alloc_contig_range handle free hugetlb pages

 include/linux/hugetlb.h |  6 ++++++
 mm/compaction.c         | 28 ++++++++++++++++++++++++++++
 mm/hugetlb.c            | 35 +++++++++++++++++++++++++++++++++++
 mm/vmscan.c             |  5 +++--
 4 files changed, 72 insertions(+), 2 deletions(-)

-- 
2.16.3

