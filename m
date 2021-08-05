Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17C3E1783
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbhHEPGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:06:24 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:51538 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230183AbhHEPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:06:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ui3.PO-_1628175967;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ui3.PO-_1628175967)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Aug 2021 23:06:07 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Some cleanup for page migration
Date:   Thu,  5 Aug 2021 23:05:55 +0800
Message-Id: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set did some cleanup and improvements for the page migration,
please help to review. Thanks a lot.

Note: the patch set is against 20210804 linux-next.

Baolin Wang (5):
  mm: migrate: Move the page count validation to the proper place
  mm: migrate: Introduce a local variable to get the number of pages
  mm: migrate: Fix the incorrect function name in comments
  mm: migrate: Change to use bool type for 'page_was_mapped'
  mm: migrate: Remove redundant goto labels

 mm/migrate.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

-- 
1.8.3.1

