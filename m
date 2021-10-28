Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B0B43E0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhJ1MaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:30:08 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14873 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1MaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:30:07 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hg4ZW61Mrz8yCQ;
        Thu, 28 Oct 2021 20:27:31 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (7.185.36.10) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 20:27:35 +0800
Received: from [10.174.176.231] (10.174.176.231) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 20:27:35 +0800
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wuxu.wu@huawei.com>, Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] arm64: mm: Use asid2idx() and asid feature macro for cleanup
Message-ID: <4aaabf1b-00c3-3365-e371-9d97dc0c06ab@huawei.com>
Date:   Thu, 28 Oct 2021 20:27:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.231]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use asid2idx() and asid feature macro for cleanup.

No functional change.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 arch/arm64/mm/context.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index cd72576ae2b7..076f14a75bd5 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -50,10 +50,10 @@ static u32 get_cpu_asid_bits(void)
 		pr_warn("CPU%d: Unknown ASID size (%d); assuming 8-bit\n",
 					smp_processor_id(),  fld);
 		fallthrough;
-	case 0:
+	case ID_AA64MMFR0_ASID_8:
 		asid = 8;
 		break;
-	case 2:
+	case ID_AA64MMFR0_ASID_16:
 		asid = 16;
 	}

@@ -162,7 +162,7 @@ static u64 new_context(struct mm_struct *mm)
 	u64 generation = atomic64_read(&asid_generation);

 	if (asid != 0) {
-		u64 newasid = generation | (asid & ~ASID_MASK);
+		u64 newasid = generation | asid2idx(asid);

 		/*
 		 * If our current ASID was active during a rollover, we
@@ -306,7 +306,7 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
 out_unlock:
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);

-	asid &= ~ASID_MASK;
+	asid = asid2idx(asid);

 	/* Set the equivalent of USER_ASID_BIT */
 	if (asid && arm64_kernel_unmapped_at_el0())
-- 
2.27.0
