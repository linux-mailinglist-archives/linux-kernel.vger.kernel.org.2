Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428B5454EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 21:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhKQUsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 15:48:09 -0500
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:32130
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229899AbhKQUsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 15:48:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEPyHUtMH5CuqRZxKZJXKu1J68jIBl63sf7oAHfe9iZ/eKbTMJ9JypYaBB965mrboySgKpEp37emtcdXtI8kYfAb6jvb5VaqZGbILugqyhK4QBfmG6wKQR2mb0fEJR7H2ACMEkDOfB0No9PajYK5xaRxfbv9Hog/YswZ2ekTfxoQpD/RvCbp9jIJzk+oeQaKe1xs/y71oMZ0bm7ZkXyE9ZE0Np09E8+9lOxUQjfWZTgOsAqRlTofuN7RsLcdjdt5R2AZ5v1hMSL9bQnwRxceTYqkihBAfmjVYLLgDlMKyth4ylrmIDuQDo7AzUrYeAqrcyD5Up1CihyRB0ryPWQVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxz6hUSFum89ioFl9LjhgbhxBEM//oftZhQx0arV+FA=;
 b=DQNzA3OOu/2dhkVoN/kDS/WvxeDCO0yVqo64z5kddptOoWB5wH768yroKY2jEl9yp7FgkYu7pvPszUlnsmAtwfZ37Qx+ODLT0YeUQZndOfzn/y/j8UFpPd0Kxt9lPiaVDhtEg+iR+Nd/K3Hw8I0IXRHTVFiOY5+Je8pdq4F9e5ZS6lnMoMaipy58wzqO2acjUOIe8b4hozullZ8zaAAeNEUotBfW1XNIsGqRGHqVGL0YFjPgoI/cCDT/vzwWUoVmR1rZv5QRdxeCvFSWczLY8F0oBlESPUqkxs77ab7lCORBdkivLsywihLuUZq8VEq5+UFjpSqCkDbzLBWC0HhY/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxz6hUSFum89ioFl9LjhgbhxBEM//oftZhQx0arV+FA=;
 b=qOmiUlwZzVgoFzyPm6cNdJs0q4I3geIfV6MhfYSvqwfl04v8+HzixemetsHyozTKU82UuoQ36zfX4/qk7KpG6AGaLdmahANugA5KBtp0vgLBxbztVShiLyYUVvXQFKCzE6Nssj4Q91vcogMmdRI4kpbDJ2Tnpr00u1d00bUbvM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by PAXPR04MB8512.eurprd04.prod.outlook.com (2603:10a6:102:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 20:45:06 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e4ec:6c3e:84fe:f92a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e4ec:6c3e:84fe:f92a%3]) with mapi id 15.20.4713.021; Wed, 17 Nov 2021
 20:45:06 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     peter.chen@kernel.org, pawell@cadence.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lznuaa@gmail.com
