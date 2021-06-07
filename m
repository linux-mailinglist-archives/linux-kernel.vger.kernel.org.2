Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E98139D32A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 04:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFGC4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 22:56:11 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:24429 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGC4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 22:56:09 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 7 Jun
 2021 10:54:16 +0800
Received: from zx.zhaoxin.com (10.28.64.91) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 7 Jun
 2021 10:54:15 +0800
From:   Cody Yao-oc <CodyYao-oc@zhaoxin.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <hpa@zytor.com>, <x86@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shyaololo@163.com>, CodyYao-oc <CodyYao-oc@zhaoxin.com>
Subject: [PATCH] x86/perf: Fixed obtaining address error about performance monitor MSR on old Inel CPU.
Date:   Mon, 7 Jun 2021 10:53:35 +0800
Message-ID: <20210607025335.9643-1-CodyYao-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.64.91]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx2.zhaoxin.com (10.29.252.164)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: CodyYao-oc <CodyYao-oc@zhaoxin.com>

Fix "obtain wrong msr address" bug in function nmi_perfctr_msr_to_bit
and nmi_eventsel_msr_to_bit. In X86_VENDOR_INTEL switch branch, if all
of the check conditions are not met, code flow will slip to
X86_VENDOR_ZHAOXIN branch which may lead to incorrect information.

Using fallthrough instead of break was completely unintentional,
therefore, "fallthrough" should be changed to "break".

Fixes: 3a4ac121c2ca ("x86/perf: Add hardware performance events support for Zhaoxin CPU.")

Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/perfctr-watchdog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/perfctr-watchdog.c b/arch/x86/kernel/cpu/perfctr-watchdog.c
index 3ef5868ac588..7aecb2fc3186 100644
--- a/arch/x86/kernel/cpu/perfctr-watchdog.c
+++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
@@ -63,7 +63,7 @@ static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
 		case 15:
 			return msr - MSR_P4_BPU_PERFCTR0;
 		}
-		fallthrough;
+		break;
 	case X86_VENDOR_ZHAOXIN:
 	case X86_VENDOR_CENTAUR:
 		return msr - MSR_ARCH_PERFMON_PERFCTR0;
@@ -96,7 +96,7 @@ static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
 		case 15:
 			return msr - MSR_P4_BSU_ESCR0;
 		}
-		fallthrough;
+		break;
 	case X86_VENDOR_ZHAOXIN:
 	case X86_VENDOR_CENTAUR:
 		return msr - MSR_ARCH_PERFMON_EVENTSEL0;
-- 
2.17.1

