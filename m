Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF3544C109
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhKJMQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:16:06 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50966 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231131AbhKJMQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:16:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UvuzBB2_1636546396;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UvuzBB2_1636546396)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Nov 2021 20:13:17 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 0/2] mm/damon: Do some small changes
Date:   Wed, 10 Nov 2021 20:13:12 +0800
Message-Id: <cover.1636546262.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches are mainly to do some small changes.

Xin Hao (2):
  mm/damon: Unified access_check function naming rules
  mm/damon: Add 'age' of region tracepoint support

 include/trace/events/damon.h | 7 +++++--
 mm/damon/vaddr.c             | 8 ++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

--
2.31.0
