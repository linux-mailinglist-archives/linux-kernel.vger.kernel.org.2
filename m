Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9CF3B8E40
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 09:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhGAHjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 03:39:12 -0400
Received: from smtpbg702.qq.com ([203.205.195.102]:55458 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229906AbhGAHjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 03:39:10 -0400
X-QQ-mid: bizesmtp34t1625124936tf6m3la0
Received: from localhost.localdomain (unknown [182.148.13.55])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 01 Jul 2021 15:35:34 +0800 (CST)
X-QQ-SSF: 01000000002000B0B000B00A0000000
X-QQ-FEAT: bP3hyS9xCjA7J/77GbofYI+rY7umHteL/QF6hn1KsceXoa7mblpmHIiDbyKxm
        5mKkOGtHK5Q5quahIJTvAkxgh2PWgwNA9xKUak/xAX7WErDuoUiPCozeGHcnwFfdAlZnsuf
        DLFpR07naMqvwyGDLR+DyH1bJWqNphzkhbmakFOJhTDWIjeO0+OznlBhK8+UDx+ezeKU1JY
        G66hKAXkcU6Xfsy9CWiLBOX9xv5VvNtOviJjAGhONnV4XHwKxUS/ITnARMvnIjt2TY7Nxs4
        BKXpcHHa3VGHOKoi0n5KVbqvjki/P3F/BYt65dAFj8eIupblKEnlGGpeHQYP7k3kExM+53M
        BF6ZDSu
X-QQ-GoodBg: 0
From:   Jinchao Wang <wjc@cdjrlc.com>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wjc@cdjrlc.com
Subject: [PATCH v2] cpuidle: Remove unnecessary empty lines preceding EXPORT_SYMBOL_GPL()
Date:   Thu,  1 Jul 2021 15:35:12 +0800
Message-Id: <20210701073512.19954-1-wjc@cdjrlc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary empty lines preceding EXPORT_SYMBOL_GPL()

Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
---
- changes for v2:
- Change the title and commit description information
---
 drivers/cpuidle/cpuidle.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index ef2ea1b12cd8..ddd11236a0cc 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -457,7 +457,6 @@ void cpuidle_pause_and_lock(void)
 	mutex_lock(&cpuidle_lock);
 	cpuidle_uninstall_idle_handler();
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);
 
 /**
@@ -468,7 +467,6 @@ void cpuidle_resume_and_unlock(void)
 	cpuidle_install_idle_handler();
 	mutex_unlock(&cpuidle_lock);
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
 
 /* Currently used in suspend/resume path to suspend cpuidle */
@@ -538,7 +536,6 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 
 	return ret;
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_enable_device);
 
 /**
@@ -566,7 +563,6 @@ void cpuidle_disable_device(struct cpuidle_device *dev)
 	cpuidle_remove_device_sysfs(dev);
 	enabled_devices--;
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_disable_device);
 
 static void __cpuidle_unregister_device(struct cpuidle_device *dev)
@@ -665,7 +661,6 @@ int cpuidle_register_device(struct cpuidle_device *dev)
 	__cpuidle_unregister_device(dev);
 	goto out_unlock;
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_register_device);
 
 /**
@@ -689,7 +684,6 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
 
 	cpuidle_resume_and_unlock();
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
 
 /**
-- 
2.31.1



