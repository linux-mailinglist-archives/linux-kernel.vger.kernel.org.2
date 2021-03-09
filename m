Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC23F3322E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhCIKWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhCIKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:21:52 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7979EC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 02:21:52 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a188so9185883pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 02:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AOI9/EqQrWdE1XESO6SiB4zNNccVCN+InRdKPMsv6ZA=;
        b=Exoq3HoofPOZMBhQj8V5+8/q7J169b3L54UWET7r2uZfiB2oi6IxyUZ9lKLtmdkdmZ
         pjupiiPfDu9vrGkLmjdQ8gm+3t5zVWwyVDfF3ynDVa0f86BOLGPkcpRAqFBhm5lFO7HF
         fRGoLB7QT84dZsESh2xKZUnpgu/IpT4y3vGqhN9ZtyuqMPMDw1a2mSfvtjR6aM4baOSU
         7Y2u21OvPPKqhs1cYOcBci8b8E6FqwdUQdYanEW4Fq+HOhKjwlAB6KxBqZDvWgCdtNt2
         H9PXoiSgN0pMjvdiXeJBR9CSjsqlErnpYDiO7MvritIZMQ3ul2fRnbQwTGEfOlvTH96X
         QbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AOI9/EqQrWdE1XESO6SiB4zNNccVCN+InRdKPMsv6ZA=;
        b=EJfDlyvWDlu2k5fpRbkSacg/PWwFAYUT9DaA80n445ym39J6sUQrL9+dtdrvIcOl76
         e8l/yS8WLfjUe/xR4AN/hcyGy3FyJ3fPZWydnyJuXwgqHNSEeh6m2bcDHPbDnDZAMN5Y
         cW5PP10Vz/TOvVmVs/lChBnaaD5tUte5IQJCjot4sX1to48Px325En41oNVvA9B5jckL
         nIRrAk4IvVR6utmd9NtECVklfOUI9h4Z6VvzTe0G/y6i0ZlY9ka1ewe7BuNWGtTFlmCI
         pPjFv5q8Hd0ENcQxOs+BuwAyPpVlfcWRarIzq1yKKYKFhB5DOl7LsvKcL8W++BRxc4Rx
         TFYQ==
X-Gm-Message-State: AOAM531PCJNF1TohHfYOwvufmQmGnzL2eifn25Irnj44WEolKeABVSL7
        +0ZYt1gOQT1FRDkNIpELCg==
X-Google-Smtp-Source: ABdhPJydmJHzGO3Hgi0h1shnHNFFD6gaTmEsOuDe4xO9d2hmTn30SxQP3m4yWf//aBgiaVLXuerzvg==
X-Received: by 2002:a65:4c86:: with SMTP id m6mr16579465pgt.174.1615285312103;
        Tue, 09 Mar 2021 02:21:52 -0800 (PST)
Received: from x1pad.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m7sm2513396pjc.54.2021.03.09.02.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 02:21:51 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/arch_numa: remove rebudant setup_per_cpu_areas()
Date:   Tue,  9 Mar 2021 18:21:38 +0800
Message-Id: <20210309102138.41170-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two identical implementations of setup_per_cpu_areas() in
mm/percpu.c and drivers/base/arch_numa.c.

Hence removing the one in arch_numa.c. And let arm64 drop
HAVE_SETUP_PER_CPU_AREA.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig       |  4 ----
 drivers/base/arch_numa.c | 22 ----------------------
 2 files changed, 26 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f212b47a48a..d4bf8be0c3d5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1022,10 +1022,6 @@ config USE_PERCPU_NUMA_NODE_ID
 	def_bool y
 	depends on NUMA
 
-config HAVE_SETUP_PER_CPU_AREA
-	def_bool y
-	depends on NUMA
-
 config NEED_PER_CPU_EMBED_FIRST_CHUNK
 	def_bool y
 	depends on NUMA
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 4cc4e117727d..23e1e419a83d 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -167,28 +167,6 @@ static void __init pcpu_fc_free(void *ptr, size_t size)
 {
 	memblock_free_early(__pa(ptr), size);
 }
-
-void __init setup_per_cpu_areas(void)
-{
-	unsigned long delta;
-	unsigned int cpu;
-	int rc;
-
-	/*
-	 * Always reserve area for module percpu variables.  That's
-	 * what the legacy allocator did.
-	 */
-	rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
-				    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE,
-				    pcpu_cpu_distance,
-				    pcpu_fc_alloc, pcpu_fc_free);
-	if (rc < 0)
-		panic("Failed to initialize percpu areas.");
-
-	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
-	for_each_possible_cpu(cpu)
-		__per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
-}
 #endif
 
 /**
-- 
2.29.2

