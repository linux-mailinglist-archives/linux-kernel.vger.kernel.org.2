Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A8F447C96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbhKHJO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhKHJOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:14:51 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568D3C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 01:12:07 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b68so4720860pfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 01:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8pJBofY7W457CAeYjDyB8HE85u5US8wpjr5jzky2JaM=;
        b=gpACOkwp41ZXx8LTjA40x7QY6EFB7Y+AOSmgEg7oTWUj2Y3VkYkWatJuk8zWEJd6if
         1V0qI1IhU7zsjHFgcdVlDRztGHEWhcoNZmeBxvlQKJ4U9wjH23c2rpD5VeD+1oOQ6dWo
         1WYF3cir9tz6M4c+nbYRqnP00NHjSPTNPtytsrn2aOgkzQRTF7BvkMc5aM09W7EKADqE
         oD2+/FQo4k3/PbFkXC01tKV6g96OSHpaDigaPVwlVo1HP5uwqW9yfHyds+6M5WYDob8/
         IgTk6qwlp32BD6LWkWPm98lmii+OZij8x2KhlLydwwBzYy47sfIRlkQe6J95E3h19/Ny
         W3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8pJBofY7W457CAeYjDyB8HE85u5US8wpjr5jzky2JaM=;
        b=ozYq2neMDbSOAgumdJhflA+KmMLn5+sempldCCcxps0tG8CvFTi1CwWbB5PdVgqoEf
         Fio7dH7tJi+8vz+76PYkgd2A7kfRJr5RQ7ApRfz5Qd6S9OpJ0Fset0q/R0VjhykUN8vM
         3IO+osX8k04UXUV0YIABAN9f5xGDO25dAGtMTlvxBVs0V4/k7jkhtUjG1LvyMkJP4zrD
         273/2aXwULl6jy5nW0Ak04Y2xadw/PgCSLWTrwMacllZCmCacQbmRQOW5EwPZR1c9Hjs
         w3d/jqmG+ROc88f1qpj398qsQ3LUaQdbKdiwfNU8gMxV4YDkBSZ6eP5jHt527Cbf94Mi
         zGwg==
X-Gm-Message-State: AOAM5301Eg2hVare/KLoWZvFN93zmOLuwBpnQn1WvEo+d+E/8Qtguc1L
        uL8SRNXwOHqBK868AsTM9AY=
X-Google-Smtp-Source: ABdhPJywBfLlZz/10i0VlhAQ3+sJ0ItnFMP766l9YCkyuJGB/0qFig8vh6iLhw6ORc0j6Oct+P8L+Q==
X-Received: by 2002:a63:720c:: with SMTP id n12mr58757149pgc.95.1636362726869;
        Mon, 08 Nov 2021 01:12:06 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w185sm14723497pfb.38.2021.11.08.01.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 01:12:06 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, vincent.donnefort@arm.com,
        valentin.schneider@arm.com, mingo@kernel.org, npiggin@gmail.com,
        rdunlap@infradead.org, yuehaibing@huawei.com, ye.guojin@zte.com.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] cpu/hotplug: replace snprintf and sprintf in show functions with sysfs_emit
Date:   Mon,  8 Nov 2021 09:12:00 +0000
Message-Id: <20211108091200.103745-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING  use scnprintf or sprintf

Use sysfs_emit or sysfs_emit_at instead of snprintf or sprintf makes
more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 kernel/cpu.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index fffe8b738201..fcaac665c53e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2261,7 +2261,7 @@ static ssize_t state_show(struct device *dev,
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
 
-	return sprintf(buf, "%d\n", st->state);
+	return sysfs_emit(buf, "%d\n", st->state);
 }
 static DEVICE_ATTR_RO(state);
 
@@ -2309,7 +2309,7 @@ static ssize_t target_show(struct device *dev,
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
 
-	return sprintf(buf, "%d\n", st->target);
+	return sysfs_emit(buf, "%d\n", st->target);
 }
 static DEVICE_ATTR_RW(target);
 
@@ -2368,7 +2368,7 @@ static ssize_t fail_show(struct device *dev,
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
 
-	return sprintf(buf, "%d\n", st->fail);
+	return sysfs_emit(buf, "%d\n", st->fail);
 }
 
 static DEVICE_ATTR_RW(fail);
@@ -2397,8 +2397,7 @@ static ssize_t states_show(struct device *dev,
 		struct cpuhp_step *sp = cpuhp_get_step(i);
 
 		if (sp->name) {
-			cur = sprintf(buf, "%3d: %s\n", i, sp->name);
-			buf += cur;
+			cur = sysfs_emit_at(buf, res, "%3d: %s\n", i, sp->name);
 			res += cur;
 		}
 	}
@@ -2481,9 +2480,7 @@ static const char *smt_states[] = {
 static ssize_t control_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	const char *state = smt_states[cpu_smt_control];
-
-	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
+	return sysfs_emit(buf, "%s\n", smt_states[cpu_smt_control]);
 }
 
 static ssize_t control_store(struct device *dev, struct device_attribute *attr,
@@ -2496,7 +2493,7 @@ static DEVICE_ATTR_RW(control);
 static ssize_t active_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
+	return sysfs_emit(buf, "%d\n", sched_smt_active());
 }
 static DEVICE_ATTR_RO(active);
 
-- 
2.25.1

