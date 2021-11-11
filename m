Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B2444D1D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 07:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhKKGJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 01:09:58 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48916 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhKKGJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 01:09:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uw.HkwB_1636610826;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Uw.HkwB_1636610826)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 14:07:07 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/4] mm/damon: Do some small changes
Date:   Thu, 11 Nov 2021 14:07:00 +0800
Message-Id: <cover.1636610337.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These four patches are mainly to do some small changes.

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
 mm/damon/vaddr.c             |  8 ++++----
 4 files changed, 13 insertions(+), 33 deletions(-)

--
2.31.0
