Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1AA35F908
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347390AbhDNQfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhDNQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:34:59 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D876CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:34:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b136-20020a1c1b8e0000b029012c69da2040so3490246wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5bUo8r4r13lEGITKVpdKd1iCEn6Je2Xyo3Iut/rgrSM=;
        b=d8pyRcO2akO++aJRtc4XlKYLV9HOYFfpM2oJ0m08qW8aKmlXMkm+76KUVyxOjb9jvv
         7PXy1UMvErOfSIltPjlp38GfJjp5MGByBkpcvZADTkWbkKStuCbG+0nZgK/+vFj05brw
         MQFrrMxB5Ws0YjOUzCT7LYWfb8M3fYdxhWxNXEJ0heN1sTB7776cpiWzS8Z0HuPOpm7g
         vrgg6cVd0VL212ZpiTSMz2VOMpoq9yLuBLcJWnsFSucXMjh8lg7iEfLzmNu7ftttv90f
         rgBwNG2nMLd0XifiVhCfpHoQuJmm1Gm+ktt0avQomzvBO42pPaonIVep4QHCf/f+Op2C
         42yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5bUo8r4r13lEGITKVpdKd1iCEn6Je2Xyo3Iut/rgrSM=;
        b=XRlVvDw0Ke7BDwVyyhiPhAq22VPSpHIcYa6KiEVX2peisojDH3LXTCrRCBRTIFLjxI
         AnUz0zuLva97iSdN4n3rf441lTEc7LyTQ9L1h7/OIcGjvE7atTaymLXrVu2F09Kf2zuv
         tcczMWty8AXAjYjf6pl5iWPCuIEpwOGjIHd0kFTjIevfcZ0XXv/HV7wFGRrP6IGxpT6j
         K2gpddJMGVu4nIHoTE7xH4wyGOYa2UfgFLFUraRa6SHMRuSA6yf7yQT6PWgANdg6Cwf/
         dL1it0c/aQkqd8kOjn79hcPKesqswwsHfwQJvno7b/dk1GfQ5BTNLu4YuW4roMo0wpXb
         TCGQ==
X-Gm-Message-State: AOAM532DiOKMKMPSz8sySmo7jhNOj6tbKazr7p8VmXcysnpZPSOjWgdk
        N+XH+A0RqDoDb2ARCZ0p830=
X-Google-Smtp-Source: ABdhPJzdczMyr4rGvuoYhoKkz4/Q5rSl4879o+8TF2z7yz7NTNcg8SsrIWSSIZ3pnCaolfo0Ss9ouA==
X-Received: by 2002:a05:600c:4f03:: with SMTP id l3mr3874188wmq.149.1618418076603;
        Wed, 14 Apr 2021 09:34:36 -0700 (PDT)
Received: from oliver-Z170M-D3H.cuni.cz ([2001:718:1e03:5128:b9b8:574a:9cb2:1c55])
        by smtp.gmail.com with ESMTPSA id l4sm5677999wmh.8.2021.04.14.09.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 09:34:36 -0700 (PDT)
From:   glittao@gmail.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oliver Glitta <glittao@gmail.com>
Subject: [PATCH] mm/slub: use stackdepot to save stack trace in objects
Date:   Wed, 14 Apr 2021 18:34:34 +0200
Message-Id: <20210414163434.4376-1-glittao@gmail.com>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

Many stack traces are similar so there are many similar arrays.
Stackdepot saves each unique stack only once.

Replace field addrs in struct track with depot_stack_handle_t handle.
Use stackdepot to save stack trace.

The benefits are smaller memory overhead and possibility to aggregate
per-cache statistics in the future using the stackdepot handle
instead of matching stacks manually.

Signed-off-by: Oliver Glitta <glittao@gmail.com>
---
 init/Kconfig |  1 +
 mm/slub.c    | 79 ++++++++++++++++++++++++++++++++--------------------
 2 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 37a17853433a..a4ed2daa6c41 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1891,6 +1891,7 @@ config SLUB_DEBUG
 	default y
 	bool "Enable SLUB debugging support" if EXPERT
 	depends on SLUB && SYSFS
+	select STACKDEPOT if STACKTRACE_SUPPORT
 	help
 	  SLUB has extensive debug support features. Disabling these can
 	  result in significant savings in code size. This also disables
