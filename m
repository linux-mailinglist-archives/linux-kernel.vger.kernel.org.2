Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B033E545B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhHJHfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:35:55 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:49280
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234183AbhHJHfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:35:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHD0k8JCzrvvVmOcWwZCoJPPKsVstJZV4TPfhTQEDmMm0qvyyn+85TjxbkeaJKrLtdBIiQrV2gjdYur4IkzMg5QInpaMZ5Imdw2OhqaJ8B6/vibmdE4NjpiDAhga89j1Dxeu4KHkO+cZDd8lmas8zAl620qdbZ3kD7S0qcO347kGWofj5BnkmyH4UcX8K7ktJPpupwpHyoL2GYMGLdrWhpdHDIDehZYfsUOWxfWIDvCWMb66whuOAcqDxjLoLKYHjdqBcx9B67Us0aRGggoyYvj/lMkP1xW5vOVOK1v+EIcfxn5cZuvSisUyRC3I+8+KdcQ6RzDbZcpZGea0QYuH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekOF1fTA+RKtFkq7oPXK4G0HX0JUkfgVPNb83ampwvA=;
 b=nr/mlsf6rL1yz8Eg+cuGwTmnt2Tk67bgpEu0Zw6FZL3DrO2Dl7hGeiqZVOt7mrPM9572cMvxyzGS0PHTliQYQVmh0vFeKTQqMbocPx82A2kSwmmx2YfzOj/bmYbMzwMRGVNrb1LSYV3Z4eyYQ5wQeY4UmEc4m8nZa6h8MlhjdfUj5LS36NifxQd6GnCQUOY7iXJmXolloYKEUQtRtqNPZHQtfI1lb4aTDfJKqqb78CLWvEkBATK+mxQrjC3WNMKdZfjlevtGYt/Kyvgtg+RHOBRj55zxVE8Cr/U6rkKQbWcwqv3sCxI6f4hiOlopWuN1c6Kc4AAqwGOT1uv9BeAPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekOF1fTA+RKtFkq7oPXK4G0HX0JUkfgVPNb83ampwvA=;
 b=dBduwRHdvJKn1j78tVFplhiHCkkyRUS7AX9oKIO7KBCRE9C305L4tUiZW+3W2n8JZyQPNEK9ivSYQj8ZpgA/uWJZZwtOOQ/iMd7NRHYihqIvUTQFF7f2+NKFGPTJfvJKRl/SAlRG21lIWegzrw++SjqRIHt/6S0RbzkT+suEIUQ=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB6793.eurprd04.prod.outlook.com (2603:10a6:10:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Tue, 10 Aug
 2021 07:35:27 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d%6]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 07:35:27 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 2/4] nvmem: core: introduce "reverse-data" property to reverse buffer
