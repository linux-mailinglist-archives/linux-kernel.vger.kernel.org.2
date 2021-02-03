Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A6D30DC86
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhBCOUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:20:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12017 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhBCOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:20:10 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DW3gL4wXYzjJNq;
        Wed,  3 Feb 2021 22:18:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Feb 2021 22:19:17 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <palmer@dabbelt.com>, <atish.patra@wdc.com>,
        <linux-riscv@lists.infradead.org>
CC:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next] RISCV: Add some depends for NUMA
Date:   Wed, 3 Feb 2021 22:23:43 +0800
Message-ID: <20210203142343.59781-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The numa feature is useless for riscv32 platform(MAXPHYSMEM_1GB if 32bit),
and it should depends on SMP feature, this also fix the build error,

  riscv64-buildroot-linux-gnu-ld: mm/page_alloc.o: in function `.L0 ':
  page_alloc.c:(.text+0x4808): undefined reference to `node_reclaim_distance'

Fixes: 4f0e8eef772e ("riscv: Add numa support for riscv64 platform")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 22fa17898d29..ac7f5801bd82 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -312,6 +312,8 @@ endchoice
 # Common NUMA Features
 config NUMA
 	bool "NUMA Memory Allocation and Scheduler Support"
+	depends on SMP
+	depends on 64BIT
 	select GENERIC_ARCH_NUMA
 	select OF_NUMA
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.26.2

