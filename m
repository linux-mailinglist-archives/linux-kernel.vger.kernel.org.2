Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05558337694
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhCKPL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:11:29 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:32886 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233978AbhCKPLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:11:25 -0500
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12BF3LwI011868;
        Thu, 11 Mar 2021 15:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=KgON0JNjPPn3agmdfKnN9oeNhsJWy56GgPCfWOLOKC0=;
 b=Z9lP1LFRS8/LA/bKCcS3pd9zGFa2gSRWwWgFmkIDK8C9x9Y1uY8bEPg3efU7W0wJJKxY
 +R75srS9eatU0wLo2eiKNb8+6WYaW0+3PPpNnbimAA4cJrb5YS+QMPT7VvpAemMO0zbw
 K55jjZQnaCAVvuDK+TkXwmFt0hD9c40gIuT6gAaVXfJzsVgYvbWH6ThLyRETMXFhWpAL
 w5xO5K3MButeSR/Bi7rd3TvR9WX1557i+PpPsbqyQqZFOf05W7ywHGStH8Ias4P7bxgW
 3GL23KaVsdzLT4eRggl93Fo2SuGOVNtf0uklzbS9vz78P2n34Jc/s5Yy4que/L8kzR12 fw== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 377ev23ee1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 15:10:43 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 4AB6653;
        Thu, 11 Mar 2021 15:10:42 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 20DC748;
        Thu, 11 Mar 2021 15:10:39 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav_Petkov_ <bp@alien8.de>,
        Thomas_Gleixner_ <tglx@linutronix.de>,
        Ingo_Molnar_ <mingo@redhat.com>,
        Steve_Wahl_ <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Georges Aureau <georges.aureau@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri_Sivanich_ <dimitri.sivanich@hpe.com>,
        Russ_Anderson_ <russ.anderson@hpe.com>,
        Darren_Hart_ <dvhart@infradead.org>,
        Andy_Shevchenko_ <andy@infradead.org>,
        "H._Peter_Anvin_" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/platform/uv: Add more to secondary cpu kdump info
Date:   Thu, 11 Mar 2021 09:10:28 -0600
Message-Id: <20210311151028.82678-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_05:2021-03-10,2021-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103110082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georges Aureau <georges.aureau@hpe.com>

Add call to run_crash_ipi_callback() to gather more info of what the
secondary cpus were doing to help with failure analysis.

Excerpt from Georges:
'It is only changing where crash secondaries will be stalling after having
taken care of properly laying down "crash note regs". Please note that
"crash note regs" are a key piece of data used by crash dump debuggers
to provide a reliable backtrace of running processors.'

Secondary change pursuant to a5f526ec:
	change master/slave to main/secondary

Signed-off-by: Georges Aureau <georges.aureau@hpe.com>
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/platform/uv/uv_nmi.c | 39 +++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index eafc530c8767..f83810f7bcc2 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -24,6 +24,7 @@
 #include <asm/kdebug.h>
 #include <asm/local64.h>
 #include <asm/nmi.h>
+#include <asm/reboot.h>
 #include <asm/traps.h>
 #include <asm/uv/uv.h>
 #include <asm/uv/uv_hub.h>
@@ -834,34 +835,42 @@ static void uv_nmi_touch_watchdogs(void)
 	touch_nmi_watchdog();
 }
 
-static atomic_t uv_nmi_kexec_failed;
-
 #if defined(CONFIG_KEXEC_CORE)
-static void uv_nmi_kdump(int cpu, int master, struct pt_regs *regs)
+static atomic_t uv_nmi_kexec_failed;
+static void uv_nmi_kdump(int cpu, int main, struct pt_regs *regs)
 {
+	/* Check if kdump kernel loaded for both main and secondary CPUs */
+	if (!kexec_crash_image) {
+		if (main)
+			pr_err("UV: NMI error: kdump kernel not loaded\n");
+		return;
+	}
+
 	/* Call crash to dump system state */
-	if (master) {
+	if (main) {
 		pr_emerg("UV: NMI executing crash_kexec on CPU%d\n", cpu);
 		crash_kexec(regs);
 
-		pr_emerg("UV: crash_kexec unexpectedly returned, ");
+		pr_emerg("UV: crash_kexec unexpectedly returned\n");
 		atomic_set(&uv_nmi_kexec_failed, 1);
-		if (!kexec_crash_image) {
-			pr_cont("crash kernel not loaded\n");
-			return;
+
+	} else { /* secondary */
+
+		/* If kdump kernel fails, secondaries will exit this loop */
+		while (atomic_read(&uv_nmi_kexec_failed) == 0) {
+
+			/* Once shootdown cpus starts, they do not return */
+			run_crash_ipi_callback(regs);
+
+			mdelay(10);
 		}
-		pr_cont("kexec busy, stalling cpus while waiting\n");
 	}
-
-	/* If crash exec fails the slaves should return, otherwise stall */
-	while (atomic_read(&uv_nmi_kexec_failed) == 0)
-		mdelay(10);
 }
 
 #else /* !CONFIG_KEXEC_CORE */
-static inline void uv_nmi_kdump(int cpu, int master, struct pt_regs *regs)
+static inline void uv_nmi_kdump(int cpu, int main, struct pt_regs *regs)
 {
-	if (master)
+	if (main)
 		pr_err("UV: NMI kdump: KEXEC not supported in this kernel\n");
 	atomic_set(&uv_nmi_kexec_failed, 1);
 }
-- 
2.21.0

