Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200BE3CB4BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbhGPIzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:55:11 -0400
Received: from mail-am6eur05on2080.outbound.protection.outlook.com ([40.107.22.80]:30840
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237433AbhGPIzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:55:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+SVFz23RyFV4Iy4HL/bQVGDxA2jcHjC/40TDFItglBEOw9DEJKDJ2tt2sYHm44jPQKWcusVZjtC+fFWSEptixlHI1mHtV3hnCn/4mty8PNbxwusCizT6eTPQj+IVTYBZA7cKhcfFxPw4vhTYy7tvP0N54af+xl/hquFtJLp74dg20/qvOPhrW9nyp4AZZR7QTj56i8Z+y5EoqsSKdIVsgnuL2FQwmzLNHN7P1oykgRqgFDzyrHZKVZDmGTPjqyuy2t8ory8q62siZ+42QJt62pxN5Bs32boMBUfIePCqhS8pl7rYNvxIvqx6+H4FseWNBxWFmlN9ECMHpsgkx4GCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8iJASn+k+hE36e7mucUotmHPbltM93635xrofcgJXE=;
 b=kZMXe8dfVpJ8lzx2TIrcClmWyfZgNyEukZq36sV2LRxqksvW/e17a2ie68DVTulZmdmDyeKQGFkVAtYMucwaVwCl0wkrmjEP6oNAq+AgyEMXIefcIgFlzFVJIAv3SEPch+96hW2Iv2X7vxnq47SJ/XWXKm2G4uTi78EnOIZ9V8l0c3zFXvswmTqJ1iDi6uFc67NufsSoRextDgKZ4ssQyfrk63c4S3Hs6bXIfmh69r0kuOcODSRkqbtxNNyiU03c+sP6SrQ7eoFVjjZEvCRxE2Tl+yf/vDGpsKqNwSWf8GMn09xFaGRtw+vYUq5spL3vlTw/Lw7zr+iOkY70ZHETFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8iJASn+k+hE36e7mucUotmHPbltM93635xrofcgJXE=;
 b=WCwxBOiDPctp4G8KVW8USvTanERZudNKhhxiuazAc6XOjz2ryLPj/HgmyWkBbfDEfAqfG9wJbJwweSUmETMQEvH1IXnG9XPqgUiZwT/RsdZchJGvrKUbkM5bfb5JXagnsjy58B+hl+h0pZYdWYZzXpLwMTSWzMv3eFWV403+1mI=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 16 Jul
 2021 08:52:12 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 08:52:12 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiaoning.wang@nxp.com
Subject: [PATCH V3 2/5] i3c: master: svc: fix atomic issue
Date:   Fri, 16 Jul 2021 16:53:14 +0800
Message-Id: <20210716085317.3572224-3-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716085317.3572224-1-xiaoning.wang@nxp.com>
References: <20210716085317.3572224-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 08:52:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f812006c-92a5-4901-3d5a-08d94836ff3e
X-MS-TrafficTypeDiagnostic: AM7PR04MB7142:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB7142D03522F6847377AC5B81F3119@AM7PR04MB7142.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7rChvOnNm7R4I33kOPSf+E5OkdHW0a/d1CEcV60S8Q9VEhzuacUtf6lmjj4fui5MBva1IZGRkJyyS2WCztWybqUeFtniUO0M7B6oD1YbuyPL+579ff8bbzf3voEhLMCMe1Kcj6sX0k5DRHQmJzEwiKPcQSKEywUeElN4gHtEG8tE4+JE8c5g49O0+kh9vEXnPE7AbUJEpYgqk0oqtfbyIexssB15eW7gEsFcsQ8dq72Wqza/emgPon9KNb7GYNCoCDVH4w5hTZ/myTry79GvB6lkXQRsMkRLhH3Ye5i62H4nTUmjzWz9HGWjKIQFLxWh/y0xSeK4i6efbe4lev19wQg+MYzuJ9l4dU3D+20OOKxJhF6CRxPGivQk/zJerZwEOlPBi63qm7NDGNWbrWH6r6l8PEW+dCktERL1EA4XQLh/hk4O7HDHliYfzyUXt4oxympn2bmmrW1u0WQGGBDUgQlwwQ1RmCHk0vbdxdDlYpj+HyttL8dASw612H6QnpGOx4fNb49SACgLeUGKfCTxdbD5UJw/+eDL71NUaAdFrw+jba4QuJWFhzioWj9+Hw7w/M214/nvM0F2j3cBN+0R6pRb4ACk2Zb0Ri020HKvLcdhtbdDrYyM2vhFC6VBlsU7oP5QGKn6f0tVvAey12NduTuxGNzwnBsKvOUKWJKMtgyK23cRA5z3kHD8o8YiSHTLFh3dQnQIqAA3f/fEOsCaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(136003)(366004)(376002)(36756003)(478600001)(5660300002)(8936002)(316002)(66556008)(66476007)(8676002)(4326008)(86362001)(6512007)(1076003)(66946007)(26005)(2616005)(956004)(6506007)(52116002)(2906002)(6486002)(6666004)(186003)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iH7SRjtUtiQ9RiwhJoQfeylX+bEInCQSesoJ0kunokdcuWFKnsnRsCXGtkyo?=
 =?us-ascii?Q?A/HFe1mdoAzd125dAHlljGtGIUkZUpMePZhSKMi7dR3J6G3gE63jvQVp825F?=
 =?us-ascii?Q?mFen7RJiHS/dKp+/prZGRV4K28RnNPOYIAXkxLwwAEBt/ZZwZ4CQiNYiAJCd?=
 =?us-ascii?Q?YIjoJXK5KNrJDs+sX9nvL1x4PX4NyFlrZoBoiko4a+LN9hrSucJ6+qxd5VOr?=
 =?us-ascii?Q?Gt0WzV3vUpd3IPnZuyExTWC/g5Y2elMZz6S+uMKgOzUQGIF0bsdQ/HvK+0S1?=
 =?us-ascii?Q?066iy1mFhREpyfP1nsDha2frLXNgReK4m0WEyEFhqOXZWWlUD5sN6nFL69BU?=
 =?us-ascii?Q?0PJb5WpD8QNKE32yjzAErns2EtwZnRhwLpFdLBx7/qk1efwDtYJOxviwzbWL?=
 =?us-ascii?Q?C4U3NQHCylkXigx3/TG7YYRPfb8nqCknvXAji5K3xoJeaMxmjYDnKwF7S4J7?=
 =?us-ascii?Q?bwMzqg8JayFWR0uLXVPciQ1PX/331fTLpU4JqIFzm5YF7I9lvDw2H+BSfDVo?=
 =?us-ascii?Q?5Fujiz3bbLS6+w4Njpz/gO+BfvtI750l+WaMRx0mC/RL+xD/NxdKLTI6Bcbm?=
 =?us-ascii?Q?8Lc6MJ1zBpgFT54F492XLMB3ZjUfrgZK1sJ5OYc0by6qGB9MM/dfATo+AZKR?=
 =?us-ascii?Q?61GkVGdti0ORI8K1A8+aMEkSV4uLm7lDc/bNPZx06UB/omOtZB+5k7GLq1eJ?=
 =?us-ascii?Q?VyjFH4RXzumtFe+84Q0xut6sugiXzxavSDmhlKnr467iwIDiTsz/ouYuqEjQ?=
 =?us-ascii?Q?5l303Safp5QW31vlKUbHVCKHr5Uy2W1qZySD1vsGiuh4tHJGyr2CRxuEZXxw?=
 =?us-ascii?Q?f6KHtigxVlK3X8LVBlEXJ1EMY0TSplZY/xXQCPgJ8lSv39NDPXYpYX/oEQZN?=
 =?us-ascii?Q?6NN/Tv7oyLhlV6pqk01Saf9FqkKVHkae3V9YNcEQ5CfT7S6c29ylg6yq3QVG?=
 =?us-ascii?Q?WsYdIfZoXQ7tI038E1E8TpEICCjpPo/YaqL4vFKz7eglJq8f5pzr7IT1JG1i?=
 =?us-ascii?Q?i9wLLhHL69HgSiVYwYGNScEHUDVLi57Jlq7RrbV3mXAJSInhmiMa/x11k5cY?=
 =?us-ascii?Q?192ffCEfhgMzAo2ETAO/lRVUAbQYkVsgugkQj8t7G3jQMpJYfQkpf9d9dIDt?=
 =?us-ascii?Q?JpoJO7EhpAayC+1fxhILCSndFOhKjj44somvXpUkVFGuRkeuY+4SxxXTDPqn?=
 =?us-ascii?Q?cP22mGeZCAkbPklcBkoybv47LU8v0nqEEB8UFdQqzZsF5R7KrBMeQL0t5DqL?=
 =?us-ascii?Q?d8EXrd9KWDwmEwXHl2sqhPNG6sY/LKnmHHSKsUun70Fc0Y6i5HshytFot4WO?=
 =?us-ascii?Q?EKj/Nuw9ipC5oGP8f5pHVUhi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f812006c-92a5-4901-3d5a-08d94836ff3e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 08:52:10.0756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keboCUMzk3rHY1X6f9VkppmqgWpHG7NRlcmvbv/dAW4sgpLqv5ZFn+8Dk2EWJDKhX04uogLQPnpFHHWOaLU+uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_daa_locked() function is in a spin lock environment, use
readl_poll_timeout_atomic() to replace the origin
readl_poll_timeout().

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
V2: align the parameters of the function.
V3: no change.
---
 drivers/i3c/master/svc-i3c-master.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index c25a372f6820..47c02a60cf62 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -656,8 +656,10 @@ static int svc_i3c_master_readb(struct svc_i3c_master *master, u8 *dst,
 	u32 reg;
 
 	for (i = 0; i < len; i++) {
-		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
-					 SVC_I3C_MSTATUS_RXPEND(reg), 0, 1000);
+		ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS,
+						reg,
+						SVC_I3C_MSTATUS_RXPEND(reg),
+						0, 1000);
 		if (ret)
 			return ret;
 
@@ -687,10 +689,11 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 		 * Either one slave will send its ID, or the assignment process
 		 * is done.
 		 */
-		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
-					 SVC_I3C_MSTATUS_RXPEND(reg) |
-					 SVC_I3C_MSTATUS_MCTRLDONE(reg),
-					 1, 1000);
+		ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS,
+						reg,
+						SVC_I3C_MSTATUS_RXPEND(reg) |
+						SVC_I3C_MSTATUS_MCTRLDONE(reg),
+						1, 1000);
 		if (ret)
 			return ret;
 
@@ -744,11 +747,12 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 		}
 
 		/* Wait for the slave to be ready to receive its address */
-		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
-					 SVC_I3C_MSTATUS_MCTRLDONE(reg) &&
-					 SVC_I3C_MSTATUS_STATE_DAA(reg) &&
-					 SVC_I3C_MSTATUS_BETWEEN(reg),
-					 0, 1000);
+		ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS,
+						reg,
+						SVC_I3C_MSTATUS_MCTRLDONE(reg) &&
+						SVC_I3C_MSTATUS_STATE_DAA(reg) &&
+						SVC_I3C_MSTATUS_BETWEEN(reg),
+						0, 1000);
 		if (ret)
 			return ret;
 
-- 
2.25.1

