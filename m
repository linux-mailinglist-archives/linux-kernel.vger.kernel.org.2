Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE43C9A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbhGOI0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:26:02 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:53636
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240720AbhGOI0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:26:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeoR5uXiSAoyvWoIYtWhwDQswC+++18vb4ulgyIEF9EBih7HUWzrmLgdyOVBKnwv3l0iPzMrRWuW7GEROY7Fh6FkUqktDxy2tHSRnL1AoIdbQrAXw9fFE1TsnC7Xub4OJnn3nhoHGFDEliXzqqBKnK8VrD3yrfQQ+3R11/EL6HS2xu2RKB4U/K3fE3lL0V2FqMklera8H/G+eafY/3TPqJTjC6I7GN8/y/q2xA8p35+cr8+YJuJ0tRddxSDr+1NPGXG7PcBb/AF3RBKkYq6msWhbDNwIHE5jM6KbSiwZ5YwXzqM6UMGrb9wfbjLNwrYxckhf8DexuLTVIvTEoO3jSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHnPHSEOftskGT2PHwMa84tqycW4h7ta8y/XmG40bsc=;
 b=guhbppNe4Vmtbth9HxReozqxFaf9iysd4cXOff0WX9syRGZCaqOxreshlGSYS/1Yp3jzolkrCJBsnSTmKj3VdoRKBdUX6O3Ftj1k3PkS2BOLFOGYI0/LdcNeO1PYgCnjnVHHfAcUSIf8OT2aGwn1J3NnYh+KRyjmhX0YcdbfiW63mV5VdbyyfQeafIIwZ0gQQI0g226ct/zhlU9W5rVkfnN1jHProX22QX5SYfgRdPGCvg+loqkLPv0ybqzbNkaL3p+T12TGzkDg/atzsijNwQzq5RaLpMwJo2UdE1mOWR/S+Tqt2NNVBlPRdkMQzixQWVZUr5dPcGqbrX6LY5NjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHnPHSEOftskGT2PHwMa84tqycW4h7ta8y/XmG40bsc=;
 b=KucRFbwUN2pDhDN0HzmiBfQmNc3TZ+bLGF9dp8CXab+uzVu2uVhruoFljq75F/2Z968lF355kl37c0i8sLAtFYxTUY33RSwEuvTkYzqQJZQ/a3mdBLFy7XhEXHLKFI0JNP3LTvPXCCefchQh2l5r2bikB8mCNV8ng0LsR3uBU3M=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR04MB4167.eurprd04.prod.outlook.com (2603:10a6:209:4e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 08:23:06 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 08:23:06 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, vitor.soares@synopsys.com,
        boris.brezillon@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiaoning.wang@nxp.com
Subject: [PATCH 2/4] i3c: master: svc: fix atomic issue
Date:   Thu, 15 Jul 2021 16:24:11 +0800
Message-Id: <20210715082413.3042149-3-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715082413.3042149-1-xiaoning.wang@nxp.com>
References: <20210715082413.3042149-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0142.apcprd03.prod.outlook.com
 (2603:1096:4:c8::15) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR03CA0142.apcprd03.prod.outlook.com (2603:1096:4:c8::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend Transport; Thu, 15 Jul 2021 08:23:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a8ac774-16df-4628-60e6-08d94769c58d
X-MS-TrafficTypeDiagnostic: AM6PR04MB4167:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4167EF7A0DFDAAEBB4DA2300F3129@AM6PR04MB4167.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ioLkygGekKNs7lZlL+YqXR6PQ5BqBbX3gCA+5VpJMy93ODTvopmseIg0qYnUKND4nAy9H8MHdqkPODgN6vHJCerlIEawKBMJFmo04RACh3QztcBwtgw5gRoZS5SQf6vbsNAR8Y0Nw1QF/yn/CJHNT/6VnjoSWJhtQVMBVWgX5hPUobHYMbavigwMovJKaQI1ZexMjrcvF8dxhDXUeu3KxtZSTI8Sogq6eStsW+9JOpmSam+Z5Zsd+GVJ708PRpRORpmqrv00ciLCs5czmiKnpuC4Dc8n+wKbKfXlguTztshVqHL32zkfqQgWkl07R2/wp4WqFN7DMX2en7eLvWp8whjpRnrlJFC/1RwuX7xCRH9U6iv5+hNrOsl/DK3FJ8pZIoyPOoMz59sSGW6hlYYsStU71I6lVCoMY4dbwTAbeHYWjsnZmP/CiK6vzCBZAlydI8BO26P0Op2np0y1xIBZqyBgrx9EUDM7T+TGcq/7YqmqoXgbknoIic58Xfbh50g8Jt5llaRyM0DodeiRDPLM1c+judaG45Yx9179EQDFkwEoEikQXmud3pXsuV09U3+WNix3y15R8imjXCHm+3IxbzDUFgCFbvkkc/gRMHAdxXfj+2elgwVtX5syVvy6rbvHwo9F6IkZrXt4NZJEd8lzl28q8GrRWGppUg8iy4XhyuatQsi28XhwUDY2aQ1GPSzK9itpEo5wMnz+R+OUgxhhgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(6512007)(478600001)(4326008)(83380400001)(8676002)(6666004)(8936002)(66946007)(86362001)(316002)(36756003)(2906002)(2616005)(52116002)(1076003)(956004)(5660300002)(38350700002)(6506007)(38100700002)(66476007)(186003)(26005)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ISntSBi9HSaZuObHZmBXWxgMiAtRL+bplMAMwEO3WPVtzzZhbLHeGBiWV+lv?=
 =?us-ascii?Q?DNLm1oDzWiu0HevBonuch6esdmEvR0i1n0CcW31CxJ2hsRc9ZhRXW7rAu+wE?=
 =?us-ascii?Q?j7dcuDBC/ts6lwfIADqRntB+ULOkSXd+fjP9ldVMOrzQlpsFtH6dhvWin0UU?=
 =?us-ascii?Q?uRcdCq5nXII41h52Y9UhLVXyTxsgFYeEVmd79Kbp++8hVAYcu5bRRaDnEfmi?=
 =?us-ascii?Q?x9sW/AJ6UHxdYmscJit3Dd19rMSgc1qrEAdQsX6sk99nNHNGpdjw3cM/QBdx?=
 =?us-ascii?Q?ndi11y5Mv1w5MIMZTk67ljq5S3X/II4o0IFtxnaTqHqnY1Vvgvw6IvrSErqb?=
 =?us-ascii?Q?kIN+wxZYoP+F2sY25h+aUNs1B9yGBjozvhNWxmrqT6eFJ85wIhkQvyBPRbqj?=
 =?us-ascii?Q?ak6YDRmDYQ3wKSdlekyQ2XdwdIqnbWeMvrlApzc46qPmdPZvVvD4pzXtA83N?=
 =?us-ascii?Q?l1S/1bnjzYpB1Kf8AmzvKKazQ0j3ImLK9BTMNH7bVV0rcTYAnfSskPBW63cV?=
 =?us-ascii?Q?wwUjBg0tu/NjxbGUFQQAZqpCTqic9kpdLFlt2RicNwwtTLrWv4zgyK9T3Hex?=
 =?us-ascii?Q?iryAVpVcMjIWyKyMG1for+GYhNhFim8hZOYXLz+f9bXCjUgVpT56pGZVewpA?=
 =?us-ascii?Q?u7QcWdY30FdbXsZk+g/W3W26KFjRcPqdTNQWRTmSy8eJ6mHzJUI/jHrpzjer?=
 =?us-ascii?Q?o4/Ww9FHl4YGIHgnMAgI4hU5VYaFDEnme9HoZGE8d7Vr6syrtxkayNV0kmon?=
 =?us-ascii?Q?Rks5kWHebsSLAUPhdCVxkGWyKKbtThpF0eXlcspZORC/sR86Lsv9+1fnKwyy?=
 =?us-ascii?Q?VG1BvDeKKvd/W6luNhmCcvh5YyimrZv/f+ScLQYpJBzC7nHYj3JRrU8S5TLh?=
 =?us-ascii?Q?BxQ+rSc+/kKD2j9YB16SvvssNSGK2d0E7gOsBAhS1LdnX6huYfQbfxHJMWtg?=
 =?us-ascii?Q?+8I+boZRS1TkclE3zPf6RYEk647CU04WnSWH7iDYIdBxMQITfev/tHvuJvDV?=
 =?us-ascii?Q?p+VQvRmx+dLHF58HxpbBnYBNznYensueZrnsgEea45XmNxx7J6hthIF36NYG?=
 =?us-ascii?Q?EBCORHZlu5kCNGdy2WjCSXNvWo2HE3nyhYrgeAf8HJqfrmNYkF3FVkEyxMsP?=
 =?us-ascii?Q?uJ4RtNomxBfBA732EXzA28MdIoZcsgwlfcuZID40t4SRaZKSDlYJFWt/VfrZ?=
 =?us-ascii?Q?mkyOuUXKplPNtZ1d/lyK4Kq262nRFVItW+8f+hxikVD0RjzwEPdKy5RppHCr?=
 =?us-ascii?Q?gv0w17MytggykjL0ryPKbJCDvQ3ZG00yH/3NF2mNNs9pqbxf5Sk7Xbojdw/m?=
 =?us-ascii?Q?JAjsgYOAQeWTtJmjmNS3KVdy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8ac774-16df-4628-60e6-08d94769c58d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 08:23:06.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0ZaNhEb8TipG/ewaiov6VIlrwN4HqtuHkEsKMaW0fzog/U3AT1HPEPkrg43BeTuWgCv4maczhQ3ilGiGE9Bag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4167
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_daa_locked() function is in a spin lock environment, use
readl_poll_timeout_atomic() to replace the origin
readl_poll_timeout().

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index c25a372f6820..9d80435638ea 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -656,7 +656,7 @@ static int svc_i3c_master_readb(struct svc_i3c_master *master, u8 *dst,
 	u32 reg;
 
 	for (i = 0; i < len; i++) {
-		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
+		ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
 					 SVC_I3C_MSTATUS_RXPEND(reg), 0, 1000);
 		if (ret)
 			return ret;
@@ -687,7 +687,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 		 * Either one slave will send its ID, or the assignment process
 		 * is done.
 		 */
-		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
+		ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
 					 SVC_I3C_MSTATUS_RXPEND(reg) |
 					 SVC_I3C_MSTATUS_MCTRLDONE(reg),
 					 1, 1000);
@@ -744,7 +744,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 		}
 
 		/* Wait for the slave to be ready to receive its address */
-		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
+		ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
 					 SVC_I3C_MSTATUS_MCTRLDONE(reg) &&
 					 SVC_I3C_MSTATUS_STATE_DAA(reg) &&
 					 SVC_I3C_MSTATUS_BETWEEN(reg),
-- 
2.25.1

