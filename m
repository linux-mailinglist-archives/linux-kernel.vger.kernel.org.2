Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D6334E66C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhC3Lkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:40:52 -0400
Received: from mail-eopbgr140094.outbound.protection.outlook.com ([40.107.14.94]:49121
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231701AbhC3Lkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:40:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBdSuJRYE2c3ZKqQk31GPmRQ8EzQvK1JK+UEECxilf4fgf4VhUB/zZBYvfASeifs4RSkBeFX4Lw6BKcBbnUyPXzf3XDDJ5MXIJfGJKNVwG17fkYpLIx1JN96Qjm7lyUNj2yNSs+7uaIKKZaQHyGYK6FGWTkdARMNrTBffBUpyI23w+Fle9i+Fx+JQIpXjZQHtJiRQIYQsx8t0YpEH4EBNDQdbYc7D/cZCzKX1sXYaE4llJa59SVr+jIyO7p/QAmQwuHhQbDoytJ78aWGGgIqku5F2K8pvdHzqNTcZlQ7qoD3Q6QXVrrFhBIMTZXYNFQf7aDWeiuBtwIvivCJnLc/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vnNT0cAOKE99+naUJjBQLeti2+AkJQPIzA21oLGMCY=;
 b=cKPm7JdHkuRqfgVqJtNWy4zXnrccRCG9PlSxQl91DpRiuygkb3Ou0SNwbQGpwpTQMpo6NO/x4BpqKqpANyJT4bTC/xS3f6qpZFb/v1m1NkweGFAvLSTeyXwlojbs9+xopTUurrfmqhpxDIyULx6dHkDRz6sdjbP78HDZ7is0YXEO6YChZmyA1KQ/Oi13dKhNpGeU/IcsQ+QiZTVFTsoEpRkFI+uKgabcrDhFIu3iBA/aMiRcdIA8Zw3Cz+5RGMNZGrerpeuiFMhYDOs5RikO+bCwsHt4GbdZVpsheZcMrbO5I2C6gWyaYNGCUpOxJpRC8hafNfzILX7zGgRMQ5Zr1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=arm.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vnNT0cAOKE99+naUJjBQLeti2+AkJQPIzA21oLGMCY=;
 b=mvwqe0Xr/8QdT5uo5Qwt0x+whDN0B7mxC4H0VrDIjdZgcm7FiHU1LP+1HUlmj93HFAL0S+fg5fVkI48o23mgZ+jDOsRqQtEC8Tyja0hl6UmUGhESa7ZxrdJIacJ+v2drscejJ9k5xa6sYljjY+E6Y3/NSgwTx2CEMzPjd5luunA=
Received: from AM5P194CA0024.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::34)
 by AS8PR07MB7077.eurprd07.prod.outlook.com (2603:10a6:20b:259::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.17; Tue, 30 Mar
 2021 11:40:44 +0000
Received: from AM5EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:8f:cafe::ce) by AM5P194CA0024.outlook.office365.com
 (2603:10a6:203:8f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Tue, 30 Mar 2021 11:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 AM5EUR03FT019.mail.protection.outlook.com (10.152.16.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Tue, 30 Mar 2021 11:40:44 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 12UBeeul023631;
        Tue, 30 Mar 2021 11:40:41 GMT
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
Subject: [PATCH v8 0/3] ARM: Implement MODULE_PLT support in FTRACE
Date:   Tue, 30 Mar 2021 13:40:32 +0200
Message-Id: <20210330114035.18575-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e9f50b00-6b2a-429d-8431-08d8f370a783
X-MS-TrafficTypeDiagnostic: AS8PR07MB7077:
X-Microsoft-Antispam-PRVS: <AS8PR07MB7077683DC41FA1DB6E38F3FE887D9@AS8PR07MB7077.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QL6npV9GFddFuLobM9wnt33yS7J4zDdM6Gupu4RBuGacEspvdCUtpfDwla/0aRDbpAdEgNewfJBoe4jvH3ztyl0k/PoogmN8cwWSSaWgGMHJbyBG1no6+5Jr1Sumr4N/Fp/DMZtz0or/DbTrIGogq2+RAM5K6lltDKlPbEa8YyTGMfIRixUmCPPQAdKF0FH6/sCYiK4ofbgfMKv1yYoQBSiu8UZdlw1QXg8fNQDD2KGfzO77D+jiacN2WugV4hbTKORa9W4ophqgi03mcJJf7m36y7qMPL+6cLTel0U6dV3r8bxN/j4FW1EpmItDnBFJ7c3zIMzcEA2goCZ1TonDIUGMDneW6HvjjAhJlDOp+T7eYcFF3BZu039+g7+783Qv6uuyx/LmUsojC4SJ+qfDUo77nr4XZSV99/5SAM1nWD5dvcHb4m0fY9y+LapMFeAzRkYKKLIT4XpNSPobazETsDpsWRtFaoec7oFtzfu+aHjjdOSXNpo8H+aqqSTCMXAL8t2PDXyRQX9vlhmppxd4ps/45DgWy29voNMvNMJC6SIct19hrmnre3gAGz3YNiCECyHEpAsdCsacuQDYkdGYnarMDhwFtlj2znftwwRyizsRFY2V/QGHiFiR8s4KwmAO1qdf4h6CzsJedlfSpKuvZxUAN3hlXwo3WazaD1QAuIZlmKSjXxmMj4vYonUbBf0g
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(36840700001)(81166007)(70206006)(6916009)(36860700001)(2616005)(47076005)(478600001)(70586007)(54906003)(82740400003)(336012)(356005)(26005)(1076003)(316002)(186003)(86362001)(83380400001)(36756003)(6666004)(4326008)(82310400003)(2906002)(8936002)(5660300002)(8676002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 11:40:44.4556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f50b00-6b2a-429d-8431-08d8f370a783
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7077
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
v8:
* Add warn suppress parameter to arm_gen_branch_link()
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

Alexander Sverdlin (3):
  ARM: PLT: Move struct plt_entries definition to header
  ARM: Add warn suppress parameter to arm_gen_branch_link()
  ARM: ftrace: Add MODULE_PLTS support

 arch/arm/include/asm/ftrace.h |  3 +++
 arch/arm/include/asm/insn.h   |  8 +++----
 arch/arm/include/asm/module.h | 10 +++++++++
 arch/arm/kernel/ftrace.c      | 46 +++++++++++++++++++++++++++++++++-------
 arch/arm/kernel/insn.c        | 19 +++++++++--------
 arch/arm/kernel/module-plts.c | 49 +++++++++++++++++++++++++++++++++----------
 6 files changed, 103 insertions(+), 32 deletions(-)

-- 
2.10.2

