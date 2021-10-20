Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC741434305
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 03:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhJTBov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 21:44:51 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36543 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJTBou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 21:44:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ut.2tuf_1634694154;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Ut.2tuf_1634694154)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Oct 2021 09:42:35 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mm/damon: Fix some small bugs
Date:   Wed, 20 Oct 2021 09:42:31 +0800
Message-Id: <cover.1634693911.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 -> V2
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
 mm/damon/dbgfs.c      | 13 ++++++++++---
 mm/damon/vaddr.c      |  2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)

--
2.31.0
