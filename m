Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B9F34FBB3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhCaIdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:33:52 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:22660
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234343AbhCaIdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:33:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT71Xr9pN7RleCXg6S8FCGPVLf6Kj+Nv8b5PvbDT82rJLiI9DlCtbU1X/wQQcI4yf6V5bwHOmpkOrDn7eB2coMI+XaNybxFgm2QRDyswJqarvahQep4fXWDVlAct1qYcuT0CgzOLvdHsAyhfXkIyW2AvPQko8xUu6dIk7HRiMFGWQjUQL5QyGiQuKGr458SoiE/20YPpkGGjmc3/n+d6ygfyfAnyUWmJbLCpymaGaq7ge+ZLoH4lHJLdqgaN0jwGxBVpKbSuj9X+feQ6a9uzK47dkAQc4Jf97mTUsHiBeoR5ItHSynqga6ltpE5rZY6nC4+2JgrjbfDPH/b/0N2pzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwy8W+hCYCj/hOU+s7VfxzP8J2OUKY9CkgrLasF3w5g=;
 b=KRsb2bSmcDeAt/egso63LsGdvTzDl9bZc1KQlxbJWNK07cgWoHnMZthI0a+dGAv0PcdfoizxdU+6qZEM02bn7Px20Ep4fKQKCwaZQhK5n8veJJILaQjOQ4Ohd1erbHi36GkyzqkDHRNOxnV5zM1/paevoCWh98j3NOVIQcTdNBSK+0sJrCDUXEn6PRB7Nynz1xn9m/rvUOyJK6S98Td25f9LoTd084Zpu/6sBwrxyxx+Bc9CNQXuIB83ZFFGMucJ8n+oy0tHzz+RaqEH+gsGEaaeEu2V1hVb8ww0UeSQ9jZVtJL1NThsYNJH9CgtJPV7ijUYZ9IYPJNC+xoPiGMB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwy8W+hCYCj/hOU+s7VfxzP8J2OUKY9CkgrLasF3w5g=;
 b=IgNu+Jl5d+gBEvLYnFE+7XklpFwZ45SN/aI6qG7+piYJriLPTprvyfVs1iiU3i1wTQAEX0TAGLAul7j+g2IlcnNNr3f+JYOQCnN/WTXWG6aIKe9k6uwWOz2mvD42HcsQ6q+8F+YpZ9Gw1by1+T4jT4NjP/QKz8qTzL6lTQKUrmo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0401MB2407.eurprd04.prod.outlook.com (2603:10a6:4:4b::7)
 by DB8PR04MB5740.eurprd04.prod.outlook.com (2603:10a6:10:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Wed, 31 Mar
 2021 08:33:39 +0000
Received: from DB6PR0401MB2407.eurprd04.prod.outlook.com
 ([fe80::8007:e187:6f31:719]) by DB6PR0401MB2407.eurprd04.prod.outlook.com
 ([fe80::8007:e187:6f31:719%9]) with mapi id 15.20.3999.027; Wed, 31 Mar 2021
 08:33:39 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, jindong.yue@nxp.com
Subject: [PATCH v3] tick/broadcast: Allow later registered device enter oneshot mode
Date:   Wed, 31 Mar 2021 16:33:18 +0800
Message-Id: <20210331083318.21794-1-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.70]
X-ClientProxiedBy: HK2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:202:16::14) To DB6PR0401MB2407.eurprd04.prod.outlook.com
 (2603:10a6:4:4b::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv11135.swis.cn-sha01.nxp.com (119.31.174.70) by HK2PR02CA0130.apcprd02.prod.outlook.com (2603:1096:202:16::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Wed, 31 Mar 2021 08:33:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b819243b-1786-4164-7678-08d8f41faed6
X-MS-TrafficTypeDiagnostic: DB8PR04MB5740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5740FC8399A8DFE6C508ED72FB7C9@DB8PR04MB5740.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAVIQC1CxyNADp1ROni70RvkadEPUn/XY706P+Z2MBYBnBPnjEJIPAd0HEXcB3Rt2IclNDrB20tbwiLrIeaqyoxYK5R5/ZAmzI/R3i/EDmcX+NWIg2NBzVxW2/jJtR5Nye+vPDfWllfFYav5yRDkVPnN6oMe5RNDE5lca8mxqlSvB21NGv0TXPvugSvQc0qSGEMFKFlqf1alV3Q7mCiyr3aRuYbb8kl1nBoB5l2woT8cy2ah6VCvQTK/MPPUBGt+TC/UcsQlDBcFAHZ8mJvwGbG2B0MyT5vB/DarQBOL9O7zLwvbj+NFgRUF87zKBYKbvFhAbFfkYdMHgSFmYLDtdW+hmnGQTEK7RbQW2/C4MUChspSVDGe0JOeB32t7Tff0pEuiCkUXrMB0ufqNLxQhzh9z2ElNEtFEbQNoNZgC2DWk7EjQ9oHXg308rDC8P4bXyET6PUFwPOYYEXYNIQ/R1d1F+ZpwrjcvimMAz+NO9iV/b5GiTNJc49FmxQVol5R1esgh3zVVoBzWRYR3LlBQWW4+OqIAIJlZ8Kjx8+EPQ4T/S6R7a8CQ0ezPBmtq5CnGFqxnaT64dhhA0bznztFUXVz7Rhvu8DuB248rAReddTX5FAOL7UYQ4Vvoze0XHn5FlZVOi4L+mQz2HXJ6i/ZYqKGe8bKygqIt9Dy2s53NYXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(44832011)(36756003)(5660300002)(7696005)(8936002)(1076003)(956004)(66476007)(52116002)(66556008)(83380400001)(498600001)(8676002)(6486002)(186003)(86362001)(6666004)(4326008)(16526019)(2906002)(66946007)(38100700001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hph/GeEfrFei2mtevab/27mD23kAsLZHpxUKc3OqStdpxfCqNu9+tDenlicE?=
 =?us-ascii?Q?wE+tZxRAIRyo2bmWuDdahIKmMxXFqCWvBALTC4AqsSvq2WQx/xsPAT8Svf2J?=
 =?us-ascii?Q?B0lxRe4+KULaKC8WEh27DTQO4rFC5BTjdRDO037e6WIlYeRfAzbPsnPfqpHA?=
 =?us-ascii?Q?aSXcSEXbfZdvQrJTyiGK3tkhakVjl4sx6ie2Yc6ns4pocx3DGiwZCGXm/ZzR?=
 =?us-ascii?Q?h22cVmqHLV/G6jH7n5EcF9XZsn89S9EVnZizEQW1lx1Ehq8RIxxWvl9b4eQh?=
 =?us-ascii?Q?6b5RaV9vJso1n+9xjt6Fc4i/lbn1gGaXTmqhhNz29j7AqMSAaQeSMdevHpz2?=
 =?us-ascii?Q?CnpTAB1adLxVPJbASdpX2sHC+/53mDeef9Op9bWg9lcVFrU1AXLZbXlZKpPj?=
 =?us-ascii?Q?GHslDqHI1CGy7Vy7HzWzleimioZHo6rLnDOBD3GXw3XyZG5sCom1H36paMS7?=
 =?us-ascii?Q?aE8+IHBo8BSvqsYuqWzNUxU394OjVCB/JOoax2SeuoxNTStEUTvaZbvpkZnR?=
 =?us-ascii?Q?+FBHM3QzDVTROnUWaYVLlETblirLQ0WQo1suZQX0Y4Eq8WPL5mJRKFVBEeGg?=
 =?us-ascii?Q?I2ApdOhbUoN4jR3ECD0tUr3wbTW5Y3xxBgW+EN3RDKwHuJl12ApPSMzJsAjC?=
 =?us-ascii?Q?Msf5nWag1bCwnz/w71QIKOcRCV6JS1LkKJdsmucSTFoig3mRE++erqF5OXUw?=
 =?us-ascii?Q?a0KgeOJWkuf1x3P/fHK1QM/CLsR/R0xR2SSOc2K5acM/+H74MRZzY+GdGPyr?=
 =?us-ascii?Q?9BXTXEd96ZdRqGrJtt1Rx369XwOZzfGMBC3N0o/6mFTkLxRJsuScpURN8Uw3?=
 =?us-ascii?Q?TdT8GXveLdMbTcYip7QLcc1kCVXZ0QH2G/A7chLHFMiSFiZdzO0oZ/M/F4wh?=
 =?us-ascii?Q?WolbOIlkijkHTwI55uuTm5a6omj70p1FmYE7QGa3S/UI0GJvmhEIJyF/ZRKV?=
 =?us-ascii?Q?dXfRgAVOSuwXya8zVyiUlWvTC1XRq6jb23g93KMqXmEpYqTn23XWr6zaD7Jg?=
 =?us-ascii?Q?tbiBVVra+MvmeGN6uko9LiZXsNZxZcQcYWVDkVHWU537PHx+PXfvLyyWFXHg?=
 =?us-ascii?Q?uLxgaN8n5fHoF7zmNHZo18ECCmVCo6Cnz4kRnpdvys6t0feobG7pgGKyjnZ7?=
 =?us-ascii?Q?IABV/PBR/0ZCcFr88DkwRFbXSH8Ct2mfTwd7Xs5RjRmHmGHkmqNknuXwhnnS?=
 =?us-ascii?Q?PkMOPHhNbFha3vAxk11kRXUmHI3XTx7WDHCq3Kr5H4m7dWe22/js33MXT9X9?=
 =?us-ascii?Q?VWzSOTlQggZpBhBE/wrPSxfQzJ7QpHGfAmjM+WZUXMfJz0/a0sOVVJEJdpo+?=
 =?us-ascii?Q?S6erDH/QNzAGFd3fLIQeEu9b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b819243b-1786-4164-7678-08d8f41faed6
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 08:33:39.2567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIZTDNn3088KZCsfXcJBMj18GLhnU7GVB1jnKWCqecZQNWH3ZP4EscvJiFpQohLrKz4Z5FxX2smiyn/7lviLBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5740
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcast device is switched to oneshot mode in
tick_switch_to_oneshot() -> tick_broadcast_switch_to_oneshot().

If build broadcast clock event device driver as module, and
install it after system enters oneshot mode, then it will
stay in periodic mode forever.

This patch allows such broadcast device switch to oneshot
mode when register.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---

v3 changes: 
- Remove useless declaration: tick_handle_oneshot_broadcast()
- Refine some comments

v2 changes:
- Remove below condition check before switch new installed
  broadcast device to oneshot mode:
  dev->event_handler != tick_handle_oneshot_broadcast
- Put tick_clock_notify() after check system not runs in
  oneshot mode

---
 kernel/time/tick-broadcast.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 36d7464c8962..f4bc384d8f1b 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -107,6 +107,19 @@ void tick_install_broadcast_device(struct clock_event_device *dev)
 	tick_broadcast_device.evtdev = dev;
 	if (!cpumask_empty(tick_broadcast_mask))
 		tick_broadcast_start_periodic(dev);
+
+	if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
+		return;
+
+	/*
+	 * If the system already runs in oneshot mode, switch the newly
+	 * registered broadcast device to oneshot mode explicitly.
+	 */
+	if (tick_broadcast_oneshot_active()) {
+		tick_broadcast_switch_to_oneshot();
+		return;
+	}
+
 	/*
 	 * Inform all cpus about this. We might be in a situation
 	 * where we did not switch to oneshot mode because the per cpu
@@ -115,8 +128,7 @@ void tick_install_broadcast_device(struct clock_event_device *dev)
 	 * notification the systems stays stuck in periodic mode
 	 * forever.
 	 */
-	if (dev->features & CLOCK_EVT_FEAT_ONESHOT)
-		tick_clock_notify();
+	tick_clock_notify();
 }
 
 /*
-- 
2.17.1

