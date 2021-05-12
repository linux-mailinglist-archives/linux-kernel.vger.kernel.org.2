Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B8A37BC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhELL6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:58:21 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:50242 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhELL6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:58:20 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 89558AC626;
        Wed, 12 May 2021 19:56:59 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P1748T140588825409280S1620820610980711_;
        Wed, 12 May 2021 19:57:01 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <794a1de435a0a63d4553be8fcf03f0c0>
X-RL-SENDER: penghaob@uniontech.com
X-SENDER: penghaob@uniontech.com
X-LOGIN-NAME: penghaob@uniontech.com
X-FST-TO: rodrigosiqueiramelo@gmail.com
X-RCPT-COUNT: 8
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Hao Peng <penghaob@uniontech.com>
To:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hao Peng <penghaob@uniontech.com>
Subject: [PATCH] drm:vkms: Add NULL value after free function In function vkms_exit, after kfree(default_config), give specific NULL value to pointer default_config to avoid wild pointer.
Date:   Wed, 12 May 2021 19:55:54 +0800
Message-Id: <20210512115554.10431-1-penghaob@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Hao Peng <penghaob@uniontech.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 2173b82606f6..6c63201db5d0 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -227,6 +227,7 @@ static void __exit vkms_exit(void)
 		vkms_destroy(default_config);
 
 	kfree(default_config);
+	default_config = NULL;
 }
 
 module_init(vkms_init);
-- 
2.20.1



