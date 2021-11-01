Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD02C441214
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 03:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhKACQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 22:16:05 -0400
Received: from mail-eopbgr1320101.outbound.protection.outlook.com ([40.107.132.101]:7920
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230233AbhKACQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 22:16:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6r51q/M8n8fus/pW/yQNo/AbR1frw00oC79gZ0GRv+1iG/pJC8NlrpOyvscLZCRbfS9YDM/oe/Px41mgmY4c4/Ak9TCQzcjWYmi8xar+XpoY+csnAiHk0mrDII+tgwz5SO5UhWr28Gs6xweLrlexzi/jYIzDrKWnlFeFt918IQHCu5WThAKgXLWb0ECP/r7ItUL5LZebe3Xw51GqWaiC63hfJfzfHrwuMjg8c5YDottT1U+Aq+8DdUDhBVlnQO/AgCw0Hvt69oL1+sg7nqYKz+BdCR2QF8BN5UMEnW/CAohATPRjd8A+cS5untfXkeJeU+Lnki88XYUUIwovZqmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujyeWsdO7e3B8U8muRMZN8nk6cPKMR8yqmyNrjOPulE=;
 b=XXU6z3vCVeymfUF+y7SQBwU+vJswBBTQ2TFEN9gy86Hgr/ZzcRktwtZHbo7OkF4q6t4uKbIE6gWWk1U+wU1shmlqF4CjDqSaq1QOnsyNzDZvjAxTx743r3MXV0oE5WCceQCvcpbl83MkipTUJqtW0VLopdYL/T8+CnMj2cAGLLgHcL+Ms/vusBtLXg985lrTQ5QURWeLPrUpfR//DEpGdccgZqpkwdjVgmFKojBrgfpu3aJLWCT+L0XzjARCiQTcwdhDRSRCB9/NaMoG4n216SQbjJhJhYz92fCleY2X8e9nPbCNWneIURIx0PMy+O5dHf8DIfuTDWe9D3x54PeMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujyeWsdO7e3B8U8muRMZN8nk6cPKMR8yqmyNrjOPulE=;
 b=Uu9LhYz67NsYakH4GklO8AyMqKkFRQuM2Z1utvM2sLFbZBH+yaE2uzv1msuPgnYI5/PdUxnqO8YC4C04MTS6VbNtd7ZBknOYsEtoDVRl3B43EsF1PluHe4zun+PQ9bc5EdXp/EaORCtOBBi6IHf27BlfC1FQRAvHQz50mbIbT3k=
Authentication-Results: HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TYZPR06MB3904.apcprd06.prod.outlook.com (2603:1096:400:4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Mon, 1 Nov
 2021 02:13:29 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e%7]) with mapi id 15.20.4649.018; Mon, 1 Nov 2021
 02:13:29 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Yihao Han <hanyihao@vivo.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Sven Schnelle <svens@stackframe.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] parisc: using swap() instead of tmp
