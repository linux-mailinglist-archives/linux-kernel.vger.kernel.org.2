Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67F23ADF8F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhFTRC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 13:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhFTRCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 13:02:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C4BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 10:00:06 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x19so7270575pln.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vplKU+u5BNo996K8f2xPSiatclDH2lB4T12dOrQIivE=;
        b=QWRnGHvKw4OmAKVdb7g4PrPt4DMjFNMI71DYvWPQ4o/2KNDm5Qkf3YSvllvOT4zbdy
         M6ouf/4FnHr4JaLLnP/nLaZwQm5mJOx7JxUQ8PSRpniVhAiUDdFbex4xd43tOdGIx/BZ
         Dsi6pfRoLE007Y3fTwSvXaGMcyRUHs9yloP5tnDID46zrspB6QHtkHxnz//fo5xMlvhY
         uc10QAajHXZ+wH6X6J620X8DFV6WPwujfAcl7vJ1eQMU9epbqLmxXDqrrilmsUYZZ9jV
         F0dGkmOu3NgPbm8AFQ2XiEww5Mkmg+X3DxLZnaBM7CsqIfP7L0VJvwJ7iW6Ez9YiTQb2
         oqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vplKU+u5BNo996K8f2xPSiatclDH2lB4T12dOrQIivE=;
        b=hcF5YuIMcQvUob6l8j4nLw8rHEwD3+wdxj9Ez78TLRDyizO1usasLzqNPxH1n6seS4
         McyjtSnw4WVfg+QIBmRgnP/1o9KG+PmK3oXRUpDu//MCxq33Y+4xG4fkxIO0jMlzf/Mm
         T/rA4Jz2PIz8k19qefOfcs79b9LCRlTsumukVKBSbWWcUbRl3AG+Ys9ktv2P6Yoy0iIF
         /Pn1TsqP/kOCNVhg6pqeGM08rPNj9Qr9GL76NMSFt292UaXk14lGO8yV/PV5S4rs603X
         z30XXxzDIIpnTVw4O3NQOGtWItjl5qui+5CclOJV2VKN/R6CF2fuR446NpFvMaFrwOrE
         zLxg==
X-Gm-Message-State: AOAM5316C8xbY30+ja7vQZdhdP2I+oqRIC/cM014vGtRA8p71MHkzyU6
        UWnqXLyoXNeNf9x2ZUIT7RNuOvLKCAeIhOHc
X-Google-Smtp-Source: ABdhPJwIo7u5PX8GYiAcafV3q+rzQxQ3UWtImDVVFuxgXmoO/ovf4rEBkoy3Y2RrCKVlKUC9/ssLhg==
X-Received: by 2002:a17:90a:8804:: with SMTP id s4mr22648275pjn.200.1624208405401;
        Sun, 20 Jun 2021 10:00:05 -0700 (PDT)
Received: from pn-hyperv.lan (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id i128sm13554263pfc.142.2021.06.20.10.00.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 10:00:05 -0700 (PDT)
From:   Nguyen Dinh Phi <phind.uet@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] samples/kobject: Use sysfs_emit instead of snprintf
Date:   Mon, 21 Jun 2021 01:00:01 +0800
Message-Id: <20210620170001.224583-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert sprintf() to sysfs_emit() in order to check buffer overrun on sysfs
outputs.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 samples/kobject/kobject-example.c | 4 ++--
 samples/kobject/kset-example.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/kobject/kobject-example.c b/samples/kobject/kobject-example.c
index 9e383fdbaa00..96678ed73216 100644
--- a/samples/kobject/kobject-example.c
+++ b/samples/kobject/kobject-example.c
@@ -28,7 +28,7 @@ static int bar;
 static ssize_t foo_show(struct kobject *kobj, struct kobj_attribute *attr,
 			char *buf)
 {
-	return sprintf(buf, "%d\n", foo);
+	return sysfs_emit(buf, "%d\n", foo);
 }
 
 static ssize_t foo_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -60,7 +60,7 @@ static ssize_t b_show(struct kobject *kobj, struct kobj_attribute *attr,
 		var = baz;
 	else
 		var = bar;
-	return sprintf(buf, "%d\n", var);
+	return sysfs_emit(buf, "%d\n", var);
 }
 
 static ssize_t b_store(struct kobject *kobj, struct kobj_attribute *attr,
diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index c8010f126808..52f1acabd479 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -112,7 +112,7 @@ static void foo_release(struct kobject *kobj)
 static ssize_t foo_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
 			char *buf)
 {
-	return sprintf(buf, "%d\n", foo_obj->foo);
+	return sysfs_emit(buf, "%d\n", foo_obj->foo);
 }
 
 static ssize_t foo_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
@@ -144,7 +144,7 @@ static ssize_t b_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
 		var = foo_obj->baz;
 	else
 		var = foo_obj->bar;
-	return sprintf(buf, "%d\n", var);
+	return sysfs_emit(buf, "%d\n", var);
 }
 
 static ssize_t b_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
-- 
2.25.1

