Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96F33CE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhCPHA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:00:26 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:52080 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhCPHAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=0gEZVh59Tp7JQ9VxHf
        W65RR8NZwmRliZUEldnyUvLyk=; b=nFcPR6qXfrYkNssFB/lKGB8GkwQNN7adu0
        6oZR+9Ed4EtJ9jw5yBfEJFuZa/5hGGBTZc2UPey4JrRINjlLE6VYwjCFm7O2yTm1
        GLBp3gJ7aoZXsSoqId4Gav0Nm9dMLlmbDpGiZeoOo9aE8b5cTSOKY+NCu3VV42MM
        5D85xlrf0=
Received: from bf-rmnj-02.ccdomain.com (unknown [218.94.48.178])
        by smtp1 (Coremail) with SMTP id GdxpCgBXZ+tOV1BgTGV3AA--.137S2;
        Tue, 16 Mar 2021 14:59:59 +0800 (CST)
From:   Jian Dong <dj0227@163.com>
To:     zbr@ioremap.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com,
        dongjian <dongjian@yulong.com>
Subject: [PATCH] w1: Use kobj_to_dev()[RESEND]
Date:   Tue, 16 Mar 2021 14:59:47 +0800
Message-Id: <1615877987-32163-1-git-send-email-dj0227@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: GdxpCgBXZ+tOV1BgTGV3AA--.137S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW3JFWxCryfWF1kGrWxWFg_yoW8Gr1rpF
        sxJa42yrWrGr4kW3W3Xw4DZFyYy34kCa4rKrZ7JwnYgr17JF9xZFW5JFyUA3W5tr90gr4a
        vrWDCrZFvFW8CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jr9N3UUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/xtbBQw9X3V++K5vpQwAAs9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dongjian <dongjian@yulong.com>

Use kobj_to_dev() instead of open-coding it

Signed-off-by: dongjian <dongjian@yulong.com>
---
 drivers/w1/slaves/w1_ds2780.c | 2 +-
 drivers/w1/slaves/w1_ds2781.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2780.c b/drivers/w1/slaves/w1_ds2780.c
index c281fe5..9dcb5a5 100644
--- a/drivers/w1/slaves/w1_ds2780.c
+++ b/drivers/w1/slaves/w1_ds2780.c
@@ -90,7 +90,7 @@ static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
 			     struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
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
1.9.1

