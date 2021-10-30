Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5277B440928
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 15:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhJ3Niq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 09:38:46 -0400
Received: from mail-eopbgr1410127.outbound.protection.outlook.com ([40.107.141.127]:35296
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229989AbhJ3Nip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 09:38:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMMaH+E9yoSHe3YAS47Uj4ebqaVSL2u111yuKnwbfwsktrV1L5u84M6BNW2bz9Eb45CI/b2hHWYlAR+GmFDfTT/IyWtDmM+4DNCqOyaSgwf4rrhjVY6RWz4nlOIhnQW6PwDCauLTj++S5H7gWSevBspX/bUMcb+D5h6as8bG+ro5TDg89dS2MY5lgH2opPv+qmvlfkI99tPOIO6FB+yq8maJ3k3TbS9oUgV4jzL5sD64z9ws7h6zTOga85J9F0/FVgc9zJ+IhYpjqGLaBIQ1EntN2IXZ8hYxdi0rouD+kyLJNm1qKHf53k/kIFS+pHH8cwm/Nb7cT65LjlqGCJUTRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgWB6SRYbH2XyjYtlm7ECMd3eTF/rKilyN/0NGhQdmw=;
 b=llWxL/zFH3NBhx5e2rX4iHlYc3QLG+IUxV+eewn4Qp05laUY74Mhloo4Ei46ATcvqcbbzj/8df3CPwRynXL+sA0usYw4aB3U+wfb/onOuKj3q6ovSL6x5w2/HIB3ivdBlqmg4lQxEbsr4w4C3jRVp1jcXMiqwvI0JaJ1cw+fvQlQvn8PG/bE6NmdQEravbo+Bc1U5MYcKDL9KDI+bf/bWPmFmXD1pMqSuNtURdMPmRHnejMw0QGyTbNBpyYYeoaBetXGocZRK72NRGbEgcJtri1W67eQfw+8euBmQvjS8glnzpOQTAJUQWokstd3gd07jMx5qQ7s6sfRMb7DNeycbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgWB6SRYbH2XyjYtlm7ECMd3eTF/rKilyN/0NGhQdmw=;
 b=TJJl08pH9QkPtKNSVNRXj0VazDGBkw/4PVES7XzZdYHyU4yZMr5SRcyZavOozvNjgaizvEcROENFg9pEyR1gRJLH9HHwcIAtBuwcZYsLcPztumDwbJOkVxaxN8ytA4PBAyfGlkwC9TmhlObZSLPOb+UTXTzsyXsmne4xHt45R98=
Authentication-Results: gondor.apana.org.au; dkim=none (message not signed)
 header.d=none;gondor.apana.org.au; dmarc=none action=none
 header.from=connect.ust.hk;
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYBP286MB0432.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:801d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14; Sat, 30 Oct 2021 13:36:12 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%8]) with mapi id 15.20.4649.018; Sat, 30 Oct 2021
 13:36:12 +0000
