Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97D7368E29
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbhDWHyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:54:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17030 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbhDWHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:54:02 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FRRKP1P3zzPtWR;
        Fri, 23 Apr 2021 15:50:17 +0800 (CST)
Received: from vm-Yoda-Ubuntu1804.huawei.com (10.67.174.59) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Fri, 23 Apr 2021 15:53:09 +0800
From:   Xu Yihang <xuyihang@huawei.com>
To:     <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>, <dwmw@amazon.co.uk>,
        <linux-kernel@vger.kernel.org>
CC:     <xuyihang@huawei.com>
Subject: [PATCH -next] x86/apic: Force logial APIC ID in range from 0 to 8
Date:   Fri, 23 Apr 2021 15:53:24 +0800
Message-ID: <20210423075324.133463-1-xuyihang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.59]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Intel 64 and IA-32 Architectures Software Developer’s Manuals
Vol. 3A 10.6.2.2, Logical APIC ID locates on bit 24 to 31, can only
support up to 8 local APIC under flat mode. Also C99 says left shift exceeding
maximum value representable in the result type is undefined behavior. But
under x86 architecture, it seems doesn't do any actual damage.

There is KASAN warning on a 80 cores machine after booting #64 CPU.
```
[    1.681097] UBSAN: Undefined behaviour in arch/x86/kernel/apic/apic_flat_64.c:51:11
[    1.688739] shift exponent 64 is too large for 64-bit type 'long unsigned int'
```

Signed-off-by: Xu Yihang <xuyihang@huawei.com>
---
 arch/x86/include/asm/apicdef.h      | 1 +
 arch/x86/kernel/apic/apic_flat_64.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index 5716f22f81ac..150a5e831368 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -42,6 +42,7 @@
 #define	APIC_RRR	0xC0
 #define	APIC_LDR	0xD0
 #define		APIC_LDR_MASK		(0xFFu << 24)
+#define		APIC_LOGICAL_ID_MAX	8
 #define		GET_APIC_LOGICAL_ID(x)	(((x) >> 24) & 0xFFu)
 #define		SET_APIC_LOGICAL_ID(x)	(((x) << 24))
 #define		APIC_ALL_CPUS		0xFFu
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 8f72b4351c9f..7bf91cadee21 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -41,7 +41,7 @@ void flat_init_apic_ldr(void)
 	unsigned long num, id;
 
 	num = smp_processor_id();
-	id = 1UL << num;
+	id = 1UL << (num % APIC_LOGICAL_ID_MAX);
 	apic_write(APIC_DFR, APIC_DFR_FLAT);
 	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
 	val |= SET_APIC_LOGICAL_ID(id);
-- 
2.17.1

