Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905C943478E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhJTJFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:05:25 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:43652 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229600AbhJTJFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:05:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ut1iyHi_1634720585;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Ut1iyHi_1634720585)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Oct 2021 17:03:09 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/2] mm/damon: Fix some small bugs
Date:   Wed, 20 Oct 2021 17:02:59 +0800
Message-Id: <cover.1634720326.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V3 -> V4
  -- patch[1] add Reviewed-by: SeongJae Park <sj@kernel.org>
  -- patch[2]
	Call kfree(kbuf) before return,
	Fix test example in commit info.
	 # cat /sys/kernel/debug/damon/target_ids
	 #
	 # echo on > /sys/kernel/debug/damon/monitor_on
	 # damon: kdamond (5390) starts

V2 -> V3
  -- Fix some formatting issues
  -- Modify the return value of 'damon_targets_empty' to bool type

V1 -> V2
  -- As SeongJae Park advised, put 'ctx->adaptive_targets
  check' into 'dbgfs_monitor_on_write()'

Xin Hao (2):
  mm/damon: Remove unnecessary variable initialization
  mm/damon/dbgfs: Add adaptive_targets list check before enable
    monitor_on

 include/linux/damon.h |  1 +
 mm/damon/core.c       |  5 +++++
 mm/damon/dbgfs.c      | 15 ++++++++++++---
 mm/damon/vaddr.c      |  2 +-
 4 files changed, 19 insertions(+), 4 deletions(-)

--
2.31.0
