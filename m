Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5280357F43
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhDHJew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:34:52 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56169 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231224AbhDHJet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:34:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UUt8r04_1617874471;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UUt8r04_1617874471)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Apr 2021 17:34:37 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] agp: Remove useless variable
Date:   Thu,  8 Apr 2021 17:34:31 +0800
Message-Id: <1617874471-36338-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/char/agp/via-agp.c:131:28: warning: variable ‘current_size’ set
but not used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/char/agp/via-agp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
index 87a92a0..dc594f4 100644
--- a/drivers/char/agp/via-agp.c
+++ b/drivers/char/agp/via-agp.c
@@ -128,9 +128,6 @@ static int via_fetch_size_agp3(void)
 static int via_configure_agp3(void)
 {
 	u32 temp;
-	struct aper_size_info_16 *current_size;
-
-	current_size = A_SIZE_16(agp_bridge->current_size);
 
 	/* address to map to */
 	agp_bridge->gart_bus_addr = pci_bus_address(agp_bridge->dev,
-- 
1.8.3.1