diff --git a/mm/slub.c b/mm/slub.c
index 9c0e26ddf300..4b18499726eb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -35,6 +35,7 @@
 #include <linux/prefetch.h>
 #include <linux/memcontrol.h>
 #include <linux/random.h>
+#include <linux/stackdepot.h>
 
 #include <trace/events/kmem.h>
 
@@ -203,8 +204,8 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
 #define TRACK_ADDRS_COUNT 16
 struct track {
 	unsigned long addr;	/* Called from address */
-#ifdef CONFIG_STACKTRACE
-	unsigned long addrs[TRACK_ADDRS_COUNT];	/* Called from address */
+#ifdef CONFIG_STACKDEPOT
+	depot_stack_handle_t handle;
 #endif
 	int cpu;		/* Was running on cpu */
 	int pid;		/* Pid context */
@@ -581,22 +582,27 @@ static struct track *get_track(struct kmem_cache *s, void *object,
 	return kasan_reset_tag(p + alloc);
 }
 
+#ifdef CONFIG_STACKDEPOT
+static depot_stack_handle_t save_stack_trace(gfp_t flags)
+{
+	unsigned long entries[TRACK_ADDRS_COUNT];
+	depot_stack_handle_t handle;
+	unsigned int nr_entries;
+
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 4);
+	handle = stack_depot_save(entries, nr_entries, flags);
+	return handle;
+}
+#endif
+
 static void set_track(struct kmem_cache *s, void *object,
 			enum track_item alloc, unsigned long addr)
 {
 	struct track *p = get_track(s, object, alloc);
 
 	if (addr) {
-#ifdef CONFIG_STACKTRACE
-		unsigned int nr_entries;
-
-		metadata_access_enable();
-		nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
-					      TRACK_ADDRS_COUNT, 3);
-		metadata_access_disable();
-
-		if (nr_entries < TRACK_ADDRS_COUNT)
-			p->addrs[nr_entries] = 0;
+#ifdef CONFIG_STACKDEPOT
+		p->handle = save_stack_trace(GFP_KERNEL);
 #endif
 		p->addr = addr;
 		p->cpu = smp_processor_id();
@@ -623,14 +629,19 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
 
 	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
 	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
-#ifdef CONFIG_STACKTRACE
+#ifdef CONFIG_STACKDEPOT
 	{
-		int i;
-		for (i = 0; i < TRACK_ADDRS_COUNT; i++)
-			if (t->addrs[i])
-				pr_err("\t%pS\n", (void *)t->addrs[i]);
-			else
-				break;
+		depot_stack_handle_t handle;
+		unsigned long *entries;
+		unsigned int nr_entries;
+
+		handle = READ_ONCE(t->handle);
+		if (!handle) {
+			pr_err("object allocation/free stack trace missing\n");
+		} else {
+			nr_entries = stack_depot_fetch(handle, &entries);
+			stack_trace_print(entries, nr_entries, 0);
+		}
 	}
 #endif
 }
@@ -4017,18 +4028,26 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 	objp = fixup_red_left(s, objp);
 	trackp = get_track(s, objp, TRACK_ALLOC);
 	kpp->kp_ret = (void *)trackp->addr;
-#ifdef CONFIG_STACKTRACE
-	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
-		kpp->kp_stack[i] = (void *)trackp->addrs[i];
-		if (!kpp->kp_stack[i])
-			break;
-	}
+#ifdef CONFIG_STACKDEPOT
+	{
+		depot_stack_handle_t handle;
+		unsigned long *entries;
+		unsigned int nr_entries;
 
-	trackp = get_track(s, objp, TRACK_FREE);
-	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
-		kpp->kp_free_stack[i] = (void *)trackp->addrs[i];
-		if (!kpp->kp_free_stack[i])
-			break;
+		handle = READ_ONCE(trackp->handle);
+		if (handle) {
+			nr_entries = stack_depot_fetch(handle, &entries);
+			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
+				kpp->kp_stack[i] = (void *)entries[i];
+		}
+
+		trackp = get_track(s, objp, TRACK_FREE);
+		handle = READ_ONCE(trackp->handle);
+		if (handle) {
+			nr_entries = stack_depot_fetch(handle, &entries);
+			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
+				kpp->kp_free_stack[i] = (void *)entries[i];
+		}
 	}
 #endif
 #endif
-- 
2.31.1.272.g89b43f80a5

