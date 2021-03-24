Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762F1347208
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhCXHHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:07:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14447 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbhCXHGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:06:42 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F4zl24Lfwzkb0s;
        Wed, 24 Mar 2021 15:05:02 +0800 (CST)
Received: from huawei.com (10.175.104.82) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Wed, 24 Mar 2021
 15:06:36 +0800
From:   Xu Jia <xujia39@huawei.com>
To:     <gregkh@linuxfoundation.org>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] applicom: fix some err codes returned by ac_ioctl
Date:   Wed, 24 Mar 2021 15:20:31 +0800
Message-ID: <20210324072031.941791-1-xujia39@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cmd > 6 or copy_to_user() fail, The variable 'ret' would not be 
returned back. Fix the 'ret' set but not used.

Signed-off-by: Xu Jia <xujia39@huawei.com>
---
 drivers/char/applicom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index 14b2d8034c51..0ab765143354 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -839,7 +839,7 @@ static long ac_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	Dummy = readb(apbs[IndexCard].RamIO + VERS);
 	kfree(adgl);
 	mutex_unlock(&ac_mutex);
-	return 0;
+	return ret;
 
 err:
 	if (warncount) {
-- 
2.25.1