Subject: [PATCH 1/1] usb: cdns3: gadget: fix new urb never complete if ep cancel requests before.
Date:   Wed, 17 Nov 2021 14:44:47 -0600
Message-Id: <20211117204447.16869-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:a03:54::43) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
Received: from lizhi-Precision-Tower-5810.am.freescale.net (64.157.242.222) by BYAPR02CA0066.namprd02.prod.outlook.com (2603:10b6:a03:54::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Wed, 17 Nov 2021 20:45:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aa4aa3e-93c8-42f7-0f31-08d9aa0b2373
X-MS-TrafficTypeDiagnostic: PAXPR04MB8512:
X-Microsoft-Antispam-PRVS: <PAXPR04MB8512AEAFE6F4A902E3B5926A889A9@PAXPR04MB8512.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1yqZSUEi2q72jc5qwm2o4Zs/1wZgmToM4W+dJr8uDLUzpfYFiOyqh1e/rsCHf2i4lzlNBceLBWGErVHHY6kADwnO4L9QjacYi0KFdsLnfq6kdqpj7kh8zxB2UWQvHY5KWh6p3+3GtZxT/14jg5siLifz7XwG0S0jtRh5fb53lvOLTIip7HvjUHPy0PXvigoUu+fLeopfewVUiDCtuVSf044LkY3Fn+/pIo/oDmRLI55x6xypJqR8YUiqHAmYDkSix+NGJeBXXs/O0vW4jb09kVJcKhByGBM/fsoXzXGQKjEZHRj8IhQJ+jBs6B6cOdo/WrWdPM60N/nJXu8t6PmfKglvW0qAL54aNmDrOjQUSNnYZUhQDN/PGgTD6t4r8I3qNttYADAZdKkgJhL3GPXHY/DCQfpzRpIzn2lDTTiEMPVqBDg6SOhR+B/JUJHZqCDXPmsreSq5SJ6s9GVmBiAQz3Nm/AxT9GLnIY4RAj6lzDQSVxC7gbd38vfrO/8dH1MaWAU1KPipyAMQFKdtMdqOx62SISR/m9W2qxCRb0ZyuS4zUU0xHOeiE4Iswx1+Yje5mn9nSMO2qpDhFCioXF0f20cSeMkZIX4Ja5yeKCqphu+gVeVE8KDM9LZsbtn6LE4tiOcbyYJ848Q9F1jgkHF8mKEHxLVFx4Fygg+8VaS/rsOLxI+3u8sVXIWRc8eGkYOPSfEpBnaIqojbS0aBYD63ClP/mLOODbt34Acrn8UAX3dI2WjLY+uB+L/AK7fzXvf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(83380400001)(5660300002)(956004)(2616005)(186003)(6486002)(66556008)(6512007)(36756003)(26005)(86362001)(66476007)(66946007)(2906002)(8936002)(508600001)(52116002)(8676002)(6506007)(6666004)(316002)(1076003)(4326008)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1vt22y4MSHPKyAQNfYysX60Ck9I//fzCI6woCUoOWS/xFzvHGtlskBeC6dpk?=
 =?us-ascii?Q?KEHtPAEdLOvD8kl9tnXmxvNliwygICRsT7T3NCgKxpc8BzxhyUj8V/Hwqk+v?=
 =?us-ascii?Q?XzoHTT2emkmLtWmjuNbnGfUAOAuNnutRI6KWrwN5F2jcUXcEwb6Vdvf3evd/?=
 =?us-ascii?Q?I+Jhkz+UZnE5hX0tBaq7SVGGe2AqZFIjzRoPXniexI34ibzyTw9xLu1ADtWM?=
 =?us-ascii?Q?G3K2p97IvWQL9xXIlxCgCdiBTdnVDU13u2QVK0H2jAGPFHTaBMEJo9XrS3TG?=
 =?us-ascii?Q?/RGRNKdfjMnXcb9ZsnSUYh1LaIj0RztZA2OjReBk52n2yeppd72hqyh6L0iK?=
 =?us-ascii?Q?KGFxUzMMJCt5OC38mCmYp96bRlVv5TJ+HdwifsTgImkHxpqyStH6gSR62nh+?=
 =?us-ascii?Q?iyursGwYjJMaGrqbkMg0+QZRx1QykVI3TbHeB9GzETHAG6dRMW+WR56TjGrl?=
 =?us-ascii?Q?q8sbDyct7+vp9qWYpeFlMgA3VlQFUbGmLxsZkONDsAur3S7CmgWbIByRVqIw?=
 =?us-ascii?Q?bz/vOg3mvtAIGVNh7+qXh3/JRCRQgz7GIy3yuukkqT/t5IW6OfcloigLaqwS?=
 =?us-ascii?Q?Zt0Uf8D/JSpmyFtkXMMw+pGvl9xmliDmo5IVgboENJNzs9suawyOzRqbhPj4?=
 =?us-ascii?Q?F5M9pZBsvgDAUjOMJzGifxgXL+Y2Nby7N89GqATYerraY13pxhmyedlbhqU/?=
 =?us-ascii?Q?Nu7TTwVg0xGEtJY+yyOOVdM9cc9HWyUaW9Uo5GngAXvv+blDsB4uJ3i7EWfo?=
 =?us-ascii?Q?kEnUUIFkgohscbOxj9Wk9RxyS5tl2xaSOboWLfOJsrujNlE6RbJeK7lrHgy+?=
 =?us-ascii?Q?57LQXfvnPckiV4RFj44vM+eg1yjO21CFT7V/EfReRlsys3s89zkAYMVSQu3P?=
 =?us-ascii?Q?DbuZDr7LRmP/i3SauJQJyV10IDkvRw77uHd4HU8Yfh7AitFHWHdEBIk5qRx2?=
 =?us-ascii?Q?pmzqKRYoUTdtsJ5LKhMWdL7I5v7o7wiQUKQ/yZCKDiLYBQNtrheoKXgOHaDn?=
 =?us-ascii?Q?8Wv/etFJEoM5jNSJl63zIwGEcachMpmxFuIdN9hbmFXyoNAr8ZvvwyNQt6Vx?=
 =?us-ascii?Q?PZ8HG4JrrzFqCs0l6WMc0T5MJLZz9Pnrsuwytqsce1o2UxeAAP1op9+RVfK6?=
 =?us-ascii?Q?Jr1Xg2gakf79KmHeNXR2mHHtJn8QG72iq+qIgleDtvIwo83kkr3cZR3E3MyV?=
 =?us-ascii?Q?b0hge6aNljlkxBrxAm6eOJMHyfeuFMknud7Txgpfpq0tGVfOhz7yoRUc1Agp?=
 =?us-ascii?Q?FHeHVLxmj4Metzgv3hp8BrJWjGFzULQTSQ9tXUt5QaPZudiuQzyaEPSxonjg?=
 =?us-ascii?Q?eymZf8xIO9r80IXKSIsmGpAPPft7gAbsBP775JcD1jNX+TWBqiu3yPQ83OAQ?=
 =?us-ascii?Q?ivu+F/SdCKZWwaOgNJca9VHPqnzMKKHd3hWjJ7UixGCuUzmUZZIQ4M4WYNbf?=
 =?us-ascii?Q?G0peC3FItFXSMb8+kWteYhh8WFk4XlA/0Lu9MzlLcHsFqsaQl+YtpJXS3Mbw?=
 =?us-ascii?Q?fvqyg2hwr04lqfzZAM023m0qzXBTmsp3wbZ7PLPtatTkvWiXOgz2oaud8qnh?=
 =?us-ascii?Q?b6xPoVWZeXOk3pu8gOL/rJ6RH4RHD8f8Z4hzhnSDu0IGneBCNgJBKV0oUBV/?=
 =?us-ascii?Q?FI7xhNhes57INdWfuRE4fUk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa4aa3e-93c8-42f7-0f31-08d9aa0b2373
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 20:45:06.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqiMNzpHG9Q0HmJizwnx74gL6JJwB1SxE14IyadOlquh1jXgglQ5YcggOqilg5oenApkmeVzjdFiS0u31TsmPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue was found at android12 MTP.
1. MTP submit many out urb request.
2. Cancel left requests (>20) when enough data get from host
3. Send ACK by IN endpoint.
4. MTP submit new out urb request.
5. 4's urb never complete.

TRACE LOG:

MtpServer-2157    [000] d..3  1287.150391: cdns3_ep_dequeue: ep1out: req: 00000000299e6836, req buff 000000009df42287, length: 0/16384 zsi, status: -115, trb: [start:87, end:87: virt addr 0x80004000ffd50420], flags:1 SID: 0
MtpServer-2157    [000] d..3  1287.150410: cdns3_gadget_giveback: ep1out: req: 00000000299e6836, req buff 000000009df42287, length: 0/16384 zsi, status: -104, trb: [start:87, end:87: virt addr 0x80004000ffd50420], flags:0 SID: 0
MtpServer-2157    [000] d..3  1287.150433: cdns3_ep_dequeue: ep1out: req: 0000000080b7bde6, req buff 000000009ed5c556, length: 0/16384 zsi, status: -115, trb: [start:88, end:88: virt addr 0x80004000ffd5042c], flags:1 SID: 0
MtpServer-2157    [000] d..3  1287.150446: cdns3_gadget_giveback: ep1out: req: 0000000080b7bde6, req buff 000000009ed5c556, length: 0/16384 zsi, status: -104, trb: [start:88, end:88: virt addr 0x80004000ffd5042c], flags:0 SID: 0
	....
MtpServer-2157    [000] d..1  1293.630410: cdns3_alloc_request: ep1out: req: 00000000afbccb7d, req buff 0000000000000000, length: 0/0 zsi, status: 0, trb: [start:0, end:0: virt addr (null)], flags:0 SID: 0
MtpServer-2157    [000] d..2  1293.630421: cdns3_ep_queue: ep1out: req: 00000000afbccb7d, req buff 00000000871caf90, length: 0/512 zsi, status: -115, trb: [start:0, end:0: virt addr (null)], flags:0 SID: 0
MtpServer-2157    [000] d..2  1293.630445: cdns3_wa1: WA1: ep1out set guard
MtpServer-2157    [000] d..2  1293.630450: cdns3_wa1: WA1: ep1out restore cycle bit
MtpServer-2157    [000] d..2  1293.630453: cdns3_prepare_trb: ep1out: trb 000000007317b3ee, dma buf: 0xffd5bc00, size: 512, burst: 128 ctrl: 0x00000424 (C=0, T=0, ISP, IOC, Normal) SID:0 LAST_SID:0
MtpServer-2157    [000] d..2  1293.630460: cdns3_doorbell_epx: ep1out, ep_trbaddr ffd50414
	....
irq/241-5b13000-2154    [000] d..1  1293.680849: cdns3_epx_irq: IRQ for ep1out: 01000408 ISP , ep_traddr: ffd508ac ep_last_sid: 00000000 use_streams: 0
irq/241-5b13000-2154    [000] d..1  1293.680858: cdns3_complete_trb: ep1out: trb 0000000021a11b54, dma buf: 0xffd50420, size: 16384, burst: 128 ctrl: 0x00001810 (C=0, T=0, CHAIN, LINK) SID:0 LAST_SID:0
irq/241-5b13000-2154    [000] d..1  1293.680865: cdns3_request_handled: Req: 00000000afbccb7d not handled, DMA pos: 185, ep deq: 88, ep enq: 185, start trb: 184, end trb: 184

Actually DMA pos already bigger than prevous submit request afbccb7d's TRB (184-184). The reason of (not handled) is that deq position is wrong.

The TRB link is below when irq happen.

	DEQ LINK LINK LINK LINK LINK .... TRB(afbccb7d):START  DMA(EP_TRADDR).

Original code check LINK TRB, but DEQ just move one step.

	LINK DEQ LINK LINK LINK LINK .... TRB(afbccb7d):START  DMA(EP_TRADDR).

This patch skip all LINK TRB and sync DEQ to trb's start.

	LINK LINK LINK LINK LINK .... DEQ = TRB(afbccb7d):START  DMA(EP_TRADDR).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Jun Li <jun.li@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 1f3b4a1422126..01d0e09a87ad7 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -337,17 +337,21 @@ static void cdns3_ep_inc_deq(struct cdns3_endpoint *priv_ep)
 	cdns3_ep_inc_trb(&priv_ep->dequeue, &priv_ep->ccs, priv_ep->num_trbs);
 }
 