From:   Chengfeng Ye <cyeaa@connect.ust.hk>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com
Cc:     linux-kernel@vger.kernel.org, Chengfeng Ye <cyeaa@connect.ust.hk>
Subject: [PATCH] crypto: fix potential null pointer dereference on pointer dd
Date:   Sat, 30 Oct 2021 06:35:56 -0700
Message-Id: <20211030133556.5601-1-cyeaa@connect.ust.hk>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:202:2::15) To TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:b7::8)
MIME-Version: 1.0
Received: from ubuntu.localdomain (175.159.124.155) by HK2PR0401CA0005.apcprd04.prod.outlook.com (2603:1096:202:2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Sat, 30 Oct 2021 13:36:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a84aa75a-db50-40d4-d1d0-08d99baa3cec
X-MS-TrafficTypeDiagnostic: TYBP286MB0432:
X-Microsoft-Antispam-PRVS: <TYBP286MB04329EF20AB0718E4928D9A38A889@TYBP286MB0432.JPNP286.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZ5WqMG9LvFwbaLOB6H/rTAD+417TYWa+W2wqTNOlwkAaWZlfnTIm9m4nKU7eI58SbzFLpOZU4ZqhXYUZNfxNbO99avT5QPNIKaIXn0RZpSq50dt2lXttYI2yFn4uqr8Kimexc4M3OaSFNyVO+Hn+i7ckw8wiay7Xbi3mCukgs/EwE912eEuv+YNI4VopSC+LtbNa7vvHqCIexFd/deGn768/EpG6mBa7txJ0C4un2z9F9KwoY8nQiDFVUAw+RAsWh9jGigUL3CKUorPXo8iTelXW1th7BHDTTDuiCwa7VyzMSlfsBAGz1dnDRtzaJyahsZR8qsa9XpeNxL1uGgk65dRqO4p6tbnixUCEZElusLztXAesLSEZ3/jJBMZVUu/5tbd7VzJB0irsx0mP+3fds3SvDdPVtkc3nFLWta5vYJ9fWwGE0kpQH18PsXB540bnx3S0Tass4Mp4NbmhffZOeiCV9r/XrbtEqa5eSQb3/YMNVnqi2JgZbDrpPEVd6dlhhTd/wjmpCcOprm8mC4M4U6ufUeTw475i1oZ6PWJcunrBGSsCkciCJWF3MtIWsXO3Il8rNWQS0J7DI5P94P8AO5UCaGA+z4YntSZy+L7YZM+DvxdEhKiy4MTKCSQWtC3B6wCml62tweB3w+/6UjcqBa5diveu7DgeWMphmFqkIK8H6PgmCOaCPKAkzyErD/D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6486002)(4326008)(26005)(508600001)(8676002)(6512007)(8936002)(5660300002)(66946007)(66556008)(66476007)(1076003)(4744005)(956004)(786003)(316002)(83380400001)(38350700002)(6506007)(2906002)(2616005)(107886003)(38100700002)(6666004)(36756003)(52116002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o2aznEIyOu0WcZN3lm0rg5GBPRTYz41f3mKVo/HV1yTKFH4TT4Suu2DSTkux?=
 =?us-ascii?Q?Oi50wl5I4yJEdegx0g1GucFccXTWg52d67XUF2rTAcN+fWcsY522QMrTVU/F?=
 =?us-ascii?Q?iXPzhv1IWNz1BK6+C37VDWTVswfuL2rtQCCmeU8vtWbMNty07DjQu+fNWTy8?=
 =?us-ascii?Q?QIxHkbxxssZdqoWq0ukReJhU6lbW6TtjJVYQe5oymycnZ6Y+vWZeGCBdAKJi?=
 =?us-ascii?Q?GpVhk7x5ftIdOiQNjTC5585MELRm8xSupIKKdC7YiG4dQULI7dikSMAvzqDB?=
 =?us-ascii?Q?CHBcWYMhcd7jyzyVcW2RmIKMINYGUUBEqeIQZCXGl+neo51IfqxMue1wtgFx?=
 =?us-ascii?Q?fgfvflATvEGLfZVMJjfQvTVsp4LCbRxGcAvsBTWhzUcZQv3tNJgxczCJRUC6?=
 =?us-ascii?Q?536fvlekbRZVpNdfLEfiX2/nppnlRX2SiCgEzaIV90HCd8/gDFTzgC7uM+dy?=
 =?us-ascii?Q?0SMNyQWq2KShuHuSNVxv4bQQ/sQ+mbgodc7iJDGaf7ojzcmyPop+6px4nIsx?=
 =?us-ascii?Q?4gcta0ysSHJjSyDfBuA8OWAvVTHUy6vbX4YkknSsD3zB1bMMO6N/AFA2euFI?=
 =?us-ascii?Q?IrEDg2rqzrcWWO7VL/0mDIw4lD3ogF2CDq1+aHyH2XZhlOYYjSEVAGN6cTtq?=
 =?us-ascii?Q?oSlR5Qwe1K7WW2FCUd9jLQt1CnyHUNjsULJsnJl0g4QeNoL6DOgMKe68pMZ9?=
 =?us-ascii?Q?OAkOuGJ5Cc3OmaU5CAUtcUmAy6BgojnQLLigpxrnX1gLer3FxOyvkyD8I+LK?=
 =?us-ascii?Q?wCA7qILxV/hKITRMPxxrep2/kmKLNAHtKL5TioSM1cOvmVtNsvGer4G8LKVn?=
 =?us-ascii?Q?g0ZiWuOtDWE5L4qLEJbuGnWfDYJxtmlpyi2D6U4xruWy+TR60MsuxhAaPsv3?=
 =?us-ascii?Q?2i6Dz97DgtibTxb2+svkkFN05Peaq9yhIgFMD4T5Km4juikoiGVhtX0s6iZB?=
 =?us-ascii?Q?CFI7qFFucWVSxkEkE2VlBYh0W7nwF7P+c2cJ8quPojPctGe+DYhnUtnMF23b?=
 =?us-ascii?Q?DbX+r8+FuFspF3C0gIqX3pLEnRC1Nqq4XTLKAVrghs5LEGIHjYi/lkcarlcV?=
 =?us-ascii?Q?JEIZUg6R8PXsLbQ+SI1SFIol/YRCbnTVoM21bo/80rj+GiMsAhYJqiokptGl?=
 =?us-ascii?Q?eUy2CBkfQGO7T0nkhys3wmk6NTgRi+AS1UcXR4/pgmnO1wt4Grs70o+o3Not?=
 =?us-ascii?Q?s4b3ycyOlOGydeujfNd781TGMrAXIZLxNRsTSofZGedK2Dp9W3+U8ANs/W5i?=
 =?us-ascii?Q?LmQ28ah6RRfH4Kgf8hI7UJck7u5C/2Ta8j6ric0tS2/13ijXinFh18g5xoxS?=
 =?us-ascii?Q?P81eJhrUCUrMXzi8w0/ks/K4BKEsUokoH/3eA3xhEp/1Rk5kytwuFUsDJ6WY?=
 =?us-ascii?Q?MZ3Cny97FviSAPmYLjsZMy5iDGGdEB6fxvViCuUqUT7JmVM2iHBFq4VC9w2N?=
 =?us-ascii?Q?TbL9dH8LrfQIJZjFXi3jVHJ2NNV2Ifl5VzsLn2WS/Q4x+pbNnAX+Bbsrw/Cp?=
 =?us-ascii?Q?dD+ODB7FmeAB3TQKoNC14pAnw632qetmSpmywG6qOvyJYwm76ZZFO2um4w4T?=
 =?us-ascii?Q?bTg+1Oao1o5emRd0Cw1kHciPnT4i6VlXbFeqA8VWHyswTj18hRePQBTpTQ/D?=
 =?us-ascii?Q?dZoigm0x8zQ3dzrKIUm89Ts=3D?=
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-Network-Message-Id: a84aa75a-db50-40d4-d1d0-08d99baa3cec
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2021 13:36:11.9998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+m6cpFVyyQ1JTMaEwc1NEyYUdXoStNfRiDiF3Eo8E2UnzDipefAkaXfggH6B20y5otiBRswyyqfUoXhzwepbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBP286MB0432
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return pointer of atmel_sha_find_dev could
be null, there could be potential null-deref issue.
Fix this by adding a null check.

Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
---
 drivers/crypto/atmel-sha.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 1b13f601fd95..f6ea5aadb86a 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -430,6 +430,9 @@ static int atmel_sha_init(struct ahash_request *req)
 	struct atmel_sha_reqctx *ctx = ahash_request_ctx(req);
 	struct atmel_sha_dev *dd = atmel_sha_find_dev(tctx);
 
+	if (!dd)
+		return -EINVAL;
+
 	ctx->dd = dd;
 
 	ctx->flags = 0;
-- 
2.17.1

