Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1E34F5F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhCaBLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:11:34 -0400
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:10646
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233470AbhCaBLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epbjuuw3N4cOWKRayBMF6JadD7BAPnbZ8/0o7bvTyuc6RyeVW3Bfoqh+PzglS9tdtKToiQkuCMMtkWR/Zqq78y7kD0b1vKczrGb1i0nDphULGOtF/OcCMFngy7ekY3KI/nsYu/moPKyWbf1gY8RvEOMEQIpIQe+UqmwloS9kv2cnC84c86cL2j9mmbD1p3CVARc/NXAY1T7JcxnrbUY16wihIYZ6yqtgqhUE11DLs34WzRe5vf3Jq1VvyVPCOho8BekT4l8/1r7IqoP4PGFKUHkiPnElUNtvnfdYN/vmaX6aLMHDCkzmJpb5iIOrtpE6LIVlu5L9rSZEWh1kPdyifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgBHpnpxJSPxwFLL13u9QAgvC+QHJoJcp5Nz1utuF0M=;
 b=hQ42xQ74iStjvdhzDJqKQgxscFG9zX+avYKkMLttINGAekKiwNGyM1U9Z/nqUVF0ivu/kPFaVwRYs74wm4dGSOUPmCXRjSBhhYaSfB/6Lsw886k1y5LeT9qKb08ys758+miIBFVR1rJK5fIzSpFGemyrM5iB0JF/4Cov8Cw89ZGgH8Ly6FyJC67ljC5It3y8b1doLdKiaO9RuqXBDq2psjlDUDvPR7fi+9xvGeaGfzsqSdqkaUHMAL8WaMeizY2zfoX6gjIXU0BdKRTczZYzTefTuVVxutDivqn+NU+LE81UlFK+uQHWIql92LyUuQnoWDlIhe4GmLJYxO+Pq8hx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgBHpnpxJSPxwFLL13u9QAgvC+QHJoJcp5Nz1utuF0M=;
 b=JKTrNhM3p1sm/U0GhSJqDFeYVP+Ghnziv3DAc3bpKMuSqPcqQBsz5seeDigxvfDS+VDJvnR9NDLVp7G49FD9iDJEBFUv6GAo41KqZEzccG3pKulSuz7e2WuHLgjbo0Hgv1/fJsivcazoXjyEpgpDa3ZpCPWy8EE7XFiEPtWswEs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0401MB2407.eurprd04.prod.outlook.com (2603:10a6:4:4b::7)
 by DB8PR04MB6955.eurprd04.prod.outlook.com (2603:10a6:10:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Wed, 31 Mar
 2021 01:11:09 +0000
Received: from DB6PR0401MB2407.eurprd04.prod.outlook.com
 ([fe80::8007:e187:6f31:719]) by DB6PR0401MB2407.eurprd04.prod.outlook.com
 ([fe80::8007:e187:6f31:719%9]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 01:11:09 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, jindong.yue@nxp.com
Subject: [PATCH v2] tick/broadcast: Allow later registered device enter oneshot mode
Date:   Wed, 31 Mar 2021 09:10:45 +0800
Message-Id: <20210331011045.25381-1-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.70]
X-ClientProxiedBy: HKAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:d0::20) To DB6PR0401MB2407.eurprd04.prod.outlook.com
 (2603:10a6:4:4b::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv11135.swis.cn-sha01.nxp.com (119.31.174.70) by HKAPR04CA0010.apcprd04.prod.outlook.com (2603:1096:203:d0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 31 Mar 2021 01:11:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cce4eede-efca-4acb-cc22-08d8f3e1ddb7
X-MS-TrafficTypeDiagnostic: DB8PR04MB6955:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6955AF1ECFAA88A1FE4DAE82FB7C9@DB8PR04MB6955.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m9cFEh+FF9izTMlvnYaCsLWhkG4SBlmSZJCXZnN3CX2GoocFO+JUrilQMdOSNHVLa0pQ73kh2cFnqOysZsz+u6mxKXoIoL8ilEbTw42yDiWmLmrr8ks6lOS4lZ9dxMPYavFZI1+NLmebQzpZEHLf2zt4nu0Ggw2hotf7zC3fdP26e15g5YlOG2m9DcAtyvUPXNJoMrliY8wfSZwz8RU4+ZEdqFP0BDKdsPnnuHdrxOCMD/mLmHfwAqMX5efHPk4VipM78YG5VWMt0gMML/Ge+B4DNkjdWLdjyy/InJEW2BjbBAldGZQt1lWT+70xiq+Y/J3Kk9m1iG7ZeCLe9zOjcej+jSLGoTGKzs5ECDF0d4XHZTTqwg6Mk7x9ITj+T+tBPwX0wF8WLq1wlfMBHmFVW0hc9G5jrVf3skhoF83yuFeWuBVGDZtCV3uCn5YZMIWAHOYBCfdDo/Ixmj11A4aSi60+vjwOskolbCfRb6Q7UFfIems2a+DasNk7zjfUDilBu7Jg5GDqVZP5KQqYkoKeiGNHZ5QpGBWC+H4f++CuVJ0Rc/jGIgnKkuENZB1HFuEv9/XXHekOEOp1k5cvlISHtGmqnqhaQcqbRDTAaqne/l/Qha8gZWiU/V+BMU6XDMoo4xdLpjTEPG7jrzIwqIfZBWap4uismi+ijm1OVIBhvr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39850400004)(136003)(396003)(8676002)(66556008)(2906002)(66476007)(316002)(4326008)(5660300002)(38100700001)(66946007)(2616005)(16526019)(478600001)(8936002)(6486002)(1076003)(52116002)(186003)(7696005)(83380400001)(6666004)(86362001)(36756003)(956004)(26005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DSk+HER2FWu+d9xRshNQbDe/2FzB0OttcykVvaAhrva+MoLZX9tWlLsgODzD?=
 =?us-ascii?Q?txu1xKasHoU1nVhj2nafyIvO8hH2cBFkfdfNwolBdrRhM8FbCg/3Os6DmcJG?=
 =?us-ascii?Q?bGcvguGOMzmJzlxXg5AU8086TLYC+mTaDSy/1mRbWgJbXv2LGPJwO4Wu5wxF?=
 =?us-ascii?Q?mDC8SIiCiKgztJqqj9CX5Nro5fmTRcbFqwCWvNBQ9/6YCVPKEoVSkYuWA3HU?=
 =?us-ascii?Q?syD1wRqKxjraKXKVbFpw/0es/qh79dW5ukqfBOXdvu5yPIbp2KX3YWfDyrad?=
 =?us-ascii?Q?Ns8ibFtgWVl3wzt2nZGED53oCt+e88CgTaSD+3j8+jK/BdMIBV4kg+T1Rmdx?=
 =?us-ascii?Q?24MBYOSpaWNB43kTqqjb+i8r49A/gm2ouNlh7qiE0fSSu5UY5aWVdw60/dEn?=
 =?us-ascii?Q?68wJcKHoezYnwqq9W7kP4hMH6j+1xYhI1dSVPmGvkC9Mls4vib+utonYsBwu?=
 =?us-ascii?Q?okTPWAotyi8L/ewZIy15a59zDiYFs75i9SCX3aeaeMSbFIx0eXPvr0N1AoZ3?=
 =?us-ascii?Q?KNzhYQxmvis8n3UK8QseV7t63FrNvukbMOT29sSklg7S9+g4XDSxQBwlObD8?=
 =?us-ascii?Q?sd7E6lghnbijTikbdL7OoSXppzLSJ9YHr0XmeRrCl90EBuua5rZhn7qH4Wzc?=
 =?us-ascii?Q?V5rmurK1njOimzGs96ROq3B5DDTUjvPRzDahLbLNgMlO4mvBdc3RHPfCuMnb?=
 =?us-ascii?Q?elCZE85U6TFtnvTyQVYMBfQp69u+9lq9zBMQrVR5W8HWc9sIUsGkw8a4yxHo?=
 =?us-ascii?Q?9ygSTrfUb38IEuRFf103v8X/4TsKiFWYOWVWSuVrcBB/HPkN4lYRv/sEBlic?=
 =?us-ascii?Q?UrVTfc3m9eWzpnUZHjUuml6RkGmJJOno0I7ds4Go0irE59iaWfFUZMK/PklX?=
 =?us-ascii?Q?A6tWp1RgTSjr5H8FkraO7jptevotDfh9sIV30VlGaiMVXEy2mtl5zclMqIDz?=
 =?us-ascii?Q?sOwj+hx5qxgrFDz5EKQ+PQA1AM44eAID/XZDbTbZZY9rM3H7aZt7w+W3IdMq?=
 =?us-ascii?Q?OcWxEBFVvzyvzHZvUk1tUsJ5fV+CexSgHZYsyFYw9hq7msn7P8Ra5e1ky/ro?=
 =?us-ascii?Q?lyNqB2nIQ1eBYH4qzoM1igTqUiNy5YY5j47gifNq3SftmYansRx2B58tJIx0?=
 =?us-ascii?Q?pup47/Cq4ypXeuRCJGRGlvc/xlgABALfRNFh3tGp7zfbAFO5hUkeGX3z3ICY?=
 =?us-ascii?Q?PV4UsDXose1UH+wIwmDUtZRGwzfbruhk1kD4Xzzwa6zNLVz0ibaYNd6GUX9M?=
 =?us-ascii?Q?YG+rCm9bTOcDcLH40ooYJtaJKw7SL2eku9Hzrl5qUzJ2/3atna1eC2mTIXSs?=
 =?us-ascii?Q?xuBEoLa9ORY9c21VvbS9EFYD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce4eede-efca-4acb-cc22-08d8f3e1ddb7
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 01:11:08.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tE/uatvzmssZPFUPcAJWYPhCdiX0sf+HdSQJAi0YAKM/N/erbnc68eWp35XF/8Fm5fo6+c9nZAAjisKGC1kBiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6955
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

v2 changes:
- Remove below condition check before switch new installed
  broadcast device to oneshot mode:
  dev->event_handler != tick_handle_oneshot_broadcast
- Put tick_clock_notify() after check system not runs in
  oneshot mode

---
 kernel/time/tick-broadcast.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 36d7464c8962..c5e67685b0af 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -47,6 +47,7 @@ static inline void tick_resume_broadcast_oneshot(struct clock_event_device *bc)
 static inline void tick_broadcast_oneshot_offline(unsigned int cpu) { }
 # endif
 #endif
+static void tick_handle_oneshot_broadcast(struct clock_event_device *dev);
 
 /*
  * Debugging: see timer_list.c
@@ -107,6 +108,19 @@ void tick_install_broadcast_device(struct clock_event_device *dev)
 	tick_broadcast_device.evtdev = dev;
 	if (!cpumask_empty(tick_broadcast_mask))
 		tick_broadcast_start_periodic(dev);
+
+	if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
+		return;
+
+	/*
+	 * If system already runs in oneshot mode, switch new registered
+	 * broadcast device to oneshot mode explicitly if possiable.
+	 */
+	if (tick_broadcast_oneshot_active()) {
+		tick_broadcast_switch_to_oneshot();
+		return;
+	}
+
 	/*
 	 * Inform all cpus about this. We might be in a situation
 	 * where we did not switch to oneshot mode because the per cpu
@@ -115,8 +129,7 @@ void tick_install_broadcast_device(struct clock_event_device *dev)
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

