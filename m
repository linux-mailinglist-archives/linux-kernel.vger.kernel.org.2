Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5DB3BD76F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 15:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhGFNFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 09:05:54 -0400
Received: from mail-eopbgr140115.outbound.protection.outlook.com ([40.107.14.115]:63988
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231895AbhGFNFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 09:05:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO/b+pYmAkFM4tD8+RjrgGbI5kORASfDV4PaGikW7mOIR1MSJ7dHbdJJDfMTTek1rgS75JPcmUbpLLINNF2glxaSDXx+U0Dspth1B9bga09CpgO12cAPwcABPx3nXMw2I2w6xPX+p1RF8pYXlKq0pEwhSSvvX9Ju1S5I/RlcvmGWr/D5zXUgvX1MJMtBzYwBaeEhGdpz7m4i9sAuyEow2reuzRN7JATlbfV/R7kMI4VK02AbXMRbupHMk5RB0jCmE3u9pQ632cIhI8uyyrAumKEJGTYPeX1p/RrMuCFdshHhOFqUSW57MXBKjDuEj7ySLQd+0cO2KQTfo0iDOfV1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OFBCR49Hqk+WtQ7QYtqttCBCZeh8W/q291EeRDU0UU=;
 b=Aij5l3X15JUu1ByyTQu6KtZfW99E7oc7LYOiUMKZJBHGx2NB1SaIULvAzbvWlVYOgrSqy3iVIxBDc2iPIYUaJjzn+WDtgnEi1U41cW4jQ8jO3XffdUU6/HBpYqKKS6QqWqwnEO/6S0zb1IvN7xGegFSGpNjjmxr4u9Hd3Pq3OZkpHZjI/u9G9cnJtefUWRcwdmYL4m1x1GjB/jXYv05KkWRZ2GrtkHWUJLDn7FIGhhXT5Nafo82TsF4N42KRXYnBW0Ddq9Pmdlk11RNTSucPGKcYyuN6sDG4qt4cX8kM64xnisgQTuKuyTTNyLxTNC4EhO0a2M/Npm/l63lAqz7G5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OFBCR49Hqk+WtQ7QYtqttCBCZeh8W/q291EeRDU0UU=;
 b=CbjYmcbFXbSz8PWdiHtToo2j7Xj4ozi8Iul52jDV2jHVrnYLSjuwPHlIZgO9mmn6FxymG7vdfWG12yBFQ4Q554JXHO7syWeuvuwonoXyHSutDGXtmuL55oktYoF9FQlTsfs+NNs4TqXeXcYJ7Yq0riEhE/Rl3zoLDZGtD80XD8g=
Received: from AM6PR10CA0037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::14)
 by VI1PR07MB4783.eurprd07.prod.outlook.com (2603:10a6:803:6e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.15; Tue, 6 Jul
 2021 13:03:09 +0000
Received: from VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:80:cafe::3c) by AM6PR10CA0037.outlook.office365.com
 (2603:10a6:209:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend
 Transport; Tue, 6 Jul 2021 13:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 VE1EUR03FT062.mail.protection.outlook.com (10.152.18.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 13:03:09 +0000
Received: from ulegcpding.emea.nsn-net.net (ulegcpding.emea.nsn-net.net [10.151.74.60])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 166D35rI027104;
        Tue, 6 Jul 2021 13:03:06 GMT
Received: by ulegcpding.emea.nsn-net.net (Postfix, from userid 61283203)
        id 67EBA15FD9; Tue,  6 Jul 2021 15:03:04 +0200 (CEST)
From:   Reiner Huober <reiner.huober@nokia.com>
To:     reiner.huober@nokia.com
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] module: combine constructors in module linker script
Date:   Tue,  6 Jul 2021 15:02:52 +0200
Message-Id: <1625576575-1008-1-git-send-email-reiner.huober@nokia.com>
X-Mailer: git-send-email 2.6.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4d0b9650-7479-4d88-847f-08d9407e6777
X-MS-TrafficTypeDiagnostic: VI1PR07MB4783:
X-Microsoft-Antispam-PRVS: <VI1PR07MB4783F6144FD38BDCB60B0627F91B9@VI1PR07MB4783.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qJMK2nG4qSAFJjNGiS9Z2oi7ZleZLGt3kgJ55rv9uai9dJZQSvVDODTp+r6bAVq9AbajK6alkVJCvjKxgedajdmxxnw0NY5acWnvr8iGn9WHvAmqEsRctNjKDz0Vd2ZuxDAnRWd/kKqOoaXo31fiThiVxqEygMNKkisUq85uNUO2x6YTVoQ0YmcLe0MwkaYMdTKii/WRH5evqxwTI4Ng5TMzoXcqKCUVVc07Wg6hv46ClFZDOjozr7q5Ej5dH94eyx9mq16LPCJT2Se0DZ1zFH4b/qM/UjF3VHUDGWIKjYgsq7gqUJcSVv713wANPXdGRpmSdCzvdrpK5hhrAfH1XlzDKrQIIksLv6EajVIrjDdrKJEqvV/1xs4JLEZnTt45VhQ+sM5g7gpERoTUgVQ8ZottNW8Jpw8D/qsUmlUapHapHPE2fBsyaIgBVlPMpN53gZN4XvHEPpoLuwoqtsYghJoUu5owElxrX9aN1cJesfeuT1vyTy13fZv3vxzaRsLvghPVurPCJBxUfJyFElxDjEEpMltgxeMddCpk04ik1m/TV1DAkEkj37k9zzm+24jOAveLHroLWAcxrTDz6qipKUrfrPULSOWyp8dxhXHZQZt0Wv0xEjei700oLMy413TySBixu4YkVTw5z5Og4dVo7c5z7nviDDn9Scgc8kOMkEI+LkySv6bZJ25CraXQEK1WTizj3G3OIuP74+Uw3MhZuporcYg1qpCvWyq39/T99s=
X-Forefront-Antispam-Report: CIP:131.228.2.17;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(82310400003)(8936002)(36756003)(356005)(6666004)(42186006)(26005)(5660300002)(316002)(37006003)(86362001)(54906003)(34206002)(478600001)(336012)(8676002)(36860700001)(186003)(82740400003)(4326008)(2906002)(47076005)(70586007)(6266002)(81166007)(70206006)(44832011)(2616005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 13:03:09.4599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0b9650-7479-4d88-847f-08d9407e6777
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4783
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constructor code for modules must be aware of init code inside
different sections.

Newer GCC compilers write constructors in more than one section,
e.g. ".ctors.65435". These must be combined into a single
".ctors" section. In the module loader, only the ".ctors" section
is searched and the constructors therein are initialized, when
CONFIG_CONSTRUCTORS=y is set. Other constructors are ignored.

This change combines all ".ctors.*" and the ".ctors" section, if any,
in <module>.ko into a single ."ctors" section.

For code coverage in GCC, this is necessary to show the
code coverage for modules, since code coverage uses such
constructors when initializing a module in newer version of GCC.

Signed-off-by: Reiner Huober <reiner.huober@nokia.com>
---
 scripts/module.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 04c5685..1d0e1e4 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -24,6 +24,7 @@ SECTIONS {
 	__kcrctab		0 : { *(SORT(___kcrctab+*)) }
 	__kcrctab_gpl		0 : { *(SORT(___kcrctab_gpl+*)) }
 
+	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
 
 	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
-- 
2.6.2

