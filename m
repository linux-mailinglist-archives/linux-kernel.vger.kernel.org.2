Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681153CB351
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 09:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbhGPHj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 03:39:28 -0400
Received: from mail-db8eur05on2049.outbound.protection.outlook.com ([40.107.20.49]:44928
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235671AbhGPHjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 03:39:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoQi6avqTnnznxfpmEQE7qPIelabvTH2ojnqgZ08moZrJ2DhjNx3cpH3EqrSWuCvCQ8D517iuBCZNCmSWRmNopQOrK9966Ib/+L+ILp1iU+sf3sXBCpKTgHFQZCWKRzqN2XGHUSh+hrP3Eil38rKHcUa99vKFQvdysU/UKrIpZfkJYe8o/qimTjFjvGsMrN6S+eaySWFePd1QrBVIxSBGUtbPQt3HrCc14DLD+ghYvI0GFLTGyg+Sh2VgN6sdKONhR48tcmAwhq4KRIUOuN35sZGfMy/TWJ6GlLePqkTgLZyCQvsVsQJg5oD2vJucT6nE5AUAjGOZeSbXfIRYjcK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XG1vCIvh3AbDj8o9jWKgtcTwX74OTGKA6WiUff0kLYc=;
 b=IV4sokShU20Be8xTba5DZRO4I03AQdMiDi3aHtas8Gb0mh9xmQXRDnmrUGayocsPApdfSikF3tS7/v6/QESOFt3sy1NjxIjTXX+XmpXtZjn4c2BRWNawy8rZ+HG5oBi046NUOqpO3/sL5cZE7OLTGeqgTXJsFKMU9GPsjvBvJ4RiAk3P/hCO0+V08/sBW1SZnhZO9Iq0nh5hiWejM00roIcsIDg8o/Vn6T2M2YhCH3WkOULHlXO1J+NIJXDLw42+WP2HoNrMaDXc1UZu5xWxtm9Ss0jVYwVqNgza9hI0HwylBQJB+zb23dt6FlDqHPHBwQt+QBa9toPNfHanb1XP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XG1vCIvh3AbDj8o9jWKgtcTwX74OTGKA6WiUff0kLYc=;
 b=cgC+oUp85h+gVO4mV36vXiIoEzKIh6g+gqO1FooWxVZZTG8u8eEA/VZjrubaQh07YwWQBCYnOQMv7IOMo8Gt9txkBYHnZDLVFTvYrsRiM7ZUvczlfNdJEgHq+Aq0LzwgIsnoi6GWACx4tcwgtuaBZf3TFsNYOw2/Q3/dHRWRZh4=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 07:36:19 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 07:36:19 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiaoning.wang@nxp.com
Subject: [PATCH V2 3/5] i3c: master: svc: add support for slave to stop returning data
Date:   Fri, 16 Jul 2021 15:37:21 +0800
Message-Id: <20210716073723.3490180-4-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716073723.3490180-1-xiaoning.wang@nxp.com>
References: <20210716073723.3490180-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0005.apcprd02.prod.outlook.com (2603:1096:3:17::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 07:36:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b8ee3d9-6deb-4b22-f99a-08d9482c670c
X-MS-TrafficTypeDiagnostic: AM7PR04MB6997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6997A21D3A33912B6DFB0E88F3119@AM7PR04MB6997.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlnfU57Tvz2qpj3h+N/Clxaugwj4wgK+52STtzFsxsRV8eldv+D4E/amvZ6S98K66i7i2GahUf5JU8Hx1rgrC0okjxh6MUGUrcbQAxREbPT4xq8tgE4W4ijModdRcc7udQoICfVRS3dBtKX/U0soBmwI2Tc7TcMc5+n3vdHXj2rAnsp4732FKCS1OhWcxexaVapHuu19zSC893cMCELNFFVOz/zU076nfczZmTpSHAkR4qhkEfN0PkLIOKsmPeuOKWKfbCunLu1YuY5m520nZUxo7xFTLnf6+SOBTQgboD2+YEbyHVAgY/KTupZL+OGrElGwfgbebhkPKS4Jz+96CxJhXzDC4HEYxLzZwrscDkVtAeUl4HIPpyIeuVoTYQlEkT6pDTYBfIqhrnLSHBG5mDfQuJ9CdNKMR8qgk2jAJ3ACCmYAm2ne5kSSK+TYW7r4ISZiKNf1LSmq07C1235DbYyXAKiqzkJ0H5caevBG5g3l7VpmmRHK5v+6urLVTgVggYZxHEz1lhk/aF4W3AMUYOPZLecAGavL29MDgweoWRmvY5nDBymY2R+hjmDuoxJWCSopV/cwKeu21MoLDF8f2UhC2nQsVnG7xPAnXk/rQ/QmIaj+yWP/zKYSh1TxLuvJUtXtCr24MJKJh+oEeiETDzawb14GgoXwaJZVmyxI27Zn2/2O6rUCtWA8ztQ1rMKQ07qKzXE35p/8L20C38S9xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39850400004)(316002)(83380400001)(2616005)(26005)(956004)(38100700002)(2906002)(6666004)(6506007)(38350700002)(52116002)(5660300002)(86362001)(66946007)(66476007)(66556008)(6486002)(4326008)(36756003)(8936002)(186003)(8676002)(1076003)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EwXVrtAvm77+aC6K2ze0Tx0V1eHDKP7r7Str9WRdaFzzMmfJrbIQ33BPvAIa?=
 =?us-ascii?Q?ygFxfH4PaHFRRMjstvpspfLsqFpKEvrSW4QdWSDEAkz1TRa34a/maZOTe9cB?=
 =?us-ascii?Q?pRobkgh29EVeY0mjmJmIWRWoptAzASMbFcGBtIaA8fg5LBkPPNAm0oXXrbev?=
 =?us-ascii?Q?/3e4WbZA8EL0w9MddXfvwHxdHrQxkSBzR6vGBEafa8UqC29LmtKjwF92zm1e?=
 =?us-ascii?Q?eAzRpfNW2BeNdAtogFI8hta019/DKxaHAGAW8BI/KOl/jRlfbcrv2vAL1qNT?=
 =?us-ascii?Q?53UmlmiAWh4lcwi5QizytP5MseXT5TtpJJYgIE4QNI8yOFJzVMOZYS6L681l?=
 =?us-ascii?Q?8JtV1ZkpJ6aZh/LpePpPYPQK2ANGdPo23nzOxO3G7KdviBP/MNNtJl2GKiGj?=
 =?us-ascii?Q?D5lOJnnc/fkyrI/EUm3eVzJaV8KC7K/fqwkSW01uOCTVbAzVldra0R7Vty8V?=
 =?us-ascii?Q?icDg8Mr0dOMNNJG49GPVloPMxBDS45tZPz2tmOxurmRcR2HeYR/l8G/tgHol?=
 =?us-ascii?Q?HptT2V66jxmYbiCACMwb/WT1FmEMZCFTCLd47EoN0zTRaCQWcqBAz75YoaG3?=
 =?us-ascii?Q?gxvOoqmEa/wsjvLPOavFus9/iLGpEJrWNaoKwuXgSY/MhclPdYEldDJkXrzH?=
 =?us-ascii?Q?kxvRuTAHQ/vrbd3ZDWa0HE3sHVGgr0DmVD6/hiXdHQyvvKe2H8YCR5UXJz8i?=
 =?us-ascii?Q?Li+9KMKYHQu6eqWpkNGIqAwn4Ira1Ky4OcyQ0LtJvjCsCCvGFSJseFz2fY3u?=
 =?us-ascii?Q?Dh9RDHXvI+ptlkE2hsEFRm8I4+ss0LDYX7H61aW+c9bkXRCENbQ/pYJZ0Vci?=
 =?us-ascii?Q?iIaLdbmMJvQn01f20U+KctgMMHr0CeShB53649J4xR76RLJ0rZi3Xal5xF3n?=
 =?us-ascii?Q?STnB7OdFPw8e3YR4zyqRt6D9d0nfNMvLBfI6pSdM6qjUPCUwKDBiKE2gbSRx?=
 =?us-ascii?Q?dIYn3Ge34Uf89/mXRQyVf4x5iZ6lEZGdVDSV6O6Gtj5scsuoTWgksqattQhh?=
 =?us-ascii?Q?TpWG802EJU7GDaEtnLDBOHsvSheKs3238XpjMhmItNb2ZFoAbaftv2lX4gV0?=
 =?us-ascii?Q?EuwZ7Mf8uX+pX2K6KZdlPVMpUPtPL/SjBZHelkUwKxM88DJuvq1ZFkfu2Mat?=
 =?us-ascii?Q?gaXLZLmg8PYl6JKQ05kVAqcTwIgMvUxi2ZAvZTtzcCE18gVtLwhlavlYJOhL?=
 =?us-ascii?Q?WZNqtMLi9lqCZSfydyr+F0KnNfLvYgaBsxjvAFPTA5Bz6/KLceVLQ0ie3BOc?=
 =?us-ascii?Q?tcxzpWlDRCvTwPaE8R9aS3HQnv9Yz/+xk5XMEOk6wGAcQ+Vp6LSUIqsKE3KB?=
 =?us-ascii?Q?1NgscI//nu5CEJ/tHIMZnZSu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8ee3d9-6deb-4b22-f99a-08d9482c670c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 07:36:19.6029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4z9q0MzDfMNrhqPDM8pzM72j/A0UXRVXuFxd8eO1xhaGGYuyEpqpWNWNdAyeNe2MIhLjiVSMHYKr4oxaMr4dIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When i3c controller reads data from slave device, slave device can stop
returning data with an ACK after any byte.
Add this support for svc i3c controller. Otherwise, it will go TIMEOUT
error path when the slave device ends the read operation early.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
V2: No change.
---
 drivers/i3c/master/svc-i3c-master.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 47c02a60cf62..91358cc5ca07 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -869,7 +869,7 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
 			       u8 *in, unsigned int len)
 {
 	int offset = 0, i, ret;
-	u32 mdctrl;
+	u32 mdctrl, mstatus;
 
 	while (offset < len) {
 		unsigned int count;
@@ -878,8 +878,15 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
 					 mdctrl,
 					 !(mdctrl & SVC_I3C_MDATACTRL_RXEMPTY),
 					 0, 1000);
-		if (ret)
-			return ret;
+		if (ret) {
+			ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS,
+				 mstatus, SVC_I3C_MSTATUS_COMPLETE(mstatus),
+				 0, 1000);
+			if (ret)
+				return ret;
+			else
+				return offset;
+		}
 
 		count = SVC_I3C_MDATACTRL_RXCOUNT(mdctrl);
 		for (i = 0; i < count; i++)
