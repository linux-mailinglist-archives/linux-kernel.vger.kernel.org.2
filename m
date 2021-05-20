Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB4938A016
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhETIto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:49:44 -0400
Received: from outbound-smtp55.blacknight.com ([46.22.136.239]:46955 "EHLO
        outbound-smtp55.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231206AbhETItn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:49:43 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id CF550FAB49
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:48:20 +0100 (IST)
Received: (qmail 2737 invoked from network); 20 May 2021 08:48:20 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:48:20 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 00/14] Clean W=1 build warnings for mm/
Date:   Thu, 20 May 2021 09:47:55 +0100
Message-Id: <20210520084809.8576-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a janitorial only. During development of a tool to catch build
warnings early to avoid tripping the Intel lkp-robot, I noticed that mm/
is not clean for W=1. This is generally harmless but there is no harm in
cleaning it up. It disrupts git blame a little but on relatively obvious
lines that are unlikely to be git blame targets.

 include/asm-generic/early_ioremap.h | 9 +++++++++
 include/linux/mmzone.h              | 5 ++++-
 include/linux/swap.h                | 6 +++++-
 mm/internal.h                       | 3 +--
 mm/mapping_dirty_helpers.c          | 2 +-
 mm/memcontrol.c                     | 2 +-
 mm/memory_hotplug.c                 | 6 +++---
 mm/mmap_lock.c                      | 2 ++
 mm/page_alloc.c                     | 2 +-
 mm/vmalloc.c                        | 3 +++
 mm/vmscan.c                         | 2 +-
 mm/z3fold.c                         | 2 ++
 mm/zbud.c                           | 2 ++
 13 files changed, 35 insertions(+), 11 deletions(-)

-- 
2.26.2

