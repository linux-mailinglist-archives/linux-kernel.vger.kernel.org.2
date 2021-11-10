Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C244BA89
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 04:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhKJDKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 22:10:24 -0500
Received: from mail-eopbgr1310129.outbound.protection.outlook.com ([40.107.131.129]:35456
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229445AbhKJDKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 22:10:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muFHFQ12k3cMe8TTlVb9hWLLcJONOJUnLxu20lyOvvfF/szQJYiGCp2I7ocTPdpa9sDBqEdEIol0jy3SsTjagEeTodr4oCPvT4jeW4+o8/o3d/sCSjwA6jcSx0G+dfbgEgzkoRCfnFFs2AFqMXd0edVUkxH1+qep4k3gQYmxs2kkygPRD2OQY711iyDSDfq8Euclbdsa4UrBnCpdoxBbf18fZSvIqHwq0+RVF1o+3iUi3Gi6sr0WNLn7U9hyxRB7HtE7F5EqY6kUETbcCXpNNJP+e49TYpzm0MQbXCIDOHB7MbthFu9MrRIYQg1+8x0DsF/bviB8VOVqpsrg0uzoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfHqFRcwXlcoY7H4MdpGQiTSGRw5kl7jSLaniw3ZkBI=;
 b=PRK2YcAXEzuftIyv/97zRziJtOwVYG73yoNr4NtjPOpKmGoto5XsnByhtJRyRbBTY0G3jf2uKih2IHl7smiggs4bckh/KzTB/WgFoHPRN7n2Onu+c6D3FP92HdGpqXm54KxUSmbjvM8ME8Q0kg9KKDANJ0qogLpyWAMPGsPZ6ehsTO1YEoD/0U63YH7ZViuTayJi4YgYOEd0Kj3jYVxlncIAYsi9V8MDcWTkPTCe7z2nRLE1i/Er8r0jzP1fvFMojTGp1LrYOhDZZ5CN8KvbchFm+HhPNiQW0jvEvLZk8sMXZhNn+EDwkDud1Ab+KQXi+UUS/r8pM/piux+k/0JPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfHqFRcwXlcoY7H4MdpGQiTSGRw5kl7jSLaniw3ZkBI=;
 b=axKiPPdZ2enYESAVJMkDZvfARZ8ksIitMEPmJ3EEG5UOinOV/NW8RrbDRz0UmKJdv153KxQ5eiu5uMIkH3VytyN0rOe0F1KTOJRmvkhGhcHxy61kW/n+NXbLZhal/oZxg1L3Lsict9ShbnV860EYbzF+aeI1NXCCUTTJe+W7LU8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TY2PR06MB3536.apcprd06.prod.outlook.com (2603:1096:404:f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 03:07:33 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e%8]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 03:07:33 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Vineet Gupta <vgupta@kernel.org>, Yihao Han <hanyihao@vivo.com>,
        Jinchao Wang <wjc@cdjrlc.com>,
        "dean.yang_cp" <yangdianqing@yulong.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] arc: use swap() to make code cleaner
