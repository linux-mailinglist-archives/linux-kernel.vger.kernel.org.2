Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F42C42E938
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhJOGsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:48:02 -0400
Received: from mail-eopbgr1300122.outbound.protection.outlook.com ([40.107.130.122]:13727
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229716AbhJOGsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:48:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4FKr1TMXs0p85dwTORXck/PaI/lKhTUz34K4hWRYPKnQHoUg7KAU1oe4AG4ZI5v+l6Y8byZ+m438DAz3DkEQSXEkbRRrEusxD+oyfMg8eBLnir1h4Tybwe72ljn657h24orVG/DHXYf+WZMhUrRpgehasCi9WObUsOGN8YRhdpeRLhEvKlGaegu1yRc4XX+1n7NBXfXmO+6b8b03AjLYHW4Cv7IhUveZBeB2UwEk/kmf8EAphu5fVUGl9BaK2A3S9x9GOChfRiUyzJk0LKjAkG5LK/rURjJjkNo8TFZPkyLeekSy7rUeDttwHWTJoLawcrYScLQ9pcFmESqG8BgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8tUOf7PMAM47UFFx8D+aNuLAVPp3Hz9l+g+D//dFgU=;
 b=lzQOImPP2PWg0CMRVs6pTUlH2/Yw5X5Z4xKx7iTIc8hQHwG9lPwjoiissMU5m5gPBQAUaFcGv61xAiFdVJpQ56/89/Noj9eivhlH0DfTK0XszUAhkWdLcPOi+jlpiAE5j5ckYMgqZQPwNQmFbfUa+QmvzR48q5/fdkhVKUWp+tsb40S+Y3r4vnmN2jWT807dE/1xUW3SRyIOLsvF4i5sPH3WKHf2m/OQA7yS6d8lJCiIi53Z26pGku5FR3DSTYUWeD1MtJjoXHF48bZDvApjigz+f3dCmsGMZlX3jeoP0yguUCH8Kkehl3TDNyvpxErnWCt+0T44leDjjfvXpVCgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8tUOf7PMAM47UFFx8D+aNuLAVPp3Hz9l+g+D//dFgU=;
 b=qFzboV/ciCChndDkE8tz5Anx/FRbNE3Yt9rR2pCeCli+aL/NmIjcyy0QOeAGLOZ3DEeMYdfkuZ3BTaJbbbQtxHwz8Tmkpf2PIoA7A6WNZRIFgBJ2DtOOmnDeNbKVeXyNdIdbfX0jbXDrWCnQGhFy+1793bv2AJMtetM/wZ0mUZE=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3147.apcprd06.prod.outlook.com (2603:1096:100:33::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 06:45:51 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 06:45:51 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mike.looijmans@topic.nl, Qing Wang <wangqing@vivo.com>
Subject: [PATCH RESEND] clk-si5341: replace snprintf in show functions with sysfs_emit
Date:   Thu, 14 Oct 2021 23:45:28 -0700
Message-Id: <1634280331-4150-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:202:2e::19) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR06CA0007.apcprd06.prod.outlook.com (2603:1096:202:2e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.17 via Frontend Transport; Fri, 15 Oct 2021 06:45:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 117eae58-8dbe-4783-21c7-08d98fa76dad
X-MS-TrafficTypeDiagnostic: SL2PR06MB3147:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3147BF7749B4A82309E71A5EBDB99@SL2PR06MB3147.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOsh3OI+w/3fCSQB5pGcnimo95aWcDBn8PvI6DotXRXNV4AL8qzj8vQUlSOK9hKSi3ocxV+zeiz9KxJBmWLyKjK/eZFozjl5eDyZOGqB7qK1CUFh3mY6tbvsGAnzYqgeX+UFDbhnyUeFpQBVR5+TBZUGYn2aiDq6v+WVwK9PrfOF9gszFuSbepSMqi2CuyY5OKcyQHr01lZQNf3Ub4yT2n4jNWy+6ajCwV/8tn/38lhFh0OOh/lwPvPRhqCLtjrmi0xKeMAX+20rM5hkGyKxfNHVm+Eh/j5BmwZZtRgAQV5n+pAnxb1m72qXQdcgAI3p9LDEf+CA99nuGqg0GP0r4oiYUjuGeYsJZhAAxCk/8RfFidg+sMkc0pTLhmyaDXJpYabqWt1xiAYd/58tqz1HM98Ds+64fbu1AvDnfsUtLeqWW7li1/Z80K9HxCOtJDWg/Er09m/3tCHIsHwZmDb66J89u76kiZ4uwDpaWkZfDTDgHilSnJl45pBj4daJhrp6zrSQlrg9au1kEs2bzKqBFyPwSVK82fXBdCZsZ8HH0tb3zT2ykQi1gDOqZJpQax078/LiykktL5TezvDr9qBvhOx+yd2Ry2RR796IAGR1cULlhRZPUAiOUCpoUhEDd8l8r5DdteMQEFoyOM4QnzywEkYmyhUjaercRYFv+WZYBdzvJVOiUS8DnJaXW7LOK8MzgrPInuknrwuaGRkYiBjzzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(83380400001)(186003)(107886003)(6666004)(4326008)(508600001)(52116002)(8676002)(26005)(36756003)(6506007)(2906002)(316002)(86362001)(66556008)(8936002)(5660300002)(110136005)(956004)(2616005)(38350700002)(66946007)(6486002)(38100700002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BEoCswIkWowP1ERSrIjtVH1tKu4+4KWTH3MlUuOnSeFSEocVodmmV5Gm3m9z?=
 =?us-ascii?Q?BZ0vkhmmdZ1yVaHLYtRuLFUme4ohT/6kki7kESGBZgbTNkwEOEHZ5TTNCzpd?=
 =?us-ascii?Q?GCPZamUig15SHJStYcAxiOfdpcF+2SN8nJUMsa92U5QKzdnghduPZvvUPqjg?=
 =?us-ascii?Q?5Ap+vZOfF3N+8BbLC23l0KzMJyMOZAafQ/T0adEeEFE3MTOUrtUuLsKib3pk?=
 =?us-ascii?Q?X1AriKgfiVcuFzFfyzkrzP7C2CPvQQt5UE9ubbfmYiWn4/qugGZCRHwMg+gV?=
 =?us-ascii?Q?pdZm/6uV61ePeGAW3eE9Jz4lZD4QCeQt39FBEP2r2LT+NEViwNpgee2m+3yD?=
 =?us-ascii?Q?rDTq7ZBCpadWYHyu/ZCBQejta3h6oCz2fUO/jMYeu//ZJpYUfBdEGCcTdDiz?=
 =?us-ascii?Q?qeG87d/+a0OlVqBfjrax/7uS54wOx5GX4OAlZd1oEMNzyfDWshZ3pU0HcTrj?=
 =?us-ascii?Q?I2Jutwv8uMwujqD57ElfLqZEepNLmvuom8hpDNkH60d1XDUibx6wUDXCszjw?=
 =?us-ascii?Q?g0oGhdSqT78PXItU61cqWN6Tqn6zb+jentDfB72faFvptD2zIhxJlagAsydi?=
 =?us-ascii?Q?VFT0LCN6gfuAc/JhDWu58dSM0QUG+D9x6g7KPCk9+qI8YxtPZiaT6mf4Ucje?=
 =?us-ascii?Q?GJnWToikh1MooI513TMpuNkAZao9wxPzEfnTzrH3G44lfQlkIDZ+T0nvEKXE?=
 =?us-ascii?Q?nOowayZN2GYHR5NdRmMoJosh2jXrMVGcBS9JyklpDInNizor2aSC3+d8ejEn?=
 =?us-ascii?Q?P+XwgOQhSG3GepE2x02jreH5umCZjH8reehcP07bcf3RNq7ykCPfZPmLQsZb?=
 =?us-ascii?Q?dnMJ8KSXh7DLyfX88066dBgXQU40EYxnqT6Mnv6LA7eXsOigoDmQAxm20Z1v?=
 =?us-ascii?Q?qDOv8tOEpjk1VlKMpjDcGNARsbSLEQn9NpJ1ygINlOg6VCLbvuMilR0mlJdF?=
 =?us-ascii?Q?wuTLPlO/7uBvwFIrmDCkVfqhRw8yALTqmQ8iO9PS5mf28tLOolnQmNzoQUfn?=
 =?us-ascii?Q?PZr+nPZJYeUJ2cJwdvplFc5F9Jy0jnhn2uIbvg0mWwnjKrpEDbok9wOe+xqF?=
 =?us-ascii?Q?uCowKXuJ6oIsh/MG3lg6XdOOEnB1I8tUDkQacwnqFCBGybyqPl/RqhWneAWx?=
 =?us-ascii?Q?PKYYt0HeI4zgpHK7i7fFwsxoWF+/NTX329nzHRve/JvUcg57txeIPd+IBbpF?=
 =?us-ascii?Q?VZTNDBbU4PoDj3Qno8P4EhayRz8AIGDFFY+Lgot79U//GDVWDEPOQTxWtEef?=
 =?us-ascii?Q?8WPIjgslo9RxyPclPjg1eC69B1Nkp/3dxrFzoR2H6sP9IBOSC+vP7o7UIxvk?=
 =?us-ascii?Q?H9CbZC4GJO8kOQH2rwi7SQKl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117eae58-8dbe-4783-21c7-08d98fa76dad
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:45:51.4207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f15roTlWwAx/ZS1oEKJi88eaSYXjJfvvKxaoe+9p7dLxOI6heCCA9A3mhjkCmbA5fF7Vicb+r6EXm6LHZ321iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the following coccicheck warning:
drivers/clk/clk-si5341.c:1471: WARNING: use scnprintf or sprintf.
drivers/clk/clk-si5341.c:1486: WARNING: use scnprintf or sprintf.
drivers/clk/clk-si5341.c:1501: WARNING: use scnprintf or sprintf.
drivers/clk/clk-si5341.c:1516: WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/clk/clk-si5341.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 57ae183..5d62ddb 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1468,7 +1468,7 @@ static ssize_t input_present_show(struct device *dev,
 	if (res < 0)
 		return res;
 	res = !(status & SI5341_STATUS_LOSREF);
-	return snprintf(buf, PAGE_SIZE, "%d\n", res);
+	return sysfs_emit(buf, "%d\n", res);
 }
 static DEVICE_ATTR_RO(input_present);
 
@@ -1483,7 +1483,7 @@ static ssize_t input_present_sticky_show(struct device *dev,
 	if (res < 0)
 		return res;
 	res = !(status & SI5341_STATUS_LOSREF);
-	return snprintf(buf, PAGE_SIZE, "%d\n", res);
+	return sysfs_emit(buf, "%d\n", res);
 }
 static DEVICE_ATTR_RO(input_present_sticky);
 
@@ -1498,7 +1498,7 @@ static ssize_t pll_locked_show(struct device *dev,
 	if (res < 0)
 		return res;
 	res = !(status & SI5341_STATUS_LOL);
-	return snprintf(buf, PAGE_SIZE, "%d\n", res);
+	return sysfs_emit(buf, "%d\n", res);
 }
 static DEVICE_ATTR_RO(pll_locked);
 
@@ -1513,7 +1513,7 @@ static ssize_t pll_locked_sticky_show(struct device *dev,
 	if (res < 0)
 		return res;
 	res = !(status & SI5341_STATUS_LOL);
-	return snprintf(buf, PAGE_SIZE, "%d\n", res);
+	return sysfs_emit(buf, "%d\n", res);
 }
 static DEVICE_ATTR_RO(pll_locked_sticky);
 
-- 
2.7.4

