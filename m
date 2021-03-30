Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5906034E66F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhC3Lk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:40:57 -0400
Received: from mail-vi1eur05on2102.outbound.protection.outlook.com ([40.107.21.102]:20544
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231743AbhC3Lku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:40:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRkOq/MFKG9IuKfclDYk7yQ2VvEonGx1+Q4KaWB9R+QrgX70QS5daSbRhlZOOK9Zf3m6A/Zdo7Tos0QkXfqnoZAobDBdApaVb3jYh7JwdEWRfYmwe5xQ91txw/yquQnQm5M8ZSmkJngRi9gTXpftrDldzJ5dknyYg3bfetrlsgtp0hT2P27UIX87aMfe2zmTm4fQqoXhOx53gY0rRuqM3jpL7fBIWNmb3Vnupo5YgXwfjsFT0EjIZkYtW4LexWV2FwWAkTenCP93hONrzG2jD+OHdS+qjglp8aFd3p7udhY4Brl7kSIJHDZZSvy21h+OaRMv96IWSON4yDUpuJUi4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvL7nqulDcbsFi5vYpVIbAdLKt7a49AhrZ8jhGB2bHY=;
 b=imiqgazWRKMHiJiCv4zb/UqDWOvLRpUs/zt/EGzVNS5d/lWs8LuOMM5O+zRbF/q9ZRZaFVPpSGCjJ8SxL6y/oJfo9jvO9yAke2BUz6qIco6niAU8OkFgIdZ0Ake+uRDmlKhFVEJL1n0xUmgGtTTAf9h1rtHFf8nBcGxJ28Er4gmsNSrtl1FnSN4x2dmIJ34jXBMj+WeA3zfVPmP4+5A1k26biGPA78irAGPV8FEnRE6T1zJLfEgRrZjkkgr/wDX6VyudMtcbafUlUrisnyj3DFREagNyI0qYpRygRdQfVCf3oAPI8fS/Ra34RxC+Tyt6JXvPoROMxqL6GapFDsYIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=arm.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvL7nqulDcbsFi5vYpVIbAdLKt7a49AhrZ8jhGB2bHY=;
 b=XnUpasunZ+vkBhKUJRruQjWj3tNjNy7fC7C0gasIG4u2p36HbDXaCl/XLJX/bBV/R6u443LOl/s7nXG+ZzWHN19I/Y6mVWnHDWakptW8Gzbp2IKhoD9ECgxxR+a/cBPU6rvu4iXahRpsC1zS5JzBYJbyWt3OvFbFoUZytPwWq48=
Received: from AM5P194CA0014.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::24)
 by AS8PR07MB7943.eurprd07.prod.outlook.com (2603:10a6:20b:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.17; Tue, 30 Mar
 2021 11:40:48 +0000
Received: from VE1EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:8f:cafe::bc) by AM5P194CA0014.outlook.office365.com
 (2603:10a6:203:8f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Tue, 30 Mar 2021 11:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 VE1EUR03FT034.mail.protection.outlook.com (10.152.18.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Tue, 30 Mar 2021 11:40:48 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 12UBeeun023631;
        Tue, 30 Mar 2021 11:40:43 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v8 2/3] ARM: Add warn suppress parameter to arm_gen_branch_link()
Date:   Tue, 30 Mar 2021 13:40:34 +0200
Message-Id: <20210330114035.18575-3-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20210330114035.18575-1-alexander.sverdlin@nokia.com>
References: <20210330114035.18575-1-alexander.sverdlin@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3a26acbb-1b89-4952-e930-08d8f370a9e9
X-MS-TrafficTypeDiagnostic: AS8PR07MB7943:
X-Microsoft-Antispam-PRVS: <AS8PR07MB7943967F2184CDA3FF32BC45887D9@AS8PR07MB7943.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HE38puOVdMFrrGG8Gjd4Pnnw6CxB+jfaAfX4fIwA++LX3bk4rnRMKj3+o+bVpzoGvgZMZkr+Amo4vCOnEnsOqEUHOdFp9EayfSZYbNjWlGiawc2ZJwetysvC5ky6y7SwoKQYSZt/w8Gz/xZWAkiqFilAOfppi5qSjuBdbNM+KoYY0zr9lv0CgLDlNZEWDdSED85jSxcK9eY0vFvwTcsffWJlQhzWn4FpEenRJZ5I2AH77ckXeKEg8iEQ7U/zyQiq8J5dKnQxyMkGmoLTOQi8o3vPIXSwxHiivTMdCr8/lnxxq0H9Z1LQLJ3qjWA1KNV8nq4ZC21zpvB6b8IXZysRX/BGfOcuu3wfPm0Z/htXEgu4VmqfK/IiddhrNM/i9LlAeb8rqMOLg2uTQYK+2HTBMnbuZIDemlUBz9H+tx+or8BwkoVnu/MeoabgRgpBdnHCjE79YrS3CLyw+1zhSv+Q7owCDgo4HUwO/gQcWtV7Xb4x+9PWrKyey2w+0GIfKo0VK8hvfn8TdTrSRgA/3SQcFTxi/9M52to/zptOwyHFg9VgFqynpRAQu0UmSd5GaE7Dnr9WrXEKz7X5K4C2W3TsisYnEgzZt5v/hufrsK4yz2FOXtllb/xuXUZ1EsMsYus0Lhbxink3IFI2v93MwEGhKkGmTjn74woJVfipps7dQgYB5uzl8DooiaPK5e/C0xq
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(36840700001)(83380400001)(81166007)(356005)(70586007)(2616005)(86362001)(70206006)(47076005)(6916009)(36756003)(1076003)(54906003)(8936002)(8676002)(316002)(336012)(478600001)(186003)(6666004)(4326008)(36860700001)(82310400003)(26005)(2906002)(5660300002)(82740400003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 11:40:48.4441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a26acbb-1b89-4952-e930-08d8f370a9e9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7943
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Will be used in the following patch. No functional change.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/include/asm/insn.h |  8 ++++----
 arch/arm/kernel/ftrace.c    |  2 +-
 arch/arm/kernel/insn.c      | 19 ++++++++++---------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/insn.h b/arch/arm/include/asm/insn.h
index f20e08a..5475cbf 100644
--- a/arch/arm/include/asm/insn.h
+++ b/arch/arm/include/asm/insn.h
@@ -13,18 +13,18 @@ arm_gen_nop(void)
 }
 
 unsigned long
-__arm_gen_branch(unsigned long pc, unsigned long addr, bool link);
+__arm_gen_branch(unsigned long pc, unsigned long addr, bool link, bool warn);
 
 static inline unsigned long
 arm_gen_branch(unsigned long pc, unsigned long addr)
 {
-	return __arm_gen_branch(pc, addr, false);
+	return __arm_gen_branch(pc, addr, false, true);
 }
 
 static inline unsigned long
-arm_gen_branch_link(unsigned long pc, unsigned long addr)
+arm_gen_branch_link(unsigned long pc, unsigned long addr, bool warn)
 {
-	return __arm_gen_branch(pc, addr, true);
+	return __arm_gen_branch(pc, addr, true, warn);
 }
 
 #endif
diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 9a79ef6..61de817 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -70,7 +70,7 @@ int ftrace_arch_code_modify_post_process(void)
 
 static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
 {
-	return arm_gen_branch_link(pc, addr);
+	return arm_gen_branch_link(pc, addr, true);
 }
 
 static int ftrace_modify_code(unsigned long pc, unsigned long old,
diff --git a/arch/arm/kernel/insn.c b/arch/arm/kernel/insn.c
index 2e844b7..db0acbb 100644
--- a/arch/arm/kernel/insn.c
+++ b/arch/arm/kernel/insn.c
@@ -3,8 +3,9 @@
 #include <linux/kernel.h>
 #include <asm/opcodes.h>
 
-static unsigned long
-__arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link)
+static unsigned long __arm_gen_branch_thumb2(unsigned long pc,
+					     unsigned long addr, bool link,
+					     bool warn)
 {
 	unsigned long s, j1, j2, i1, i2, imm10, imm11;
 	unsigned long first, second;
@@ -12,7 +13,7 @@ __arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link)
 
 	offset = (long)addr - (long)(pc + 4);
 	if (offset < -16777216 || offset > 16777214) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(warn);
 		return 0;
 	}
 
@@ -33,8 +34,8 @@ __arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link)
 	return __opcode_thumb32_compose(first, second);
 }
 
-static unsigned long
-__arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link)
+static unsigned long __arm_gen_branch_arm(unsigned long pc, unsigned long addr,
+					  bool link, bool warn)
 {
 	unsigned long opcode = 0xea000000;
 	long offset;
@@ -44,7 +45,7 @@ __arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link)
 
 	offset = (long)addr - (long)(pc + 8);
 	if (unlikely(offset < -33554432 || offset > 33554428)) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(warn);
 		return 0;
 	}
 
@@ -54,10 +55,10 @@ __arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link)
 }
 
 unsigned long
-__arm_gen_branch(unsigned long pc, unsigned long addr, bool link)
+__arm_gen_branch(unsigned long pc, unsigned long addr, bool link, bool warn)
 {
 	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
-		return __arm_gen_branch_thumb2(pc, addr, link);
+		return __arm_gen_branch_thumb2(pc, addr, link, warn);
 	else
-		return __arm_gen_branch_arm(pc, addr, link);
+		return __arm_gen_branch_arm(pc, addr, link, warn);
 }
-- 
2.10.2

