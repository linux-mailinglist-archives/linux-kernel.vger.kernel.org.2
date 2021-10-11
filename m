Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB174287BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhJKHjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbhJKHja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:39:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CABBC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:37:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lk8-20020a17090b33c800b001a0a284fcc2so285270pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=7rGE9mSxFcmTICtm7xLbAJ1BFzNpTe9iLYM4J2h4SGQ=;
        b=PNVMnMXDkCirMAR+akSIGJzGSHTW9violPGnH14VQNXa0AmL11DrPfLcb0xy7JNIRm
         s03xY03AGB5UW1BLNXJc+0HNP3demC+lPGgWvru9868wjIs8BAKEtqmi0wMoquGWsoIj
         OCscGXo/VkAvI8zPK4HpTwF3kKGEeq/Ivz0d1vO3YKI3LerMPayAyecTeDZN6fS05OBU
         0HjUq858KFpRUO2ZVhpXSXuLN1k8aVzLeszwhNo1trEct0QVHRmQW5ckF+WqQSZji1z/
         6OyR9/lok4snEB+IC/7fR9ena/zKMrckdg+29Bg7trIBa373vYk9Mr+/hpW7NgwpRhaK
         OWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7rGE9mSxFcmTICtm7xLbAJ1BFzNpTe9iLYM4J2h4SGQ=;
        b=oXQKsVVkDax5nEkRmiM4tkaZemmXed4IFdT+KTaPOP6HvYRUeZ6oz3tx7WV0g0kEES
         3a4/K4FPk6qH3K6WVRftBbMgBuxZlDip3+2noLlPBR+LazhwEM++b86+B/0bh8tPC6nj
         Y0XT0MO1QlgGPrynJyfBXCbJQJMFSXzXJGiRS3AK/wvl06WwzrFFFR9FAd3/FhNCnAhH
         NSqBObeDoNDn0lBXi2N1FpeVDJGuk4Et2ZD9tBerCBGg6EGaEA6oX4OUjFnsaY4qHysH
         PUDNxW/if5k1XhB+u1b2Ym/x6uJFJrfITOWGv2+gewTCzHX1V33UnFyWyQv/PBX7EvEo
         Hrmw==
X-Gm-Message-State: AOAM5333SOA0l8Ae8TwfV3AhGbKIFs5E+G73BfgJlKMSK6xEpxX7vpOV
        nhkZvzAH76AaHu8f49oCIlY=
X-Google-Smtp-Source: ABdhPJz8ZfuI9PB/RTWUXhqeu1vrh8wEyZtCAb54OY7FADWnMVPRDIKAr52qi+DeWBPlT46dXo7z1A==
X-Received: by 2002:a17:90b:1645:: with SMTP id il5mr28005747pjb.158.1633937848486;
        Mon, 11 Oct 2021 00:37:28 -0700 (PDT)
Received: from bj10083pcu01.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g14sm16095235pjd.24.2021.10.11.00.37.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Oct 2021 00:37:28 -0700 (PDT)
From:   Liangcai Fan <liangcaifan19@gmail.com>
To:     liangcai.fan@unisoc.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Liangcai Fan <liangcaifan19@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] mm: khugepaged: Recalculate min_free_kbytes after stopping khugepaged
Date:   Mon, 11 Oct 2021 15:36:49 +0800
Message-Id: <1633937809-16558-1-git-send-email-liangcaifan19@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When initializing transparent huge pages, min_free_kbytes would be
calculated according to what khugepaged expected.
So when disable transparent huge pages, min_free_kbytes should be
recalculated instead of the higher value set by khugepaged.

Signed-off-by: Liangcai Fan <liangcaifan19@gmail.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 include/linux/mm.h |  1 +
 mm/khugepaged.c    | 10 ++++++++--
 mm/page_alloc.c    |  7 ++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 73a52ab..4ef07e8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2475,6 +2475,7 @@ extern void memmap_init_range(unsigned long, int, unsigned long,
 		unsigned long, unsigned long, enum meminit_context,
 		struct vmem_altmap *, int migratetype);
 extern void setup_per_zone_wmarks(void);
+extern void calculate_min_free_kbytes(void);
 extern int __meminit init_per_zone_wmark_min(void);
 extern void mem_init(void);
 extern void __init mmap_init(void);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 045cc57..682130f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2291,6 +2291,11 @@ static void set_recommended_min_free_kbytes(void)
 	int nr_zones = 0;
 	unsigned long recommended_min;
 
+	if (!khugepaged_enabled()) {
+		calculate_min_free_kbytes();
+		goto update_wmarks;
+	}
+
 	for_each_populated_zone(zone) {
 		/*
 		 * We don't need to worry about fragmentation of
@@ -2326,6 +2331,8 @@ static void set_recommended_min_free_kbytes(void)
 
 		min_free_kbytes = recommended_min;
 	}
+
+update_wmarks:
 	setup_per_zone_wmarks();
 }
 
@@ -2347,12 +2354,11 @@ int start_stop_khugepaged(void)
 
 		if (!list_empty(&khugepaged_scan.mm_head))
 			wake_up_interruptible(&khugepaged_wait);
-
-		set_recommended_min_free_kbytes();
 	} else if (khugepaged_thread) {
 		kthread_stop(khugepaged_thread);
 		khugepaged_thread = NULL;
 	}
+	set_recommended_min_free_kbytes();
 fail:
 	mutex_unlock(&khugepaged_mutex);
 	return err;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c..1d44386 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8452,7 +8452,7 @@ void setup_per_zone_wmarks(void)
  * 8192MB:	11584k
  * 16384MB:	16384k
  */
-int __meminit init_per_zone_wmark_min(void)
+void calculate_min_free_kbytes(void)
 {
 	unsigned long lowmem_kbytes;
 	int new_min_free_kbytes;
@@ -8470,6 +8470,11 @@ int __meminit init_per_zone_wmark_min(void)
 		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
 				new_min_free_kbytes, user_min_free_kbytes);
 	}
+}
+
+int __meminit init_per_zone_wmark_min(void)
+{
+	calculate_min_free_kbytes();
 	setup_per_zone_wmarks();
 	refresh_zone_stat_thresholds();
 	setup_per_zone_lowmem_reserve();
-- 
1.9.1

