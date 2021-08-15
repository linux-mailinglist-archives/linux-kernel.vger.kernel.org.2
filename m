Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D1B3EC7AD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 08:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbhHOGYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 02:24:04 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:53142 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235996AbhHOGX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 02:23:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uj0gECp_1629008592;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uj0gECp_1629008592)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 15 Aug 2021 14:23:12 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     apopple@nvidia.com, shy828301@gmail.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Some cleanup for page migration
Date:   Sun, 15 Aug 2021 14:23:02 +0800
Message-Id: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set did some cleanup and improvements for the page migration,
please help to review. Thanks a lot.

Changes from v1:
 - Add reviewed-by tags.
 - Add more comments for patch 1.
 - Drop unnecessary patch 5 from this patch set.

Baolin Wang (4):
  mm: migrate: Move the page count validation to the proper place
  mm: migrate: Introduce a local variable to get the number of pages
  mm: migrate: Fix the incorrect function name in comments
  mm: migrate: Change to use bool type for 'page_was_mapped'

 mm/migrate.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

-- 
1.8.3.1

