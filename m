Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D770445F88
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 06:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhKEF7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 01:59:54 -0400
Received: from mail-eopbgr1410137.outbound.protection.outlook.com ([40.107.141.137]:6216
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229587AbhKEF7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 01:59:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3pu6iT51km/dkidIsp+bSWzvvdcwdGTZyLXYYpThSsOnD3aap+DJy1qJNI2knI4InYbUnanymIDc57sewEA4qRTv4okB493bsoYJKyrUhw1rVK4nv2hAB1xv+GvKCeLYpzNK8EchkUh+dRQR+P+39hTldUx1WIi5x1US69+Rv0dpKsDDB2UF5HnBWdxAeYw29P4Fg4RA0l2vg8AVk6PU4kReqndESBZV7QsZR1F/Td6OHmLDZ3bOROeA4ytHDiMqOXMW87BA8GIg5Bh0C59u8lo9GXlVghBrnfkQBQQEuFSm5pauYFro479cL14ns/w8d3UngOpPl0SXuVgIkYwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVvuR6ejAf22mCLYEFAXIkDd63CXfSD56uyo+xAFDg8=;
 b=YXAwHZQNZk7fv8a2JQSxZgimeR8c9IAkjwbuv+pOHuML9dTqgDE+ocW3efxhOBtz7nEoVoY6JXCs8FhxTLXAHAkRtbR1XJPF/TWtsVyIChWzLCpM76jOAKu/xFg3ay98A48MbbNTaeQpy+I727A7UsE/sZltAn86gv6AHHh59GmWEw0Xwm91Trjx01/9AtljAzATKDA/OfGXgcFQxNTO9x4go0cE8DKYqcriVBBENYHWRPX8dvlbRr8CCW6+nXXCWdr16caUtWurnqZGsY62e2clJfCUnRqpwxiTyCNF8bAJ0O9zMp0OQQV0twmEsED1SQYD2oEz+HZiOEyT1m9aKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVvuR6ejAf22mCLYEFAXIkDd63CXfSD56uyo+xAFDg8=;
 b=G0aXIYCh1MMwXmjvLgdF4sYzIH8dIjzojshKdimRPohMvBaUt2Psigl7efcjQDAwt//Ej10fsas4kZvlF4GnhRdzGD8jgnnitF1QGTGu7VG3X9FgcMIvfKS7nzhPD/54K1Vd/pg/jR3aqi8sRDW9j3g3JTkoag93FbnMpX4QayE=
Authentication-Results: s5r6.in-berlin.de; dkim=none (message not signed)
 header.d=none;s5r6.in-berlin.de; dmarc=none action=none
 header.from=connect.ust.hk;
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYCP286MB1281.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Fri, 5 Nov 2021 05:57:10 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%6]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 05:57:10 +0000
From:   Chengfeng Ye <cyeaa@connect.ust.hk>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chengfeng Ye <cyeaa@connect.ust.hk>
Subject: [PATCH v2] firewire: fix potential uaf in outbound_phy_packet_callback()
Date:   Thu,  4 Nov 2021 22:57:00 -0700
Message-Id: <20211105055700.25661-1-cyeaa@connect.ust.hk>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:b7::8)
MIME-Version: 1.0
Received: from ubuntu.localdomain (175.159.124.155) by HK2PR03CA0044.apcprd03.prod.outlook.com (2603:1096:202:17::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.5 via Frontend Transport; Fri, 5 Nov 2021 05:57:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c398826-fb8f-4c67-8d41-08d9a0211b3e
X-MS-TrafficTypeDiagnostic: TYCP286MB1281:
X-Microsoft-Antispam-PRVS: <TYCP286MB12817DFAE1C4D47DD276BC478A8E9@TYCP286MB1281.JPNP286.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSYouJ6imQ3WXn38iFsxnZ0Be8Ja7iafKTTblPdetcJTIgHJc3WRtJ3KjGs74DW3Y8GbcxeUmL1Ssy9n3IZXmlI5Rh9yk0Y87hyxASnjzucKDl2A4aPhcRwoOyMa9645rkWZ/lpqAxV+6lPQg93HY7xiTKGMvKBnTnvKaE5fW2CRNSSYZd0nLtiEXEuWpneaozlp7fYgtAbRoLEKM64luUT7n0v4L/b0kx6lHMiW+1DqmMkCNdsAmxiLhDvmzUCy/WjuNeCNWXi05ScarpWhemmROwQ0j2H1VM0KvhVMIJUzjCrFMdhfTDRnmyLbCVor13mhI0hSkJ0oLg6CQpGCB2ocCT8aRBU8cAlQSNibOEg6/qyySnOjK/fx3pZHQAydKwAlaypZvK44x3uFp+Da2oYQ35U4fko+aRMStfMJYDs0rHPUWX9mECHlVUYsm2hRfq6FXRCLG0oaGuE3m4LlVnvEHEWIwEtiVDzj2Hr8dl7MAQcRpE9LOFBnvePJKhzf1D8b+VhqS5CbiCbakTGGUpc8riocf1kh67OGjpph5l8hIJH5d5ioG4LlQqsNi3gg57xmtEOZ/HSoTyrpqPLngCTrclQWU+805Yz9VNbp1LKnj1EGtv31/LYfrp2+51tvu1t+u6rgwctU7xNaWt/Dr7HDx9VQJNK9jbv6VySggFN7H2VwltA1uf165D0TtzC4YvL8cax7FMkNwo7OPcD9Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(38100700002)(8936002)(38350700002)(86362001)(2616005)(956004)(5660300002)(316002)(786003)(36756003)(6486002)(66946007)(186003)(6666004)(52116002)(26005)(66556008)(6512007)(83380400001)(8676002)(66476007)(1076003)(107886003)(508600001)(4326008)(6506007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dhW0OUr2eOXGSm72mnTPtx4kKUzYgCOYa0YkWqrXPICIxey1Tf6LJyhLLf3d?=
 =?us-ascii?Q?oDseixmH+2QhyVOpgpM1KVn2CtWyeh1nM6YETW1ESvAbsHjv44H3DbfAm6d0?=
 =?us-ascii?Q?RlcwWzEdEEWZx/k7Qc3/tsn8EbuusyImIEka/eOJpnv3AqkCosJUJ9hUWG9j?=
 =?us-ascii?Q?L0BzgdNFAtlPcOW0W+EE5Cz6eRHT5Hv+yGvlJO1DFdNRb2FIGhpj6lsBTfO0?=
 =?us-ascii?Q?8UBJBJPP6mAOmnuWGy2NrRwzSRM4W4kOtiK2uVoQ9k02BDXAmknyfZuV5UvL?=
 =?us-ascii?Q?jDwN1XhZkiSBwOD586zBSMYi1Rift2j9rPx4v2H98SXimmpdkckmy2A1zsXX?=
 =?us-ascii?Q?j5u5wusdfdpK/juD/0QrvaZdOMala3U08HDiCqYiTpM7kShxsD/zJnu15Ptf?=
 =?us-ascii?Q?d6nRK1PVT54K4B8niHexWGc/7KRdfMkedjtjhQP10k9SmUFyJtINCCuxcj+J?=
 =?us-ascii?Q?tsT2yummTNaYN2yvlUv+OIZoU1gnnmPAnhoZkvW2gTAu70ie9h7X84V1el2D?=
 =?us-ascii?Q?4DADmeBGIODwBo11OUCeEwg6jSbW9Q0YgQIEvFmkZ98MiQMkqypwM6b6dAaZ?=
 =?us-ascii?Q?ibmLX63Rnf98WkVGZA9GR1g1S2Mpp6YfJvo3Z4K62R+Mx/gY3uudoo9vuZMb?=
 =?us-ascii?Q?gdhZ/v15r0Xf0LmbOnX58fjSXpeB5oaQY0578Z/9jr7gTZHJFRK1fxZbgAzA?=
 =?us-ascii?Q?8fT9eGbL8whp4vdBcA2PMFBah3kKLBlctAO1ZFabVu2TOGIteZ8lp0rYQGMQ?=
 =?us-ascii?Q?JmCy/ZgAFIqCvyveHopHWpav/cWySbqP+J2Ay1gpgOmPWhdD7UYS5T8lU6p9?=
 =?us-ascii?Q?cnlNT3bXFX7kxHZpMcTqRRJ5ZdLtM3sXZEiGnN9yX0+dtkRKpuTylHbVeljl?=
 =?us-ascii?Q?J5PQWv0Yn0BUR87Md2viVs1fmFzjAsDt9tgxONA47DADslXpT81loxEyicNO?=
 =?us-ascii?Q?h85iaUXB+M82FwuEHJ4ccILHsaT/qorfHYe0Qpq1qU+9khwtaHCH0ZBYhT7b?=
 =?us-ascii?Q?v4Ndsts2ScH1vt0JH3AixBypJYjGe/qVXjXhKaLvwBWy0In908t43gGf2rVB?=
 =?us-ascii?Q?W6uyjrpUzgQwAO71TWLMrIeJ6CPfWWrzEaYq6aflOgDp+S4bw0mgPl+vUJmp?=
 =?us-ascii?Q?l+nR8O1hudmpeD6gT22uRSUB8NEmBYQ0FMBPbJkNHYlcmH8BFXkXE3HL2wjP?=
 =?us-ascii?Q?7SdVo5Zg8CJfG2fGRaFaVEsjUUd7FwT/L1BbwdK2lJpzUM1ULHi+rUa6ijJR?=
 =?us-ascii?Q?o/TxkDpNbkerWJs656+s3Vrs2hNpSTI/KuJeH8O+ybMcqChIvrQA24xd4XV1?=
 =?us-ascii?Q?LvrACkkpdK3LRfJv0qDJrxnDcnchzoTJgIKwzhd1rBLScz7XtBK7Gbvi9jSv?=
 =?us-ascii?Q?YRbFs3TXnf9qk/29ttpMTTvuhFcKfYnHkHHBqW10ooL0UVUJ78cbinQA5DTk?=
 =?us-ascii?Q?1bLmM2N2iPMuhAywhgeRntWIEeEW7fb8SWMbKGJYj2NOAQZ7LbmFBURt+Ik6?=
 =?us-ascii?Q?2EVv/LeI+QqcVdFhVyyyOdoBzbdBPh3bbGeFdpVgVy4BOW17chWYPqtWk41+?=
 =?us-ascii?Q?Jd1vJk+klZ6P3WSsQ6nN36z5KnBYIh+0kFJAV8vMlXYC5j82zpXFi9/9DOsr?=
 =?us-ascii?Q?IM7dvsr67tmU3RYJolNSNrE=3D?=
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c398826-fb8f-4c67-8d41-08d9a0211b3e
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 05:57:10.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDNrevR9auCC5/WBVJzv6ehAJbOccuPkoO5CKJNviwZw3xUTtMbhxJ6kbtDrtnmg/Phbb/eGb+acjPY4PyT80w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1281
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

&e->event and e point to the same address, and &e->event could
be freed in queue_event. So there is a potential uaf issue if
we dereference e after calling queue_event(). Fix this by adding
a temporary variable to maintain e->client in advance, this can
avoid the potential uaf issue.

Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
---
 drivers/firewire/core-cdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 9f89c17730b1..708e417200f4 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1500,6 +1500,7 @@ static void outbound_phy_packet_callback(struct fw_packet *packet,
 {
 	struct outbound_phy_packet_event *e =
 		container_of(packet, struct outbound_phy_packet_event, p);
+	struct client *e_client;
 
 	switch (status) {
 	/* expected: */
@@ -1516,9 +1517,10 @@ static void outbound_phy_packet_callback(struct fw_packet *packet,
 	}
 	e->phy_packet.data[0] = packet->timestamp;
 
+	e_client = e->client;
 	queue_event(e->client, &e->event, &e->phy_packet,
 		    sizeof(e->phy_packet) + e->phy_packet.length, NULL, 0);
-	client_put(e->client);
+	client_put(e_client);
 }
 
 static int ioctl_send_phy_packet(struct client *client, union ioctl_arg *arg)
-- 
2.17.1

