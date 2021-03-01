Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5CA327A88
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhCAJON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:14:13 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:57251 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233009AbhCAJOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 04:14:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UPxZNk7_1614590005;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPxZNk7_1614590005)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Mar 2021 17:13:26 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] driver core: Switch to using the new API kobj_to_dev()
Date:   Mon,  1 Mar 2021 17:13:24 +0800
Message-Id: <1614590004-69592-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the following coccicheck:
./include/linux/device.h:590:46-47: WARNING opportunity for
kobj_to_dev()

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index ba66073..31d7137 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -587,7 +587,7 @@ struct device_link {
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
 {
-	return container_of(kobj, struct device, kobj);
+	return kobj_to_dev(kobj);
 }
 
 /**
-- 
1.8.3.1

