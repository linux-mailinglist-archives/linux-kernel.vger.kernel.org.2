Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5823E4027
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhHIGgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:36:38 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:22658
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233351AbhHIGgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:36:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rc/9vsmr1rLPxgI5PZNLBkNdEpYzk6ugqgi5uzgi5HahQF5z8Bw2x6NbdtKtkOIZj+2d/qY+zwkznqsVS3y5Q6mPT8o4N6wqfCrVjHjjZbCl5f1v/GNSom4h2nNTDC2/5Ul4mOrjkGYSl2Ehc/73qOQg56Ul3fXywLOC7KI30h/PiLqR5eoM+US5hLD4VC9O6LInJxjPhPWSLVEQbB+A+tVLE0KljsZ1ymd6adHoKoM+dURBHqEtyjN5y7ER9kJQG5EqFI2OUQQBdGhJUalWoxJvelJbgZ6vMVH/8zXUDWNBPl+NbysfpM/xXnK1OXf22Msylr7AIPQQ5QOS2/IgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoFCX8BWqYdoibmbyH2aPbUC79k44/o/+mL4ZSFpU7s=;
 b=iG1a0lIPeD4VY2hqXCznMOv7DS1JlEVsNcr1SJG++Wdu7r8dxTu9NI9HWZtfGZnpbAAsifC4T22ZPw0nF+fGA9zF2Ui86Ccp2zZAZji+cfn4z7pXy+zbsFHJu4btrvoXM0ZImIjnPTY+ZlRY47bAFYskBGpCsBa56ep3Tf3prmYjAMajplhCqSBzT18IlxqMc7cAE9h6n9sKRaWSOcFwihu21Z0GnazmRPn+MgwZ3IAgs27icEo4TXJt/e+Zyt/fcTn5+L6rpIqfAxHrcyxv65xVXd7l86RBuGU2RfA4P0iDzZuSUDebXpjgQ3O6qUrZPEf31s+Y4eVH2yIBhVqPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoFCX8BWqYdoibmbyH2aPbUC79k44/o/+mL4ZSFpU7s=;
 b=XhwcPIdohi8ongkfs1qoO4y4MBQ+6KXJw+uos5hkFcTicJPO1UVYdmgtUB9NpJqzF2kWMMI6HzXbrwwpmSqew6T4AyMVKuU5EKFjb+RbbnEMsLn+e3h9HSUANPK7ECOsOV6kwPDtI0Twmrr57nqZuFmydEU3KLCX2DDPl5a3iRQ=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Mon, 9 Aug
 2021 06:36:11 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4394.022; Mon, 9 Aug 2021
 06:36:11 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V4 2/8] i3c: master: svc: fix atomic issue
