Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1883634FF12
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhCaLBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbhCaLBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:01:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50192C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:01:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o16so19273141wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vpasoPhVYw8KNa6DUjj7NxNL215nlw6wzCs7oS8Xu4Y=;
        b=uQyjeCo+EVTso/xgGDo28DMqdCmJtay4jgqZ3FNfvHhVtu64Umhi/iNfGq2DlKALXO
         idzufOKV8nF0heW54D32ECXTjvO+HHAjQaaRfBuNJu7SW7ht4Z1WIQJv+i5b4bHMdiH9
         4cYX5p2wZYvPVrN2ObTYay9nzrkIbGlObv1brow543d01FHy1WuhaL1mSjr3FqZ7LGS2
         NjVRG/fS86qR2E6VgMmU5aSd99LWoI+8jbFfkBExxBXX2ihQ/NVn8WPGbkKBnIElIuvb
         4w0B1t4Sjmv8iPevznorlPKyzJ7XaMPBmSgUQRoxbc70HBMyGMdkWIwEMFbQypXsvPBN
         7acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vpasoPhVYw8KNa6DUjj7NxNL215nlw6wzCs7oS8Xu4Y=;
        b=OvxQI7G8dDHioIJf6ysZG7HeZLE3FR8Xq6NVAlOc0v/HwfDJzuML3bbww3279aZ9qH
         YtSTx0OyaNbOJpWwa4/xEo+r8AcZZo8khObdC2/rd6++fDKmcL4tPD+UmaAD5cLzn3of
         GytM2G+n7qOvs7XYFKAKx5D6XHoIYfBbPdew5VE4yR9QE55foQ+rgW7hnPtMtESC5WGp
         uPGL1KZVqxMwkT/59QgBg3/Uk8qdMyhWxc9dOhNa9WvCIsJMbuenNuewF0itMhYISjbM
         DzwKG2gbzjoNZhPhMFrhqx6mHbgAWHKvYqDxjTFwAKprhWQEANqL0/ZGWgm0di6mKIuw
         JTPg==
X-Gm-Message-State: AOAM530yiKNZGz0teoTvctePhRUFVwiDn+q+kjpVGC/xtT+52PhhzjmE
        gfpXnhphf7O/xw+jidRSmKZRow==
X-Google-Smtp-Source: ABdhPJxaopZ9tfI0hg48mn9NYUxFZ35l1B0QHbMpfMpIzS7qKGhExb4jgCrXndZ+xpOVNQLrdCIOLg==
X-Received: by 2002:adf:f9d0:: with SMTP id w16mr3090824wrr.336.1617188464931;
        Wed, 31 Mar 2021 04:01:04 -0700 (PDT)
Received: from localhost.localdomain ([82.142.26.252])
        by smtp.gmail.com with ESMTPSA id u23sm3376275wmn.26.2021.03.31.04.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 04:01:04 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v5 3/5] powercap/drivers/dtpm: Simplify the dtpm table
Date:   Wed, 31 Mar 2021 13:00:46 +0200
Message-Id: <20210331110048.24956-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331110048.24956-1-daniel.lezcano@linaro.org>
References: <20210331110048.24956-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtpm table is an array of pointers, that forces the user of the
table to define initdata along with the declaration of the table
entry. It is more efficient to create an array of dtpm structure, so
the declaration of the table entry can be done by initializing the
different fields.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/powercap/dtpm.c     |  4 ++--
 drivers/powercap/dtpm_cpu.c |  4 +++-
 include/linux/dtpm.h        | 20 +++++++++-----------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 8df7adeed0cf..3bcd8374baf8 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -580,7 +580,7 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 
 static int __init dtpm_init(void)
 {
-	struct dtpm_descr **dtpm_descr;
+	struct dtpm_descr *dtpm_descr;
 
 	pct = powercap_register_control_type(NULL, "dtpm", NULL);
 	if (IS_ERR(pct)) {
@@ -589,7 +589,7 @@ static int __init dtpm_init(void)
 	}
 
 	for_each_dtpm_table(dtpm_descr)
-		(*dtpm_descr)->init(*dtpm_descr);
+		dtpm_descr->init();
 
 	return 0;
 }
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 9deafd16a197..74b39a1082e5 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -204,7 +204,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	return ret;
 }
 
-int dtpm_register_cpu(struct dtpm *parent)
+static int __init dtpm_cpu_init(void)
 {
 	int ret;
 
@@ -241,3 +241,5 @@ int dtpm_register_cpu(struct dtpm *parent)
 
 	return 0;
 }
+
+DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init);
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index 577c71d4e098..2ec2821111d1 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -33,25 +33,23 @@ struct dtpm_ops {
 	void (*release)(struct dtpm *);
 };
 
-struct dtpm_descr;
-
-typedef int (*dtpm_init_t)(struct dtpm_descr *);
+typedef int (*dtpm_init_t)(void);
 
 struct dtpm_descr {
-	struct dtpm *parent;
-	const char *name;
 	dtpm_init_t init;
 };
 
 /* Init section thermal table */
-extern struct dtpm_descr *__dtpm_table[];
-extern struct dtpm_descr *__dtpm_table_end[];
+extern struct dtpm_descr __dtpm_table[];
+extern struct dtpm_descr __dtpm_table_end[];
 
-#define DTPM_TABLE_ENTRY(name)			\
-	static typeof(name) *__dtpm_table_entry_##name	\
-	__used __section("__dtpm_table") = &name
+#define DTPM_TABLE_ENTRY(name, __init)				\
+	static struct dtpm_descr __dtpm_table_entry_##name	\
+	__used __section("__dtpm_table") = {			\
+		.init = __init,					\
+	}
 
-#define DTPM_DECLARE(name)	DTPM_TABLE_ENTRY(name)
+#define DTPM_DECLARE(name, init)	DTPM_TABLE_ENTRY(name, init)
 
 #define for_each_dtpm_table(__dtpm)	\
 	for (__dtpm = __dtpm_table;	\
-- 
2.17.1

