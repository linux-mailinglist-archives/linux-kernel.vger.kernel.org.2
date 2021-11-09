Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62044A71F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 07:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbhKIHCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 02:02:16 -0500
Received: from mail-eopbgr1320100.outbound.protection.outlook.com ([40.107.132.100]:31679
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243331AbhKIHCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 02:02:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqZF52QuaXLWlJY5/wba7lWjV2Fe/9xll7fF0ry2eJCvOPRxCweYb9kLmnl7QYWHQ9n5I4DAgGoz3rwXh9FdahVZZu7TlD5mxhT8HzrjmJC/QB8sU2EfsyAZMUrojJmyCKIAFfHEEBp5WWWyf8JL25Y+GoWsJdTLsumeE4INxUXqvZdb8l39E8s3RgnFpZZmuEk9GS0ecbm+OTi5EbCZEapehD59zkMUQO8Iy0wNMxB89rFTgT0NvEvQiFwxKE0RLLbJcKEb1dVT9xqDyU5rmCmNMTLsHuDXJzXpdItlE9ac36lJVzxxv3YkcezSLpWX6k8Lu2kfmn9vJalDgzdx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VR0L4XWrQMVsEuAxnw3v5OsiZpU0XFbyK3Pfcks//G8=;
 b=H47sNhNgzgSjQLF228drHvlDGMTsx1xFwbXf7yKmpeeZ2JXMTWECskdveyn0MrVGuFCD4ZGwQkRED7xZTbA6o3N+RaDeRtCX4d1ojmeGrzCfg/2Id0xjIONBiPbr+ZsNt8P202S9zV90WtAjpXCuHir8kswll9dDeceP10bG+UFjN6JKPAl/2f5zw5fbckbiI16BjIKeGCKrWpJJ0LDBBmkmDx+d5gVm8u/Jq1SxfF4pcUicLXV4FCELzoOOLCHf0MKeHPZ/n+IUo5n44DG83DpHYR7HLjcU4YVzc7nzLW1jL2xThGHYBaQQ6Ud5YUfIJukMNUCmXItRs8MDqLiYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR0L4XWrQMVsEuAxnw3v5OsiZpU0XFbyK3Pfcks//G8=;
 b=UPrDpQqyOv6L8QnJco4zD5bPJfVoWlAIGCQ77FfwVI/2S4pHpOWHXn61sziV7s9EDyx/SJU6sD8jBcnQEPFKHr2dhpJUVuSmdA0YfRApx7HO7pKV0Ox7/V4tX2nHmEiP3LRk+qegXF+H7RCPHvz6k2RbDe+rRg4U6bX78+2HTQc=
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TY2PR06MB3613.apcprd06.prod.outlook.com (2603:1096:404:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 06:59:26 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e%8]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 06:59:25 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Yihao Han <hanyihao@vivo.com>, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] lib/mpi: using swap() instead of tp variable
Date:   Mon,  8 Nov 2021 22:59:05 -0800
Message-Id: <20211109065907.11647-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:202:17::24) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR03CA0054.apcprd03.prod.outlook.com (2603:1096:202:17::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.12 via Frontend Transport; Tue, 9 Nov 2021 06:59:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bfaab0a-c594-4ce4-dd38-08d9a34e770d
X-MS-TrafficTypeDiagnostic: TY2PR06MB3613:
X-Microsoft-Antispam-PRVS: <TY2PR06MB36134CCE39B585A446C428F9A2929@TY2PR06MB3613.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZMK2132F89XyiUpPJ59a8ePnQ0n8g+6MvnzZp9q/wUDZN+AIn8ZkT1ywbyoJjAqJgDrxqqv2GLvlfFfPYN1AiLfno3btlUgFhZbxISpJHE5SWXBr7Qd+DjO4DgmHkue1NdpEXRJreqQ0SkrZia7bV1BlUkub44TCO5jlTw9sdSFxedNXIhoUJWHOjpcOHN1of4DNzJ4I+RKjzqkC0OGXsGlqBRNCeQ8v8WYyDPIeTRExuUdHAyIipsIdkQWmejfZektQF9HSD2qjCgSxnWAN36liejPPS3Uha4IoSsnKw+OJHqaVAi+p5Ysa2cnUpmbEtcZBZfXYAfNQdtLl8+VYf5HRb7Hp38AClufroazx9rwU/876D1OiWvs5uw/eKBWPxsH1NOIfHSOaTLUHNgUEtTJgWRA5mUI9hDWoM6HYs7h4G1Nhqhf904QlqJElxqztRNl5yDElWOKK1BaiXDgiY/5vtfmI3X61n2jOljCCayd+bM/ctyH5sa0whDvto4m0VMJqufHDSydNQfXbrVmGMJv78TyuRxSxWqAeT2I2yvEP1UqeIWoKvZY+uVGDft8wzbIk63euYy5UN3mp70FFyPd2A+KY2tIvaLM2BpB/rCsWIFiSI7YiZFqGvFw7yQ4M4tXVyHP8KfJJMPpRgQyz1Id/qIIODF6rVIEHuI0YpMdQh6/37Ho4HXEeWX+jeV0FxuvNbooAHiFk78v/kihfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(83380400001)(6486002)(86362001)(6506007)(186003)(4326008)(6666004)(107886003)(36756003)(6512007)(52116002)(38100700002)(2906002)(38350700002)(8936002)(8676002)(2616005)(956004)(66476007)(66556008)(5660300002)(1076003)(66946007)(26005)(316002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OssH7lXBDAnrCflRTGmaDjdBarG3PQESpOZGRYQ3e8XPNjD3kYurBzX0rV/+?=
 =?us-ascii?Q?Lcd5I9aI1D/gMQ7g1o1aa8G/TXBDFToUKfsiOAi6962xBKY/zKKnbIwQUf4a?=
 =?us-ascii?Q?1LINdRkHJi514/PdAljPg7Fs70H7h+Dsq8aGcpVYgJ0gKHQhwkB+UrsXhuhb?=
 =?us-ascii?Q?M/FrkiUaQu6lmIgqLh883ZenO/Rc9cUBu5BZEmVG0mZhouKAnKJDUdohIsU9?=
 =?us-ascii?Q?86Kq21EBl+8or+6OhvF/EiNqxDvRaMzvRZ/MlwLooSaCrSnA+Mp2iw/mox4r?=
 =?us-ascii?Q?y0RrCDurHyXfXBS/TAfu7J7B8a9GlTwf1cg7deLnd0aISyHsBbL8jQTV8vWA?=
 =?us-ascii?Q?VISszEAiF27zWyFujw1vdD4EWkQbJJB0R+zLm/8HD+43aeV4jrt5GrR6VGdf?=
 =?us-ascii?Q?tUdoqV6qj5CL+7yv1wPazCkgAZSt8J9Uol/X3YXrApgAfnCPz/h9db/pyt7Y?=
 =?us-ascii?Q?b8mzzBEa9OIYNCtcN2VQ7fDx3Q/YBbyoEIfxZMsrtMhv6n9QLCcwgMja4qhl?=
 =?us-ascii?Q?zunDvgWoAwwEItSnVNHQ6qtpkLCPb4o2XtgQHhpjD+YHt19/NG8sDkJgBRYe?=
 =?us-ascii?Q?18HY/Y5c1Vi6Io0otRQ6wl1jZvq99IZpNjo9Vc+O10lL9XMeH/J/2y71+LU9?=
 =?us-ascii?Q?dP+3K8cq9uikUfPovuFbSItn9yYAEBzTrT0MqhDgaJ9k8MKXqd4pBDJ+XOzW?=
 =?us-ascii?Q?rBc/LZYybfhVK5Bb8iuJYvwkQeaY5nU97v/eJViLoLm1splquK+uG+wWBO5L?=
 =?us-ascii?Q?ObnPZ3SjSFcxn/LEblZhedbAhMofqRzBTWGcEc5WSzjojz1Mq4xVq5BIJQrA?=
 =?us-ascii?Q?1hkOgPXKhaJHNf3FzRsnvpKwmFP2x/ZuH43ehq0W3511CiSasqeF4O+KDo/K?=
 =?us-ascii?Q?E+PC4G8gQT7WDpeqOVCMufzqBstQGpZr8emDicOFPoeb45RIvqhfx68To3hp?=
 =?us-ascii?Q?fWt+nSo57DvxKAY1Glwh9Jjc5KcALql4S6cLTBACVqUwT4kYvSzkl7u4K7qS?=
 =?us-ascii?Q?4BIS0bnAFxXdD+Yz6hreJHgMLo3HCrpQ2c4SRXHfcQprTKIpGHZpGdyak1Aq?=
 =?us-ascii?Q?UNNd4Al7Ai7b+UOj6jxnkU+hRr+TSne76ylgADVQb90ontBRgQ1HYnvdgQoA?=
 =?us-ascii?Q?CoQJ+Icvt5PrbEc/LUkYLxlY8N7gtSe+o8M1vZoe6UVTKgo1Q3IMp3FDfelC?=
 =?us-ascii?Q?SOvfSBPAcWLJVHvUJFRTv5qUYII+p4kl1EHb2+OI/DPhxURSXsureDpBE/3J?=
 =?us-ascii?Q?ANw7qY+wrF7dTdiC6WANKGyEermKpjKlAY+IuCrcbINje/fFo06or3LLptQ5?=
 =?us-ascii?Q?4omMfRBxohYERpVuuk+K0BSTdb1RC9pasA7q4YG1zk3DFkj6NZnstj/DU2Rd?=
 =?us-ascii?Q?AmIxMcCcBu/5udHdDHGIjBhe9XwihH/9voZd2+kqWZHw9Py1ALnD+J3SOq4A?=
 =?us-ascii?Q?TE1IgV1zwVG1OffokIayxb18dlN2oXrxlD69RAzMnbD/Shh3lf7HCnNjKNsQ?=
 =?us-ascii?Q?EUqZi5qN48NE8ET9jHwUHjDOhbf7W2RfFLQbFWpziCPOzoUovnixWVIPz19U?=
 =?us-ascii?Q?VFXnxnmnVE339YNgIcRVlbdp93JYyaCe4EBtZixXWnXZh+y2enD1N424jINs?=
 =?us-ascii?Q?UaNx7jEUB2Xqpf92qTMxBXY=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfaab0a-c594-4ce4-dd38-08d9a34e770d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 06:59:25.1094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxXUMouf7CkeWY3Vcu2JNbL27J6cqvpgc/hp+63/9iWF756ojBGqDWFR8VKCn0+jqLukmuCPtoN28cMI5/AH2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3613
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap() was used instead of the tmp variable to swap values

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 lib/mpi/mpi-pow.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/mpi/mpi-pow.c b/lib/mpi/mpi-pow.c
index 2fd7a46d55ec..67fbd4c2503d 100644
--- a/lib/mpi/mpi-pow.c
+++ b/lib/mpi/mpi-pow.c
@@ -176,7 +176,6 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 
 		for (;;) {
 			while (c) {
-				mpi_ptr_t tp;
 				mpi_size_t xsize;
 
 				/*if (mpihelp_mul_n(xp, rp, rp, rsize) < 0) goto enomem */
@@ -207,9 +206,7 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 					xsize = msize;
 				}
 
-				tp = rp;
-				rp = xp;
-				xp = tp;
+				swap(rp, xp);
 				rsize = xsize;
 
 				if ((mpi_limb_signed_t) e < 0) {
@@ -235,9 +232,7 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 						xsize = msize;
 					}
 
-					tp = rp;
-					rp = xp;
-					xp = tp;
+					swap(rp, xp);
 					rsize = xsize;
 				}
 				e <<= 1;
-- 
2.17.1

