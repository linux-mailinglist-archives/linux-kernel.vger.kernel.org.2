Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E445F3513B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhDAKeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:34:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15572 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbhDAKdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:33:40 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9zxd1fyPz17PDL;
        Thu,  1 Apr 2021 18:31:33 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 18:33:37 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
CC:     <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH -next v3] staging: greybus: camera: Switch to memdup_user_nul()
Date:   Thu, 1 Apr 2021 18:36:45 +0800
Message-ID: <20210401103645.1558813-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memdup_user_nul() helper instead of open-coding to
simplify the code.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v3:
  remove duplicate ';'
v2:
  delete unnecessary blank line
  use return PTR_ERR(kbuf) instead
---
 drivers/staging/greybus/camera.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index b570e13394ac..2ecdc1bc5092 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -1120,16 +1120,9 @@ static ssize_t gb_camera_debugfs_write(struct file *file,
 	if (len > 1024)
 		return -EINVAL;
 
-	kbuf = kmalloc(len + 1, GFP_KERNEL);
-	if (!kbuf)
-		return -ENOMEM;
-
-	if (copy_from_user(kbuf, buf, len)) {
-		ret = -EFAULT;
-		goto done;
-	}
-
-	kbuf[len] = '\0';
+	kbuf = memdup_user_nul(buf, len);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
 
 	ret = op->execute(gcam, kbuf, len);
 
-- 
2.25.1

