Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E13305955
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbhA0LM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:12:59 -0500
Received: from mail-am6eur05on2136.outbound.protection.outlook.com ([40.107.22.136]:33537
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236489AbhA0LKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:10:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iom88+bJBledwR1JTo9+1Y9K1E817z4zI0sv7cNr4rgUqhcy6qG7ZktqYd8uTHCMF0MVCT/8n1SVnqbb1z9lRQMOIgp7CxhiaqHOM6eUqNIYAtBxnFzW15vtD42WOxA23d1mx9H3EE+i5VlhGczH+HbGmE3Ni3Jco8wMy6gPxSbf/A5CFCceMsHOUr0g3EKONuVAlOUwl2i6tIZ+TbhILskvVVz7LYTY5gK7jPplnuNs3f1pw8ez/GHkJwVg34MGQ+ax2cYDKZz9RmI02sfIiTeYPvhCXW+vFacU98xh2vG1yRm7glXTSR2+XmkH1J5HgQ79cbKRm8NGYsktPedZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=basErwpYEjV3/3fpSS0Rb9RL6aEF4JYu5pmp0PSjH/M=;
 b=GK7ovUKAIUFRmoJtQAq8kfB5H7JHNEk4Ii5MTyPwOlSKgyHXXldNDeiwE7UwTk9/O12+xa6DL4KA5RlDYVvw7WCrkvIbQ9dLcja5IsyC4zKX3x8YZbZI1F4MYEar5aFtR0aC2TfIeqUNBqNXyRn1dm/qOdY/d07jFxv+1cREkc/oTbczcEbLc4qdavj0pMSYS990KCYmzUf/wi0m0N8RiPus3rjwrMDWYLUtrvYc2elqCdqZbXQR7ZT2x3fK2hB+mKu9TpbXsl6eg033TtmwsnRwHe5gvFB3VoaRXgJoUzuomkIe5ayBHFkyexErhMbbiTt/QyXCeTwTCdtm2nyOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=linaro.org smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=basErwpYEjV3/3fpSS0Rb9RL6aEF4JYu5pmp0PSjH/M=;
 b=daTpdLEWNRG6XFWemaY1Kinier0s4jL/DIOhXp2yP+QIpiXARMyjod9l0Z1X0Dp+pyMgJe/W79USVSEnkIqU23sCHqNfpnN6gSplx2YeqYwwywsX4m5+lMDQzmxO+rgYbait6xZCDVchbJTod5LPKBAw50zm1fhiCAz5OJquWi8=
Received: from DBBPR09CA0019.eurprd09.prod.outlook.com (2603:10a6:10:c0::31)
 by VI1PR0701MB6845.eurprd07.prod.outlook.com (2603:10a6:800:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.11; Wed, 27 Jan
 2021 11:09:52 +0000
Received: from DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::20) by DBBPR09CA0019.outlook.office365.com
 (2603:10a6:10:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Wed, 27 Jan 2021 11:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 DB5EUR03FT025.mail.protection.outlook.com (10.152.20.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 27 Jan 2021 11:09:52 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 10RB9nLp008895;
        Wed, 27 Jan 2021 11:09:49 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v7 0/2] ARM: Implement MODULE_PLT support in FTRACE
Date:   Wed, 27 Jan 2021 12:09:42 +0100
Message-Id: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8a3e9675-7359-4b6b-f746-08d8c2b41229
X-MS-TrafficTypeDiagnostic: VI1PR0701MB6845:
X-Microsoft-Antispam-PRVS: <VI1PR0701MB684587EC248BD147E8728E6688BB0@VI1PR0701MB6845.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcWfHYXoepDIM2KpQV09aY4AfGB9pr3llyycaMS1CjQDb9eoiSE5kvrAju0cXknzIxEH69PxegtjOzzMZFTPgQ1Lx0wsoQPoo0c0cQCTrHukJ8coOcEY94XiVU30IviHw9SQ9eC47qsLL/VpTagzszyikVfMgAsjPOvd2bHF8AXIhkaO5z8va5uvD0Pzxo/y+l0TCqR3aUcIxcYehJXr9Cq80a/Kpvsr+NbhJOBzReI8asMOJFyc48ghyYn2TerunBREBauJVoQQVprK35PWLIfhed9hc3ox0QUR/eeWNG9E3fC4zzSGgzaPejKOlItyj4hKg7Om5LIrph+0hlz3cxxR5uzFLjxK7kKToGaGMJys9audt1Qn11NvpisxUAx28CQ7PGcHSQulLxDLGt/PwXMtmn/0OEHCi2L7bSTehbA6RL2YA5RpXa7kYuPhbv6AiYy0P+Xczjw6AQXftAFaT22TQYygzZCzo7eqSkSIZQ0agPqMBW+HVjgolHAk27iOo9EtgaRyrBcW1DgWVq/H77xrlU/OCREpkRuZkbBVfuv+G8tMzJHL/PtA8sZsXlstNUUAOk7gcx/9dtYenMtzq56hn/AH/pTRsRaZr6O36n7aGtbZSAAQxtLh0EHP4b8g
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(83380400001)(8676002)(5660300002)(70206006)(110136005)(54906003)(2906002)(6666004)(81166007)(82740400003)(336012)(36756003)(186003)(47076005)(478600001)(4326008)(8936002)(70586007)(26005)(82310400003)(2616005)(1076003)(86362001)(356005)(316002)(36610700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 11:09:52.6597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3e9675-7359-4b6b-f746-08d8c2b41229
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6845
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

FTRACE's function tracer currently doesn't always work on ARM with
MODULE_PLT option enabled. If the module is loaded too far, FTRACE's
code modifier cannot cope with introduced veneers and turns the
function tracer off globally.

ARM64 already has a solution for the problem, refer to the following
patches:

arm64: ftrace: emit ftrace-mod.o contents through code
arm64: module-plts: factor out PLT generation code for ftrace
arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels
arm64: ftrace: fix building without CONFIG_MODULES
arm64: ftrace: add support for far branches to dynamic ftrace
arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()

But the presented ARM variant has just a half of the footprint in terms of
the changed LoCs. It also retains the code validation-before-modification
instead of switching it off.

Changelog:
v7:
* rebased
v6:
* rebased
v5:
* BUILD_BUG_ON() ensures fixed_plts[] always fits one PLT block
* use "for" loop instead of "while"
* scripts/recordmcount is filtering reloc types
v4:
* Fixed build without CONFIG_FUNCTION_TRACER
* Reorganized pre-allocated PLTs handling in get_module_plt(),
  now compiler eliminates the whole FTRACE-related handling code
    if ARRAY_SIZE(fixed_plts) == 0
    v3:
    * Only extend struct dyn_arch_ftrace when ARM_MODULE_PLTS is enabled
    v2:
    * As suggested by Steven Rostedt, refrain from tree-wide API modification,
      save module pointer in struct dyn_arch_ftrace instead (PowerPC way)

Alexander Sverdlin (2):
  ARM: PLT: Move struct plt_entries definition to header
  ARM: ftrace: Add MODULE_PLTS support

 arch/arm/include/asm/ftrace.h |  3 +++
 arch/arm/include/asm/module.h | 10 +++++++++
 arch/arm/kernel/ftrace.c      | 46 ++++++++++++++++++++++++++++++++++++++--
 arch/arm/kernel/module-plts.c | 49 +++++++++++++++++++++++++++++++++----------
 4 files changed, 95 insertions(+), 13 deletions(-)

-- 
2.10.2

