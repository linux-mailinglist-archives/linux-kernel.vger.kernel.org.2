Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17BB32E6F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhCELDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:03:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13066 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCELCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:02:55 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DsPsk6yHdzMjS3;
        Fri,  5 Mar 2021 19:00:42 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Mar 2021
 19:02:44 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH 5/9] riscv: time: Fix no prototype for time_init
Date:   Fri, 5 Mar 2021 19:33:28 +0800
Message-ID: <20210305113332.428048-6-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305113332.428048-1-sunnanyong@huawei.com>
References: <20210305113332.428048-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 compilation warning:
arch/riscv/kernel/time.c:16:13: warning: no previous prototype for ‘time_init’ [-Wmissing-prototypes]
   16 | void __init time_init(void)
      |             ^~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 arch/riscv/include/asm/timex.h | 2 ++
 arch/riscv/kernel/time.c       | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index 81de51e6aa32..507cae273bc6 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -88,4 +88,6 @@ static inline int read_current_timer(unsigned long *timer_val)
 	return 0;
 }
 
+extern void time_init(void);
+
 #endif /* _ASM_RISCV_TIMEX_H */
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 8a5cf99c0776..1b432264f7ef 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <asm/sbi.h>
 #include <asm/processor.h>
+#include <asm/timex.h>
 
 unsigned long riscv_timebase;
 EXPORT_SYMBOL_GPL(riscv_timebase);
-- 
2.25.1