Date:   Tue, 10 Aug 2021 15:35:08 +0800
Message-Id: <20210810073510.18218-3-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR03CA0098.apcprd03.prod.outlook.com (2603:1096:4:7c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Tue, 10 Aug 2021 07:35:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01408913-deb5-43ed-632c-08d95bd16c5b
X-MS-TrafficTypeDiagnostic: DB8PR04MB6793:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6793A597192DC04B7319A8FFE6F79@DB8PR04MB6793.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09EbP0uzKw2UYhAlz6p06PKnjk/Op8evWhP6e9ONXZg0WU9rgCeAaaJUOt89zJVV32i+0gQuWrBvoDluPnIPC/7NZrnCvV7XvkHrwg7z3HN6dbO6Z9Ly+y+HQ4rCLpHBobnu+ejXPw+ygLtiPM4Xa7HFUNwNpYQou+OtjUrdhwNYRShba5PrCa7f/yugDm9P9oUFCew4p7AdUAjHxrwn/PqKA064jn/Ky8kmKIsw+IdRkUvsiQl1qAZ5lHTnWkaWKzRzQu1hfDNEcBJh7Z59SDLEYEIGu+Bs29nHvXfMM6PsJBB4yvHoW+wjwHDhhzrSIa/i7zmXrTuUFDaqPPhBh+pCP0GLIvEvRHGxz2j+XIjobvtDLSikWR5OumFrY2NSjWpBXWJIRWJTaRhCd5Ss2SJRLFfsSDOECyFfXCNQ4cwx8DxQcA3LSXJA7ovVaomI4ypHl+REZRLrvQudS+sOHUVI+Nj8oUtYsIO9pHbpC1AYeWQPYHgAsDfZ4Z8H3giIjBK9ymcAEAcFmNXn3kSYWSvmvSrW3gw6L3+HGlUREK278vDIdsk5sMYxP/73MvCsXf/lU7wQ8tNZr3SBy7t/9CYoxTiaUtneYAjyobdaZOIS797Hx84GZdTgN0NNkhU7+xOLYjcWUMO2Tv+p89H1f6R3hhSG0WwhjLjUXsOpg+Khxm1kMgoyAmLyBSARzmFGlqKHaCgWPQ3bWVLgvNHByg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39850400004)(376002)(346002)(2906002)(26005)(66556008)(8936002)(86362001)(66946007)(38350700002)(38100700002)(66476007)(8676002)(6666004)(6506007)(1076003)(186003)(316002)(5660300002)(83380400001)(36756003)(2616005)(956004)(52116002)(4326008)(6512007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HqpaBpuCg7smdCJgq0VXAZ3U9Sju4rtXN/ZnMjD7/RbBQTY2/SQkPBWtB9lv?=
 =?us-ascii?Q?KotC1lbz/pvgX7FILzGoncg3TXEjEZ7l6zORbzrpO/uE3wKw1DOzmWh4z3AZ?=
 =?us-ascii?Q?4pF5Dm5QrmCHsv1TwW6AO52wXLgZ2gQ/+Cl5t/IFSU0spvLRLoocEyiEAFu7?=
 =?us-ascii?Q?KN+eHCcTNjtbN82INvBzQSBz5w+NRjdhoEKClsvAW6pZBqYrTJWfcybaRLtv?=
 =?us-ascii?Q?nuIsjD1GfqNzTmI4DiTW63eTwQOgRf9P9eY5dqX6+jJyuCAaz66ITRYSe6qD?=
 =?us-ascii?Q?0voKdNntVmaQ03IOvo/LR+aUICec1iI835XXsKeJtpo+lXmFEKL45/o+yGDQ?=
 =?us-ascii?Q?NRKzC0pMET0fVriHgIPzJKK4DyCWlfWns/1f0RxrNRPu2MYsmrvU2e3LXuXy?=
 =?us-ascii?Q?/UAEEGwL1cBsw88HOUCK1asltcVXtBPWET+qcgEajZzUcwJDlImigrfql91U?=
 =?us-ascii?Q?+gDgJD63SKhbgpgL8WtQLdYgZ+1D/dsn0LsXiHqMe5HvPnwecfektc7+kpHy?=
 =?us-ascii?Q?Xm/jfUCZWyCsL1RXp0SsH7A3IGXpg3CVuxHuzgO3r3ZW5dFFMtOOrZtoEb05?=
 =?us-ascii?Q?Bf+m6XK1pc7jbraL7MHTbQ6ePEX0c9ZYPhR0ga1eBfL3Vh5yJw7UMumFt2Aw?=
 =?us-ascii?Q?UTbs1YOUnVgHk35PefL6W9njU7pUHueNPllc+xzuVFLblEhLHOPovfvfxu6s?=
 =?us-ascii?Q?dVoeBTSCy90yngJPM0kaG+d2saNYR3Dfafa0X4SAaAySOwqIMXeE9VC5JLfl?=
 =?us-ascii?Q?55RffQ/qN9QR6/9mFEpACfSrxIfQLvJ9HgP0+t/uXmMBMa6chOp2VjY3P7UZ?=
 =?us-ascii?Q?V3WSFsOtURGKmlYnXQiRM5H0dlozXjmjdB1NQ6s+bVC0hIzxWPlvcqYSbv0I?=
 =?us-ascii?Q?goDSRh9Kh1kGgvy2AA2ZLgzXDqC/+fbxn4DlYpc1mPtDPYiqjyZqnzl0NrtS?=
 =?us-ascii?Q?RbF8Gd1oUNXmm46/bgr8qeJLe6R/wu5K2i+sgsK4S2hrE0UutxlZrtQ+PDE5?=
 =?us-ascii?Q?dCNL+uViqMEHtbDHhPKooFFNd3gBTI8XihmezyJlHILxN0THd51TzkApWCue?=
 =?us-ascii?Q?6flkG6cDz+5nG9K7S9y4WsfR27npF5ulS+Hzcpz1y/Lg4j4Teel+1lnX/ofv?=
 =?us-ascii?Q?c1Sn7KAR7Sr/vymfE0r3VDHQP13mGprVd5YpdTg4Nj6oITICwOEmFFbPsKSr?=
 =?us-ascii?Q?z0EiAXQCQG+8gi++jx1Xu1Hxe4WnUMKuxLPSJ17U/TswOI2BMw4/Ts/Tv9Kr?=
 =?us-ascii?Q?bHD+Y0W+JpMqw5eVXTP7N2IjUE3pKZ88Wk2NCHzaJzImpfwJ2KzeiEZQLcK/?=
 =?us-ascii?Q?tKsuZvxCbpvfHvUZh3RS7oUp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01408913-deb5-43ed-632c-08d95bd16c5b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 07:35:27.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wonvTVurLnbBmJjHHphP5UcZkGiQIdPnLCZIScLP+hKFM/5SrH4z23Qas6gmgRqDhE7gOc1bPSd5jiXZ7I8aOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6793
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch intends to introduce "reverse-data" property at nvmem
provider side to reverse buffer.

For a case used from Ethernet driver, of_get_mac_address() may call
of_get_mac_addr_nvmem() to get MAC address from nvmem device. MAC address
programed in imx-ocopt is MSB first in lowest address, so need reverse
data then feedback to nvmem consumer. E.g. MAC address read from
imx-ocopt is 98:e2:06:9f:04:00, after reversed the data is
00:04:9f:06:e2:98.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/nvmem/core.c           | 30 ++++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b3bc30a04ed7..ccc2c5801c8e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -55,6 +55,7 @@ struct nvmem_cell {
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
+	u32			flags;
 };
 
 static DEFINE_MUTEX(nvmem_mutex);
@@ -92,6 +93,26 @@ static int __nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
 	return -EINVAL;
 }
 
