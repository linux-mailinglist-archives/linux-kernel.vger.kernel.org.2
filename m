Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7033332E6F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhCELD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:03:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13065 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCELC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:02:56 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DsPsk6gLXzMjRb;
        Fri,  5 Mar 2021 19:00:42 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Mar 2021
 19:02:42 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH 3/9] riscv: sbi: Fix comment of __sbi_set_timer_v01
Date:   Fri, 5 Mar 2021 19:33:26 +0800
Message-ID: <20210305113332.428048-4-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305113332.428048-1-sunnanyong@huawei.com>
References: <20210305113332.428048-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the comment of __sbi_set_timer_v01, the function name in comment
is missing '__'

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 arch/riscv/kernel/sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index f4a7db3d309e..d3bf756321a5 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -116,7 +116,7 @@ void sbi_clear_ipi(void)
 EXPORT_SYMBOL(sbi_clear_ipi);
 
 /**
- * sbi_set_timer_v01() - Program the timer for next timer event.
+ * __sbi_set_timer_v01() - Program the timer for next timer event.
  * @stime_value: The value after which next timer event should fire.
  *
  * Return: None
-- 
2.25.1

