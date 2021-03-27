Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B70634B3FC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 04:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhC0DRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 23:17:22 -0400
Received: from out28-53.mail.aliyun.com ([115.124.28.53]:39269 "EHLO
        out28-53.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhC0DRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 23:17:15 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1620423|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0116974-0.00703452-0.981268;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.JqwOtPe_1616815032;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.JqwOtPe_1616815032)
          by smtp.aliyun-inc.com(10.194.99.38);
          Sat, 27 Mar 2021 11:17:13 +0800
From:   Liu Xiang <liu.xiang@zlingsmart.com>
To:     mst@redhat.com
Cc:     david@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, liuxiang_1999@126.com,
        liuxiang1999@gmail.com, Liu Xiang <liu.xiang@zlingsmart.com>
Subject: [PATCH] virtio-balloon: fix a typo in comment of virtballoon_migratepage()
Date:   Sat, 27 Mar 2021 11:17:10 +0800
Message-Id: <20210327031710.16151-1-liu.xiang@zlingsmart.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typo: compation --> compaction

Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7da25b87f..c25665802 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -734,7 +734,7 @@ static void report_free_page_func(struct work_struct *work)
 #ifdef CONFIG_BALLOON_COMPACTION
 /*
  * virtballoon_migratepage - perform the balloon page migration on behalf of
- *			     a compation thread.     (called under page lock)
+ *			     a compaction thread.     (called under page lock)
  * @vb_dev_info: the balloon device
  * @newpage: page that will replace the isolated page after migration finishes.
  * @page   : the isolated (old) page that is about to be migrated to newpage.
-- 
2.17.1

