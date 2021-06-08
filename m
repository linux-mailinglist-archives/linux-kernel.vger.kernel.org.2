Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEB839F0DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhFHI2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:28:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4521 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFHI16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:27:58 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FzjtC08zWzZf22;
        Tue,  8 Jun 2021 16:23:15 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:25:58 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:25:56 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Ley Foon Tan" <ley.foon.tan@intel.com>
Subject: [PATCH v3 resend 09/15] nios2: convert to setup_initial_init_mm()
Date:   Tue, 8 Jun 2021 16:34:12 +0800
Message-ID: <20210608083418.137226-10-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210608083418.137226-1-wangkefeng.wang@huawei.com>
References: <20210608083418.137226-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use setup_initial_init_mm() helper to simplify code.

Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/nios2/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index d2f21957e99c..cf8d687a2644 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -156,10 +156,7 @@ void __init setup_arch(char **cmdline_p)
 	memory_start = memblock_start_of_DRAM();
 	memory_end = memblock_end_of_DRAM();
 
-	init_mm.start_code = (unsigned long) _stext;
-	init_mm.end_code = (unsigned long) _etext;
-	init_mm.end_data = (unsigned long) _edata;
-	init_mm.brk = (unsigned long) _end;
+	setup_initial_init_mm(_stext, _etext, _edata, _end);
 	init_task.thread.kregs = &fake_regs;
 
 	/* Keep a copy of command line */
-- 
2.26.2

