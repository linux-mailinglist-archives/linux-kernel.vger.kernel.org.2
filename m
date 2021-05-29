Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356C7394BC6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 12:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhE2KsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 06:48:23 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5145 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhE2Krn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 06:47:43 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FsdST03dxzYp3J;
        Sat, 29 May 2021 18:43:21 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 18:46:02 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 18:46:01 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 04/15] arm64: convert to setup_initial_init_mm()
Date:   Sat, 29 May 2021 18:54:53 +0800
Message-ID: <20210529105504.180544-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210529105504.180544-1-wangkefeng.wang@huawei.com>
References: <20210529105504.180544-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use setup_initial_init_mm() helper to simplify code.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index ac8222443ea8..08b0308b7f3b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -293,10 +293,7 @@ u64 cpu_logical_map(unsigned int cpu)
 
 void __init __no_sanitize_address setup_arch(char **cmdline_p)
 {
-	init_mm.start_code = (unsigned long) _stext;
-	init_mm.end_code   = (unsigned long) _etext;
-	init_mm.end_data   = (unsigned long) _edata;
-	init_mm.brk	   = (unsigned long) _end;
+	setup_initial_init_mm(_stext, _etext, _edata, _end);
 
 	*cmdline_p = boot_command_line;
 
-- 
2.26.2

