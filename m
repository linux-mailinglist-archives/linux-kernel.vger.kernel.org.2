Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67592450848
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 16:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhKOPbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 10:31:33 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:42987 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231819AbhKOPbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:31:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UwkTWPf_1636990097;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UwkTWPf_1636990097)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Nov 2021 23:28:18 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/4] mm/damon: Do some small changes
Date:   Mon, 15 Nov 2021 23:26:11 +0800
Message-Id: <cover.1636989871.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V3 -> V4
	Fix kernel test compile warning of patch[4]

V2 -> V3
	Fix commit information patch[2], as suggested by SeongJae Park
	Add reviewed by SeongJae Park
	https://lore.kernel.org/linux-mm/20211111082034.13323-1-sj@kernel.org/

V1 -> V2
	Add reviewed by SeongJae Park
	Add two new patches

V1:
https://lore.kernel.org/linux-mm/cover.1636546262.git.xhao@linux.alibaba.com/


Xin Hao (4):
  mm/damon: Unified access_check function naming rules
  mm/damon: Add 'age' of region tracepoint support
  mm/damon/core: Using function abs() instead of diff_of()
  mm/damon: Remove some no need func definitions in damon.h file

 include/linux/damon.h        | 25 ++-----------------------
 include/trace/events/damon.h |  7 +++++--
 mm/damon/core.c              |  6 ++----
 mm/damon/paddr.c             |  8 ++++----
 mm/damon/vaddr.c             | 20 ++++++++++----------
 5 files changed, 23 insertions(+), 43 deletions(-)

--
2.31.0
