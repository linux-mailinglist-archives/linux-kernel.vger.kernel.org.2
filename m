Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9913455D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhCWC7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:59:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13661 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhCWC7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:59:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4GH11vSYznVX2;
        Tue, 23 Mar 2021 10:56:45 +0800 (CST)
Received: from vm-Yoda-Ubuntu1804.huawei.com (10.67.174.59) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 10:59:07 +0800
From:   Xu Yihang <xuyihang@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <tony.luck@intel.com>,
        <fenghua.yu@intel.com>, <rppt@kernel.org>, <xiaoyao.li@intel.com>,
        <seanjc@google.com>, <linux-kernel@vger.kernel.org>
CC:     <xuyihang@huawei.com>, <johnny.chenyi@huawei.com>
Subject: [PATCH -next] =?UTF-8?q?x86:=20Fix=20intel=20cpu=20unsed=20variab?= =?UTF-8?q?le=20=E2=80=98l2=E2=80=99=20warning?=
Date:   Tue, 23 Mar 2021 10:59:01 +0800
Message-ID: <20210323025901.205381-1-xuyihang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.59]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):
../arch/x86/kernel/cpu/intel.c: In function ‘init_intel’:
../arch/x86/kernel/cpu/intel.c:644:20: warning: variable ‘l2’ set but not used [-Wunused-but-set-variable]
   unsigned int l1, l2;
                    ^~

Compilation command(s):
make allmodconfig ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-
make W=1 arch/x86/kernel/cpu/intel.o ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-

According to Intel Software Developer's Manual Table 2-2 through Table 2-24 about MSRs:
X86_FEATURE_BTS which represents Branch Trace Storage Unavailable and X86_FEATURE_PEBS
represens Processor Event Based Sampling (PEBS) Unavailable, but on some platform these fields
maybe reserved or not available. For the function init_intel it self, only bit 11 and bit 12
are used for checking BTS and PEBS, and higher 32 bits are not used. So cast to void to
avoid warning.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xu Yihang <xuyihang@huawei.com>
---
 arch/x86/kernel/cpu/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 63e381a46153..547ba6668eb3 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -644,6 +644,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 		unsigned int l1, l2;
 
 		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
+		(void) l2;
 		if (!(l1 & (1<<11)))
 			set_cpu_cap(c, X86_FEATURE_BTS);
 		if (!(l1 & (1<<12)))
-- 
2.17.1