+static int nvmem_buffer_reverse(void *bufaddr, int len)
+{
+	u8 *buf = (u8 *)bufaddr;
+	u8 *temp;
+	int i;
+
+	temp = kzalloc(len, GFP_KERNEL);
+	if (!temp)
+		return -ENOMEM;
+
+	memcpy(temp, buf, len);
+
+	for (i = 0; i < len; i++)
+		buf[i] = temp[len - i - 1];
+
+	kfree(temp);
+
+	return 0;
+}
+
 static int nvmem_access_with_keepouts(struct nvmem_device *nvmem,
 				      unsigned int offset, void *val,
 				      size_t bytes, int write)
@@ -705,6 +726,9 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 		cell->bytes = be32_to_cpup(addr);
 		cell->name = kasprintf(GFP_KERNEL, "%pOFn", child);
 
+		if (of_property_read_bool(child, "reverse-data"))
+			cell->flags |= NVMEM_FLAGS_REVERSE_DATA;
+
 		addr = of_get_property(child, "bits", &len);
 		if (addr && len == (2 * sizeof(u32))) {
 			cell->bit_offset = be32_to_cpup(addr++);
@@ -1398,6 +1422,12 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 	if (cell->bit_offset || cell->nbits)
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
+	if (cell->flags & NVMEM_FLAGS_REVERSE_DATA) {
+		rc = nvmem_buffer_reverse(buf, cell->bytes);
+		if (rc < 0)
+			return rc;
+	}
+
 	if (len)
 		*len = cell->bytes;
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 104505e9028f..364ac2a61b11 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -31,6 +31,8 @@ enum nvmem_type {
 #define NVMEM_DEVID_NONE	(-1)
 #define NVMEM_DEVID_AUTO	(-2)
 
+#define NVMEM_FLAGS_REVERSE_DATA	BIT(0)
+
 /**
  * struct nvmem_keepout - NVMEM register keepout range.
  *
-- 
2.17.1

