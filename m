Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF9A34A4D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhCZJpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:45:25 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:49760 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229528AbhCZJpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:45:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UTMtOfu_1616751898;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UTMtOfu_1616751898)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Mar 2021 17:44:58 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: [PATCH 0/4] mm/page_reporting: Some knobs and fixes
Date:   Fri, 26 Mar 2021 17:44:54 +0800
Message-Id: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following knobs in PATCH 1~3:
 /sys/kernel/mm/page_reporting/reported_kbytes
 /sys/kernel/mm/page_reporting/refault_kbytes
 /sys/kernel/mm/page_reporting/reporting_factor

Fix unexpected user OOM in PATCH 4.

Xunlei Pang (4):
  mm/page_reporting: Introduce free page reported counters
  mm/page_reporting: Introduce free page reporting factor
  mm/page_reporting: Introduce "page_reporting_factor=" boot parameter
  mm/page_reporting: Fix possible user allocation failure

 Documentation/admin-guide/kernel-parameters.txt |   3 +
 include/linux/mmzone.h                          |   3 +
 mm/page_alloc.c                                 |   6 +-
 mm/page_reporting.c                             | 268 ++++++++++++++++++++++--
 4 files changed, 260 insertions(+), 20 deletions(-)

-- 
1.8.3.1

