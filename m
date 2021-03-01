Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDAC327EBB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhCAM64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:58:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13101 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbhCAM6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:58:53 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dq0d835Knz16F3Z;
        Mon,  1 Mar 2021 20:56:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 20:58:05 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <zbr@ioremap.net>, <rikard.falkeborn@gmail.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] w1: ds2708 and ds2781 use the new API kobj_to_dev()
Date:   Mon, 1 Mar 2021 20:58:55 +0800
Message-ID: <1614603535-24046-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the below warnning:
/drivers/w1/slaves/w1_ds2780.c:93:60-61: WARNING opportunity for
kobj_to_dev()

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/w1/slaves/w1_ds2780.c | 3 ++-
 drivers/w1/slaves/w1_ds2781.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2780.c b/drivers/w1/slaves/w1_ds2780.c
index c281fe5..3cde1bb 100644
--- a/drivers/w1/slaves/w1_ds2780.c
+++ b/drivers/w1/slaves/w1_ds2780.c
@@ -90,7 +90,8 @@ static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
 			     struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
+
 	return w1_ds2780_io(dev, buf, off, count, 0);
 }
 
diff --git a/drivers/w1/slaves/w1_ds2781.c b/drivers/w1/slaves/w1_ds2781.c
index f0d393a..2cb7c02 100644
--- a/drivers/w1/slaves/w1_ds2781.c
+++ b/drivers/w1/slaves/w1_ds2781.c
@@ -87,7 +87,7 @@ static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
 			     struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	return w1_ds2781_io(dev, buf, off, count, 0);
 }
 
-- 
2.7.4

