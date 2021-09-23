Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35269415C72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbhIWLC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:02:59 -0400
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:54915
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240542AbhIWLCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:02:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvE3eJMfBH0lGHaOtpFYX9ReMJ7WmL5QwTVX+66Q5s5/YCeBxiwDACJqKvEWfT1FcF9Iv+tPJ8/8CuvKZsThRM+gMzgjAXm/XnK+kVb8kjHMxWAORc8Pnd0BG7FtOztEHaiWELKikuzCPlIr7jt0deIRWa7lToJC+6gYe0jnJKHOcldgAXfOz9PlUVW0CoMxC0uJZrFCFDCyD+cCNs7/ldIIP/C0RX8w1a2AJFYg7Z51rjiDWMpVKv2pQ357XOorUMlPb0EDPjukErcUygRxkJgljMI19fhgHbq4Ud1xi8T5LYumkxWXb8CcIwowscvyBV0tkOrO/GEfNrbGyyqg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=L1w6mJgNPv25TAFp33iSL9NrM/o/1JNb8Gl5JeEagkw=;
 b=RrUwboU6CCsDdkd/AI+3rxob6ax9JknUB+4/AtXof4somDKRLBbrQqirBvuhqmMzpDZNgBj8WCXicxY7NclYTsosPQbVdvaAk6eLLpiMdQ7u6yZuF9Nawzk2vnYrO9Vm+oTvJYZzTXF7mYAp8pes1WTvwPmPJIR/Xz5BXaW7tD1Dv1kx7eHmdKT4JAPg2NASJWAbTbdsmg67lheFqQHB6pJdcRS21WSL3YxIB2Dtci9l/jQ8DVjzwiNtyp9L4kbny6FPoP+BZQsjsi0VpT4IGnITdU6aGDJx13WxW1dIQTQLEkrUmRtHVsTd1Kpw/lvcOLutHlvu6J//sCn7Ckkwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1w6mJgNPv25TAFp33iSL9NrM/o/1JNb8Gl5JeEagkw=;
 b=KtBrh4pkPeasTvSrsR5xo2EA3kD5oceTROxWwIDnovLJWEBsl8sHQHL3jmj6nilQtCz+Zmt/xrkEmOt9BssbbcmZCZ5292/b9oPhmCk94KetaN9owgHI8An6fUK5VfCSEy38eAmY/b1kBSroJJVL3Hf2l8w+Tf/EEEnbdJVesM8=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 11:01:18 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 11:01:18 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, a.fatoum@pengutronix.de
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 4/6] nvmem: imx-ocotp: add support for post porcessing.
Date:   Thu, 23 Sep 2021 19:01:07 +0800
Message-Id: <20210923110109.29785-5-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
References: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0004.apcprd02.prod.outlook.com (2603:1096:3:17::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 11:01:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e33622e-7d1e-4eb4-8f29-08d97e817809
X-MS-TrafficTypeDiagnostic: DBBPR04MB7836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7836FB178FCCDCDBD5625BF9E6A39@DBBPR04MB7836.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQTbRbZ8QbtbpygYm39Bhoha1PL+Uc99CiERrvi2QxW8kddiEwH98Q915r5ccboDPRcQVOwPxKu/Iq05btOgtnQzi2CAnrNLvsMXegROxD3FD7Q7g1nAZpNjitRf12O0rah6yzkMoaG1tJo84NmXugtIBsY1u3Is8l2Q49xB7xlwHy1jD/faFqPRiipeSFr8bbmL60S+uiSHPj9NIkEzpEyk9Poz00neD7PBr04sYhqiZ3R8qk1KYo8QCMbcfwVFIycoYiqnpAf5q16lGSWQifE9H6wPf2vgg0r9h76FRPsqEeI+DR5CycIp/amkQTn1urC96ZAlgJ+fcsES+31fr4RCXqzoo+cGVSsduSF9yHBolfNFItm1EavC3led7G65Ivz+MVtMysUw4ksjqlhnke/fwAHi5C7lwhGJoN7GSok5/HodAzBiFDAQpY2gKHgyE34k4h4Re8JQzSwQGxm2FQ+aNJBdyekBqzslG+f1jV48ow/1evBAD5Rf25DXjm8DiikiRABYEg14EwbBlojfUOnsjmy20lLa8fjvfX7fvgdGOU/RHvvEAylwsyqfwIHJbz45QQwIhD3BkC0Kn+9OjGuUO6eZaHmb8WMZqg4u/SXcKQyYnWJ7fAkqQYYessYIKycsPtvMNeTUnGsBXWYrJopceO0yAvMIn/UivOFewUYGkwx8glZMxf6dwYTqzyzPaQ/O6LLtor6ksgcYVNqeeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(1076003)(36756003)(8936002)(86362001)(186003)(66946007)(2906002)(6512007)(38100700002)(38350700002)(26005)(8676002)(66476007)(6666004)(6506007)(5660300002)(66556008)(508600001)(2616005)(316002)(83380400001)(956004)(4326008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pKGMlwbB56+ovzDULwVxy46RegO1UStX1l8onOfy35TWHxq4lhpfx7b3fXh4?=
 =?us-ascii?Q?PwBwwTAufdyOQjSnvja+aBMVKr+Byj3K2RlJX4SbYasvlw2GDZcoSwSisAGF?=
 =?us-ascii?Q?l+EBHx+1xRD4lr9vKqeF0BJIUwvWwk/wibl+yly5A4MrRVkELdMNS2VMQ83b?=
 =?us-ascii?Q?5aO1vQDHZLgeEaQZUzT38X7l1TnHRHXDPyYuwttNGl+/Ms3ji+K+r6EJJnVt?=
 =?us-ascii?Q?eV9CsL6tF31KS9rzaaqJOayfCMyBJp3y+PjuydZQuAAUudJCe4bDfcEPdZ+H?=
 =?us-ascii?Q?but66GtbU8dqnHd5Qj2pPNFXhiNx/Q9dC6ebRMHEKsZi0XtabUoWJHE710Ar?=
 =?us-ascii?Q?ALPJnl6PXJfhGUGYGBVejIrtchO6MYKEZnYDmmVruz3I++QYtDac9YFcHNu/?=
 =?us-ascii?Q?36LanYort2Dv7rg58/+e3xeFaVL41Fk3bghaZB5gmrM7w9L3SKbnewPlpVoC?=
 =?us-ascii?Q?sXL/mO+/zqNwxaPLMhT09p/Oemz8s8/qyvI7AwAGKVWaPunLx0Ci4l6Abf7n?=
 =?us-ascii?Q?ZFzmwV8XVlxda3CTp6n/JS4m2SaHnd4vml5tpSCD6n4QMXw2M6l4D1M7vSe4?=
 =?us-ascii?Q?QD5oH+91MifVVck3IWecSJD6p2UkjbBI1TkKeLLKVeSak5NvbzHsJ+hWRGgr?=
 =?us-ascii?Q?OIP//xFpPZT4rPrrBup0/PDOsEY200ARUaMvEHSn3v2HLW9OFY8xtXmpSKnO?=
 =?us-ascii?Q?6gL0bFcmqtBROzIn+bN3SVjdoU/juc/I6m5dVcNmJMkDu9Q2VIz8dh5ATicA?=
 =?us-ascii?Q?g6oOFLrxKFBKmNVCn2zzu1NXMBZRw5/ZxCg2hvirEn7ubdAdmmgMe/2RdAYD?=
 =?us-ascii?Q?bdLZNwK5liwrw7F7GR0ohkOD8DZWnsi/+S2CKwJWj4e/2cKl7mqrFcrL06Ez?=
 =?us-ascii?Q?fHniyssQEA9hbI4SLNOus9ujYeUJcXXv/AyBxspHmuyH5jH5Z4W/mO4/855F?=
 =?us-ascii?Q?ldgFuygF+tjL9JS/tetYsnKjtoIWrWu6edOs0eAFJdCOnKOoi3bFeCaUzVyp?=
 =?us-ascii?Q?Xx4a0fdg8GKt/nAHe2lpCGiUAHp2o5yDC+LowHm1ewuMY62nl1mEGTF4weez?=
 =?us-ascii?Q?zSAFYMe5qCdyH3KC0bpQn2fCddVOd8k62tsIIfqGk252Fy8mXnNRIxra0ZKV?=
 =?us-ascii?Q?L7QMwkBE8bZX+JAdj5dzKGWEWN9p4fzWjrIQwWKxllhyMLe3yB+lRI5LLVMP?=
 =?us-ascii?Q?paitw34lxdFm41sX7zoy76Ek8gGY/oHbu1syrppjzsf1hBxFlxf/HGBATmgs?=
 =?us-ascii?Q?wW+i8ZFZCepQq/eaqqAAHRBYJ3hGJW4md0LMy/zhPpIOF30FNjIymRJib0aR?=
 =?us-ascii?Q?tTDB5UJKRvH7Ri5kD0cN344q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e33622e-7d1e-4eb4-8f29-08d97e817809
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 11:01:18.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbJUumlH96t/+bcApd0CLDgAgCA8T22Zs9w1k09OWmULPBfErxzRklX2rw2AMpg5EBiUn1biWFCM3Aj93C9Lww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836
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

