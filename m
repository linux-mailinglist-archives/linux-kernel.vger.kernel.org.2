Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3562B3F396E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 09:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhHUH4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 03:56:14 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:48977 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232864AbhHUH4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 03:56:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UkdiL-q_1629532531;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UkdiL-q_1629532531)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 21 Aug 2021 15:55:31 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     shy828301@gmail.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Some cleanup for page migration
Date:   Sat, 21 Aug 2021 15:54:55 +0800
Message-Id: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set did some cleanup and improvements for the page migration,
please help to review. Thanks a lot.

Changes from v2:
 - Simplify the page refcount validation suggested by Matthew.

Changes from v1:
 - Add reviewed-by tags.
 - Add more comments for patch 1.
 - Drop unnecessary patch 5 from this patch set.

Baolin Wang (4):
  mm: migrate: Simplify the file-backed pages validation when migrating
    its mapping
  mm: migrate: Introduce a local variable to get the number of pages
  mm: migrate: Fix the incorrect function name in comments
  mm: migrate: Change to use bool type for 'page_was_mapped'

 mm/migrate.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

-- 
1.8.3.1

