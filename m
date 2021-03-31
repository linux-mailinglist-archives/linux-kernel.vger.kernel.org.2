Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B3E34FD6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhCaJta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:49:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15835 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhCaJtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:49:03 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F9M0X5Jbhz9tVy;
        Wed, 31 Mar 2021 17:46:52 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Wed, 31 Mar 2021
 17:48:54 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
CC:     <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH -next] staging: greybus: camera: Switch to memdup_user_nul()
Date:   Wed, 31 Mar 2021 17:52:01 +0800
Message-ID: <20210331095201.2173793-1-yangyingliang@huawei.com>
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
 drivers/staging/greybus/camera.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index b570e13394ac..0f005facffbc 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -1120,16 +1120,10 @@ static ssize_t gb_camera_debugfs_write(struct file *file,
 	if (len > 1024)
 		return -EINVAL;
 
-	kbuf = kmalloc(len + 1, GFP_KERNEL);
-	if (!kbuf)
+	kbuf = memdup_user_nul(buf, len);
+	if (IS_ERR(kbuf))
 		return -ENOMEM;
 
-	if (copy_from_user(kbuf, buf, len)) {
-		ret = -EFAULT;
-		goto done;
-	}
-
-	kbuf[len] = '\0';
 
 	ret = op->execute(gcam, kbuf, len);
 
-- 
2.25.1

