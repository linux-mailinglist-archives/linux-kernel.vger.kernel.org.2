Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C51408AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbhIMMMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:12:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19035 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239865AbhIMMMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:12:36 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H7QFt4YzZzbmTc;
        Mon, 13 Sep 2021 20:07:14 +0800 (CST)
Received: from dggema756-chm.china.huawei.com (10.1.198.198) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 20:11:19 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggema756-chm.china.huawei.com (10.1.198.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 13 Sep 2021 20:11:18 +0800
From:   Chen Huang <chenhuang5@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Chen Huang <chenhuang5@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] riscv: support HAVE_EFFICIENT_UNALIGNED_ACCESS
Date:   Mon, 13 Sep 2021 12:19:55 +0000
Message-ID: <20210913121956.1776656-2-chenhuang5@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20210913121956.1776656-1-chenhuang5@huawei.com>
References: <20210913121956.1776656-1-chenhuang5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema756-chm.china.huawei.com (10.1.198.198)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISCV ISA can perform efficient unaligned memory accesses
in hardware. This patch selects HAVE_EFFICIENT_UNALIGNED_ACCESS
for that.

Signed-off-by: Chen Huang <chenhuang5@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index aac669a6c3d8..6e70bf50b02a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -81,6 +81,7 @@ config RISCV
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_EBPF_JIT if MMU
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GCC_PLUGINS
-- 
2.18.0.huawei.25