Date:   Sun, 31 Oct 2021 19:10:45 -0700
Message-Id: <20211101021047.22945-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::16) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.2 via Frontend Transport; Mon, 1 Nov 2021 02:13:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35e08f46-f345-4eff-6f7a-08d99cdd3209
X-MS-TrafficTypeDiagnostic: TYZPR06MB3904:
X-Microsoft-Antispam-PRVS: <TYZPR06MB3904558FCD1A4B7453DB39C6A28A9@TYZPR06MB3904.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UbsL8yegiTA/kQBs7ro4Vc+1DQtkm7LP8TFgKcD6FGqyaCEWbgkWWbXKpX63tY7Fro6Mp3QZOF264KSUJe3/852coDuVxPxTrEGP95bni1kmUTSQodf3MfNYExCHkhJ/p0zxSfVEQ09ERkmfdJmQXxc9561KKmN7FaMYZewMVTbno6RKvHK5+m1JdflEHS+U4kXGrAuTolAqvOouIskzlyD6x5EL2DDiiYtMhPA7YEXzDTqvP5Bi+/3FG8U7tFP1FgFV6AVzrHZBM7y5fxVs9BoirXdHryFKIQf2DiZbYuJNbCML8BdnpFgxFscfrj+GAtX01xnQBLOk8YDmkQOog2XvVltE8URA/hIugyns0RFiUzD7Q1Dop30EaAMnkpq489m/fv99+tDbhJY1umInC6Nhhs9v3G7QicanbxYIRl/Cii4vTyUnJ+RwHWKtpkc0egM6XW13u4DU5x4WhT3aJIsdp4ZGsQouyA4o5T77OfxWRIujcUukUZAYmDE3fx4DC+MUaKW9/WPAgQK87CWlxi/EHxoA8nZy/moZFJuWxxUYhs8vn8OkcomenASDqxkaXzGO5K3CP2ov41ALGqopKGpzXT77SQZZDXuT7L3ayORvpWYfcUqfUac5QIucb3whkMzfBabXN2bd2tQ51HY6jKs5y9SETrqNRt2l3/ZvqJ3mLAquTfoVbt85ckDgPL+arl4/dW+cAlTGkuQVBMdk/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6512007)(1076003)(36756003)(4744005)(26005)(110136005)(316002)(6506007)(66946007)(4326008)(921005)(52116002)(107886003)(66556008)(66476007)(508600001)(2616005)(956004)(186003)(38100700002)(8676002)(6486002)(8936002)(86362001)(2906002)(83380400001)(38350700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHGKBkr0wOS85Ua9RN/e7NCVb06mi59lTB8YuAfmfT4HsTmT6yn/c7HgyiaM?=
 =?us-ascii?Q?CK+cMYzCJ1heUn43L8GrHDLh7nBhQVZmNLeAHaGFus3WMEY/rnWp6sEyEyho?=
 =?us-ascii?Q?4MQQvlibENGlBO+dgtQRHhx+R3W3t/fogmDrfWIhmph+KtqNmUUX3+1LoqUk?=
 =?us-ascii?Q?A949pbzSOF82/WFHbKznnq4BXL3Y8VpjuTKdUjbvlYNq1RESWcTUmPPFJ6Vb?=
 =?us-ascii?Q?EczG6QCQGGBa0++MccPb1xK+69Y5K+2HMOEQovkRsO+Ic+UaLVdLL398+xUq?=
 =?us-ascii?Q?CxQB6K3bc0dKwJhU/lBaTo2orFc6aPXAnR0nnJueOWLtvFtRl3EJ9jvSx0NS?=
 =?us-ascii?Q?XH9nN2DWecf5Jer/MY6SX7WDwAM4ySFMH0D/bQ7vbZpRE8w5kh7MIEUyCsPQ?=
 =?us-ascii?Q?1lLiIYIcQz3c69N3dvf6nUd1oHU235G70pHJQKatHC4MxJf1JptoGnH1aq1Z?=
 =?us-ascii?Q?vJfetyQ9DO+A/Ut2+TPyqiGdINm0X0G6ttOuuP8exb/oKo5k5emcvrrxrHj8?=
 =?us-ascii?Q?CHRNdEpUxiA9mVln9LOwFpzixSQ49RMHFai6apXEqnYklUMrN5PneWQx4aMh?=
 =?us-ascii?Q?edzRrOKm/9yB83ekrPFzg1BzfCPsAvvmn0Cy/RwC2fw7a2PjH/2t0SqO6Rbu?=
 =?us-ascii?Q?iFrnR+eTa2VK3VJCQ8RlYWRPu7w0hd/9jM2zFGpsgdmSfqDUbx8Yr9tjub4Q?=
 =?us-ascii?Q?ajJPXS1yiJN02lNMF7qLQGrRpsqvoA0qb/ADcHunz0Vlyun4eogVBcMcJmxJ?=
 =?us-ascii?Q?OSZ1kbxucjMn6MMOEcIRYwE5XGQBo4YYu98T+wv+afDWXDINRrt/FRxnd7DY?=
 =?us-ascii?Q?Accqtb1OHNGeMnu98z4MtxMiKULPmMiSGozZxxaSTpnrPp6wGZux+46u97Ke?=
 =?us-ascii?Q?jpctoNN3xENhtVwHYZTIQX3I02D796BnytwBVC5PTRr3igS7JcseLdE0EpSN?=
 =?us-ascii?Q?BpVum42ZqqdgpDSaOeC4m4+bYLcfM3xaIhPxkAw5KeNzWOZHZmorJzx1kjGa?=
 =?us-ascii?Q?aQN30l/p9oR/84z5O/JU+GAbAHiTgyMKRcogRFO9OXBcqXZa13pKKAoq3Pn5?=
 =?us-ascii?Q?xVD/z0SWVl5qh1n0qKMBC8588NOqGaJQnQAzSR1p/yLuDfBsVuZjH9GnkKTZ?=
 =?us-ascii?Q?WECtN2iy3Zb1L+u1N1ymhcYmcXOi06TN0o5WH96HucOAnpFaTGZOekhzHEV/?=
 =?us-ascii?Q?/orj2LLuGKDTp1Icah3toUGNY/KF9T+QUv2izk1L1jR6T5S+/064ZUqdV5GK?=
 =?us-ascii?Q?a+exaDuAJiVZxjC6i73dhNqQRU34lsyLtbDOi7nyFanIvYk4SoIGdcGM4szN?=
 =?us-ascii?Q?4CSqOg2/eNPp7ELGivwz4xbyrdIbZ1ImGLhr37xzVOC0fgL9yHgzoFMCP26D?=
 =?us-ascii?Q?CuSFwXDJdwKWTiOsMxxCdrC+waq5vijjeznBqe/x+PiaLMIJY0j4YrHdki+b?=
 =?us-ascii?Q?uzqsVUj3+7vFfzGmEtRfvr5cvBBLtg4zWzn2V/qPuDrRWPqANCFQDnN95+bF?=
 =?us-ascii?Q?G4rCmP5Y8aRnW0PVjS/op4xk0QyeS9XTZ4I2blch28FrRUuKgwjHQgNV20/i?=
 =?us-ascii?Q?pDMv34jAgGiBEALkUtcU0M76m1EwUphaHibwWHYZKjekqY82GsxB0Jh/49PH?=
 =?us-ascii?Q?t4lNbKJQGyXtjC+fZ0UuqRM=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e08f46-f345-4eff-6f7a-08d99cdd3209
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 02:13:29.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9KKvFp/loVag/846bEuTS3uGX4xgVU0DrVPmC6R3tMxRR2eqi2cVc3GMQH/VeAQRfKyBIOpzEYcbVwCMFCWYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3904
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap() was used instead of the tmp variable to swap values

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 arch/parisc/mm/init.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 65f50f072a87..b705a423be85 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -127,16 +127,13 @@ static void __init setup_bootmem(void)
 		int j;
 
 		for (j = i; j > 0; j--) {
-			physmem_range_t tmp;
 
 			if (pmem_ranges[j-1].start_pfn <
 			    pmem_ranges[j].start_pfn) {
 
 				break;
 			}
-			tmp = pmem_ranges[j-1];
-			pmem_ranges[j-1] = pmem_ranges[j];
-			pmem_ranges[j] = tmp;
+			swap(pmem_ranges[j-1], pmem_ranges[j]);
 		}
 	}
 
-- 
2.17.1

