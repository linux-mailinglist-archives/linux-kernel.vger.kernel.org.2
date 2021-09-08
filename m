Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0330C40377B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348705AbhIHKFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:05:02 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:63650
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344012AbhIHKEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:04:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPm+ve5xbKQgmFiE95S4wA0Dd8vWn98TiOgkcjWruwWFzBRlhMG5vzbIPIuQAch92mVzxI+S+wBTUZ/z6gQNw9zGMM0oEjSTU9Z/7sEq0BJavZbiMWGwu3pLid8g09By2RgX23YQ7EbGQ2m8ogcwqk0J9n2qPgCseQj+ALdMZX9lgB4ymOrOC2vB7p7jPZBTQ/1gbPciV94oohb+4jNJ8MFf5xnIZHXpF9u+1EaFgQPr8THtvTdDLhS6fH9LIlUyAAwv1+eXD778Lq7Ws0rKNtvt5ZIEpaFQ6O97puZbEAxIhILxPfR9/gBM706mIKkAwvniD5ggDBTg5PKqEh52xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AEsEyklTcauiFEYDSQqVI/dGtO4/38cDa2pjeUD4At8=;
 b=W26IEHZ5o9qH0usF4POPWblLLBVN0J6wAixxOrITzwTi5QyWaEaiPXVYAHyTmdsvX4LCrfvBrOLKOdToxDHbI/kpDTUe/OT5f9AzvOlkQ2Ve5V/haW9ot9xpmyeZ2NgpJ0b8+6lN2YM7d6xJP7tXSBmVr6C/SX2avxpN/yGzclom8EwypQWx3jJ/DfNiG+AukfW0IisoJtd+jd0Z5t7t7lMj2mUDLlU6JFKNIiR4S5yRFb5SOKWIkCpIJWkwvFB6/YXpQ4eepvyOGnit5TyYCS5AYk1RiBN3f43j+RO7zn5b/Lri1E6mZ+g9Mnp12ab52qEcWuaV7AY1IJrVaTWAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEsEyklTcauiFEYDSQqVI/dGtO4/38cDa2pjeUD4At8=;
 b=l8rtRZFXqFUh+EYzp6e50pi3UBaS8oxRa6iNKPaH5bnq/oZ6uyYeHrF/hQXWGaYCwRcjH00vmTWjfAQF1K8MbBFoiOZpc83j663PqFFpPq63s5ink0SpqtkfFGYpCEABUXPPtgtsMKERP7QsZnwqgySuSa2UG5QpTNPrsFzZYbQ=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0402MB2726.eurprd04.prod.outlook.com (2603:10a6:4:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 10:03:12 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 10:03:12 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] nvmem: core: parse nvmem cell-type from device tree
