Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30F9346F58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhCXCR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:17:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14438 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbhCXCRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:17:15 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F4sK51D6czkf2y;
        Wed, 24 Mar 2021 10:15:37 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 10:17:03 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <akpm@linux-foundation.org>, <peterz@infradead.org>,
        <paulmck@kernel.org>, <ast@kernel.org>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <hch@lst.de>, <m.szyprowski@samsung.com>,
        <song.bao.hua@hisilicon.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        "Tian Tao" <tiantao6@hisilicon.com>
Subject: [PATCH] dma-mapping: make map_benchmark compile into module
Date:   Wed, 24 Mar 2021 10:17:38 +0800
Message-ID: <1616552258-22282-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

under some scenarios, it is necessary to compile map_benchmark
into module to test iommu, so this patch changed Kconfig and
export_symbol to implement map_benchmark compiled into module.

On the other hand, map_benchmark is a driver, which is supposed
to be able to run as a module.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 kernel/dma/Kconfig | 2 +-
 kernel/kthread.c   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 77b4055..0468293 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -223,7 +223,7 @@ config DMA_API_DEBUG_SG
 	  If unsure, say N.
 
 config DMA_MAP_BENCHMARK
-	bool "Enable benchmarking of streaming DMA mapping"
+	tristate "Enable benchmarking of streaming DMA mapping"
 	depends on DEBUG_FS
 	help
 	  Provides /sys/kernel/debug/dma_map_benchmark that helps with testing
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1578973..fa4736f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -455,6 +455,7 @@ void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
 {
 	__kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
 }
+EXPORT_SYMBOL(kthread_bind_mask);
 
 /**
  * kthread_bind - bind a just-created kthread to a cpu.
-- 
2.7.4

