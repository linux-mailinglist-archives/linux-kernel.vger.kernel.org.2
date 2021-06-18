Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDAB3ACD5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhFROU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:20:28 -0400
Received: from mail-m121145.qiye.163.com ([115.236.121.145]:47748 "EHLO
        mail-m121145.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhFROU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:20:27 -0400
DKIM-Signature: a=rsa-sha256;
        b=B58vvdAGyZx4fWV0byf0JaAsEnLMceP0KYMCyrXQj82I+/2bsL7Yd/EnRTXmdDA2SprT29WxFvwwpGAx/ydgQgGUfjMxqzS9BvwWZ191iYqX6+3mdFKGd8FSb+XtknxYaCHbKfUnisxU5lV4x9zJp220gkioUN9AUZynFiB0kjA=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=ncUAe6Gwv9fuOMRgFfGJqNIS8f5ZI584zd1KauBJ7x4=;
        h=date:mime-version:subject:message-id:from;
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id CF8A4800282;
        Fri, 18 Jun 2021 22:18:16 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] include/linux/w1: Use kobj_to_dev() API
Date:   Fri, 18 Jun 2021 07:18:11 -0700
Message-Id: <1624025891-56786-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGhlJQlYdQ0xLTR9LHkhIGB9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBg6PQw6Cz8PEUI9FywyC0ow
        TS9PCS9VSlVKTUlPS0lOQ0JMSUtLVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUpIT0I3Bg++
X-HM-Tid: 0a7a1f7c97dfb03akuuucf8a4800282
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() API instead of container_of().

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 include/linux/w1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/w1.h b/include/linux/w1.h
index 9a2a0ef..55f01a4 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -311,7 +311,7 @@ static inline struct w1_slave* dev_to_w1_slave(struct device *dev)
 
 static inline struct w1_slave* kobj_to_w1_slave(struct kobject *kobj)
 {
-	return dev_to_w1_slave(container_of(kobj, struct device, kobj));
+	return dev_to_w1_slave(kobj_to_dev(kobj));
 }
 
 static inline struct w1_master* dev_to_w1_master(struct device *dev)
-- 
2.7.4

