Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C5930591F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbhA0LDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:03:45 -0500
Received: from mail-vi1eur05on2084.outbound.protection.outlook.com ([40.107.21.84]:12257
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236275AbhA0K7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:59:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpnf+E8X5wW+W5fNN3jRMu4MYxcy7q0jAVNDcQkG7uGVDuzgvSn+EpIqKVTb3+RyQZe6hhc/hXnkHrPhPTr4gmaIJaANmpVvuphDKStsQKrjmZJAWqSudTOdv85d9BY0OiAcpdw0DxYmTatJq58Sdp9AYQ6DogJrxNDvY40SAc60+zrU8n+sEGLOFYRkZECzHYGqciVZpVx0cM4PGosjdbAaUDab5TG3rKyql5d4+nivoGYSypQ5j+EqHxJY6eIozUGcrMUDmNaBLUh5BgVgm5oXzuhs7hYHVI7WVGpzzAD+7zHCD9PiNOr7gEJ7FF3nfsZ/TRGRqqrpnOOw0r+6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFwb6tSOzUeiKi5+vwicqfdrshrdYpzG8KxRpqFj/Io=;
 b=aexF0srfAWU9i2ZMDQr7fMgRmmT3h1NhYS4EJ6WLs6YKKJ4be9XCFs/ntJMWq8XiIGQ09fbTpiTTlKUmWe15EQcBT3NL1pwCKSahOAGR6VVasbXrALqqJPiSwqi2GRrA5DZJitc+JILiS6S6el6TwciCTOfw86saxiB0pH2q9/Uk5RsU29Jb6pUOcoBdbJHcHOSnZLh0oByQu/vdymUbEzs4ot0hUsNeJnI5Rh9fM+NtIeWM6xxC7ObZtZR0Cp5tBsFvjPbsNQDPEEHyUynZWzpBS8bk/nMz/gl5VuJs7HEvtfZ+ZHiEkTnePjiCv6OfbgXT/HApkanhVvNdeuTuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFwb6tSOzUeiKi5+vwicqfdrshrdYpzG8KxRpqFj/Io=;
 b=TFhtMuY7cTGtbjx49IKzKBEekVooZUX7RvnUcgrnXerCVJlfze6uMPjogXduoACy6lu7X86X1sNjFQssZ0tDJ4WYCWqU8I0R+wDlSc0A3OeMkjhZNey5UDkjmz21fni3Uk+Ktscknq7soK6htvuHBkhhmYH891cy8Azl0af7B3Y=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR04MB3205.eurprd04.prod.outlook.com (2603:10a6:6:e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12; Wed, 27 Jan 2021 10:58:29 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%3]) with mapi id 15.20.3805.017; Wed, 27 Jan 2021
 10:58:29 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kjain@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/4] tools: perf: Add JSON metrics for i.MX8M platforms
