Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25144381588
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 05:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhEODmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 23:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEODmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 23:42:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52605C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 20:41:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p17so321606plf.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 20:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljG9oS+Y9DDy2qFTkHB7c25Na40O6djGYUjNa4ly9m4=;
        b=JpXkSEOTpY2wB+GpFOUxcoB4rttZ3iBxzftCur9r4nhabJfM2OhLp/1+Qt8GUNu848
         0KfPGgcjfLvH3O1FzEyHknjq5NXfNbJ4QRvRfkFh7iFlX8uY9QkRulFEoMZNpSzTYaq4
         vz9mHeGup1H61whSBsyYXIa4oQ48faHJUfufsklggb8WRThQjcfCQRnlHg2HArcDqU1R
         RQUn02tbjae5SjwDCY2Pjc/OibGeoW+0NKvT43nvc+SzQJS/5DOy7+BmOmuNHl6CSSZA
         xfbMduEVDS+246g3a/zfbPGK43ble8mUQEiVo68QeQ5Ts/M2iD282URrx1LayJK2aICM
         tGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljG9oS+Y9DDy2qFTkHB7c25Na40O6djGYUjNa4ly9m4=;
        b=faCjjdSs+04iCFUHCvexvba8CL/XkDihW3B1grCQ8ADu1ZEZ3JWMwCWWGY9bdVwGVh
         5ZsN9pvnwlxqGqGFCR7OB3Ik9f+Orpt5szS3W14GR81OOga8j4WVU8e44xAMV+nb3NrO
         5KVfmei4CWeg/LvefarTmHa5cnp8P9hAqNDDToOJLKQVu4RI3FFZzIOCBWeBGfact/ZS
         Y0NRuPm1TJZm4X/o6pqqYyQQWntEyBcFOMsxPAQFpTzDJuqNC1JdZLba9JJcVR1HkQES
         ijapmxDqNgw92z963H0JIpLY6Bh9FDe5jVFAMoCJNjEjJ33/ZFyNVJR5bcpdEbfY8VWs
         kk7A==
X-Gm-Message-State: AOAM532MgZnCUeu4GBV3S6V+DCZsIcmqzfrux+u95LCgsOAJWARYAiIQ
        fqOZbq2Clfb+aN7CDDjpeJo=
X-Google-Smtp-Source: ABdhPJw6SxER/k+RVLDYG7obbuBdx20yQSWPf7vwHoH+puJyrrmQbb2K9s99KF/WuMXZYbMdFEJucg==
X-Received: by 2002:a17:90b:4ac2:: with SMTP id mh2mr13678260pjb.33.1621050083590;
        Fri, 14 May 2021 20:41:23 -0700 (PDT)
Received: from fedora.. ([2405:201:6008:61b4:4e16:5348:d963:c66d])
        by smtp.googlemail.com with ESMTPSA id 21sm4895479pfh.103.2021.05.14.20.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 20:41:23 -0700 (PDT)
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Subject: [PATCH] staging: greybus: add declare_ to declaring macros
Date:   Sat, 15 May 2021 09:11:16 +0530
Message-Id: <20210515034116.660895-1-chouhan.shreyansh630@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefixed the names of all the macros that were used for declaring things
with 'declare_'. This should help with clarifying about what these
macros do.

Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
---
 drivers/staging/greybus/loopback.c | 56 +++++++++++++++---------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 2471448ba42a..ddbeb33fa3c1 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -119,7 +119,7 @@ module_param(kfifo_depth, uint, 0444);
 #define GB_LOOPBACK_US_WAIT_MAX				1000000
 
 /* interface sysfs attributes */
-#define gb_loopback_ro_attr(field)				\
+#define declare_gb_loopback_ro_attr(field)				\
 static ssize_t field##_show(struct device *dev,			\
 			    struct device_attribute *attr,		\
 			    char *buf)					\
@@ -129,7 +129,7 @@ static ssize_t field##_show(struct device *dev,			\
 }									\
 static DEVICE_ATTR_RO(field)
 
-#define gb_loopback_ro_stats_attr(name, field, type)		\
+#define declare_gb_loopback_ro_stats_attr(name, field, type)		\
 static ssize_t name##_##field##_show(struct device *dev,	\
 			    struct device_attribute *attr,		\
 			    char *buf)					\
@@ -142,7 +142,7 @@ static ssize_t name##_##field##_show(struct device *dev,	\
 }									\
 static DEVICE_ATTR_RO(name##_##field)
 
-#define gb_loopback_ro_avg_attr(name)			\
+#define declare_gb_loopback_ro_avg_attr(name)			\
 static ssize_t name##_avg_show(struct device *dev,		\
 			    struct device_attribute *attr,		\
 			    char *buf)					\
