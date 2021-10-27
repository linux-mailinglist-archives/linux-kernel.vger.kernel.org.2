Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1AD43C4F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbhJ0IYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:24:38 -0400
Received: from mail-eopbgr30099.outbound.protection.outlook.com ([40.107.3.99]:18259
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236550AbhJ0IYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:24:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V96203VtWsv/LBcVnHJq6erxnyScllEyGDpR1F0cBXoP8R6g1AfvgOH5TCXWtJEulTCH6w08Y+tiVjPfdvoJa4CLGb1/8mOwRj75XzpWERVTYMym6hm0i1fc1G5cnATA9fSkYPprm4i2gZxgTCXPIBmbEQktEm8XyRYELL060FrdTTW3qvCSM7scu3xSOpBaexZkzVE3/HjoRssD5UZk4Z+ZmDWE1WGj2z9oQw0dZGuLQAvvpJuqxjaK4QbdrNNJEcwWXcIopLoVdb6b2wITAgblwEwyXnC/4SCHkZVM4sTetv4K6Z7D3pm3Eku9NR86khJlVFypdSdLpKhXltQ9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pKhc/xzfQQ0BQI6V7txRD6Uo9lZC0eHiHYmOemoeWQ=;
 b=BXmMArj+j6yl+DtQpQ4+ZqgxytW9aipvEFlqobSDHcvFwGI8q/f+J3JwK3LLekIyy6yxVT/xs2J32QNqFFDUwbtFLAI1f1xCfqjsA83pswclos4Tnt9cpzQeK1QCjjVpzc/kespe5ctWW8GKLZ5RS3yoA3/fvkPuGwK35fSWL6/GNH84Ggv3Gt6iHnyDGFdF9Fe+jEkEZstJLeAZGfG4FMOiwwLeY8eoHhWmRN+1AZSa/91LZS46Kysng2iZ8HHhaowsPRhA8t1lXe0BwTzuMYBA2aE2KGolWfto18CWjkWcADV95Llxnil4HoFKgAciXimYi8ZBAGZq/nQUaB1nFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pKhc/xzfQQ0BQI6V7txRD6Uo9lZC0eHiHYmOemoeWQ=;
 b=cUTnyr0RhGdbm4rvxBim3Ja9rt+sRINpb/yGgsYPSneLIrRjbATh/fEMJYLE3pJEoEtTOCCVaziSX4XXp0EMpv5WLiS3M6Yabn/nMg9C0apCqNANrS+t+f3DPyCE/8g/vwoqdR/DTIarBChCOUkHI9Wr+RGMFFA0wyMwfi0fNrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com (2603:10a6:10:1a0::8)
 by DB7PR05MB4345.eurprd05.prod.outlook.com (2603:10a6:5:17::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 08:22:06 +0000
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783]) by DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783%3]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 08:22:06 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     marcel.ziswiler@toradex.com,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: stmpe: Support disabling sub-functions
Date:   Wed, 27 Oct 2021 10:21:55 +0200
Message-Id: <20211027082155.206449-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0064.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::15) To DBAPR05MB7445.eurprd05.prod.outlook.com
 (2603:10a6:10:1a0::8)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (31.10.206.124) by ZR0P278CA0064.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:21::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend Transport; Wed, 27 Oct 2021 08:22:06 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id CBD3310A374D; Wed, 27 Oct 2021 10:22:05 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a09b891f-23fe-4fbf-4bbf-08d99922dd16
