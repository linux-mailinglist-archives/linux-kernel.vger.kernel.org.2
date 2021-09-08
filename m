Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC54F40377D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348775AbhIHKFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:05:12 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:3824
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348677AbhIHKE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:04:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4P0IBWzdcAbunQYmwTzsJnwwPIlM3CemoC/rdXvkwcadf9nbwNJzdD3HheswCIGBb4n0yBOEOilyHPDwA43KI5u9BfKW8DxPJU3tmOPy1L6oaS/bYN6E0gJL2u6lKScQLhaLeT600lkjFH0D6xmXggF/VqgyMO3K9ZzU0W8BV8r21g2tjMVdkENVej+dN4oWxXJHdBCex/4e6gjsvQkdtzZM5ppMGOvNoAR6eXB+QEQikBJIYsi00HWvCgIbLu4B89sXdkW6tceDA+HmrB9uyspzHVuSFZ6hHF5I+VeU3jb8vOZtesAScimsT4+H2F9akeRtjkL9j8UR33JIx35dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=L1w6mJgNPv25TAFp33iSL9NrM/o/1JNb8Gl5JeEagkw=;
 b=F2Q4dy/sB8uhKeL5rgR/gM7mYeTNoIn9DfK+Ud5uBsLSFOBdmd7Y9d1qBGvsyZoe5A26gXQQu1Mv/fh/v9n5MhbYGVUGQEYvg9MIh4tUuTdpYQr1+sHSAKloN54uuf0D6/Z0LAJz1yCAcSpn5Kn9HMdv6Y0nf+phyMxY6iBUwDUzqyKqSci9Zn89MfYgtbUVnqcViCM5Qu0dJ6vD6V1gK47h4rDnYbnP845CDPyHTIQJDkj595CneEkwoWR6qcj6pQIkVwa9Z/8DP2uwBMB+YcEymIcO6+wH+zm0rVG1wY24EhAqzx2PcretAixwtuccRgqZBs4WfZf9AaBqRbVdRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1w6mJgNPv25TAFp33iSL9NrM/o/1JNb8Gl5JeEagkw=;
 b=UzEMRSd/3c+BCrhTEt5U5sZVMPc1qgCwjJVeKJ0ofPjECUPfzFUPUKhZjWCEmUzGCv99pS1YZ0KFrZXkCJclaJz1b2R99GeW4+V83xiGTmqZIpaBfQZXNa/W83B+bdHPT0Zsou8ysVPZAgOQLUtT12OXWmNJgxJxq3S+I/DoKY0=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB5786.eurprd04.prod.outlook.com (2603:10a6:10:a8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 10:03:17 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 10:03:17 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] nvmem: imx-ocotp: add support for post porcessing.
