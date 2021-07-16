Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C723CB4BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbhGPIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:55:13 -0400
Received: from mail-am6eur05on2080.outbound.protection.outlook.com ([40.107.22.80]:30840
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238486AbhGPIzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:55:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaM/wqhoJyuFqb+4966jX9AYzNQJr61gjBVM/vlNNH8WLVKAE7EtTNO8jQjkZhOe4YqGOARvh+wNvorbiETnCfBrIx50y0lTdV6Sd5zxBvpIuCrX91Dt+fxjVMucQRmALXmLA/Id9LwMCbU+jgiRL4UFuYPlf+9WRuoGr0VqRum/qmUcduhwkxD63YwGyCw6i0qPYO6YtRZxPTZX21wtlpWfXRLQwTyVxvkCLbww7i9g8ok16TDf+6PYtTI9ACGMRcrGfKoVou5YR8Sq8EPR7axz4ONJXrEG5xPXYiK0vaApcKinqnE30jBr6G7o9Ps/LkEsBGljzmjM6DzRWa7oug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S3BdZ5HGel6Pba7pPoFqB2GWWf2xkSJ9NM/7MB5k+M=;
 b=Cl+EaYNibjVbsLbqhQ8kQzG89F4FTQ5f1N3Ifgq78MK+vaIEkb7uf6Xux83ZyFbOPlaHCJYi6IljJ/rwm/wgYWQv8OGxCjVM+8M0bGOn0mUeZg2dSMEHUZguabnoxr0yvKvmeykflvZBJEb0OGtqLYB9EOLg31BULNkB+/vMlO6rxxE/haD79DaKOT0vBujF5HhivyxEWOFJh0so3UKv5UQOhjYLQ0adQL3sRoHlZZHClbMtHHGOgFZQqu+iKxdmX0V57W0ltWD5TuQgPOPmDzT3kewjWQLzBhpwOxp6KTQz1MGtkyvCovVgYC1XTsOrTItjsMY2MiQQAKGozukmGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S3BdZ5HGel6Pba7pPoFqB2GWWf2xkSJ9NM/7MB5k+M=;
 b=CYQtrwaCSADcFblbYEYd/hk1oYTkF66Jrouqnl356VO6PU3Xl1bxdzLbDiiwkcMLk6osP/0lyK7mvBaPoTwMcPD40GiZ1/Kz06PLeAMA8LFE37aFQKAtKQMb3Dov9j7q63qKnEKropoVsXtqcKP4lo94CzPfD1nUGaBahOcLD0o=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 16 Jul
 2021 08:52:13 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 08:52:13 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiaoning.wang@nxp.com
Subject: [PATCH V3 3/5] i3c: master: svc: add support for slave to stop returning data
Date:   Fri, 16 Jul 2021 16:53:15 +0800
Message-Id: <20210716085317.3572224-4-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716085317.3572224-1-xiaoning.wang@nxp.com>
References: <20210716085317.3572224-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 08:52:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dbbbb66-8e87-4875-3c6d-08d9483700d9
X-MS-TrafficTypeDiagnostic: AM7PR04MB7142:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB7142F490285D5D1AAB1A7F6AF3119@AM7PR04MB7142.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcjS7T/CGPuzTTg7KAL9EOVxtbqaUFwq0DPiuBcFdJmZJnZuMz0UM6I0j0ArV2/vjSrLjdEe2PSXT2kIUtwjpBZG0TnwEuCPCPFJBDqiM7N/vQTiYR61nvFgTo2NQSCVhJwcGYwC/G7cKmtfsVkSx+jV6N97OMyiVduvizHaGWUck6VnYx39LFPUGjv5EVDYkjwKjf62T2O6rU+aR+YWVkJdL3EYMnjpBTYZMANfSmWJ0LqBYhmnTWetu9MZPYAH8sMDVttjxcQihU+CeJOowHr1/I4t0mwAdqUTLBdhLKBDtbW5wGyV1BkP+iV8TifIgax33JTgeCBM351lkAgvGW+KOtWFe98Gkwy+g6cyg2sQbMq38vaWeQkrlwy1j8dj+9CAUYdihLaTtl/37BFa0Mr8wNaB05uMtoerqrcdOUNdaEN6KccOSC6rBD/SlwEShMv3vRn3hJtE9uYg03m6NKPgcJiYTNOQaUy5lVdX7R8GG9ntgOvbSVbwdpoSJHKFSGNw6b7hkEdEYSzaHa+GXVfmQ5KpVj91uiPOHfg3KOoTzk0nsISlzLqe4tvURuVLEnTM0CDp6ljvW+MILUE/YmsFW+vrT64G7cBqexwkcgDm3uafJ8YN8jAbCgUHKe1VNIzlMD9Cos/y6O/rlXjkFpWv1P5APsODjRm0vWX4iRhlSAHlfwclOCJEF9Sndx+h5Eq1dHooq3ZGRISc9/EPNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(136003)(366004)(376002)(36756003)(478600001)(5660300002)(8936002)(316002)(66556008)(66476007)(8676002)(4326008)(86362001)(6512007)(1076003)(66946007)(26005)(2616005)(956004)(6506007)(52116002)(2906002)(6486002)(186003)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UpsAEItGrSHLZKOm+6fhKDtrPvJO+utjPm2d6Y9I5R6xirMRSNJA+HS+8MIM?=
 =?us-ascii?Q?v6wRrzL5WmKX2kogQs0vxqncFdcfdQXYO+tbL+SMeP6nMCCYDstn0gQxvSl8?=
 =?us-ascii?Q?fWWRT4zr5DR2U0dg3VT5BYtukqCtiRs8MfRzsA001ZYYM4kEe+O0VfhMN70q?=
 =?us-ascii?Q?/AZkuC2437JhiAlHn/w0U8ncZWN9d3s7Jaga0qXpEWaGfOfXQumZxSU6nPGo?=
 =?us-ascii?Q?46QLM4MBpswpLCqFrPAQJJOREW26Dx6LlUi9rgwpUajYptc7AIlFCKvp355o?=
 =?us-ascii?Q?f81H4Wt1MWCRwOTqBRuSBEGdOXIw5s+YYYZcskC0YoAbRgfd1R0pUnzqeziV?=
 =?us-ascii?Q?cZrM5kLu4DCxcChEhZuSpCa/SAvHAV/vG9XInKYgnzEpYhPO0UD/KPL6BsO4?=
 =?us-ascii?Q?EQab09jh5H9UDK9eoDDBNwON5E55+NoCzU8wi+76peyComgUEzoEdf/omnEi?=
 =?us-ascii?Q?2LrsUpKfQuctpkXcWjdmSYITsuBsuG06lG1TCxWcqBrn/1tt057TBGly5vMD?=
 =?us-ascii?Q?DnMnGm0Cwtku6b4F3eejqKX8cgFUrJ47iZWWlRsUL96lbRpHS9BMyssbIuwI?=
 =?us-ascii?Q?EahHb0svRy6yV1SDjJqITsM/VtU9ZGXTcrps8zRDANfRL41Rp0KhFVB5WUH2?=
 =?us-ascii?Q?SGQVXJh0H6Aqiy84fgawyKHR58PmGq6mkGEi9aHIm48O9PfOkB7U/3Y2tTCs?=
 =?us-ascii?Q?9OZS5ZHWHaYV71lPYYzJUqjaCClcf/B6b4S8YIRL/A2F48mvWokKAdxuab8m?=
 =?us-ascii?Q?tfSKKgNxjuUcZJZKt7OaRcOPkdM5BcAu7Zc/oZZg+JBmrllB1VVGaDNehhbr?=
 =?us-ascii?Q?Wym5ZsRhhr8Vi9jLZTOgSeKchLsaySAkMrMtY2vL1iCMs40d6Ppj+7R8asIK?=
 =?us-ascii?Q?YQpBVkSagKk2198jLAE2mNmIVH+wOOBdiSRn6lpNsR+Pv9vwwHjBzJe/a8pF?=
 =?us-ascii?Q?pIgCARy6i9Ctzgg/4aCwQGyTK5p72cjFHUixdNczXMDn469vi96lDiqev9SP?=
 =?us-ascii?Q?PmlmQfqzAIeDutsEvrAjTcpQgzn64aLJoepdpmUZSzBw69QQxKt7UnaGuKOT?=
 =?us-ascii?Q?mhrr7r/NrQRTKzQ5rflf0KVjwjKUdu/2Ump5ftqv1ea8TjwedWVDdIDBQtSo?=
 =?us-ascii?Q?qNEOkr8NX5+zZca6xOvug4YjMeWR//37pan2st/et3VsgeIwr3Cjzm/RMkaO?=
 =?us-ascii?Q?QNZkN0WoGmcRN+Lhfe5k7FNhTYzJiiIumyX1x3o/uHQJv6tlyRBJqxmy4jWG?=
 =?us-ascii?Q?WtL1+m9JGUKSlHa3Ey3wKne810sFamRj2IP6G2LB1+YcAVJH1XORJg+uUV9t?=
 =?us-ascii?Q?I1bMSU664PxXvaDkt+hsIx9P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbbbb66-8e87-4875-3c6d-08d9483700d9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 08:52:12.7741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AyqVDPbDhdyMzje/B1Ipg0+c98q7znz+naoy36odvhZYvoG76Ugnajem3OWEwQ+/tTAkHym6svO6WkDM6jbBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When i3c controller reads data from slave device, slave device can stop
returning data with an ACK after any byte.
Add this support for svc i3c controller. Otherwise, it will go TIMEOUT
error path when the slave device ends the read operation early.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
V2/V3: No change.
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