X-MS-TrafficTypeDiagnostic: DB7PR05MB4345:
X-Microsoft-Antispam-PRVS: <DB7PR05MB4345768FBB33D0EC3C725FA1E2859@DB7PR05MB4345.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uw29CG5Suth16BkjyOOb3KP4nsVsgjKzQeXOCo8rqZxYynFz5Xeylali1eopwjxrNhbI9noGqH/gbKRHxX4GxHsqJ5bA7dIXVHxxc+PS8Yc1dKH5Yohc1CGwzuf+7cR7JyMAK60i+EPbzdtfCw1ojiQAQGFx/8NXgtSs7O3yhvWCBt7hASnzIyhxNzV+TYCPXp2apRWOX1/23uj9X/pvc1+fjMB1va2mywSav0VeH6ASJ+FL9+dHCEHU5F+3pUMqOKMKPFAqfVeJDNynQy9YXWAqHmy432Ni4ajuDU91+UnT2GBzcJVbb+Kg6MXEaSgWydpe9IRzWfV/5VcWc9zy5DvmY2p8hFjcggtYjnudF83Icd1T9ooasRyYhnzLCI74l+LF3wFx+XIsuaHfxUjEsbmQbQAaNOqwkTaWHmW7JDJJME+3LVHxUMT4FSJuHNsFhwMqYNXTLdoppqlS2xDd55b/ff72IHGx76/tL1r9KL6927EenNr0R5i0Xy698za90rLWnN6830aEo4FVDDTix9R+iulyuyIxVFmguyvpn3XvIu9U2liInc4rhdCujvCOq6UqWBRZMpt57QBaLZcOw6casWUfuHKvrrIrU2Y/NHFrCcEuW5TyBAWeoL3HE+VQP0EHInA2kbrGLtL6wgwiTuoNNWpkK6L2H9nzufKwLN8XASYnspgrEvHXpYucY7fnbsQiDkyr6BWe8+JtK6BEMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR05MB7445.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(346002)(396003)(136003)(366004)(186003)(36756003)(316002)(66946007)(44832011)(6666004)(2906002)(83380400001)(1076003)(8936002)(8676002)(6266002)(86362001)(54906003)(110136005)(42186006)(38100700002)(26005)(52116002)(38350700002)(4326008)(5660300002)(66476007)(66556008)(508600001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n+06FR5eqSibOHlAqVRgROHEvflaFYV98t7L6R2jmRzEgT284yF22t4HtpmF?=
 =?us-ascii?Q?rSN9VxPlhyBoz1wlrktuiPXkSJelpGfKF4dMkUbBv5mDfkuTqW4pKkTDTFPS?=
 =?us-ascii?Q?pyxvj/1d89kgam5gtcA1NSI/PAKWjWIn6uzqdbTgahWOp3pNPZzK8rTWH149?=
 =?us-ascii?Q?tAT6WiNLitZL4woMDVtI3MhHaExtkb5dHNlLp6XCQs945eMSKF40NM9sSzLS?=
 =?us-ascii?Q?f8TqJf2qE4h5u94iu+ClPcUHJ7xEqzrJfQt6EQR/j3+w37bEBO+F8SWej3AB?=
 =?us-ascii?Q?aTRQijzowWGiFqbPRL8DU89IZNorFCp0kVvgE/UFec1YGWwwKDx2DY0ePvvT?=
 =?us-ascii?Q?lmtT/PbXgfLBBFLVh+54nG8THP17kNz49nCoglQt6gDQ0wlpsALgzgpPlI5G?=
 =?us-ascii?Q?OrBXyik2+qce/3n+EReAjKKEwmkKiYaB0PvnBNN97tViG8r06+WKECUercrw?=
 =?us-ascii?Q?U5KOJXJoGU53AQpHg42OIrZ2rUpIXLabjmFYukkP1vrpjElkI/YlSVyxdsMN?=
 =?us-ascii?Q?yWaeFemsldI7FheyY9TdOF7YdTWoVYLWB+PHevISaoyBpuHGNB6CKyqMpYc+?=
 =?us-ascii?Q?QD6aYMEatPsf4IMPjk6H4SqG1ygT+Wz32B3F0U95yJ2ZieIg0/GxVkHMzaPq?=
 =?us-ascii?Q?VDUytV0lFYqK/z99VC7ZfmI+ytqyr004odxKCsPLeJ7LHhKqA6wOd8q8KNEv?=
 =?us-ascii?Q?GxOneyElKvm85bGoyEuEzUAZ7Qh7OJlNcWpa/mNxmJILcWgfMRVC36XXGODE?=
 =?us-ascii?Q?83AXyomgbb2Yrag0abMkcrUbpMy8BJBGr10hn4EkoyFmnzxYmYw8zCl5YjNj?=
 =?us-ascii?Q?jiwdhJleEqseyCQ9UEBUEa92/LukU3A/CI3iiVM1QW9EcijCTsyppqX+uB/7?=
 =?us-ascii?Q?xzpOWUEJ26lXNtsEzkeZtDPJR1aU+nTbMCOZ7uJrWo4LMuRsNt7rjTjvgvFO?=
 =?us-ascii?Q?GUmUWWh27QQity7OSN3X2Yo2oq+IufQcyllNGcVYzN4ZPZUZkiDXY3RTIk5L?=
 =?us-ascii?Q?l8Eqs3oGOkIMeeNkEgKpaYu7mM5Z1XEneP5aR/tLHlXv2Qaeke1Qw6KP9+Zs?=
 =?us-ascii?Q?K4NpAIj+ndcOWQsMIVPfJsytX+AhEDXdw9CKoiXgEFvaZZe0TsNGiBGwYRr7?=
 =?us-ascii?Q?haLmkzvoJx4+CtEieHljvzSr5VhSsZ7MzY+BySmgYAIHYSGQn6VbrG8hQdFq?=
 =?us-ascii?Q?ZgtOMbE/KVvTLfuvbgRJ1GAlfetdnXuQ/7yizuiZzJugVVirwjF0pon08QMk?=
 =?us-ascii?Q?TYiL9d3U9tC6UnQF/Ht4fVyH2NWTopSwcqzyAraaF5Z0tbFZYttM5QzFHrkL?=
 =?us-ascii?Q?O1PhfMCSxdlYIbc26BQpLm5VvtYWmJJMzuMkcQSjeXnFiaZ5jDvtAjz9MUhS?=
 =?us-ascii?Q?pmSmtKfZ5NkOpE5scpW7oH33usoJbqIjPnD+0WngdbKyjW1LnkU8YYUcgmcC?=
 =?us-ascii?Q?vxofP05YwX6dpgKZ+pU6WZgjY78O1a+vCd/ZGrrtKIFBBb5knK7cJGr46u19?=
 =?us-ascii?Q?m4mGtnuAJdUqBLNEHMTf0NO+Le9Zeoj5mFctfDDIfHq+uZ6NfO0JdDJjJkDr?=
 =?us-ascii?Q?RhCBceDnz+3K5x+xuyQBnMt8e3uWNMDLFDOhf1yO7nvZwvkcTC61kUmoH0Qt?=
 =?us-ascii?Q?0aqd9puo3cQ+06Vk6hFgIBCcCKvZ0aFjmHqI5hZMzi9pTprihdVy673opmqL?=
 =?us-ascii?Q?4SA7yW8UyyU4XZNSJUrd81je2OE=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09b891f-23fe-4fbf-4bbf-08d99922dd16
X-MS-Exchange-CrossTenant-AuthSource: DBAPR05MB7445.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 08:22:06.7665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1lCxGWaBxLrOmVDFGV0LHvQiunyxC3ufUmNaMQ4eLnDLpZcJj3ZvjNUcO5YpPaDGKMa2GuSwT2XgNkZshSBCPW1aSBLwDzdEmW60iXewc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4345
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Add support of sub-functions disabling. It allows one to define
an stmpe sub-function device in devicetree, but keep it disabled.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
Hello,
the main reason for this patch is to allow enabling/disabling sub-fuctions
using DTS overlay to enable more flexibility on SoM/Carrier boards
combinations.
---
 drivers/mfd/stmpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index e928df95e316..aeb9ea55f97d 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1361,7 +1361,7 @@ static void stmpe_of_probe(struct stmpe_platform_data *pdata,
 
 	pdata->autosleep = (pdata->autosleep_timeout) ? true : false;
 
-	for_each_child_of_node(np, child) {
+	for_each_available_child_of_node(np, child) {
 		if (of_node_name_eq(child, "stmpe_gpio")) {
 			pdata->blocks |= STMPE_BLOCK_GPIO;
 		} else if (of_node_name_eq(child, "stmpe_keypad")) {
-- 
2.25.1