Date:   Wed,  8 Sep 2021 18:02:55 +0800
Message-Id: <20210908100257.17833-5-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0105.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::31) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0105.apcprd01.prod.exchangelabs.com (2603:1096:3:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 10:03:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e8e6000-02b3-4bf4-7ab8-08d972afe167
X-MS-TrafficTypeDiagnostic: DB8PR04MB5786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5786DC94340C8186B7244831E6D49@DB8PR04MB5786.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xz0Ol29wFZpiPe9ncRUPobTBsZJvHGO4CDgoIiJ0cyIRCTag+NHJJrvoMuxdQs+xEwqGriBbDWDbdpU8/vFJ1PHqEQvwVgrj3Lj7Zc1d1jEJtkFM0FbgyrKWSiE0kL6/gU92mWmfxPldhQNPOUemmDH6zqoMwK5LDryluvUdv3xJNnzjC95ysofD6bnmAWPjlSZ5P6RsjK6XZuKTFgQCwu6Di+UYNfwrpMYSCZyuM+ksTuF4WU/qqLZGV7Wm+aG4OVQkV0EpVuMO0oMgc5SxMMzRnYE4KLpjHy3HrfaziUrlqb15/q3o+M2niLlNoh5oV/DJUnRULiyP2DZir63t9I6IlNw3EhHl3iUBCW0yyUo3mOKNVS6htiXUz0vhLF3RxJ5MtKutr5sXWoS961afx1YuPgv1bpHH9PaKQwy3oboH/2YI1WcKWlsV92AkwqggjyuTvjsuRiYI6wIDw6tXo33fLr95VIGd0LMlRLBNx9zVkMkomxYiNHBaGCQ13VZx2+SA5jIjRI18Rlx6w3Hprp8Mfubj0ONXryjp0SY+wJK4mW6Ey9wmWetKK+XXR690q7itzuTyblbhkUP/wxxO9OVVXlDbJ3sSRkCVhexQz1V4dBm3JvQ/Xv1u5aq1qm/f+9V44rg39R7o9egQhQlOnMjmkkJuWqtm8xVhPw2C+5lnDm2C7z4W5H8Fb3a7K9DIsjRuLsRmK0O4HQQ/IQJHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(86362001)(8936002)(66556008)(6486002)(8676002)(38100700002)(2616005)(66476007)(956004)(478600001)(38350700002)(66946007)(6506007)(316002)(36756003)(52116002)(26005)(5660300002)(83380400001)(1076003)(6512007)(4326008)(6666004)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LXg24N+dcf0TUB64rousfe4S3DL/+w9mDh5gGIeHHtE7CUCGXM4kpbU6vZFk?=
 =?us-ascii?Q?No393R9JXfkodg1FCGGDBXQdyFXmnfH0TlGNbRnfYljuSut9UIk5IIFbRdxq?=
 =?us-ascii?Q?bleJJt2iyXPvtVGGrX1fhoRgnaV+UWkbYYye15bFXa1S/yrd+mT5n+VLHMUj?=
 =?us-ascii?Q?JXksB5k82ztmU/GZ88iNSK0L8yrJdjhNv/bPS+dvxoyac9Emv9A9QvldpJrG?=
 =?us-ascii?Q?hbN8H6xfTs3ZOH0WSptXsJkDLQcs0DEG/R0TqJQtNiRt/Bpsx5g2RdqLKsnS?=
 =?us-ascii?Q?FSDRNGpiOIKuLvJVcXKa9I4ITxVLdawltxcntOCtIfy6EdRbMFdb5/Gj4Ao+?=
 =?us-ascii?Q?RoLH0mdlqJaS5hjA89+rWEJI/VW+tdEcaQ7byMflJeuNsVFAQ+7eeEtlGqy4?=
 =?us-ascii?Q?MrhA+NrcLarPzXmGcbkjXb+iXUzdGDdPyp1fEaGXjs8sKeW47vHR2bzIf68/?=
 =?us-ascii?Q?n3d5NIUwHnA3JqBCRnrUf7eKviy8+lNFcArH1XiYml7OFIZw9iVj+Ip1RTlD?=
 =?us-ascii?Q?gJ3Or3wWI7ENy2RDGftYDuXLtVefkRm9E8m4B5GzGwVZotp+KY0+zdfd7Me8?=
 =?us-ascii?Q?NYE9kELDdmw5VGko8X7dq2i+6M4C2MUV1ua4zygYyKmvsEv3E95KUrUc0aE7?=
 =?us-ascii?Q?2nhUZbR1bKPBbQgypLDdZRotx2v/ytH7+qwSCC4kL0gw7QnCaiK5SU/ZC5AF?=
 =?us-ascii?Q?oQ77lpX7DA/ftQrOcz4gz6dr9i2OpaXL3U9yJXeb09sM23B2E1thv9AkNazM?=
 =?us-ascii?Q?ZqFo7+uUVyzLPezJTvUcUNJa6ijqUWUkhJNj/qtR6/4qrWIBiJZI2mhWtdam?=
 =?us-ascii?Q?2XYG+5qgIY30g8EfQT4CSa8W2UYoW+5U0bfEwV3tLDIY0RHvsjb/D17OE5IQ?=
 =?us-ascii?Q?iRPywUjwZy4ZFgdkeuLnMtUce0i1vzAyizQTaWMbgspxdZ2CDoOI1I+wDyYl?=
 =?us-ascii?Q?xU9vSzkahDAIxyS+l2n1nGeVIRf8QT4QFhhi9m4GqjzVTrE+WF4M3fw1k0FD?=
 =?us-ascii?Q?jvME8V2CQCVjN5ErjF4V0IRXy7nKXmkvv/XzsxYBZXRAP0EEdOpOTS24sCgX?=
 =?us-ascii?Q?h5FhF0RxMtaahENB94Ztqj5mMcQy2xVVSRfoy8lq3qotxOdkTTSUBoBSqs9o?=
 =?us-ascii?Q?UiaZepPWGjwrEmz4HA2X07TyQNCS8wvJLJ1vAwSNLEglyVEgUDw2diyQxbwL?=
 =?us-ascii?Q?xAf9RMGQE9Nwf2L5TPwdvzfsE9EETJq38Udok9qbnV/fBF4Ki1Usl/+EZaIz?=
 =?us-ascii?Q?uOkwAMo8kIfijWrsfRrf+SvmRXITWqH6mIL9YsU4HyHXwM9nZtXLVHH5gBz+?=
 =?us-ascii?Q?XOjbSrT85GfsPIUfpVUzYn7b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8e6000-02b3-4bf4-7ab8-08d972afe167
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 10:03:17.7677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcriNTMv1n1tKWXCOiz9Z05r+rw4AHp39ns36wxiAQwTed3Yh214ax4sJ8XHwFLq4U0Usf1IBy1Wy2LDwIB8HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5786
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add .cell_post_process callback for imx-ocotp to deal with MAC address,
since MAC address need to be reversed byte for some i.MX SoCs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 08f41328cc71..0b5a092ebcd2 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
+#include <dt-bindings/nvmem/nvmem.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -97,6 +98,7 @@ struct ocotp_params {
 	unsigned int bank_address_words;
 	void (*set_timing)(struct ocotp_priv *priv);
 	struct ocotp_ctrl_reg ctrl;
+	bool reverse_mac_address;
 };
 
 static int imx_ocotp_wait_for_busy(struct ocotp_priv *priv, u32 flags)