@@ -162,12 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
 }									\
 static DEVICE_ATTR_RO(name##_avg)
 
-#define gb_loopback_stats_attrs(field)				\
-	gb_loopback_ro_stats_attr(field, min, u);		\
-	gb_loopback_ro_stats_attr(field, max, u);		\
-	gb_loopback_ro_avg_attr(field)
+#define declare_gb_loopback_stats_attrs(field)				\
+	declare_gb_loopback_ro_stats_attr(field, min, u);		\
+	declare_gb_loopback_ro_stats_attr(field, max, u);		\
+	declare_gb_loopback_ro_avg_attr(field)
 
-#define gb_loopback_attr(field, type)					\
+#define declare_gb_loopback_attr(field, type)				\
 static ssize_t field##_show(struct device *dev,				\
 			    struct device_attribute *attr,		\
 			    char *buf)					\
@@ -193,7 +193,7 @@ static ssize_t field##_store(struct device *dev,			\
 }									\
 static DEVICE_ATTR_RW(field)
 
-#define gb_dev_loopback_ro_attr(field, conn)				\
+#define declare_gb_dev_loopback_ro_attr(field, conn)			\
 static ssize_t field##_show(struct device *dev,		\
 			    struct device_attribute *attr,		\
 			    char *buf)					\
@@ -203,7 +203,7 @@ static ssize_t field##_show(struct device *dev,		\
 }									\
 static DEVICE_ATTR_RO(field)
 
-#define gb_dev_loopback_rw_attr(field, type)				\
+#define declare_gb_dev_loopback_rw_attr(field, type)			\
 static ssize_t field##_show(struct device *dev,				\
 			    struct device_attribute *attr,		\
 			    char *buf)					\
@@ -268,26 +268,26 @@ static void gb_loopback_check_attr(struct gb_loopback *gb)
 }
 
 /* Time to send and receive one message */
-gb_loopback_stats_attrs(latency);
+declare_gb_loopback_stats_attrs(latency);
 /* Number of requests sent per second on this cport */
-gb_loopback_stats_attrs(requests_per_second);
+declare_gb_loopback_stats_attrs(requests_per_second);
 /* Quantity of data sent and received on this cport */
-gb_loopback_stats_attrs(throughput);
+declare_gb_loopback_stats_attrs(throughput);
 /* Latency across the UniPro link from APBridge's perspective */
-gb_loopback_stats_attrs(apbridge_unipro_latency);
+declare_gb_loopback_stats_attrs(apbridge_unipro_latency);
 /* Firmware induced overhead in the GPBridge */
-gb_loopback_stats_attrs(gbphy_firmware_latency);
+declare_gb_loopback_stats_attrs(gbphy_firmware_latency);
 
 /* Number of errors encountered during loop */
-gb_loopback_ro_attr(error);
+declare_gb_loopback_ro_attr(error);
 /* Number of requests successfully completed async */
-gb_loopback_ro_attr(requests_completed);
+declare_gb_loopback_ro_attr(requests_completed);
 /* Number of requests timed out async */
-gb_loopback_ro_attr(requests_timedout);
+declare_gb_loopback_ro_attr(requests_timedout);
 /* Timeout minimum in useconds */
-gb_loopback_ro_attr(timeout_min);
+declare_gb_loopback_ro_attr(timeout_min);
 /* Timeout minimum in useconds */
-gb_loopback_ro_attr(timeout_max);
+declare_gb_loopback_ro_attr(timeout_max);
 
 /*
  * Type of loopback message to send based on protocol type definitions
@@ -297,21 +297,21 @@ gb_loopback_ro_attr(timeout_max);
  *					   payload returned in response)
  * 4 => Send a sink message (message with payload, no payload in response)
  */
-gb_dev_loopback_rw_attr(type, d);
+declare_gb_dev_loopback_rw_attr(type, d);
 /* Size of transfer message payload: 0-4096 bytes */
-gb_dev_loopback_rw_attr(size, u);
+declare_gb_dev_loopback_rw_attr(size, u);
 /* Time to wait between two messages: 0-1000 ms */
-gb_dev_loopback_rw_attr(us_wait, d);
+declare_gb_dev_loopback_rw_attr(us_wait, d);
 /* Maximum iterations for a given operation: 1-(2^32-1), 0 implies infinite */
-gb_dev_loopback_rw_attr(iteration_max, u);
+declare_gb_dev_loopback_rw_attr(iteration_max, u);
 /* The current index of the for (i = 0; i < iteration_max; i++) loop */
-gb_dev_loopback_ro_attr(iteration_count, false);
+declare_gb_dev_loopback_ro_attr(iteration_count, false);
 /* A flag to indicate synchronous or asynchronous operations */
-gb_dev_loopback_rw_attr(async, u);
+declare_gb_dev_loopback_rw_attr(async, u);
 /* Timeout of an individual asynchronous request */
-gb_dev_loopback_rw_attr(timeout, u);
+declare_gb_dev_loopback_rw_attr(timeout, u);
 /* Maximum number of in-flight operations before back-off */
-gb_dev_loopback_rw_attr(outstanding_operations_max, u);
+declare_gb_dev_loopback_rw_attr(outstanding_operations_max, u);
 
 static struct attribute *loopback_attrs[] = {
 	&dev_attr_latency_min.attr,
-- 
2.31.1

