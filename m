Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C47639F353
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhFHKUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:20:38 -0400
Received: from mail-eopbgr60124.outbound.protection.outlook.com ([40.107.6.124]:7150
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229626AbhFHKUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:20:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kV/yGwVePKSyA/9J2vh5FN6SvuS9I8585YqBUhWL1nZNAO90Bw1CohLUQrt+FEDW8BCIKYNcfhFH8xdSnf7AWxPuGXFx4/DiwndVRp+7Q+C2nYn8kRYUvgmR6Lq/qdB8WdZ3VHvCE7ztAjoefEqNyDg9EtHaw+fMmuY8UPRPO1yw7Zy/VyLRvRBaAFXemBfLQemUE6o0PZMYH5MTPVOnEsQ38X1oocoOEsGDRbKgx8bc3TtPUxceEhmp/r2dHUxcZTs56b7Fw939C7SiU+spvuTeSCTqH7Ny8o26oqmbGHkpvyypZQZVgP7ZS5Ft6zzFNXYy0j5pqYBL6hN038rpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygcRjJLj9aMmwXw+stqm5K3xBigAvsTL14UVt5fuYI0=;
 b=YSNEKrNlfZWGv9ki1+EAqK6IzuzfcsyYgtPFon5Hw/0WimxCG5rZPrEZCbkzRXvpNs19wupCYj2O7AlOI1mxddwh6jkl0L3z1Ho7iylsI/x3J/U3jHv/0ezRf4VYmJC9VuDxZ22GPxD56SycusncXOglJ9fVkYPP60TVSw/rtz7zdZ+8owL/bvDPjCZX+yq6oiqRONAIXKe/PjgaxICiAoyP4hdh1DdboX/TxEQ7/Vm1zEqukLE5BzitxJCXwudR4nph2tb/rFvkEaqXn+wwVnRKj9xJTGzUwoBA7h3+yRVFWkZiy7YukY9NDAvZxuHpXEGceGLTLWonmVJz8Q6Img==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygcRjJLj9aMmwXw+stqm5K3xBigAvsTL14UVt5fuYI0=;
 b=UOZapE/C05LZLe/hX9CBcm6+L/x0J3TdWX65AC2BrSjhxH30q7j9b8qtYvIrCVWTA+hsgX5UlBBwi7D6mEG5mysnXjMDlRHdkq9BCiX5LS1DsMBoqEhD2OU2x8dHSlvNYyXfUPDnIDO2imB/fYS3CKVwP+QdwtRtMoxsnQU/cdk=
Received: from AM6PR0502CA0052.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::29) by PR3PR07MB8114.eurprd07.prod.outlook.com
 (2603:10a6:102:171::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9; Tue, 8 Jun
 2021 10:18:42 +0000
Received: from VE1EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::a) by AM6PR0502CA0052.outlook.office365.com
 (2603:10a6:20b:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Tue, 8 Jun 2021 10:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 VE1EUR03FT009.mail.protection.outlook.com (10.152.18.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.21 via Frontend Transport; Tue, 8 Jun 2021 10:18:42 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 158AIcLN019880;
        Tue, 8 Jun 2021 10:18:39 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: ftrace: MODULE_PLT: Fix build problem without DYNAMIC_FTRACE
Date:   Tue,  8 Jun 2021 12:18:32 +0200
Message-Id: <20210608101832.6099-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cd24f909-b846-4820-497f-08d92a66cab1
X-MS-TrafficTypeDiagnostic: PR3PR07MB8114:
X-Microsoft-Antispam-PRVS: <PR3PR07MB81141311BB2E7FD86AD74C4988379@PR3PR07MB8114.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORjkKPhlr0Y5RXB134+7yZn1UJBUREDBOuj8wAGcHF+CrSG8Zj+Nl2Vy8l2GBfv4ALqH0woGQto+JwmMmlTls7sFP6TMY/CTbQXuyVldGPi2xwDjpbFpYPSmMngKX6ZOaP0nfAdN66L3E/rdm/SCpY1KlOXA2y1fRCkwiiE8h5C2c9lXeqOH5og8IXSRreuad3kEl2Yo62mdNc6HKKaZashyjDtzYiRGd0En67cL7FGT3ZLzk/2CnOrWSOUQ2bhj9BDlRfESIDEsasrwfPAjo42tucHD+AcHTtpm580Iq32Acb3L16xyogXbzp+trdeduCko5YSX3QatltyKIP28xN1+qbJ3RKctU8i3u66E1DPsxRe3kajQf3UY6W3Mdibxq0KNHaHEUZnwJ2px4Ny14udh2uxX6UDGU+xZ01FD3HKciSxeS7oR/63N9u8YFdQKfklAs1tnEI11gLV2QAlrOYffYMzv+sCPh8KgNf1vsDkcHe86eFMgdCWliwHK/dsYOuGlGIw/UwUWPaeSNySPNpVoURnnm524PxSGI2WU1S0l7N02v/jeNbJLPuUnUAkhZxtWkb9CG5u7YbeHRCEIj79a0ZsxfKhosp8H7M7YJLsXMvpvw3u59R5sz9+c2gOMq0zRaXoUc/gYlARKGi7KTh6qDKccS+iBaq/UVYOKIqUH/rnFBrJtnr8zvGmwExHE68cT9SB1ClM/WvFzxVVBUujWzhyLL6cYyrnWn7oTfmWCXVuV6Zx9Pk8pdJ9A/NUZ85Gi9m8r21+giCtjA3SBayEanKeaV3MwzprbV8SMHO6k7zSLDm9BNQGglyV8N1VU
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(26005)(966005)(2906002)(2616005)(70206006)(82740400003)(8936002)(70586007)(4326008)(336012)(83380400001)(81166007)(8676002)(1076003)(356005)(86362001)(47076005)(478600001)(316002)(36860700001)(82310400003)(4744005)(5660300002)(6666004)(36756003)(186003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 10:18:42.4463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd24f909-b846-4820-497f-08d92a66cab1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

FTRACE_ADDR is only defined when CONFIG_DYNAMIC_FTRACE is defined, the
latter is even stronger requirement than CONFIG_FUNCTION_TRACER (which is
enough for MCOUNT_ADDR).

Fixes: 1f12fb25c5c5d22f ("ARM: 9079/1: ftrace: Add MODULE_PLTS support")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/ZUVCQBHDMFVR7CCB7JPESLJEWERZDJ3T/
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/kernel/module-plts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index a0524ad..1fc309b 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -22,7 +22,7 @@
 #endif
 
 static const u32 fixed_plts[] = {
-#ifdef CONFIG_FUNCTION_TRACER
+#ifdef CONFIG_DYNAMIC_FTRACE
 	FTRACE_ADDR,
 	MCOUNT_ADDR,
 #endif
-- 
2.10.2

