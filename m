Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324EF305954
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbhA0LMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:12:22 -0500
Received: from mail-eopbgr00105.outbound.protection.outlook.com ([40.107.0.105]:28894
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236542AbhA0LKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:10:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKH5GBwImMNqMI1lsqtLE8fTad2ZrCP0Qjo+T+BVNG1aazYv6Qei9/B4NAloOjdbXy+n3vlRuwejBPDLc1om2nduKnQODzVmPpk7lLPzg7tr0qq7/tvYrEK8B6DXmUzbQ98fwA6M7XKkxLnNHCPIJ6EUd/KvqP21pE0S5V1KabwTbiuJ4v43ra1qWk59JIhqpM7ifLYKdFdfxun5Yy2qxKVUe7rRg1URmVSRQ0D9nhdbwfqaGTVr1aU/odXXOVzUtjl2ThBdtiD+V5+YaMm1pwsiS4sWSuWI7win0o0u6tPxNOIhVmIaIfOEi3Q14Q0rWg2cwoD2eSaEO+LSsBOafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlJmTMqpfOCiSImjexyakopdCkg7me37avy/EP7HCBI=;
 b=cn/8p8wEIh8c8MQ2XH5fv4zm8/054IuZqrcKl0Y0VgkMespa8mVUlSGJdjkBPnxonvj2+fYioa+joyfuXvFOKtp2/6EHeSnhEtBn/N18TPQrldeAJTW0ox/n/8bHS0lyq/FqL9X3eyk99KiJ3lYqGkTZTj2Mo8VTFZrdWUfGdIbeP2DcZAhI2OyGp83VkaolMO2zQtx3OSG5ijwMLsgXNIaaDedujlx4XpWZbPnQnwGawnaL/h8NV9j48IMvnZY875o14GzzjhdPicckz4PUMqscqm515gG//EtLFrxOnEsk+OmXvXYq5mxbgv3gexEiS8vYkzOjt9ApRQojCk9wCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=linaro.org smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlJmTMqpfOCiSImjexyakopdCkg7me37avy/EP7HCBI=;
 b=okN/Rtao2SmJZ6C4rw7aDc8g4x81gOpCO8f2HpppT15qa4iiJ/njwhJ4wS6DU1tKXkZE9YJYt/0Pj6d2y1TvaE+YmNmoq4ygERsk2L6+e0wEq+Nqnj1JvzZVemj9MW1ma4Zj2RErkSpPnRPlkzmRevHGNSTdU4iGT5/Tyi1tpME=
Received: from DB6PR0301CA0011.eurprd03.prod.outlook.com (2603:10a6:4:3e::21)
 by DB6PR0701MB2885.eurprd07.prod.outlook.com (2603:10a6:4:70::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.6; Wed, 27 Jan
 2021 11:09:53 +0000
Received: from DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::c9) by DB6PR0301CA0011.outlook.office365.com
 (2603:10a6:4:3e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Wed, 27 Jan 2021 11:09:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 DB5EUR03FT046.mail.protection.outlook.com (10.152.21.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 27 Jan 2021 11:09:53 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 10RB9nLq008895;
        Wed, 27 Jan 2021 11:09:51 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v7 1/2] ARM: PLT: Move struct plt_entries definition to header
Date:   Wed, 27 Jan 2021 12:09:43 +0100
Message-Id: <20210127110944.41813-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5708b87d-14d9-4cb5-de79-08d8c2b41292
X-MS-TrafficTypeDiagnostic: DB6PR0701MB2885:
X-Microsoft-Antispam-PRVS: <DB6PR0701MB28855F564B95AB9D3A5BA88288BB0@DB6PR0701MB2885.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLi2lMqGeg0z7Bgz2XWwsWE9zk1hSw+oBUGlxVhUPyO3GBWgj3cG4zVNuWCLuIbJxSm5zdpt1YlrXBpKbJ/i/myXwILOpxpZlHbKUiBNt1oEE3bzBh1S+xXGnUMFGl8ZnpvW2aqduYUVKfDKdfAHIK5FXVRiNF1DFC+ULDFFS/9024keNvz2CCmbWFYe/bYH8Xx6C2Pus/4ywPSrnk0FvQf8SOkeccl+s8FjMjvag0E8sM4Wj+U8GU1IF66Ue0n3diH37XBO5nA2AqC02vkvag9fzW/dZjhWBKJYityec39UBpP1Ytq1EWZl6Nsy1Y4a44TF1kcoTuWqVasINVDdB1tIpH9Zb8AlXwpcsntjjK46loA2D49Fntj+xZ3bmGRlUhOmPhqU2LLPJrkWd92bl56WFo9hSZRq91rj5WJHguHaWhFMKBXS1k3lyXOIDwyUkVel/PjxT3DvZZ13RKKBi02gv15YQOsnJqSZv3jG2JrIPvIhdRjrI35ud1JyZaRK
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(70206006)(82740400003)(5660300002)(8936002)(36756003)(26005)(81166007)(70586007)(356005)(4326008)(54906003)(2906002)(2616005)(86362001)(186003)(336012)(8676002)(1076003)(82310400003)(6666004)(110136005)(316002)(47076005)(83380400001)(478600001)(36610700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 11:09:53.3252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5708b87d-14d9-4cb5-de79-08d8c2b41292
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0701MB2885
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