Date:   Wed,  8 Sep 2021 18:02:53 +0800
Message-Id: <20210908100257.17833-3-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0105.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::31) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0105.apcprd01.prod.exchangelabs.com (2603:1096:3:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 10:03:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d9ffb74-4805-4142-ca8a-08d972afde15
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2726:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB272623DDD4B445EBB2DBD985E6D49@DB6PR0402MB2726.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FkmGhSjdu4EhFXoph5E27yBWiObAV+yN/KDk7/4LeYCEpmLhCCwudPfz8PFANSTpBsIIfccNQE8ms9yeTcyeLEpi7YbqgY0kThYI3MRCZMiDi57bFocE0qsSGwre7pNtKui5XSnuUcbMIvTnyEw0DV10WUrwAYyLv+q8rlKZafRtotqYWVWIvPLBiBDwQMOeylYJgYhhYRXSvXhf9jltqBDd5NuYWjvHJKW53d13/sHRAUcoTj2I7G4t7cWw6E5ySaS9cRCPEyeO1kdKLy2Z+qijLnKeV2OAGUGMZ00KwFbt1DPsvVXREEj9CTikplAxEWfGJgzLgcdTWxjqOG6STBEn9b1wA8l/mnX5LkrRG2IWfXbUDUXhI+3maWEimcV+omAbV3tonfHggg9h0X8KJbuQJll+198OqaqD0xm+c+KxtJ7BX92K7zLGBWJSeCQEOqSOnlJE+Jt0Fa9xg3qeeq6Vv2YMq9MlX+1DeJu2tZJ0Pcv8uvWffPBcmk4DqAnTLQrdT8otZfMoTZls3Afz/+MvlLXHKJ5dNIDRBQ+x7KuNfYdsKkSsBydfx8mqolRN9FnPL9QOBkcagyHIYOGgi5bKhzMESTyB7bXhGOFsGlRfjAKxiZOdEStwi5FhLguN7eZyRZLwvZVq4r2e51rS9mhlZue0J7Dg0OBfecTwUBu9tXQAjFuCIQK5kxAHF1W4HV18+6WPkljx/FyV73zo4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(2906002)(52116002)(86362001)(6666004)(8936002)(5660300002)(8676002)(478600001)(316002)(4326008)(4744005)(38100700002)(1076003)(6512007)(956004)(2616005)(36756003)(6486002)(66476007)(66946007)(6506007)(66556008)(186003)(38350700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XxPcM8DhDmRPTz2/43Y4b5oqx5DlwUvS3hoSZhy0WZlUO4HgMV9lNoGnBpCs?=
 =?us-ascii?Q?tZDjDsaS+7Mzhl41EiCZSZZzhPUpJfzlkBBci9gXy+wduBTTbJhU3Mnczwo7?=
 =?us-ascii?Q?KNPHuk+unjkJJogY44M8crlIRted9YmW2qcRzgmpIaEYKU9f3CR9K86iwGxY?=
 =?us-ascii?Q?EkPhDwRpYLz5p9isAQhHbD0f1r7D9ZCzpYuFzY78Y5c8xXpBl/Nd7OxOpJAB?=
 =?us-ascii?Q?/H8oNsVfcPJFuUcxQiPqbSixnRxli/GTLx2JLCJsJAmr9hEAmLUSqmrH9FPg?=
 =?us-ascii?Q?yM9Mxxs5mUqj08wQoCxdSfGWhOtcE8z2HdMdC7VGWmek+rBexAf829+mpCjJ?=
 =?us-ascii?Q?Q6DCPPQx4JC9RZlEssj1q0XSzaATGZ4GUKgrA0buJvdu/pGHEKH7ytZVhCvy?=
 =?us-ascii?Q?qg/lHOo1l/yMHweooT+Zh0fT1KVOTc0RCwrepf1I3GX8ShkiDTmz05uWBGNF?=
 =?us-ascii?Q?aeKwC9EuemYlHqkpBpQurEG56s0msoIU6jl2Spg0jREmxy7xFhxNxJ/UI672?=
 =?us-ascii?Q?+P1bJLzVdPgtBADqE/jTDfNR6xtliH+DF/1c0bz5VHYtw4fH1hdDGsARIEjX?=
 =?us-ascii?Q?ZT+Hr7AKS2iDt2jCyn/rdWDWm13ro2YFJ6HHmlf0HJKRYTryVMfqqLpdjNxH?=
 =?us-ascii?Q?6WDG7Cf6f00fgUY4CbgSJn67dG4glpLLmkJWxcGXUE0I3R0Ot7qLe+T+5LKf?=
 =?us-ascii?Q?SOYtWuVwEAnANT268gIDAvpa47ueObnegRyyvX1NNKp6BUM0saHr7LCaDVct?=
 =?us-ascii?Q?BkojPGNkbDu+KjGx8ZRU7CiQfgR8WtUfc0oWjjpaLUd0H3giUDwlSKUKiQap?=
 =?us-ascii?Q?ro7U4OMtv+P6xkuNp9Ly+vD1+zwFm2SQl5/vHGEOirDa6hcaATxIk0JJOB9h?=
 =?us-ascii?Q?DTlPQdhfozoe95xFc65QyuW2aPdqXZ0dLFItch64pDBW6NB1yO0NMd5Y22t+?=
 =?us-ascii?Q?jS2ESVkXLT9+nYwbX6Q1xBwG3WW2qA6jRoOIjOVU+s8tBKVtdIMAwLgtaHQs?=
 =?us-ascii?Q?x5lJRUc11G6az5lkwoNS/vJPYgQ4tm6qCArltHXjd5mPavUeLN3mscckXMnB?=
 =?us-ascii?Q?ujdPe+qL5ZGVwp1tBTqGQhnbDxP8ga9eLubm9ArIDCUIzN0luy6wzXPnDE6e?=
 =?us-ascii?Q?ELWguBqyY0CIPVyGDiMr9oTfGFreJDyakCz4hi0iFG7HN0FcaALvUBZlk8Vn?=
 =?us-ascii?Q?MKQ/GIODJdS2dRFi+Vihn2ni9EsvFy6xkYHws8yYAyUWXeZTD9ru6do+Az0U?=
 =?us-ascii?Q?RdV0ZSqprrrOAroDsPtmRnQC94LJAJ4byJ9PIjNP7Tt8Sx2T0q+S84e4Ij93?=
 =?us-ascii?Q?pl+q/OqMLO1T9AEs/DeTE36/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9ffb74-4805-4142-ca8a-08d972afde15
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 10:03:12.3475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILTFy/kVxEsFmSo1HVNpJqxxV2Iaa/TUqJ4cMCyIaEdnwXlp3tQmnBvo+aeJTTvCJ7AbCGndyOEUz+DlWyIViQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2726
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

get nvmem cell-type from device tree

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/nvmem/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 3d87fadaa160..23c08dbaf45e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -52,6 +52,7 @@ struct nvmem_cell {
 	int			bytes;
 	int			bit_offset;
 	int			nbits;
+	u32			type;
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
@@ -726,6 +727,8 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 			return -EINVAL;
 		}
 
+		of_property_read_u32(child, "cell-type", &cell->type);
+
 		cell->np = of_node_get(child);
 		nvmem_cell_add(cell);
 	}
-- 
2.17.1

