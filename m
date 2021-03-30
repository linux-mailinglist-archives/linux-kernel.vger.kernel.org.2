Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59CE34E66D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhC3Lkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:40:53 -0400
Received: from mail-vi1eur05on2131.outbound.protection.outlook.com ([40.107.21.131]:6241
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231719AbhC3Lks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:40:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOO/+Y6A2x0L0H9YEedGYE9c/4/OzN9xNsv8pOGVTwnE/2hgbu1rQTgW1ezVxCxf2SYEZ76jEeH6QAzpjyqfQ6KeByLPgrTn60il92vTA+PiIzulUhtnvRNTdxw8durmdHAs5r0g1xiLFjtb9iO0QztOeQEYt8oR1j9qONgkplT7LBVyEMJnSUciYipSb0oJgOFcTWAaRpM/J4SL21WR7OYfPbZzGzvuVw04VqJ5to8LNL3ugU/LKtbFF+ywE4xaKh8Dv9QC/omR24EgssEJBkTskH5hzUGsaezHVjyHopP0sRbDBescCM/nSpzrrcgD6bCrEfqmTo0A7+yScGrQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlJmTMqpfOCiSImjexyakopdCkg7me37avy/EP7HCBI=;
 b=A+ZnPLJ8uLsdk2NDCJhXULmuQXGz1NQiBn6ikNpgmfzrcchP+lRwd5TpowsbNrj4Wf5DPF4EIazRFyHznhKEY5+XQz9iZZArMx1ljhYAx9bTYnX1ZwCUQVMAPtKHDdZYZ38Ldu0RfBk0JCOp0nwmZjYhoLPxd3raOc0giDVe6waEKHuOPjYZ9h1R0FEvoKSTyJGdEggzDvsQcLS5oQByUsZyNS28Yw3p44b8iYDQxKjgEJb4vazgaxHUPU7r6stRZK144U90VofPhQoxDgDAoYF72NXXAwk+/UenxJXXaifFn0Ip+hG2SgYYVc2iAyka0IYV8E7p/veelkp54DRB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=arm.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlJmTMqpfOCiSImjexyakopdCkg7me37avy/EP7HCBI=;
 b=rHXpn780DlGjgyQbDKVxS22mDOR4jr/ST/NA72aqbxo8B88wiBVU0NLPZeP6rW4eERzA8fJtbCQBnj7mngnpt8p70kDmuIMGHrnPvtZIDzGk507VJAnFHc9ZBnZgAxYaZVZJr6ksOPKz9b4sfbxXh/LEFmGLz4qKJQ7wLRFXCQw=
Received: from AM0PR03CA0015.eurprd03.prod.outlook.com (2603:10a6:208:14::28)
 by AM5PR0701MB2675.eurprd07.prod.outlook.com (2603:10a6:203:73::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.18; Tue, 30 Mar
 2021 11:40:46 +0000
Received: from AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:14:cafe::6) by AM0PR03CA0015.outlook.office365.com
 (2603:10a6:208:14::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Tue, 30 Mar 2021 11:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 AM5EUR03FT056.mail.protection.outlook.com (10.152.17.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.29 via Frontend Transport; Tue, 30 Mar 2021 11:40:45 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 12UBeeum023631;
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
Subject: [PATCH v8 1/3] ARM: PLT: Move struct plt_entries definition to header
Date:   Tue, 30 Mar 2021 13:40:33 +0200
Message-Id: <20210330114035.18575-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20210330114035.18575-1-alexander.sverdlin@nokia.com>
References: <20210330114035.18575-1-alexander.sverdlin@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1f36f600-e9f7-4ab4-6112-08d8f370a835
X-MS-TrafficTypeDiagnostic: AM5PR0701MB2675:
X-Microsoft-Antispam-PRVS: <AM5PR0701MB26755992CBF42BCC15AF2F75887D9@AM5PR0701MB2675.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nJKGS0AM73iRpf4oTWrmcXhVlSAMr1z94OZmnXOjdRpgNqjv5531wARFIytozvH0Kji/WtnHCRENmdqfGIx17J2KLqsQ3LqsmsHj9mgnm7/BIoqE3eL0vzMoQJfD5nSsbIVL3fOo6W2ExjNovP4zbaKMXiKbN/aa/strhitMLroR3CcKuy8Jq4VBXMYXFTTEOUXQ2c79KRRVBhhvi8KmKaB4eNQm2yMPiaB+UreGQYSLD6QS+98Vw9MCrpkQgWBKa5h5oDdY1/gA2rkcGb2R5hPIx82gb1PElQNV7NJ4VwP/SyxBHMbs5Pi8N1jDGAun5SKJe2JaQiBtziMi0DM9GXKGVz1/VwdvsYZ9u13jI437P+auuwoqwXoMVavquXPc9U9J3uUHvd2rxueIKDynN0K1SEMyMMBCd9P1Gv9LoJ5XMT5qKGwRNw6kvV67YMSYh3pMkzLhQOthSI7Nry4+cqn4QBXW9edwRTFgvxJficQ1SAmZypEbR2biuynMmSLw3XmRtlNfM47ezQQKbHqJtHADpz6TQG+KLUE2/hLYtDXt9qt7mP8KjIAjNohGrbBuC15OvL/R0pTf2kFAkyewZhkzIgSwJlLflyxsd+iKCqQE/dptaDdN4GCcUOPyrVpdsvsFGJV/o2Lgnd+7szQH/6vGTK6CdT1OalIyWEGoQDdJ0StjMcq6ywbUTVXyx+m
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(36840700001)(46966006)(8676002)(6666004)(186003)(70206006)(82310400003)(86362001)(6916009)(26005)(316002)(478600001)(81166007)(47076005)(82740400003)(356005)(8936002)(54906003)(5660300002)(336012)(36860700001)(2616005)(70586007)(1076003)(83380400001)(4326008)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 11:40:45.6193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f36f600-e9f7-4ab4-6112-08d8f370a835
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0701MB2675
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

No functional change, later it will be re-used in several files.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/include/asm/module.h | 9 +++++++++
 arch/arm/kernel/module-plts.c | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 4b0df09..09b9ad5 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -19,6 +19,15 @@ enum {
 };
 #endif
 
+#define PLT_ENT_STRIDE		L1_CACHE_BYTES
+#define PLT_ENT_COUNT		(PLT_ENT_STRIDE / sizeof(u32))
+#define PLT_ENT_SIZE		(sizeof(struct plt_entries) / PLT_ENT_COUNT)
+
+struct plt_entries {
+	u32	ldr[PLT_ENT_COUNT];
+	u32	lit[PLT_ENT_COUNT];
+};
+
 struct mod_plt_sec {
 	struct elf32_shdr	*plt;
 	int			plt_count;
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 6e626ab..d330e9e 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -12,10 +12,6 @@
 #include <asm/cache.h>
 #include <asm/opcodes.h>
 
-#define PLT_ENT_STRIDE		L1_CACHE_BYTES
-#define PLT_ENT_COUNT		(PLT_ENT_STRIDE / sizeof(u32))
-#define PLT_ENT_SIZE		(sizeof(struct plt_entries) / PLT_ENT_COUNT)
-
 #ifdef CONFIG_THUMB2_KERNEL
 #define PLT_ENT_LDR		__opcode_to_mem_thumb32(0xf8dff000 | \
 							(PLT_ENT_STRIDE - 4))
@@ -24,11 +20,6 @@
 						    (PLT_ENT_STRIDE - 8))
 #endif
 
-struct plt_entries {
-	u32	ldr[PLT_ENT_COUNT];
-	u32	lit[PLT_ENT_COUNT];
-};
-
 static bool in_init(const struct module *mod, unsigned long loc)
 {
 	return loc - (u32)mod->init_layout.base < mod->init_layout.size;
-- 
2.10.2