@@ -221,6 +223,29 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 	return ret;
 }
 
+static int imx_ocotp_cell_pp(void *context, int type, unsigned int offset,
+			     void *data, size_t bytes)
+{
+	struct ocotp_priv *priv = context;
+
+	/* Deal with some post processing of nvmem cell data */
+	switch (type) {
+	case NVMEM_CELL_TYPE_MAC_ADDRESS:
+		if (priv->params->reverse_mac_address) {
+			u8 *buf = data;
+			int i;
+
+			for (i = 0; i < bytes/2; i++)
+				swap(buf[i], buf[bytes - i - 1]);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static void imx_ocotp_set_imx6_timing(struct ocotp_priv *priv)
 {
 	unsigned long clk_rate;
@@ -468,6 +493,7 @@ static struct nvmem_config imx_ocotp_nvmem_config = {
 	.stride = 1,
 	.reg_read = imx_ocotp_read,
 	.reg_write = imx_ocotp_write,
+	.cell_post_process = imx_ocotp_cell_pp,
 };
 
 static const struct ocotp_params imx6q_params = {
@@ -530,6 +556,7 @@ static const struct ocotp_params imx8mq_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
+	.reverse_mac_address = true,
 };
 
 static const struct ocotp_params imx8mm_params = {
@@ -537,6 +564,7 @@ static const struct ocotp_params imx8mm_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
+	.reverse_mac_address = true,
 };
 
 static const struct ocotp_params imx8mn_params = {
@@ -544,6 +572,7 @@ static const struct ocotp_params imx8mn_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
+	.reverse_mac_address = true,
 };
 
 static const struct ocotp_params imx8mp_params = {
@@ -551,6 +580,7 @@ static const struct ocotp_params imx8mp_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_8MP,
+	.reverse_mac_address = true,
 };
 
 static const struct of_device_id imx_ocotp_dt_ids[] = {
-- 
2.17.1