Date:   Mon,  9 Aug 2021 14:36:39 +0800
Message-Id: <20210809063645.2289988-3-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
References: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0103.apcprd02.prod.outlook.com (2603:1096:4:92::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 06:36:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63cf91fb-0c93-4447-8fe3-08d95afffa65
X-MS-TrafficTypeDiagnostic: AS8PR04MB7653:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB765346D36446B1A3635694D6F3F69@AS8PR04MB7653.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tuddYuITmyY/1TW6y+2M2jXngxWSPz4AFO+/TP9OR6UD2YeC6ps/LT0MVev4femQE4TJUbNwl8TjozNfcNWAUcm0FbpjUmt5nZzKqHIkzHIxelocmmIWEaJKM6gVQCipH/d0mlWi4B5K2pTUUDwEHzKFA1zBsmfMJm5iEZJTkU2hRvpw+CH2vH0DxmmjAIO/++bBHY3QJTZqL/vHUyEXQUQxeTTMCLhZ1M8nlmmqK1fLpubM25LFJzPSygi+OLQmLCnm6KIYmv9i/Myr9OFFPfZjf5xUu3klxHIUopSUCUhQSwJxgKVVcvK49/w/NoQIhs8TWMZ/dMPea+AZMsFSPq92G7PTIDjAb7OKRerOwSKtZLfEMwh5OyFd5hEuX0MdY2Y33ZCNX0hmmah41VxavVJY/gX/v5nU8jbwd7nJobAj0Mb4oCRbmT/uXxRlDfhS3k/akbjJ3WBE7IGS/FAmgWrXsLPNpWxHRjEkwB52diA4k8bK/Zj9Pi2TnrZWrJR/CzjaK+G7q9I6lB2Vg4wkmkBoUG8gX3NTDPasit42+KKjmq3i+A3/QbgxeQGEOuI2ibeaCjpVNEECJLKGCZhjXqUlnkGRh5+eVyW6U1FLnFfDvQPp5hYopPLz00tN5p2OWrFEIyX34ipOFjQZTXZ8+cBhp69C8Pf4/kD0G0mIrNQyCfGdt5F7CYmH4Kpb3SxfspNpuwyFm9RLxAx+Bt8upQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(38100700002)(38350700002)(478600001)(86362001)(36756003)(316002)(186003)(2906002)(8676002)(83380400001)(2616005)(956004)(6506007)(4326008)(26005)(52116002)(8936002)(6512007)(1076003)(5660300002)(6486002)(66476007)(66556008)(66946007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pek3Ww9uNr3MilDzt9e7TJpMYXpjwyJyCa1Q1N3sKDVEfg+SoC8R5IJ5n+Zy?=
 =?us-ascii?Q?EsNHoJAyfvRk92VD5sFbvJZIkXERvsNX8vaxIcgBhissM1s+pw+PKVLCF4Id?=
 =?us-ascii?Q?V8MLpuhhQuoA60J6b7GPv/TSzL2v7JLtQY4imz9wWDwcOURvpBse4xTPohJu?=
 =?us-ascii?Q?blMyLw4DThHOYNJvMSv6/BHLWkUqGD2j1HbkYEptqfSRL7UJeX7McmVLgpQC?=
 =?us-ascii?Q?spGbhbvkmFNjTe76+M9WU7KGTIZN1N1cbRdsmixQnxpFQLa4dSau++SYs8da?=
 =?us-ascii?Q?uBimS8AknKeKVrr5PSgPc1aIWJcdwh5f0tfKowMAKKxNBvaV9fq5iDZUDcdr?=
 =?us-ascii?Q?Zqx/04o7UBUyu3+A0uwlwjyQNPmPosAB5MnWh7KPiS3gcakaFYTLeRFzJeO1?=
 =?us-ascii?Q?yrOE11uK6VTadkX0TEVEEFhA05pe7jHfqlsIQP4/axkodDHZAURCbbzWrOSw?=
 =?us-ascii?Q?/ED/aXMrANQRn8FGVldhBTkJuwUg0qYJYibTJDqVE+DXAr8Rd18MJsn9I91t?=
 =?us-ascii?Q?2YFs3JnZIlJCDauGR0ROiMrpPL3A0E5SUEU7yXtFLBVo9yI096xc7BeMzLdj?=
 =?us-ascii?Q?VVJWd+hPHaNgOtEFBb4Bc2xuj4LGEtcIfHCDZ/JVznS0DpFRH80vdFvldlLx?=
 =?us-ascii?Q?Rze62e9E52TpEW92IDpc2kVUe/piZMixtyn+/TCSO8XjlC3BV2Ds1a5jJidu?=
 =?us-ascii?Q?OmSOX62/q07blY9p/dctTKfwALDdmjgnHAL1xqBOlL9hJaudXS9CceoN/CvR?=
 =?us-ascii?Q?Jxuy0k7Oby5zX/eOjpWcc7nj6JlHPldpYW+5Ke6OWpjx/7wzdjdayZ2p4LU6?=
 =?us-ascii?Q?wYsyJwN3XT10k+fF6sJDBsRYnP0a8+DphjZYrCUjqbmFYhuOzVg4DV+Jzqb3?=
 =?us-ascii?Q?3nr4EBOaARwZJk7sKmDdRANDgvVrkZ4iHJq51VbO0x/uA636lSdyvlpBGMtk?=
 =?us-ascii?Q?GubN2Ue7PGPNtWgta7caxvfZGzxi+NrCiqLBBR3Jz/DA+XZ1uJ6O0BPUNkaQ?=
 =?us-ascii?Q?Iie78+Z9gGeJmDpKxFmhk3BOz21JlSt3Uj8IpsuvIcdRdYyR1XwAa7Nlga1H?=
 =?us-ascii?Q?remlgKCn/9sCDSJIz9tzSRtYZb/u0F+PoCTB/TyBdtrcxOfEBL55GSLrJXYB?=
 =?us-ascii?Q?A5snpOcmWR1hwm6ZG1sxDH1MWGG0PJiO9nWbQfqDgS50A0G1tfIm7XoKkMAH?=
 =?us-ascii?Q?OuoedeNGVL0Hu6x7U0thfB9l22+Lo3/uziiA9nCjZkKOg8Dcyr8iuyv5LCDM?=
 =?us-ascii?Q?CvtacLN+CTnr+/375KeeiQGaFqH3/VEQyc7CMRy/Z6VJXXmq3LYK4dxhqcjv?=
 =?us-ascii?Q?Wwz4GgO1CX0sTgYyuHShXyex?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cf91fb-0c93-4447-8fe3-08d95afffa65
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 06:36:11.5405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeL0xOpDQovstcUjwnZmeNO6OeoAu6GplstOin1cA/wIMLpQIiwRW1l/8zslQbj+UpZzveDj8MN+vZPfMYTMXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_daa_locked() function is in a spin lock environment, use
readl_poll_timeout_atomic() to replace the origin
readl_poll_timeout().

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
---
V3/V4: No change.
V2: align the parameters of the function.
---
 drivers/i3c/master/svc-i3c-master.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index c25a372f6820..47c02a60cf62 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -656,8 +656,10 @@ static int svc_i3c_master_readb(struct svc_i3c_master *master, u8 *dst,
 	u32 reg;
 
 	for (i = 0; i < len; i++) {
-		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
-					 SVC_I3C_MSTATUS_RXPEND(reg), 0, 1000);
+		ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS,
+						reg,
+						SVC_I3C_MSTATUS_RXPEND(reg),
+						0, 1000);
 		if (ret)
 			return ret;
 
@@ -687,10 +689,11 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 		 * Either one slave will send its ID, or the assignment process
 		 * is done.
 		 */
-		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
-					 SVC_I3C_MSTATUS_RXPEND(reg) |
-					 SVC_I3C_MSTATUS_MCTRLDONE(reg),
-					 1, 1000);
+		ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS,
+						reg,
+						SVC_I3C_MSTATUS_RXPEND(reg) |
+						SVC_I3C_MSTATUS_MCTRLDONE(reg),
+						1, 1000);
 		if (ret)
 			return ret;
 
@@ -744,11 +747,12 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 		}
 
 		/* Wait for the slave to be ready to receive its address */
-		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
-					 SVC_I3C_MSTATUS_MCTRLDONE(reg) &&
-					 SVC_I3C_MSTATUS_STATE_DAA(reg) &&
-					 SVC_I3C_MSTATUS_BETWEEN(reg),
-					 0, 1000);
+		ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS,
+						reg,
+						SVC_I3C_MSTATUS_MCTRLDONE(reg) &&
+						SVC_I3C_MSTATUS_STATE_DAA(reg) &&
+						SVC_I3C_MSTATUS_BETWEEN(reg),
+						0, 1000);
 		if (ret)
 			return ret;
 
-- 
2.25.1

