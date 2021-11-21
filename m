Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08ACF4583FA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 15:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbhKUOKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 09:10:17 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:42646 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238198AbhKUOKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 09:10:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UxWwTCe_1637503628;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UxWwTCe_1637503628)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 21 Nov 2021 22:07:09 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] mm/damon: Fix some little bugs in using DAMON
Date:   Sun, 21 Nov 2021 22:07:03 +0800
Message-Id: <cover.1637503141.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1 -> V2
	Fix patch1 compile problem.
	Add review by SeongJae Park in patch2

V1:
https://lkml.org/lkml/2021/11/20/191

Xin Hao (2):
  mm/damon/dbgfs: Modify Damon dbfs interface dependency in Kconfig
  mm/damon: move damon_rand() definition into damon.h

 include/linux/damon.h   | 16 ++++++++++++++++
 mm/damon/Kconfig        |  2 +-
 mm/damon/core.c         |  4 ----
 mm/damon/prmtv-common.h |  4 ----
 4 files changed, 17 insertions(+), 9 deletions(-)

--
2.31.0
