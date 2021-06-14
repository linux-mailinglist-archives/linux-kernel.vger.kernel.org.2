Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA583A5E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhFNI3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:29:36 -0400
Received: from smtpbgeu2.qq.com ([18.194.254.142]:36868 "EHLO smtpbgeu2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232649AbhFNI32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:29:28 -0400
X-QQ-mid: bizesmtp33t1623659228tqhe5zyy
Received: from localhost.localdomain (unknown [182.148.12.171])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 14 Jun 2021 16:26:56 +0800 (CST)
X-QQ-SSF: 01000000002000208000B00A0000000
X-QQ-FEAT: W+AYcr2Wk+kZ5GFSs4IxJ6w+11ZcgN9j9EMiUIEPTZkRgzJ9a8cg/UZzUy7qI
        ry70wZJ0iW5wdg6Kt6UYwzz0GpA6lWBPUM1917CWfVb/ET0SZCVMC2HBfThnfmA+Ns+Co2u
        +bknxkzUIRILumQNGWyOVoYv+bMfL9PjNb/HfCf7+pti6+X1I+40PPM5iaoRLzeR+h+4R9Y
        wPvDMJqrQ6ObC2lcWee1+SXYs/+QxonWe7Le56g2h+MsewgMoPXgAYF6I8VDi70iu+hoKNj
        gjDvIKH8prYwIVs5zndIzM+HylnG+88RHhcUegT6uEMGwp
X-QQ-GoodBg: 0
From:   Huilong Deng <denghuilong@cdjrlc.com>
To:     morbidrsa@gmail.com
Cc:     linux-kernel@vger.kernel.org, Huilong Deng <denghuilong@cdjrlc.com>
Subject: [PATCH] mcb: Remove trailing semicolon in macros
Date:   Mon, 14 Jun 2021 16:26:33 +0800
Message-Id: <20210614082633.20770-1-denghuilong@cdjrlc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros should not use a trailing semicolon.

Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>
---
 include/linux/mcb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mcb.h b/include/linux/mcb.h
index 71dd10a3d928..f6efb16f9d1b 100644
--- a/include/linux/mcb.h
+++ b/include/linux/mcb.h
@@ -120,7 +120,7 @@ extern int __must_check __mcb_register_driver(struct mcb_driver *drv,
 	__mcb_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
 extern void mcb_unregister_driver(struct mcb_driver *driver);
 #define module_mcb_driver(__mcb_driver)		\
-	module_driver(__mcb_driver, mcb_register_driver, mcb_unregister_driver);
+	module_driver(__mcb_driver, mcb_register_driver, mcb_unregister_driver)
 extern void mcb_bus_add_devices(const struct mcb_bus *bus);
 extern int mcb_device_register(struct mcb_bus *bus, struct mcb_device *dev);
 extern struct mcb_bus *mcb_alloc_bus(struct device *carrier);
-- 
2.31.1