-static void cdns3_move_deq_to_next_trb(struct cdns3_request *priv_req)
+static void cdns3_sync_deq_to_trb(struct cdns3_request *priv_req)
 {
 	struct cdns3_endpoint *priv_ep = priv_req->priv_ep;
-	int current_trb = priv_req->start_trb;
+	struct cdns3_trb *trb =  priv_ep->trb_pool + priv_ep->dequeue;
 
-	while (current_trb != priv_req->end_trb) {
-		cdns3_ep_inc_deq(priv_ep);
-		current_trb = priv_ep->dequeue;
-	}
+	if (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
+		while (priv_ep->dequeue != priv_req->start_trb) {
+			dev_dbg(priv_ep->cdns3_dev->dev, "Remove TRB_LINK");
+			trb = priv_ep->trb_pool + priv_ep->dequeue;
+			WARN_ON_ONCE(TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) != TRB_LINK);
+			trace_cdns3_complete_trb(priv_ep, trb);
 
-	cdns3_ep_inc_deq(priv_ep);
+			cdns3_ep_inc_deq(priv_ep);
+		}
+	}
 }
 
 /**
@@ -1518,10 +1522,7 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 		trb = priv_ep->trb_pool + priv_ep->dequeue;
 
 		/* Request was dequeued and TRB was changed to TRB_LINK. */
-		if (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
-			trace_cdns3_complete_trb(priv_ep, trb);
-			cdns3_move_deq_to_next_trb(priv_req);
-		}
+		cdns3_sync_deq_to_trb(priv_req);
 
 		if (!request->stream_id) {
 			/* Re-select endpoint. It could be changed by other CPU
-- 
2.24.0.rc1

