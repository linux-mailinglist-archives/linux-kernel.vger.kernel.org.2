Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9C53AC75C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhFRJ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:26:37 -0400
Received: from mail-m972.mail.163.com ([123.126.97.2]:51926 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhFRJ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LK6Qg
        tPtbx2x19Qu0W3G8apwa/oLISwwlVrf0cDZS1E=; b=JJnzS5ULjyy/0ZEU6WV8D
        NnXsm9om0vcaYvwFxdMLcT5aYPuG527wNg3DNcOSFg4aepsO47cSuRWF+7dklz3m
        OI40yCBcQVRhd3OLG8kcgx1GME7J3TB3GYRj8Hib2gJObu6XhiyxYnUA/iqROr7b
        OirB3gMVVTzPEJWmBpcK3Y=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp2 (Coremail) with SMTP id GtxpCgC3v_89ZsxgxZVtGA--.48S2;
        Fri, 18 Jun 2021 17:24:17 +0800 (CST)
From:   zuoqilin1@163.com
To:     zbr@ioremap.net
Cc:     linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] wl: Simplify the steps
Date:   Fri, 18 Jun 2021 17:24:18 +0800
Message-Id: <20210618092418.1424-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgC3v_89ZsxgxZVtGA--.48S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UAw47Aw1rur1DGr18Grg_yoWkJFg_Ca
        40vryDWFWrGw18C3W7Xwn0vFZYgr42qF18W3yvqFWfJ3W5uas8Xr1j9rs7JFyUXws7GFy3
        G340gry7ur1rGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8FJmUUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiTgG1iVUDKN-KNwAAsv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

There is no necessary to define variable assignment, return directly.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 drivers/w1/w1.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index f2ae2e5..507d77e 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -301,17 +301,13 @@ static ssize_t w1_master_attribute_show_pointer(struct device *dev, struct devic
 
 static ssize_t w1_master_attribute_show_timeout(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	ssize_t count;
-	count = sprintf(buf, "%d\n", w1_timeout);
-	return count;
+	return sprintf(buf, "%d\n", w1_timeout);
 }
 
 static ssize_t w1_master_attribute_show_timeout_us(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	ssize_t count;
-	count = sprintf(buf, "%d\n", w1_timeout_us);
-	return count;
+	return sprintf(buf, "%d\n", w1_timeout_us);
 }
 
 static ssize_t w1_master_attribute_store_max_slave_count(struct device *dev,
-- 
1.9.1

