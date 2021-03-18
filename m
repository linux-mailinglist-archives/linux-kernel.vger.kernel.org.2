Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2938C33FF19
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCRFyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:54:38 -0400
Received: from m12-12.163.com ([220.181.12.12]:40530 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhCRFya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SnDuY
        /CUrODdW3DOO0gaWb14+07aFsVNtctzrBKHcE0=; b=CyIcqmkmTg5px/d9W38Tr
        JmDuusGpuJtJJObMeJOHevTZ59PXcv6wVmXTYG4b+3d52jcrAyZNJKlaAEKiOxH6
        X6rJ8CZQpdcz649fOCkaTXfP7IUATqp7cjDkQGQSUeBnzV24Ay4lYpAuymIxJMsi
        mKLpncXbMqkTJCx7dGsnfY=
Received: from COOL-20200916KH.ccdomain.com (unknown [218.94.48.178])
        by smtp8 (Coremail) with SMTP id DMCowADnJM3y6lJgqEJdVQ--.21149S2;
        Thu, 18 Mar 2021 13:53:59 +0800 (CST)
From:   qiumibaozi_1@163.com
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, ganjisheng <ganjisheng@yulong.com>
Subject: [PATCH 4/4] Fix spelling of achieving
Date:   Thu, 18 Mar 2021 13:53:51 +0800
Message-Id: <20210318055351.215-1-qiumibaozi_1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowADnJM3y6lJgqEJdVQ--.21149S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr48AF13GFWDuw4DGFykZrb_yoW3GrX_GF
        ykZF1Igw4rJw1IkryrAa1aqryFkayFgF1ruF4ftFnxArWUZr17ur4qvrn0y345Aan8Zr9r
        Zwn8Wr1Iy3ZFyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5epB3UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5tlxzxxedr6xjbr6il2tof0z/1tbiKxdZ2FQHWxEq+QAAs3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ganjisheng <ganjisheng@yulong.com>

Signed-off-by: ganjisheng <ganjisheng@yulong.com>
---
 drivers/mfd/ab3100-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index ee71ae0..f424c2a 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -159,7 +159,7 @@ static int ab3100_get_register_interruptible(struct ab3100 *ab3100,
 
 	/*
 	 * AB3100 require an I2C "stop" command between each message, else
-	 * it will not work. The only way of achieveing this with the
+	 * it will not work. The only way of achieving this with the
 	 * message transport layer is to send the read and write messages
 	 * separately.
 	 */
-- 
1.9.1


