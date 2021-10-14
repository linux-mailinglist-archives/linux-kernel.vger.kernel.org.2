Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6647242D559
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 10:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJNIs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 04:48:27 -0400
Received: from mail-eopbgr1310127.outbound.protection.outlook.com ([40.107.131.127]:28083
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229691AbhJNIs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 04:48:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEmgNGtNd7iHFjgIZWlPe3mRZnI8f637SSUGLwp6P3OxzmRsmS4hyiWk0YteX6jY2CCPxJeUboqRG9At0JHFlyEUC7Q97md/004i6CbkIwao6hN/MJ6OPznzoKlwjj0omkHTgmzTJPzcIjozKJ5t7d2XXp24CezO5mvc/Q4ycrtGH+K1o2dxPhttdka8g1xDLoZTePntQHzp6e7mnmhlASQNtpUGcVrGESGdY6S3vRbmwmHvqgu0SQA+AF5s7mRYlvBUYbpjNX2feDnUfKosKkNXdGk921/NTvDTAowIrUhWnl9REfjjO83d+EhkNJ+O4eD4ccMv7VrADga1H9Rr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Io/3TcDs/Sbs8w9yF98e5YfSPEv+p95vs+E9uAeVT0=;
 b=HFHivGYljHPbMIZD/FEsBkbG4xewclqjDCypkDEbam5HtTLtTLChtzIo0ViWqUlGDSeFoR3EtHC81wlAWyXuZyx7ZnpR9Rp699Ws7trpH99xU7s6PgdJaxubA5HR79NA5tYBsts95hvHfCRDMyVHEy6PJ/4zc2cMwrSQaTMeUOEkisi4S2kS/jsbO9A0Hu9gH1bNlnW8RLkgfDBUDjpDq3A9n92NIEJgOSHHSWnzmHoKg65F1odXbaNfgJkANlvC/9G/fd4RWZt21hxtghQs9hjzYIrYm2dm+gCaVTGbBfMRZRxplcZ1GAayupxXUc/ZUyEUd3yqgfpR+1GuxOrIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Io/3TcDs/Sbs8w9yF98e5YfSPEv+p95vs+E9uAeVT0=;
 b=E7e/hhdkQ/4VS8zwltYMzUtO13vqwKZ8CIuU1mHKzuRYywVug/x+Bl3SxT+5fhWMGg9ftXh3ltWp8XH3xP5VgRQbsqCWx8q0QLcokA2iR7FIOKmA36rkMJ9o5zSzNnqMvhq+ETjRWCI5Yu1P7U68+8gJd8XeKOURHNbq9GN99M0=
Authentication-Results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3191.apcprd06.prod.outlook.com (2603:1096:4:6b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Thu, 14 Oct 2021 08:46:16 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 08:46:16 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] ARM: at91: pm: Add of_node_put() before goto
Date:   Thu, 14 Oct 2021 04:45:55 -0400
Message-Id: <20211014084555.21422-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:203:c8::18) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HKAPR03CA0013.apcprd03.prod.outlook.com (2603:1096:203:c8::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.12 via Frontend Transport; Thu, 14 Oct 2021 08:46:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 310c59f3-8912-421a-ef15-08d98eef15c3
X-MS-TrafficTypeDiagnostic: SG2PR06MB3191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR06MB319104AFFDA64DB490C439E8ABB89@SG2PR06MB3191.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xEs8FcfOezic2CGB1xzvA5WRkXxQ4xB2meGjhnvcETIr5Q3GxlzVLhj2j5vNGbLAWV1fOENlEpUjszbLXNe7GJEQeik4iu6nop1eS/2QbYmK4frxwZ/KK5Vz4FyykFYS5G1gWWBQRpEtfmRz/U944L2ainKbT9Z7qM9d2DkCfYsKMK3fB5ykpxdsg0CDaFDvfsLOlvldPZA4YNhNpXrJlkS6B7NT1U5SiQ4vyaES9f5kWbRUd/O0+wu6fOiZrdZllDOoaaeNa0xCWwSCIAwqhlB28Q19FepcdMCoJecNb2PyNFoeLWvjXKYh0qe8Ur+tKYZ9fLqDHEF1TLHAB4cjo4gwcCihRA2TUOm3OBxerHY0sQhbJFTI95cE9+inxCR+hqVftUWBzD6v/0lrxW1zrlv17cYV3epYe+/Cvxe8uSZL4c1OzJ2w1ErFYF3F0e7X1H1HtQ6OTLcjawBtTOXh+HDkl5AsxCBhIdXUz1JkaJxP588sLVJw6XOFB+QT9kTm9C7xMRyoY5qyWU4VRZk1jxwxeYRIammgTqs81GTnlnhUjFz2/S1fRYZtfuRp2pSWRXvaH2sfdU7G/+AW4NZZbvVBlEDVM2lJNJRCJAgTEdUvsQGwxjf3pgAnVqsOwiaCGDg+JnixL+gwlSZOFQ4wqDp47iD7Y5Vk8axogy6Whq9JvKh+aXfhk1MDmMjHEOF5472nvNgzr7nS5XMxuKRKUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(52116002)(66476007)(6666004)(956004)(38100700002)(38350700002)(26005)(2616005)(36756003)(66556008)(5660300002)(508600001)(83380400001)(8676002)(1076003)(2906002)(86362001)(110136005)(4326008)(186003)(8936002)(316002)(6512007)(6486002)(66946007)(4744005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fkfYkW5EGYyzLow+42osp2X/yVq4EJZQJXhuWHZAMoUuWeo7PSmOdX8uadgF?=
 =?us-ascii?Q?f9L/hOkLNErPDmWqL04sk8rrS/ZcVX9V1K6abNQs9bhyRJ+69zadt9Y85eUv?=
 =?us-ascii?Q?31WNNU8jxMzzR20KUFD+KpLZItqAWawbqp252tp70s5LcpYQRm8Z9uTeymr6?=
 =?us-ascii?Q?lpa2rV2n+UMWLKXDN+EPjrjSEv6CrRGa0c7uq3IVQ7/21Odj4QZM/aBbZqLF?=
 =?us-ascii?Q?uO548AhseNn9Hq9IUlXVjgofOX1+BiMGYHlfb2kZ+AknImVLqj9N62o0IWA1?=
 =?us-ascii?Q?W+zA5Vsz7z5mtekRpIruxP2/h6MwA8+eJ/Zl9bbNoGfVVnKHvNX7Ko5fA9jH?=
 =?us-ascii?Q?YOD9gdXKwWU4/06e8Fgtw0szhOoYXSefGcHJxN4A/uIWQDQPK1S4RXfUqpyl?=
 =?us-ascii?Q?ehI7DpoKgQ1xA41WSJDmQhQnrrnpY3/ogSU7Fw9kfjK0iz9ngHLSTwpTjhZM?=
 =?us-ascii?Q?z1Nq/hP8RIf86f2+7e2Yg64yD8gmKXkf6cVdSDzQm/KobO9BlT/K0NLwKcOb?=
 =?us-ascii?Q?hwL+4Kz7t6wQvEJr32IDS7gp0F8A5JURF8RtuX3Hp6+XyrOnxcGfDmMV0U52?=
 =?us-ascii?Q?aOPdd4WZY502UIYDGNqD8hDHJCF+DUKjX45nmLOJTc+PHuio1dwzMXaDA1oD?=
 =?us-ascii?Q?ZvVQAybxfTM3DkI5dD6mCpwF9ZZ6YIfK4dZVe9dll97QwoVvnsUidvcO8Csn?=
 =?us-ascii?Q?IFzPw1dLj6xocywvtwnH28ZcOfwmkw3LK7r+MGoadivUncMB/hdoZKVyOOw+?=
 =?us-ascii?Q?ti1skkICyNznPl5/SzIpIOsNiy+MduoMgUclXgD5CAZ7ge9G/aHhSjrFx8vm?=
 =?us-ascii?Q?KWbYP85/tmGREjCv6Yx50P+7ZxKLPRiCxkRizbO8ycVQfPIe+hdy0WwFpxBW?=
 =?us-ascii?Q?imBR9p/sx8XZAp7VrdVR8gYpe4fDfMP9LxunVVdqkzxuNaoN0BhDB8VrZykd?=
 =?us-ascii?Q?qsxWDklu7PyTui9AT2ctVZpk71R55Q8uBiH4pJtmhEeyJGh0Kj5KDoKFaQ4S?=
 =?us-ascii?Q?nFG9SfqV2emG5w6XCkj+AwRYfIK/HRed7yJQEVGqIUNnDxx+uBEAMqqaTl7M?=
 =?us-ascii?Q?Fg+6HpM85AK3rco54eq1lBRZKbBJotWcLeQZX8EjLkQ3LKPWskLGawFwQV/D?=
 =?us-ascii?Q?HS061w/yXs8pMJpPP0wJsSZkOXNZ2+bGLG4JI4BTJ6931lNGFDGIekwwmR3B?=
 =?us-ascii?Q?pzMbd7e+3kGsZCB1Y7MulfUBPvciEKAJ1ubCVHdbyAhvqTffudlx6yo7cb9X?=
 =?us-ascii?Q?TvvTs5csOQuZV0JTkv7tUJ3caU9enDS4X2QsPz2OZtlbT11gd+xycV/6UdJE?=
 =?us-ascii?Q?BK5ze6/+SiTvr9ZEXBbJ2JgW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310c59f3-8912-421a-ef15-08d98eef15c3
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 08:46:16.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DciW2U5nalHCobkpMuSjOOsQ9jaOjqoeJPIGLIzLfTBtzFMvkgEOeAa/9y73zw+/bBWlf7nMAx27Qflr7Uv66g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3191
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./arch/arm/mach-at91/pm.c:643:1-33: WARNING: Function
for_each_matching_node_and_match should have of_node_put() before goto

Early exits from for_each_matching_node_and_match should decrement the
node reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/arm/mach-at91/pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 8711d6824c1f..dd6f4ce3f766 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -645,6 +645,7 @@ static __init int at91_dt_ramc(bool phy_mandatory)
 		if (!soc_pm.data.ramc[idx]) {
 			pr_err("unable to map ramc[%d] cpu registers\n", idx);
 			ret = -ENOMEM;
+			of_node_put(np);
 			goto unmap_ramc;
 		}
 
@@ -670,6 +671,7 @@ static __init int at91_dt_ramc(bool phy_mandatory)
 		if (!soc_pm.data.ramc_phy) {
 			pr_err("unable to map ramc phy cpu registers\n");
 			ret = -ENOMEM;
+			of_node_put(np);
 			goto unmap_ramc;
 		}
 	}
-- 
2.20.1

