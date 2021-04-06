Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C409C354AB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 04:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbhDFCBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 22:01:01 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:43642 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239052AbhDFCBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:01:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UUef-df_1617674451;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UUef-df_1617674451)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 06 Apr 2021 10:00:52 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jdike@addtoit.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] um: remove unused including <linux/version.h>
Date:   Tue,  6 Apr 2021 10:00:50 +0800
Message-Id: <1617674450-121861-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following versioncheck warning:
./arch/um/drivers/vector_kern.c: 11 linux/version.h not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/um/drivers/vector_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 47a02e6..d27a2a9 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2001 by various other people who didn't put their name here.
  */
 
-#include <linux/version.h>
 #include <linux/memblock.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-- 
1.8.3.1

