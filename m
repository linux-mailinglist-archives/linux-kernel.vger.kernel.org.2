Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959CE34E70D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhC3MFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhC3MEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:04:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D36C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 05:04:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o16so16043117wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 05:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/0VI3yeXD5uwV23Mq20qw7HZeWLU7kE/uRLQUoBBg7c=;
        b=gB5rCZU8RoJTo9UEe6TxRg03RGnFP7hCpFmWoyX24yvr4ZaiZ3BRPUkDVmJXEJ2bEV
         SSRVNQcU316dUEPx4RNcbXcSFLZGU1DZTwMg2yR9GNr17QgGy5eIjh9q2twFo3r5eKHG
         VUdqMzWc60cHCphiPXXS53vrJnLZ8FFKGg4QGoHWRg2UwBttaC82cqQ7qdwFk2kHTeVb
         25nBaeZ/06CZjnwlKo+RBa49RI4f+Z6E2RT6+OkkQfGf6SdS47MQS+d3IPkBt8lJGBAa
         P7kuqnPyVjxOPwI40moj/wixPk4DnSWS0XEdTMsoS+5e6T+mfVREMOIRj+N9FKMxrw2Z
         KRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/0VI3yeXD5uwV23Mq20qw7HZeWLU7kE/uRLQUoBBg7c=;
        b=VZXkMRq9gFkIovSg6AMsZIHtqLs5fLw1H7Z94suOiXQZgbVO2DMcbbH6eqQXp3Bpn/
         08f1HFJwYArsIg/BGiinQ3ryAUyQa2OkTyW6d5wwPEMzaZNQ4Y2ijCMTQC6pFGOIhLRi
         ol3RGwLupY2L82yJS7g9RroIhh6s2V1PdACvbSpsfdp2qhVq+bib2BEXIn0esTRgPi+a
         9w+AAeEh6CwEj5RXZjahfpbN1N0oWpHW25/3myQYhHk0YGe7/cLbY3x6R6al/UqwdgUy
         9gZ4b2GbC89Vhsnq1nqkgqlkBS+oQhaQylaCNSMduwVh092fdCESV0MZ6Wti63IPQkpP
         syZg==
X-Gm-Message-State: AOAM533HaWBebRTZCeOEkku1c5dUQaPePCRtBpW518e6yRJ8oNr8oZIG
        PvX68WSqiS+dcb1etdeX0cs=
X-Google-Smtp-Source: ABdhPJzP2XsSskXC/jVHrLSZc/3hfdn6vD1wUnJQqJR3OoBtzHYCYiWUw8GmFaAVqdV6/fJeaTyOnQ==
X-Received: by 2002:adf:fcc9:: with SMTP id f9mr33504787wrs.420.1617105878709;
        Tue, 30 Mar 2021 05:04:38 -0700 (PDT)
Received: from oliver-Z170M-D3H.cuni.cz ([2001:718:1e03:5128:4022:9f1c:1c57:cdce])
        by smtp.gmail.com with ESMTPSA id m14sm3219604wmi.27.2021.03.30.05.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 05:04:38 -0700 (PDT)
From:   glittao@gmail.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oliver Glitta <glittao@gmail.com>
Subject: [PATCH v2 2/2] slub: remove resiliency_test() function
Date:   Tue, 30 Mar 2021 14:04:36 +0200
Message-Id: <20210330120436.4591-2-glittao@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330120436.4591-1-glittao@gmail.com>
References: <20210330120436.4591-1-glittao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

Function resiliency_test() is hidden behind #ifdef
SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
runs it.

This function is replaced with KUnit test for SLUB added
by the previous patch "selftests: add a KUnit test for SLUB
debugging functionality".

Signed-off-by: Oliver Glitta <glittao@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Rientjes <rientjes@google.com>
---
 mm/slub.c | 64 -------------------------------------------------------
 1 file changed, 64 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 06916e11a2bf..7270978c4e21 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -153,9 +153,6 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
  * - Variable sizing of the per node arrays
  */
 
-/* Enable to test recovery from slab corruption on boot */
-#undef SLUB_RESILIENCY_TEST
-
 /* Enable to log cmpxchg failures */
 #undef SLUB_DEBUG_CMPXCHG
 
@@ -4923,66 +4920,6 @@ static int list_locations(struct kmem_cache *s, char *buf,
 }
 #endif	/* CONFIG_SLUB_DEBUG */
 
-#ifdef SLUB_RESILIENCY_TEST
-static void __init resiliency_test(void)
-{
-	u8 *p;
-	int type = KMALLOC_NORMAL;
-
-	BUILD_BUG_ON(KMALLOC_MIN_SIZE > 16 || KMALLOC_SHIFT_HIGH < 10);
-
-	pr_err("SLUB resiliency testing\n");
-	pr_err("-----------------------\n");
-	pr_err("A. Corruption after allocation\n");
-
-	p = kzalloc(16, GFP_KERNEL);
-	p[16] = 0x12;
-	pr_err("\n1. kmalloc-16: Clobber Redzone/next pointer 0x12->0x%p\n\n",
-	       p + 16);
-
-	validate_slab_cache(kmalloc_caches[type][4]);
-
-	/* Hmmm... The next two are dangerous */
-	p = kzalloc(32, GFP_KERNEL);
-	p[32 + sizeof(void *)] = 0x34;
-	pr_err("\n2. kmalloc-32: Clobber next pointer/next slab 0x34 -> -0x%p\n",
-	       p);
-	pr_err("If allocated object is overwritten then not detectable\n\n");
-
-	validate_slab_cache(kmalloc_caches[type][5]);
-	p = kzalloc(64, GFP_KERNEL);
-	p += 64 + (get_cycles() & 0xff) * sizeof(void *);
-	*p = 0x56;
-	pr_err("\n3. kmalloc-64: corrupting random byte 0x56->0x%p\n",
-	       p);
-	pr_err("If allocated object is overwritten then not detectable\n\n");
-	validate_slab_cache(kmalloc_caches[type][6]);
-
-	pr_err("\nB. Corruption after free\n");
-	p = kzalloc(128, GFP_KERNEL);
-	kfree(p);
-	*p = 0x78;
-	pr_err("1. kmalloc-128: Clobber first word 0x78->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][7]);
-
-	p = kzalloc(256, GFP_KERNEL);
-	kfree(p);
-	p[50] = 0x9a;
-	pr_err("\n2. kmalloc-256: Clobber 50th byte 0x9a->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][8]);
-
-	p = kzalloc(512, GFP_KERNEL);
-	kfree(p);
-	p[512] = 0xab;
-	pr_err("\n3. kmalloc-512: Clobber redzone 0xab->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][9]);
-}
-#else
-#ifdef CONFIG_SYSFS
-static void resiliency_test(void) {};
-#endif
-#endif	/* SLUB_RESILIENCY_TEST */
-
 #ifdef CONFIG_SYSFS
 enum slab_stat_type {
 	SL_ALL,			/* All slabs */
@@ -5831,7 +5768,6 @@ static int __init slab_sysfs_init(void)
 	}
 
 	mutex_unlock(&slab_mutex);
-	resiliency_test();
 	return 0;
 }
 
-- 
2.17.1