Date:   Wed, 27 Jan 2021 18:57:30 +0800
Message-Id: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 10:58:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2ded85a-fc14-4f9b-0569-08d8c2b27a96
X-MS-TrafficTypeDiagnostic: DB6PR04MB3205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB32053C541930669B8B0EE156E6BB0@DB6PR04MB3205.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrpdJPFHkt2kHLpPIPCocIKGY93ypMDI1sm8iR8GdtyXdzJkiNZmEAd5HgAOFoTNa0HELR3pCecoziguSaZbKKN2uP69bp/PwSjpNiQGJc5x4ok1x2OqL/rKVc3Wrxls2zdQEeH6ULA6cLvMAiDNbKFxoDYzpi9/Wc2ABQiOMAVuwFhsEJvoTSnCvK4V/v/1lFR2ZXQK9LvXzqKaqn0ShwNOIHYqDKoDXErraoT7lI100skmL9cC6y5AD6VJyvUeOPg+uF+ea2hBZQ94e9Y0UJUBhlD65fh28+yvUnYdFyKcQaWgsfzQgvb4/6pyhbGG/ZO6RW+akEcIKLohxp4O2WJ641IZFaOnODK5oj5BOyqiJNRk17I9SBEwvh+vp6ncULYq61GJdEBCnpCYou5eejtujruwngxkOwaDjA142y8Yv8hiXvNRuSu0WifiGXL2kRNrVOO6OfxyJK2UuYoDhx0v0OuChARABXCWiGF59ITAHwDnsB0lXOxw65NDRdctJp+CpQxrLBDqGuQ/SNWlODbirff4w/4XXT/nCCTrW78IwFSQP9gGCvP7n8I/axslBahO5F6vC6qea+c+XgfP31UZ7+LsJDSHq9YDqZPpxUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(26005)(4326008)(5660300002)(6666004)(478600001)(6486002)(16526019)(8936002)(956004)(52116002)(186003)(2616005)(6512007)(83380400001)(7416002)(66476007)(921005)(36756003)(6506007)(66556008)(2906002)(8676002)(66946007)(69590400011)(1076003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tzZhawobXeuq9ZH90rgpaaaOVSVBxAE3NGbSMh/znv0cPyQvk1MUzqO5Rp+a?=
 =?us-ascii?Q?ebKgoweOj/AyuNdVGx3rgwSC5yL6rA93EHZmWwGyUw98ra6s+g9aq88McpEB?=
 =?us-ascii?Q?3UKivIEwsI6CVyhkiHovYoJC9J8Sf/AgkQ4cTVWAhiaeqA9pxnN8qDC9FCHY?=
 =?us-ascii?Q?wyQsEJDnVuKdKVoi5IINEyQfKqJCXCSkp6UdYl6viCHRgk0By0R9P6zBNzYf?=
 =?us-ascii?Q?1AkelIwzlZIVH6pldgbCn4XGtOrZRnsWwquXU3GKmX6TWvZxxlU31ncJM5cR?=
 =?us-ascii?Q?pO00RA4wgcCQvO4eQksdlalsqzkuqYIR3abB0qJrwgBbJp6KKP3Z77wXR3fU?=
 =?us-ascii?Q?NT0gZTBrtUbH/wNsvsUHNPbM8UidzSiiegVW1gxGtPBiUIqrOxm6JywIQzsP?=
 =?us-ascii?Q?E4vlMIYj5xQEe8WyyMCoZat4mWzfJkuT4grGYywb9n0kL1jpCufyJPXOnNOt?=
 =?us-ascii?Q?Dn57X/hgdWLS3auo3QWTci+2vBOA6M+9+wXiUSkuMJ1p+MMc+4ARhpuJiNPh?=
 =?us-ascii?Q?BZfsi+9ul97GWkzELRIVgbwi/MyGbsjoWuM3HMHXD7z5Ik/cq+QWLJdw88Q1?=
 =?us-ascii?Q?a9CiZ09NwqM4u2napSkUW0b+FdP5yk4g2A+jR5yI7ql5ZNHB5Qkh9iaSzcUI?=
 =?us-ascii?Q?F1UUuuJuJ4azlxw4Rmend24s0rY6bEua1YrNG9s/4n/NkOSwWMEWcSjLXwno?=
 =?us-ascii?Q?PZO+NHH+tD2qhwuog3m+4V0PFQVs48ZVXGiYtShYWNTKbrGLZSc85I3xjJnc?=
 =?us-ascii?Q?Eqg+kEixGHEf1DGwpXj0NVLU7yc4XP0jApfZxQV4a2itJInJsqH+C/HDpUDg?=
 =?us-ascii?Q?AM0LwOSrJc/T4+xVGwWsjzPn0G8ed7OncjaNdPaT2iOz8H73u3Qrwkxspaj6?=
 =?us-ascii?Q?sGshaPxU+jQUg7EQYGIYAOoTSzzhur0sETrfHZJXKYOhCWNJDs6AuAFTgijU?=
 =?us-ascii?Q?QdWz0RTXoAIp808vhHGYo0p37vQv5vkSVnACBwk31NW/ZIeoume3cJXi3Tbw?=
 =?us-ascii?Q?x9pJq1zcy+h1aH7v3NuoB0ptpLRkGvQYiAEWSlQqKw3mlvTWUFO14iLbwZet?=
 =?us-ascii?Q?3OgEKVlX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ded85a-fc14-4f9b-0569-08d8c2b27a96
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 10:58:29.1635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0NFCvzHoSkypIOkKSY5ZWfTrYj6uj9rDr9rgKUqCbOgYKuZwOi0ZGuZqr+ByFtsPrZAnSHOa9BtfaGoLzfQbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3205
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON metrics for i.MX8M platforms.

ChangeLogs:
V1->V2:
	* remove board level metrics (bandwidth metrics).
V2->V3:
	* Add the missing "ScaleUnit".

Joakim Zhang (4):
  perf vendor events: Fix indentation of brackets in imx8mm metrics
  perf vendor events: Add JSON metrics for imx8mn DDR Perf
  perf vendor events: Add JSON metrics for imx8mq DDR Perf
  perf vendor events: Add JSON metrics for imx8mp DDR Perf

 .../arm64/freescale/imx8mm/sys/metrics.json   |   4 +-
 .../arch/arm64/freescale/imx8mn/sys/ddrc.json |  37 ++
 .../arm64/freescale/imx8mn/sys/metrics.json   |  18 +
 .../arch/arm64/freescale/imx8mp/sys/ddrc.json |  37 ++
 .../arm64/freescale/imx8mp/sys/metrics.json   | 466 ++++++++++++++++++
 .../arch/arm64/freescale/imx8mq/sys/ddrc.json |  37 ++
 .../arm64/freescale/imx8mq/sys/metrics.json   |  18 +
 7 files changed, 615 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json

-- 
2.17.1

