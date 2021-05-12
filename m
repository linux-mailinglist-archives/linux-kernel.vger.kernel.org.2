Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63B937B6C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhELHVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:21:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2568 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhELHVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:21:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg5hj6c2tzwSJ0;
        Wed, 12 May 2021 15:17:25 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Wed, 12 May 2021
 15:20:03 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
Subject: [PATCH -next] driver core: attribute_container: fix W=1 warnings
Date:   Wed, 12 May 2021 15:22:33 +0800
Message-ID: <20210512072233.3817056-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following make W=1 kernel build warnings:

  drivers/base/attribute_container.c:304: warning: Function parameter or member 'fn' not described in 'attribute_container_device_trigger_safe'
  drivers/base/attribute_container.c:304: warning: Function parameter or member 'undo' not described in 'attribute_container_device_trigger_safe'
  drivers/base/attribute_container.c:357: warning: Function parameter or member 'fn' not described in 'attribute_container_device_trigger'

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/base/attribute_container.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/attribute_container.c b/drivers/base/attribute_container.c
index 9c00d203d61e..01ef796c2055 100644
--- a/drivers/base/attribute_container.c
+++ b/drivers/base/attribute_container.c
@@ -284,8 +284,8 @@ do_attribute_container_device_trigger_safe(struct device *dev,
  * matching classdev or fail all of them.
  *
  * @dev:  The generic device to run the trigger for
- * @fn	  the function to execute for each classdev.
- * @undo  A function to undo the work previously done in case of error
+ * @fn:   the function to execute for each classdev.
+ * @undo: A function to undo the work previously done in case of error
  *
  * This function is a safe version of
  * attribute_container_device_trigger. It stops on the first error and
@@ -343,7 +343,7 @@ attribute_container_device_trigger_safe(struct device *dev,
  * attribute_container_device_trigger - execute a trigger for each matching classdev
  *
  * @dev:  The generic device to run the trigger for
- * @fn	  the function to execute for each classdev.
+ * @fn:   the function to execute for each classdev.
  *
  * This function is for executing a trigger when you need to know both
  * the container and the classdev.  If you only care about the
-- 
2.25.1