Date:   Tue,  9 Nov 2021 19:07:12 -0800
Message-Id: <20211110030715.21681-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by SG2PR03CA0091.apcprd03.prod.outlook.com (2603:1096:4:7c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.7 via Frontend Transport; Wed, 10 Nov 2021 03:07:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bfdd4e0-d388-4ce7-3b67-08d9a3f73d50
X-MS-TrafficTypeDiagnostic: TY2PR06MB3536:
X-Microsoft-Antispam-PRVS: <TY2PR06MB3536DE93ABF90F9B5AFF7800A2939@TY2PR06MB3536.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Wvrhbh/HLu3afbhlQjEn5M/t8wl9qURJkv1gjBufTvcWbkHvRpJVc8PRmUUe9RbB8bG95FF2FImTc3FGMYcnLaTqUxVEv2L0+BEcPVao9wXdnDzrtSEyUaxypNwU13+hU6MVYYEHUMQYSedLqlsGDmzFxoQA1sRidzJhpZlCNcKhDVttSAjp2VHnyRIgE7vuql+od3l8pN1wK5xaFFjUbtMYwKbbOIjxTh1Zh686HuH+Z4cQhwGYqWVoExbb7sDa7LVsN6VEuToJ08D9dDQ9ASV06ITCnK+/tr8a/xiZy53lO9aEYMuCnvDAWyzjhgac9V4oWrESppTUEnJCUrKsrhvXeeWGtFozIh56RjQf/+zNtf+ZryIP3gx/YRqQCEGl0w/BJ9rGKQAbGPJ6EWqnTsGVPisS+llJ1EytOGkn+QgtnxA3kHQDggA51BOGRZHKRSFJF/QLrRcu9kRwmr0+ti/ytmo2zE6HJ34CaLq05lLnxRYXEu1w5LjjsvVSyBrJ7ooSfOmyPk9/sR9een/pLhnzW5uz9hvA07cPb8pchfR67tT8hlaqDpuk4F4cKkwcnoccyrhAS7aifjLvRwGTMcfgcoFud/thL1JUdaVQS4XKucL5xsEaqjBx4z8IsSjoSl32nFv1GhDFw82CuCJrnYztFQLNRfuXYnFiPjs1bMwKfuqI8HDqRKHf9hfu4lO9SUzdQTiuUZdXolYA+bkhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(83380400001)(186003)(2906002)(66556008)(8936002)(66476007)(110136005)(66946007)(26005)(52116002)(508600001)(316002)(107886003)(6512007)(36756003)(1076003)(4744005)(4326008)(8676002)(6506007)(38100700002)(86362001)(38350700002)(6666004)(6486002)(956004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S6cy6GrAH9Cir6iHEQbb60lqstSIMV+1hSoTk6VL/z7jK1Hoc+SXpSJFAlsO?=
 =?us-ascii?Q?IOVCH4XclyKkQHf6NRlshMroGno7cpFX9gEdk2o6XloY1z+B9d1CNV697Oy6?=
 =?us-ascii?Q?4zCJUA2BHvWrG9PBjRNdgT0o707BFtFFRGB/ajcrJRU625+GKTOvIbltJN6w?=
 =?us-ascii?Q?qv6J1TqCwPwinPLd6JCgDpkxAg3yfn5he9Vr5spHm/91QT8Zy8ZzQSztxR0m?=
 =?us-ascii?Q?as9V6aXPQuxwH11RetOtRwW6j5yxGrTpCRp5si1SPJWnFDQGDd/Ll0O4Scst?=
 =?us-ascii?Q?FqyHLso74GOO05GkZ+33aS31hrVFPmVTtCa74dV/NiD1ArUtLKt5UxTJCWOz?=
 =?us-ascii?Q?qBFoZ5ArStDzd5hUOidkVvVQk5uBijAqCXjAyDowoUy5ge5VuML8y9zMjG80?=
 =?us-ascii?Q?IhoU5QhQqoxUQ+F3CLzV5LdqjDZQa7cFyUctwUyleJ+pNwywYKiUPpfXCoMS?=
 =?us-ascii?Q?RXoJmF358nnivPG945q8gVHQiLLRiV+uRj2iRGDfb0YLwb/MP4baCj6HqfMe?=
 =?us-ascii?Q?okp7pam0995J2wykcXVsH3hWUmNYluqcF2KIMurnO+7E8kXW5iIxry54Sue7?=
 =?us-ascii?Q?eEEyY8JZ1L5wsIxaMPw5qUlDiWjL2m2+NHcz5m/A7ptWm7j3/L1kK3nQupL+?=
 =?us-ascii?Q?MiUwlL9wVzm4uQGkxAzK56eNn9ehBTIC9iF0+0SuPkVR+v+xlX3ADxWqDGR2?=
 =?us-ascii?Q?eckV3+pxDIWRCLJZ+gmDAyI9mq3HhIPyszuARmnoYYOTQfrHR17mDNRuQgnx?=
 =?us-ascii?Q?SKZq0vT+UMg+ln4X4ht5VpYjty7GYGxzV80uLn8ApNYgoCoYtcmpfnM/oEw8?=
 =?us-ascii?Q?FXJHFZ8DnEVwVz6lk9JV7rz2R/gaF3NGWV0bsK1v5/VNHrug39eJPHRtPldZ?=
 =?us-ascii?Q?BnPimZsSukMeD9i4WYRKBkdP89fF4gqUsP/0HyEHWh+JSGm1poFVdfIJ2XzX?=
 =?us-ascii?Q?bFxGdYAhxVRRX+7iPkK/tX4fVWWxY2XRA0CVAfmzEaRFczkY4inncRfU0djq?=
 =?us-ascii?Q?krCNK1scG+kzqak8dsE0TJw5zBnpvx0zLkSe3Z0ZLk2PJ1dGRk/fk7sc2Iob?=
 =?us-ascii?Q?DOi792nUKpWyopGB0J96697BgOsDoY/eQ9cd1VMOEfnn4aemhgho//s97DuM?=
 =?us-ascii?Q?mlQ3iKAvKENlw5qbeIRBAF0qEvoSC5GnWWlu7h48DpRuT+i6ecIUs6bI5s7D?=
 =?us-ascii?Q?om2TDIpZmsT/Hj9l7E+Dc9YCpo2quDEOH/NaGr4LnpiTbmgDJksC4oYSil/Y?=
 =?us-ascii?Q?XxshFhwPzHEt5fdRBC+JTpBVOhbWa6ptdemgacrWcjZxT1BQalQyybwjs8fy?=
 =?us-ascii?Q?SJ33RXEW3DTKaprcmWYyaOAAHsIWOq0gnOlkre/9lNAwnpdxdfKxKux6YlsP?=
 =?us-ascii?Q?pZrMsD8QWaR8oB4U6xuJWlnM/lGpnb+9yzCNMVQWY/EkR2gWX51EqawZpBcb?=
 =?us-ascii?Q?KJCxXDnTFpS9Zio+8ypuIxJf11nrv5ey6uVvtaN+ItvjXKTP1kjmIWuLmJXn?=
 =?us-ascii?Q?6Hgc4AyQ+Sj/Eu+ZM+bYagBV86nMNIrISm5Z0bkdI0BbV6wQmz8Xy2GGY8ek?=
 =?us-ascii?Q?C+YRtMSIJmW8HzSu5hDmfk/1/eET0CgKIy9WN7RcGxtX57M9DuPbYNZeQDOV?=
 =?us-ascii?Q?bWeFopJSJvSWRwqjz+q6FZI=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfdd4e0-d388-4ce7-3b67-08d9a3f73d50
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 03:07:33.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/xJusVxJG2SOW1M5x1SN5njgSBecXBNI4o+/GQKeKOsRItNNKAAagq3Wu/7Xs6Wu7hWtyFoKsFddoGbOUvhww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3536
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 arch/arc/kernel/unwind.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 9e28058cdba8..200270a94558 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -245,14 +245,9 @@ static void swap_eh_frame_hdr_table_entries(void *p1, void *p2, int size)
 {
 	struct eh_frame_hdr_table_entry *e1 = p1;
 	struct eh_frame_hdr_table_entry *e2 = p2;
-	unsigned long v;
-
-	v = e1->start;
-	e1->start = e2->start;
-	e2->start = v;
-	v = e1->fde;
-	e1->fde = e2->fde;
-	e2->fde = v;
+
+	swap(e1->start, e2->start);
+	swap(e1->fde, e2->fde);
 }
 
 static void init_unwind_hdr(struct unwind_table *table,
-- 
2.17.1

