Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE3C34C306
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhC2F3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:29:48 -0400
Received: from mail-db8eur05on2081.outbound.protection.outlook.com ([40.107.20.81]:19329
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230266AbhC2F3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:29:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ky3oHi76BPdt0jM0HqPgTkk+H2xEN/XPu97945/F35i+ZXIx0M42CUTvKmlipcSgdA72FU4z3s9Wwr5WLEg02cdR09kY3IIj+w2ML6Xw8CDSyeHVZ71uHFSY+/wDv5mSW2NIU4qHVyQIJ4AtoNvLM8en5+ShUXrR8CHSCyjicqsMhxH2XuCEck8S47hcNfd/du7I2eKvdGqs3gkr/MHN+ppJQEXcVcp49A8bS4B2fn18GDqxHq/84fPJSSxxaCyjL1m6tuk/woHfmsCqwza0xAo6RglrsNsdHsmd8No4yAEgcmy21JkXicIFoWQEt9jhIRIv3jHZPO9tJ09X2M8SKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHSmXM7GoabGOuRgHRD5/HE05To9FJUtRlNecFpHVrY=;
 b=du0oUHXyxVJV/VyCPU9o6Bx6eBJzQOj4JPB9ZySicbBm81Kdpu1fp5wTRJJVWo4a7XQr/qaegH1nz3KqmIhe0zO55dY7P5M4GpkNeY1km1kOnxK3cQj2Q5g0/jAaqiBtdaU2pnIDQzgZFL+oCaMrCny3Y3V5ejt60pDAgf5JbaM6zJ3N+k+rc9xJz0PXE8BgyFc585RWTsxblYyvR+F2mDoxXqSV6oimAoFPZbjgwcoFLcWfNd3kC9F3iPP/ULREhbmPyTIj3fb0JLrXHQwkLpuVqaJjRFO7rqhDqvZLQlv+in0OZ4v0hHJTUmjqZG4t2WJL/xR0FDV2S5SCxLl82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHSmXM7GoabGOuRgHRD5/HE05To9FJUtRlNecFpHVrY=;
 b=Qnky7pd7eGjtkkolplpqtCW7ePRFMn45cQSoRB8s539AXgWNXOCkLtiuP27h8/QzThxxzSrPJR6HkskLuU5PqrU/3KOzhvUsyuLOV10DPYystnP4sjjMeiyfVbC4lwGXCGK0doxG0J1DlDcJ9KxKYjS/fgEzj0HIHma1aN2Neek=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0401MB2407.eurprd04.prod.outlook.com (2603:10a6:4:4b::7)
 by DBBPR04MB7881.eurprd04.prod.outlook.com (2603:10a6:10:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 05:26:25 +0000
Received: from DB6PR0401MB2407.eurprd04.prod.outlook.com
 ([fe80::8007:e187:6f31:719]) by DB6PR0401MB2407.eurprd04.prod.outlook.com
 ([fe80::8007:e187:6f31:719%9]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 05:26:25 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, jindong.yue@nxp.com
Subject: [PATCH] tick/broadcast: Allow later probed device enter oneshot mode
Date:   Mon, 29 Mar 2021 13:25:55 +0800
Message-Id: <20210329052555.24487-1-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2P15301CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::34) To DB6PR0401MB2407.eurprd04.prod.outlook.com
 (2603:10a6:4:4b::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yjd-pc.ap.freescale.net (119.31.174.71) by HK2P15301CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.1 via Frontend Transport; Mon, 29 Mar 2021 05:26:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c371adfd-cad3-4390-6510-08d8f273325b
X-MS-TrafficTypeDiagnostic: DBBPR04MB7881:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB788179DF53407F63A0B03E53FB7E9@DBBPR04MB7881.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qx2ls42WY96FS03/5GG1hJ0asfB60pEqwFCKUHLaHj6iGnXCyyCzCbyKtJulKI7AddBd31wG1E7ts8qKMEA88m6mrjJ53zA5UZ1gQf/y6GtFkMAabARzSZNlgyVA2bxvTEkHp7I1vv59Pi/YfgDkbnvdm4ZpZjGgBhQ5JkLL0o6PAhv9g0GzFS+u2M0FuQ2SphUU1zBwkz0m9PVgATewyM1geqYeA88h7dJtVw1+Cxz2pFvaHu7GyQ4qVLm3f2XZ2HhWtmkD4Hv5yoh9vnSDxxRUJ0HLj0BgWuhGnw3oohrcm/fHK+5vr6yZm1R1JEDqGT5b//lqpJ7mVIGQTm+PX3mWchQw1FEhMO4KIOWqtig9AGQrSvCrdAB7U5tbQ6r1wWuUk4CV1CrZcIxrT2wAIhg/2PyBHewtvWzmAet4nKlraLH+eaKw5Y2aN63X2KipPBn8xNcJ2YP4/7yPSN+exRP1Q0W5uQAHjjLhhiPwegoNJXAYA8yALdqTXLbd1HcM3GPH+W000RLXHpQwWr48IJlOEEhS49Ae2aggrLLtBDd9qTXvHacEq9GMqiJIe4ZQNcHCDmENRS9CNGjAB/fUZXfsZouWQjQjkWiGs9Ej2uWElUuADh9fjZROBz9duf8QRkMEEG7C/KE4UZursGPe2wSMRuT8Pp8HTkj26OMu8qNDobMU0Hq3vFkVLtj5OZUC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(38100700001)(1076003)(316002)(83380400001)(4326008)(6506007)(478600001)(186003)(16526019)(86362001)(66946007)(5660300002)(52116002)(8936002)(6486002)(6512007)(66556008)(956004)(26005)(44832011)(66476007)(6666004)(2616005)(2906002)(8676002)(36756003)(16060500005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ehehU4MDhbcsOFv2QYdFmxBriQPZazs8OdGZ1Rc/vjRJmijS6zOZA/XOy0v+?=
 =?us-ascii?Q?aPN6lRc1GWgT76LOLgm+jdp6yXVEzJTc1zWMnODt6ltYDv+9SpDqZwHTEDXu?=
 =?us-ascii?Q?a1vDkvYAOg39fzPxxWgHOyYdX2mk6/yL0KagZqM+/EGiToz8i+Lx4HyZXNGY?=
 =?us-ascii?Q?+GXNCltBceqZfQOCD/GNbxcyHjAfmDHjWClj9yWlSqXlT4adpufmUKEfloJL?=
 =?us-ascii?Q?EZ/Vk/KROGPDIpEBqDlt+OmfPw1jREuQhT7pWOUmOrOHlFbJSBg21DyF/UDY?=
 =?us-ascii?Q?5Cg7rWTgsdWfK1gW/Aw8fCp1nXPs3i2zObm6zUkjsi11IKIZps6+8bDVtjTF?=
 =?us-ascii?Q?6shbt7j30mQxWLezVL239gfqlj23vZjbIXA3821GYZLz6JnJbqg4mIsAD1DQ?=
 =?us-ascii?Q?FiyaKDMGhRIpbwnLXhDZY4szRbKZrGlUdEwS4XIroV/TcxH5tMEFZ81hoXso?=
 =?us-ascii?Q?9evJ7l0xVtiWkKTIrLI1znkj49jsY5GtgRlsTvIUtjm+vT0nHUmhDAXNjlsc?=
 =?us-ascii?Q?S3UQzGpcU7oJRTpygSUGk+lvTRcQbD7BpUf0TP0lgBcVjy+UlrJ213rkCe8C?=
 =?us-ascii?Q?ZSJa+OGev2NbFB+OQMBaVNqPDB5HQCrrTQzqlrC/EXTwcOyMiCE6bvhZi582?=
 =?us-ascii?Q?c6iW/gRuZUSScC33kDZfjO1nChN4SojVuanmfwI5Pbe6GEWEYmwQl9tIRTow?=
 =?us-ascii?Q?d/2ufxNNhrmEt3P3M1WBSsadfwPNa5kYGBUo/I6LZQR1pbaZoqKWvTtAqLLq?=
 =?us-ascii?Q?fGuR05nKD4Hrjw0N+dJTI1DuPve8SBY7E4dkAkYodsAF0DEgFotHrtHxDFD5?=
 =?us-ascii?Q?fBWvjPW9XfHS6h1NAkgnwIhJx5CvEz3aRUMeqZFqkDP9l0OZN56NHy1UM2nt?=
 =?us-ascii?Q?PLQqxP/ZZJMyAPyFU4WjARj3Xmw3BXtJ9IBQHUCUDOUjD851THaqrqXaI+RS?=
 =?us-ascii?Q?zzKr9Y04q5ETzXEwC6TzKrO0EfcYlTEUDjnX6+pgT6JIvjec17MtWpCY0dQ0?=
 =?us-ascii?Q?BuKTZTEf2z/Qi8PndcStY94Q5mLQ0zSEaNPg9wXwk5q06obsHxGqgjwDZpJT?=
 =?us-ascii?Q?GWZdxEJc16ar7YZKR9+zYyEsZrLizlDUpIFl6HOduLxQWH6P5YGLu2U6MIF6?=
 =?us-ascii?Q?2Ka8m9NdiItpkhokFmJ5Gx6NWmp55Qk7IHTx4kv69RJacgahJhGZF3xm5MDC?=
 =?us-ascii?Q?rixnllioDtq+PkE0giWjJCnvLCf9yOFOeVcxAK7HXmThff+Xl8B0Tw+6fiTf?=
 =?us-ascii?Q?ySsSOSm4Em8gV7wQynJor5GK95kU78dYqLS88jUartdCYSeUDosYggVxvKXh?=
 =?us-ascii?Q?MVhDnX4m83uGR5DC0GLGdwzt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c371adfd-cad3-4390-6510-08d8f273325b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 05:26:25.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzKrMaDtko1YDwzO8vbbeBY+21VjpAGnrYphtu2f/oiEwVlcZ2Ma4qY15G9lRmpaH401sazLRHJCl1pnRb+nnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7881
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcast device is switched to oneshot mode in
hrtimer_switch_to_hres() -> tick_broadcast_switch_to_oneshot().
After high resolution timers are enabled, new installed
broadcast device has no chance to switch mode.

This issue happens in below situation:
In order to make broadcast clock source driver build as module,
use module_platform_driver() to replace TIMER_OF_DECLARE().
This will make clock source driver probed later than
high resolution timers enabled.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
 kernel/time/tick-broadcast.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index e51778c312f1..f38a7544cb5b 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -47,6 +47,7 @@ static inline void tick_resume_broadcast_oneshot(struct clock_event_device *bc)
 static inline void tick_broadcast_oneshot_offline(unsigned int cpu) { }
 # endif
 #endif
+static void tick_handle_oneshot_broadcast(struct clock_event_device *dev);
 
 /*
  * Debugging: see timer_list.c
@@ -115,8 +116,20 @@ void tick_install_broadcast_device(struct clock_event_device *dev)
 	 * notification the systems stays stuck in periodic mode
 	 * forever.
 	 */
-	if (dev->features & CLOCK_EVT_FEAT_ONESHOT)
+	if (dev->features & CLOCK_EVT_FEAT_ONESHOT) {
 		tick_clock_notify();
+
+		/*
+		 * If new broadcast device is installed after high resolution
+		 * timers enabled, it can not switch to oneshot mode anymore.
+		 * Here give it a chance.
+		 */
+		if (tick_broadcast_oneshot_active() &&
+		    dev->event_handler != tick_handle_oneshot_broadcast) {
+			tick_broadcast_switch_to_oneshot();
+		}
+	}
+
 }
 
 /*
-- 
2.17.1

