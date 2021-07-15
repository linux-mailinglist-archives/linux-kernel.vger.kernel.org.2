Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5442A3CA041
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbhGOOKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:10:31 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:24740
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238383AbhGOOK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:10:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfEUCcVmLpAPQgSQMdEZIY2oUEeoMWxKz1NETmlDThcPGU/0vu2qP3Wp6/HDsUDrReklcaX79R77AHh7Jcr3ithaWENXr4SYQKocjrDiTX7T1BcNOWemdP/Cm315aN1qhQxglwlYNXj+ciYni1vn40/s8ebyGljAou+CH9nEahSRtQcCsbNVF5GtZdkdKO6ZsRz45LSp9vEh5i5sbFn6zmlyT8b5TH9+98nhuq2UNz4I0WbESI3Xr4356ZibihIG5BOGlE3AmB4a6kZHKlDNqDIfDXoU6DLcz46UxM4Ui6TxDr8TtHA57G94agke+DpSrYhSB7pFLqq+FFoINeG7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6lCpY3M7Si2ro6/gvxdaB5PXgcdBDpU2lkWc/TwNmg=;
 b=d41QVgFI193r50HiNy1fKr/tYDO3utOYpUgugOr3g+2u9BOo9kUXzEopgm7nY9uoTFwqAdieTq7yznL4+yavQzlsjeIE7qhQF2oo2sD0ks3dS5o6rs2zlqz+otohxPlRNLKK6aABQK8y23w3g9BNxJ2RmiYmswtny5s6/luZMlYtwLvZ5mhaF3WLl+rxPdktdPi2zSU+1wy0bER9nS8w1QxDRt8EPF+lR8kAmIPfz/0jr0w9b09hoVRYnaiX5zkCqYg52HDGNUVDaU7gGcTtASMwLeOld7gAEXZecixZ2vSIl9HKw1MjE/b802Iyx2MIBtqvVNdFrV0jH7QiytuAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6lCpY3M7Si2ro6/gvxdaB5PXgcdBDpU2lkWc/TwNmg=;
 b=QfCWW1k2NPr6mYhI1Q0LTAuAzkx1LS6jUlkr0rs6xYLPwNaev7gpUDEQsSY/pVPWuAFpq43hqDV0mk2Fx8ZrNy5dLJjYpwZHfowfklKKVJgioIIlp+KYNZnkDq2tNecFodD8nG925SAcNQ5v4zEaZoCLqpAa31dSY3N8cLGulD0=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB2973.eurprd04.prod.outlook.com (2603:10a6:802:10::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 14:07:33 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 14:07:33 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com, jon@solid-run.com,
        leoyang.li@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Robert-Ionut Alexa <robert-ionut.alexa@nxp.com>
Subject: [PATCH 7/8] bus: fsl-mc: rescan devices if endpoint not found
Date:   Thu, 15 Jul 2021 17:07:17 +0300
Message-Id: <20210715140718.8513-7-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::11) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM4PR0101CA0043.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24 via Frontend Transport; Thu, 15 Jul 2021 14:07:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c41b9833-88c0-4f12-fc6e-08d94799e43a
X-MS-TrafficTypeDiagnostic: VI1PR04MB2973:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB2973A6F6D45D0F1EDEAED525EC129@VI1PR04MB2973.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtsVTtt/JAjxK5nOQdcJD29/fbjgtjg2RX0+G6M03c6oDPiDDQI59moB0aDGYLtkBbdtUTzAC6zQUQgN7jBuHNjCN/DOjp25joQAIzcGfgilLv1IcNnz55YCzHBwc4fUITb/4XKOUYbxZOKIf+B5oNsRcGLTvlseDZi/Y+jY/phKzWQDcbjgmZonP2iQbLhJPfTM74gTb1xzh0CjxOkimF5YuZQDZUYYYoen3f61tShe3sQwxZkIvvfjn5gdyVV0lT+jP0ZLgiJldweE5IliH5PNLw8NeEqMzqIrU2yT9PMOfLv7F6hv+UrW36nNnTTLW2bK+dGLQ0gWoDuvYcYvCaPU2ZCf5GkYrtV5LkiMPRX6c0I7Iw8DDIYNV3+i8aemkilsvNKBuGn80Haejic6D75wbMpV6frs1lO3G/md9UxD6ko4/e9msXdwy+CmhDgdoZX6Z5NcoRw0HLwdEqoAN6aILv9RRqnQLFRKQ/7xi7mxKBimyT7NJXhK5XYxSK4KvMq4wrdfmwqkddsXuVvPsZbvVB1nfDCd2xDimKB7k7Z+jkvv18dQZu81V50B/N/lwYkK/GM1WF1y6Vl6dwshdQavrGetpenyxWprh5+UDalHR+8u3VTANnchmsM1lAST3eX63+iHMXtj6Nld7ev2HKxlpvFXRv13gWjNII7hJ5dVS36PRWv1pPFsNCSzI68lLqJvDXrNd7Nrr0XqhefRBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(66476007)(66556008)(54906003)(2616005)(956004)(66946007)(6666004)(6512007)(4326008)(83380400001)(86362001)(478600001)(26005)(9686003)(36756003)(1076003)(52116002)(6486002)(6506007)(38100700002)(316002)(8676002)(2906002)(186003)(5660300002)(8936002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ICyWfdoXkgla/wmlkDkbaQS3FF2Hw+HqM/YyFYvqHpBN0xSQMeekuuxN6GE?=
 =?us-ascii?Q?QKrzQT+vuikwmZcg2ivzqEkYaPHzjSv6bvT6I6Pe9RAFDQPUkVH5d8eNs69/?=
 =?us-ascii?Q?eAbLtSXtDY4fozHqK2QH+ud2j9SCKGlC46lIdWN1++N1LNyvFWu0JxsflVWN?=
 =?us-ascii?Q?PBEGs8w4QBJ/OpZecNKAW+RhWdU//1DgLa4l+EaUV8OwpEoePOFeri2MoopZ?=
 =?us-ascii?Q?MaxTrf2chQJF99PwGXSenLaspgfyd1f1XbXQwO21J8suJDcyKqHFfjeyn+u5?=
 =?us-ascii?Q?yqHqtBctKhBcie5gepQ0riysvAz3Dp7lyZffwWVAts7JZZI/O6esqtYy7rtZ?=
 =?us-ascii?Q?Ktd5ErImScRksCnOg3XpWPIFXJcdJVXfC3GxVvyFcfvHTQMsxlzp8vC+X/hq?=
 =?us-ascii?Q?7luKt4CEB8LU/fIhoy7+NIOddBOEYnmNQATzCavtopTxAdQ9mjwCMsP4G7pb?=
 =?us-ascii?Q?hyjQyxsede0pIt5zDeDGxdeZONvH51Y4M29HQnNkTvZiEChXY8L5iyl6pYrM?=
 =?us-ascii?Q?aHPQ2+yEMlFN3AXeBTaZes+klh4K+Uy8edroXSTpj+t5fWaG+BhH6BGvzhhv?=
 =?us-ascii?Q?R0Z2BvG084ZpR+0BEiYwczxjouvg8dBR4V0IP6F5WzmPmGH1fRA59OS2Ue36?=
 =?us-ascii?Q?hI1trpRCSFGDfcMLGSCO+FhaQfxV3nOYc7GCFDMIVLtzUGg1l3g3fYRxkwbh?=
 =?us-ascii?Q?R0deGWUFawrfRnb9P5ZheXHAufHAx2+BcjcqHSnPuEE/kMeLoH2xj3P3jeqD?=
 =?us-ascii?Q?Q5ppUCNqs1LTSGH0OgR6pub0SaBYHD5iULPjdOMEEhcV5pBkJjhzEZcepOWL?=
 =?us-ascii?Q?EMUlAkMza0FJNSYfODJnWXsp1TUnAxE1ruLNWFaUjMddwEF/XKLK4K1PteON?=
 =?us-ascii?Q?/7bbzm9c3Vh86y3SrKsF6BQukmVPAwTcltsEwXKZKC/V2B0X0mBDHJdSC0Zs?=
 =?us-ascii?Q?85vmfTQ368giQKGhf/Myj+uJ5vwcCp4+bNK4X4hmoV1BGVqa2Rf5e/l9LMtx?=
 =?us-ascii?Q?RHsuUeXwebS17peI9j1N44kMgUkJDoTdO9aFI+2PhK1oc6bwdCyno4FvDiHr?=
 =?us-ascii?Q?3i/IvyCBO4tHROQ2VlIxvTWxU7zb4rNvOZ++letiBAmbdpkBVgire72LfGNR?=
 =?us-ascii?Q?Q5F6XqwU4CrH89quucgy7xYbs/Wq79bWIMdivWYQQiEriACzfZfy6yUYfTZK?=
 =?us-ascii?Q?5nGtxZ85ZBbZeeAdQG694ZcjjdAbR9wiocC2sER5iC7TbRl7IfBqklTgPqPo?=
 =?us-ascii?Q?1H2u9hcSYy90wzkP98KwaE1YK3ydo0E7m56zA8rS+byfIVeBPfu7RLFQ2Cx6?=
 =?us-ascii?Q?8o6H9Ig2wqC00jkQLeiudC98?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41b9833-88c0-4f12-fc6e-08d94799e43a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 14:07:33.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJ94an5LH3GYQbVK4+wIJ09Uv6Lv2ztFHUGVQ1ScbZVx/6NN7tJoNB8XbqRt5Euk8DpW2+HTR2fUO1fcc8NJEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2973
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

If the endpoint of a device is not yet probed on the bus, force
a rescan of the devices and retry to get a reference to the
endpoint device. If the device is still not found then we assume
it's in a different isolation context (container/DPRC) thus
unavailable and return a permission error.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Robert-Ionut Alexa <robert-ionut.alexa@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index e5b4830cf3c5..31595017d207 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -950,10 +950,28 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev)
 	 * We know that the device has an endpoint because we verified by
 	 * interrogating the firmware. This is the case when the device was not
 	 * yet discovered by the fsl-mc bus, thus the lookup returned NULL.
-	 * Differentiate this case by returning EPROBE_DEFER.
+	 * Force a rescan of the devices in this container and retry the lookup.
+	 */
+	if (!endpoint) {
+		struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
+
+		if (mutex_trylock(&mc_bus->scan_mutex)) {
+			err = dprc_scan_objects(mc_bus_dev, true);
+			mutex_unlock(&mc_bus->scan_mutex);
+		}
+
+		if (err < 0)
+			return ERR_PTR(err);
+	}
+
+	endpoint = fsl_mc_device_lookup(&endpoint_desc, mc_bus_dev);
+	/*
+	 * This means that the endpoint might reside in a different isolation
+	 * context (DPRC/container). Not much to do, so return a permssion
+	 * error.
 	 */
 	if (!endpoint)
-		return ERR_PTR(-EPROBE_DEFER);
+		return ERR_PTR(-EPERM);
 
 	return endpoint;
 }
-- 
2.17.1

