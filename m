Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7715342B36B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbhJMD23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:28:29 -0400
Received: from mail-eopbgr1320112.outbound.protection.outlook.com ([40.107.132.112]:24356
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237237AbhJMD2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:28:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4xLyAOotCmT3hzQBukmlwddv7s9S07kUjp4zqbdbIhiNYqC5hcauBoQLA4nDM9GReXYKbcoJHj5b1dg0RxduP7TOyQ0XKjsSn4fVmJ4EhLnktZv/1KCY9PdtrXAlaAyySxVHm6xT6cpUcsYjjrZFY6ZVZSAAPmzScdoF3EtT/A87Kp/0iZ87pvXSX+AU+ARLnW481WjpIDqxpvIaCPtAdW6E2ft/h53gM/MOhdNlHWjon926Spe0r60p25F170kkqX4u8WC0OXBMSG3yfdTKc9DKlWzALhlqnaWYD0AlOke55Cq6CxOMEzc/ebGU7BiSthQSAW3Pyf+3T/Rl/fsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y33RzUkEsSJ6lTpW/sn284iry3NaB8SYajL/ZWkBa7M=;
 b=jk8z/p8aG6YhOWl0ZCqOIJxhpIVHOYvVGw+97NdrPcYfMYgp26M8j7omqY2rmyeS8O0xVPkuC7TN9HYg4y229ynQqml5mcIFwyaPIo+zfa72cTTCCa/iDaz70DBrXyke40lkqcXYxzHfEkfj0O63QM1PzVsxXezyuoCtBXf0vJaP4Z8l+sG4xXAkYBG/M+bFv07Z5x4cMaU70Nrt1ivH9wAIEj3Mq2XIVgTDrCaZAKtsrNwBIGC4Qyb1KQgYwc8K3LvPKmjQnU6VhqbwHCVenMKt5D0K2vlyiMS95M6DmBEKSH3Iw9EaJZGU035DY+WXCJ/bPGOA8wQE/YdFFSsQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y33RzUkEsSJ6lTpW/sn284iry3NaB8SYajL/ZWkBa7M=;
 b=RYO+S+TWggV2nMNumXfkM5205i8Iqi7m6scX1kfFV/2XZfSyK4esW6OAYK0Yn1efav79PKcygp0/3w80J9BfqcryTO/2G8aQyp1P2YGOIjS5Xx88l+2OSEBuVim5H5Ufm0Za2XuJtuyB330ApHKr1KuPg2XmwmfvXykUmS/iNzQ=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3243.apcprd06.prod.outlook.com (2603:1096:100:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 03:26:20 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 03:26:20 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] clk-si5341: replace snprintf in show functions with sysfs_emit
Date:   Tue, 12 Oct 2021 20:26:14 -0700
Message-Id: <1634095574-4076-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0027.apcprd03.prod.outlook.com
 (2603:1096:203:c9::14) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HKAPR03CA0027.apcprd03.prod.outlook.com (2603:1096:203:c9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.6 via Frontend Transport; Wed, 13 Oct 2021 03:26:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9659f566-07f5-4b97-1243-08d98df939cb
X-MS-TrafficTypeDiagnostic: SL2PR06MB3243:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB32435F93436F77B65FA9712DBDB79@SL2PR06MB3243.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twjS3ZkOMdRj6tYYzOoHvL69NOndp94jW+NtsPd0/v/iU6DM47HzSEXcotFqPSLq04FbqsCqeH7fXfUsnXXTvaxMu4vmzrCGXPhDIyYaGTgTwSxU/NC+ZYvWcMPLIIToopOQfRBtGpcP4pzBGqp0kG0CVGw2BzcqgKM/xnl7YnrTfqqtCZiI/WszgWnRwP72650iQ+e0pryVNwlp33pyW5jTxCA6idqiSoiBQrSvzDfw38kIgDdNNiZbGMwShBg5Yrl0dQTtCeGIc1mzg5pKi6vbOdGtIdzRjsUQnZibgXkOXRcx0fQSga/1p7yNQ0QS8ED9nVLgep9wiLiTeFqDoWlOi4Zd36/eynHRXuRGIVqVu/9MKwfv0WNlLBAd7LzG1xe7hfZVD8C5UZ2S/9h1rX1rifOUJfwnSRNR9P1oTNdKcUNMKS9Son2qqa9woLX8UexufIBlKaZV3Td9HhKwslANDd9NnINKvdAsJRQn74lan9d6DfI99Mx6Na+tsnozFoJyyoVoyNpoaZagB8uK2gPyIzybe7admUKJ1aNrBwWwvciIq/chm1EMcxEX5agY4Zd5QZ0EVqAF/ZqD8s703pLAaXVcuOATERJ3ajUz/kw/f99zNIxVJFFaQ4JozUT44OxLDmavA5pwROTY7PhvKWBMWTayWR5pq2baZZOLcY/n38Y3uWHCMgiU8i3AYMuHvy05DDoQsm5Gv81SvVN1qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2906002)(26005)(6512007)(4326008)(66946007)(8676002)(36756003)(66476007)(83380400001)(38100700002)(6666004)(66556008)(38350700002)(107886003)(316002)(52116002)(186003)(8936002)(6486002)(5660300002)(6506007)(110136005)(956004)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qUzeuwWyRjQiILFEaeW6oCs+lX0GQnSeHiDKhvzoo9BUESeqiPQDyMOduQaQ?=
 =?us-ascii?Q?/fh898M7m0XJTvfE5BL8Eu43mKBajCiSRv36guvX1wJ2ioK6Pp9pIb/DHfAK?=
 =?us-ascii?Q?9RAnrA6wnpkYjUaEA2aaS/g+USgdOP/uuW+B8Ci9xZb3YOataaJI9Yo0O4GM?=
 =?us-ascii?Q?/+L15fLnNCP8trHo5ibpbp0kAp26nuVAx1A+nmU2Rih31chHFWN3/AGwLBGc?=
 =?us-ascii?Q?3QlgOSaFUJ6NdLg2ftFYthAvBDp7k8WypyGORsmJzjrel+X/HwLlSq90Tjp3?=
 =?us-ascii?Q?cc3fhhhB3l9bjc19N//rFhQTTTgcsF4XAoE4k7KU4u2X+amLZUR0zNttXPWG?=
 =?us-ascii?Q?TILg/m1pTkE1zDLynKvFEAO2e+5W8CcZ1t+hldtnqyU+V+IsgajYFKqV+oxY?=
 =?us-ascii?Q?v5T2R+3AWcPMJue4CYYNA3HHs3MrKfRGl3v6e06ibbjcVGZiHsWD602BbBmw?=
 =?us-ascii?Q?txJnHqCaCzCisxY9duzBcj4kKDgdWJY7f3LBsEWiQyNVFk1LPVWXnV5KCEpv?=
 =?us-ascii?Q?CbDT9YmzYSH7JDE6ujwZkSZmbUHH3msSMrS10cm438FpJkj7doLO01kd1r6l?=
 =?us-ascii?Q?e+SKqWIsxYmmWPN1QqXbmz8SO0Eu1aZYLHp+M+fNO+FTrwfVyO/s8PlgmoCD?=
 =?us-ascii?Q?RmRl8P28Df5qDeVELZbt2CJt0kYlPUvZwSKlf/ntQBLKDnZ5e15e+zOYOE2Q?=
 =?us-ascii?Q?TfbeFaJRfnApvtW0ajYcddI0AdwUEjKM3NDxWvUdlqvGDYN9WhBQCKyvKhHM?=
 =?us-ascii?Q?Oz0eBERHscnA0Ok3Yub+CGT8F5wi8XD+Tg7MhYEiQblZjsCb9EXfijC5OHlM?=
 =?us-ascii?Q?mxb10vqcIX0fQE4GFQRthoR85ZQAWt0KrwdgKTwr43w/fpDM6Lk5c19CCWbt?=
 =?us-ascii?Q?oGdcdfm88l4YhBmGjzW5fB//lB5aC7oXx29wjhxJG22sU6em2MTMkzIVXjuO?=
 =?us-ascii?Q?vadQihYWYE8C7vJG1yiAecBYjsLbpvUwhrXz8mASOQJIezudmrGPVre5HUYl?=
 =?us-ascii?Q?AsS858w7LQ/aEdE1oH+hDqrzTzoB3UDtkl3KD5sVycPaNsJ7bW8QXQWwI6uP?=
 =?us-ascii?Q?foetYdtfodQ3cIJck2MFx1Y3D22Yta3DR0aWFqovSIGhNXauil1pkGcIecwR?=
 =?us-ascii?Q?c4NP4o2rTV6fn14+ddmUwmWZz6AorKM0avF2ZQzFadGru43+2PETaS4k6WNO?=
 =?us-ascii?Q?j/XYeFwf1+xnKlTGzDFMDqPlOcFAbR4ZHep/5HmxDPbZuIDyxapr3f1u22YJ?=
 =?us-ascii?Q?r+gWVOzF7v64Vc7TutxJxhiWzW7dz1G2UBDVRkOhcc7JyJtwSLJWkJx4efDb?=
 =?us-ascii?Q?jOW8PMNjKLL9ORUfCWW9uI17?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9659f566-07f5-4b97-1243-08d98df939cb
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:26:20.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7rWDp1pUZugsNlrP3YEXeiOROzZW985BdAxKkWyda/VNadHga4zKVcX+KzmjPZrS2AYpY+TtZPavpmtmDEdig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3243
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the following coccicheck warning:
drivers/clk/clk-si5341.c:1471:8-16: WARNING: use scnprintf or sprintf.
drivers/clk/clk-si5341.c:1486:8-16: WARNING: use scnprintf or sprintf.
drivers/clk/clk-si5341.c:1501:8-16: WARNING: use scnprintf or sprintf.
drivers/clk/clk-si5341.c:1516:8-16: WARNING: use scnprintf or sprintf.

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