@@ -888,7 +895,7 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
 		offset += count;
 	}
 
-	return 0;
+	return offset;
 }
 
 static int svc_i3c_master_write(struct svc_i3c_master *master,
@@ -921,7 +928,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 			       bool rnw, unsigned int xfer_type, u8 addr,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
-			       unsigned int read_len, bool continued)
+			       unsigned int *read_len, bool continued)
 {
 	u32 reg;
 	int ret;
@@ -931,7 +938,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	       SVC_I3C_MCTRL_IBIRESP_NACK |
 	       SVC_I3C_MCTRL_DIR(rnw) |
 	       SVC_I3C_MCTRL_ADDR(addr) |
-	       SVC_I3C_MCTRL_RDTERM(read_len),
+	       SVC_I3C_MCTRL_RDTERM(*read_len),
 	       master->regs + SVC_I3C_MCTRL);
 
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -943,8 +950,10 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else
 		ret = svc_i3c_master_write(master, out, xfer_len);
-	if (ret)
+	if (ret < 0)
 		goto emit_stop;
+	if (rnw)
+		*read_len = ret;
 
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
 				 SVC_I3C_MSTATUS_COMPLETE(reg), 0, 1000);
@@ -1016,7 +1025,7 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 
 		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
 					  cmd->addr, cmd->in, cmd->out,
-					  cmd->len, cmd->read_len,
+					  cmd->len, &cmd->read_len,
 					  cmd->continued);
 		if (ret)
 			break;
@@ -1145,6 +1154,9 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
 		svc_i3c_master_dequeue_xfer(master, xfer);
 
+	if (cmd->read_len != xfer_len)
+		ccc->dests[0].payload.len = cmd->read_len;
+
 	ret = xfer->ret;
 	svc_i3c_master_free_xfer(xfer);
 
-- 
2.25.1

