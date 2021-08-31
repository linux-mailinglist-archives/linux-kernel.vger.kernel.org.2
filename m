Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499313FC314
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 09:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhHaHJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 03:09:29 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:41884 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhHaHJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:09:29 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 31 Aug
 2021 15:08:30 +0800
Received: from tony-HX002EA0.zhaoxin.com (10.32.56.37) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 31 Aug
 2021 15:08:28 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
CC:     <TimGuo-oc@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>,
        <CobeChen@zhaoxin.com>, <FelixZhang@zhaoxin.com>
Subject: [PATCH] x86/tsc: Make cur->adjusted values in package#1 to be the same
Date:   Tue, 31 Aug 2021 15:08:27 +0800
Message-ID: <1630393707-3170-1-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.56.37]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When resume from S4 on Zhaoxin 2 packages platform that support
X86_FEATURE_TSC_ADJUST, the following warning messages appear:

[  327.445302] [Firmware Bug]: TSC ADJUST differs: CPU15 45960750 --> 78394770. Restoring
[  329.209120] [Firmware Bug]: TSC ADJUST differs: CPU14 45960750 --> 78394770. Restoring
[  329.209128] [Firmware Bug]: TSC ADJUST differs: CPU13 45960750 --> 78394770. Restoring
[  329.209138] [Firmware Bug]: TSC ADJUST differs: CPU12 45960750 --> 78394770. Restoring
[  329.209151] [Firmware Bug]: TSC ADJUST differs: CPU11 45960750 --> 78394770. Restoring
[  329.209160] [Firmware Bug]: TSC ADJUST differs: CPU10 45960750 --> 78394770. Restoring
[  329.209169] [Firmware Bug]: TSC ADJUST differs: CPU9 45960750 --> 78394770. Restoring

The reason is:

Step 1: Bring up.
	TSC is sync after bring up with following settings:
				MSR 0x3b	cur->adjusted
	Package#0 CPU 0-7	  0		  0
	Package#1 first CPU	  value1	  value1
	Package#1 non-first CPU	  value1	  value1

Step 2: Suspend to S4.
	Settings in Step 1 are not changed in this Step.

Step 3: Bring up caused by S4 wake up event.
	TSC is sync when bring up with following settings:
				MSR 0x3b	cur->adjusted
	Package#0 CPU 0-7	  0		  0
	Package#1 first CPU	  value2	  value2
	Package#1 non-first CPU	  value2	  value2

Step 4: Resume from S4.
	When resuming from S4, Current TSC synchronous mechanism
	cause following settings:
				MSR 0x3b	cur->adjusted
	Package#0 CPU 0-7	  0		  0
	Package#1 first CPU	  value2	  value2
	Package#1 non-first CPU	  value2	  value1

In these Steps, value1 != 0 and value2 != value1.

In Step4, as function tsc_store_and_check_tsc_adjust() do, when the
value of MSR 0x3b on the non-first online CPU in package#1 is equal
to the value of cur->adjusted on the first online CPU in the same
package, the cur->adjusted value on this non-first online CPU will
hold the old value1. This cause function tsc_verify_tsc_adjust() set
the value of MSR 0x3b on the non-first online CPUs in the package#1
to the old value1 and print the beginning warning messages.

Fix it by setting cur->adjusted value on the non-first online CPU
in a package to the value of MSR 0x3b on the same CPU when they are
not equal.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/tsc_sync.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 50a4515..b5886b4 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -190,7 +190,8 @@ bool tsc_store_and_check_tsc_adjust(bool bootcpu)
 	if (bootval != ref->adjusted) {
 		cur->adjusted = ref->adjusted;
 		wrmsrl(MSR_IA32_TSC_ADJUST, ref->adjusted);
-	}
+	} else if (cur->adjusted != bootval)
+		cur->adjusted = bootval;
 	/*
 	 * We have the TSCs forced to be in sync on this package. Skip sync
 	 * test:
-- 
2.7.4

