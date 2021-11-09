Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7589044A6E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 07:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbhKIGgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 01:36:04 -0500
Received: from mail-eopbgr1310091.outbound.protection.outlook.com ([40.107.131.91]:46806
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234506AbhKIGgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 01:36:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMxrOTKOYcykki8IAAT40gA2oTMV32ooEyZA40rW9VQcUMItt5j3tb/Za2L9HkLLiQO14exCgZSnCtxnfjIKQ1G/qfz/TgvG83JUllKdB8wzHMgu+UXNdTuFoEqX3TxFQP6ipmjJs7JGH6sbWDUIy0tcLa4LyX0ON1TC+jcOjl0lFLo32RZ/w7FZ5nq5nHFZV+I+Aoo9gE/0ZoKpLHd0pr9x6gn4VFRENvlSUWuSgjkEILtKs5FEPvRj6rQYdnFC3EWJm1wbAoCFAwd/QfBF7UblTUaHiqNAjnBF1E3osUrtFYhaOrSRWgX23Vn+WErFkZAUwv7gy29y9aV2V+mMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7hncRgd4JTC2oiu0ESN/VpKTWnS/Jgay8bngyl9HfY=;
 b=bofM2EfHs4FusWK2jwR+ldOj6gU90JrB7y7unVdgsxNPLjCYbWX2nV3OvMJaFJG5lEsZjGsYu7DjZLQB+gdX2bXpvyxsHAx2pY6lUbAynstRJ6+BM0gEJb4fkmI3Ipb2u6k3Do6Lcne4N5cj6PBfHtYDFvwhzMu478DkYGJgEZbg+4scVd+lj/39DIUNxd6OP78hd+pJ3yTFl4DYhFeyeZ2ivmju81Kl6A/6lF2w92gdvkAp8LkQ3BNsnPkcJ1HFF8T/QMnn23lzuRaO1r9nIKxVfYCrctaMozp8jo+mtHqD4ezirhI81yoNnOmON64Awpf11z9Li0BESECNuY5tIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7hncRgd4JTC2oiu0ESN/VpKTWnS/Jgay8bngyl9HfY=;
 b=H+6Z3n42HZnHx/IM6ef4WHH6YnCW5omyiPgw8o0ubz5IGgqw8PxQVfOrfm2dgrGUHj0W/4tNU3CYbllqGr56NfIbqGibsrzMkNQxGJOwXUTSCKtO2ID6vnBrfde6VtIzgQzYDtnUm0m4v5ZZIgl42vQJzqaN00g7e3a95JVU11M=
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TYAPR06MB2416.apcprd06.prod.outlook.com (2603:1096:404:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 06:33:13 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e%8]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 06:33:13 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Yihao Han <hanyihao@vivo.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] lib/bch:using swap() instead of tmp variable
Date:   Mon,  8 Nov 2021 22:32:49 -0800
Message-Id: <20211109063251.11215-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0185.apcprd02.prod.outlook.com
 (2603:1096:201:21::21) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR02CA0185.apcprd02.prod.outlook.com (2603:1096:201:21::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Tue, 9 Nov 2021 06:33:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7d00f75-1791-4a76-4f57-08d9a34acdff
X-MS-TrafficTypeDiagnostic: TYAPR06MB2416:
X-Microsoft-Antispam-PRVS: <TYAPR06MB2416D64C859CAEB7301E3951A2929@TYAPR06MB2416.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:78;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNFXcS9tVkWwSn9+Sd3dZML4G9oD61TaQolSoEgmrd/0Ie06t4JyE5D3g1GhLLoMclyS14znjipoqZ87+kIbEz7n9BElFUt49RJXkWQdsN8Z4IVUeVEpM9PsnmIWqbTz4ukgzSd3VRICQ3C/NQoJskqDc9ZQUfXpyLP4i2Z9BiPv0D+3tz+bpGqP2dxGDhP3CASS3gWYUw7chFSbLu5diasN69CqWbf2JfyXUSvC80e4Ekaw27Uno6WH69wmv7PKI7ZQ4hJZymA08HV9+ojDHT3VB+gX5qj+FAM2Yyu8STB5ChuGTHoIOL509QJuWfpqCXSzNlrS2oDcdQ9pLhtG5QluAToXPEo0l9uZFFUk03vlWEyVjCIl17GL3QrY6lLHJCfyPmLiFErZ3L6llxK/SDAJdTJZubcmoLm4t0SHui2FVILd+AWF+aFYaSQyzbGklbYqqvIxXhIsOrosqpbw0RQtgdpt0OYQAqdd312t+D/s1FC9M52k2BCMVWVhq5bd6f1sc8gZpNdZzJxUA9lpQp5rGccOfLztQYXN9ArCGWq/AMrTHr2x9CRsSAzGSx0uHYwjaDLBm3AG/42evsjFF/eki0ow+kjZeGoodpMxYr445BuuJEj2sHx+14BrZl3qDrIwAvjZnYWJY/FubMwQKNG1+7d8QjGkzQQNVWO51jrtpt6V0szF5EBy7DPYtCo3KV4OQiLuXNjc93mIaQ9tlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(8936002)(8676002)(52116002)(4326008)(2906002)(6486002)(26005)(6512007)(107886003)(5660300002)(36756003)(1076003)(6666004)(66946007)(66476007)(66556008)(186003)(38100700002)(38350700002)(956004)(86362001)(2616005)(83380400001)(6506007)(110136005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LXPnOlO/1eJoZSlnzFGZQx4XmBKAcXT69fyuau6kNCclAPS/wekqV+pojGM/?=
 =?us-ascii?Q?cXl1M3TrWFWCjVjOBtr+r9k39M/JHPmGLoR6ZTRZtA3m+8rpZ7c2jzM4wiTA?=
 =?us-ascii?Q?n+w7sHgGdnruPkhybNHKhMtnDRcl9WyftadQG2Fkw8F9t/LXh818CN56JJ9M?=
 =?us-ascii?Q?Mupaiq4qBNFUEUZvrqFRxFzV/wmFTr8CG0M/hidnx7S4FXtEViXG/Olp+1Lc?=
 =?us-ascii?Q?FjuKVtaAESUxyzZcElKRYyNx6eC+XZ7sL4VYDAxF8jc0kC7WmOiOlwmA8cto?=
 =?us-ascii?Q?6tD/3rEk4XOTSHk+wSKhZNvRgLGiHBiOhAPVa6bi7PlUvcb77rtZWS8Ihkcm?=
 =?us-ascii?Q?vbBIdyeAYdngwunzCfcDqKp2KxAvQs66Ht4f7LDDnT2flov0Lco9HRJAoF69?=
 =?us-ascii?Q?V+FPHfn3a4hBysJ7zrefYgJjuZSJnMmXUPeiiqSAMW4ZttEqhOVAGCN98O8T?=
 =?us-ascii?Q?c5WT3UpfcD5XmkFiU5AvqKhZXiqO0b9Oyd8zsKhnGBNoHRLSN6qPJjaIKAkY?=
 =?us-ascii?Q?0le9LdZCS/fJMx3U1ZS4PKi+ckyKyaW3r4NscUjUFxXMPgW6/ba0b6LX4U7q?=
 =?us-ascii?Q?AvpTx/hvne6354v1iEfe4gfmcWnLIA2ajewbQuZ001Wkf4QoiWi4Mq1yePgs?=
 =?us-ascii?Q?g6CVpAFvtyKFWcWtf7WN9q36eCItDIwFdbh0KAKS++3AysD2EHdhTQXGxCn5?=
 =?us-ascii?Q?BYLhEo6vlQs7Vn7ollXiE2RasLf5A1rfGJPJoOtsDSt8VtN+zJ32ookYtROP?=
 =?us-ascii?Q?5lHZ0o3zR8maLyLiuTD6mefIs+m1PCWmT73e5IW0Mbxh9upaATGJ0hm6SPPA?=
 =?us-ascii?Q?M3KC21iZGqeoRSihq1qDjDKUuc/KM6GT7fOHPgC81/47s9vGikCNnX9Jydzi?=
 =?us-ascii?Q?yNqkHv+hNNd9TVLPcab1LEdaHewe6cXQ0gjLe/S8Pu476CQt4p8U8VGFcWV8?=
 =?us-ascii?Q?RH2Af1YRzYp4GDgT0G1LSytaJCYaOrNZdTSs5zLfDSmVIukWnJxuo3WumiSP?=
 =?us-ascii?Q?7EqpqF6846EOR/NHbdSIAc7oHxFWT0Xzs7OkdgI0cI44++t81DCAWb80Ve5a?=
 =?us-ascii?Q?tegbZC7MHXtKwF5ecTLRsvGKv3557gWS5ZzxVoJ5WStphwM+130YdrR7VZyy?=
 =?us-ascii?Q?Yz3JCegcOLKRxXUQ4hL7fom1XKpiPDQrg8rn5g/fUoniRDa8/c4rbhg67DZu?=
 =?us-ascii?Q?jvXiQaRDdby/li4rpcg8kikL/L46EvDDxLJVRyhQEQvwaAY4PQiHKNTqiIJl?=
 =?us-ascii?Q?Ex3Bdci0mNIM01PSR/JmcUtzaUb3LbkM1IPh1559PiJQTa6tkBOjeFzas49V?=
 =?us-ascii?Q?qoERi/zngGSWSWUJbnEZp8FHI7934juQ6yY7hAJaUqzD7yBQFmrlOreR9oXK?=
 =?us-ascii?Q?zxYJfYYqtAS9nasZ+6EzOCtzU8MPgY8vTC1JQqBUNbaeTX3P61kLvmuwVI/D?=
 =?us-ascii?Q?CVbL3gzCW/xW9W+Duc25uB+fkNNVYPs4ExFX/TsgG4/8Y2ZnZxFyHInlqkRN?=
 =?us-ascii?Q?zxmtq14EaYt4vZGgo+2jgTKmdXhm9OGf/WYqWIlyWanEW0858c+sfOubVjew?=
 =?us-ascii?Q?lytdnu7XWyaPcJRjj/5IqbyjUev+aP6Whc8JiQXrLhpv6LHQ6CiyBZgVIk5g?=
 =?us-ascii?Q?N1m/sO77m+ej+9TX87/TyvU=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d00f75-1791-4a76-4f57-08d9a34acdff
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 06:33:13.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urvRqXJ9XnzGdV4m42Rp9pRg1LqcIrWDc/wvdW1SM9aGMjOxHtc2d2VZQ75L/9YuzjQ5dxiNuebu5DBiV4gbig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2416
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap() was used instead of the tmp variable to swap values

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 lib/bch.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/lib/bch.c b/lib/bch.c
index c8095f30f254..1c4ddb2d845c 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -500,7 +500,7 @@ static int solve_linear_system(struct bch_control *bch, unsigned int *rows,
 			       unsigned int *sol, int nsol)
 {
 	const int m = GF_M(bch);
-	unsigned int tmp, mask;
+	unsigned int mask;
 	int rem, c, r, p, k, param[BCH_MAX_M];
 
 	k = 0;
@@ -514,9 +514,7 @@ static int solve_linear_system(struct bch_control *bch, unsigned int *rows,
 		for (r = p; r < m; r++) {
 			if (rows[r] & mask) {
 				if (r != p) {
-					tmp = rows[r];
-					rows[r] = rows[p];
-					rows[p] = tmp;
+					swap(rows[r], rows[p]);
 				}
 				rem = r+1;
 				break;
@@ -833,21 +831,15 @@ static void gf_poly_div(struct bch_control *bch, struct gf_poly *a,
 static struct gf_poly *gf_poly_gcd(struct bch_control *bch, struct gf_poly *a,
 				   struct gf_poly *b)
 {
-	struct gf_poly *tmp;
-
 	dbg("gcd(%s,%s)=", gf_poly_str(a), gf_poly_str(b));
 
 	if (a->deg < b->deg) {
-		tmp = b;
-		b = a;
-		a = tmp;
+		swap(b, a);
 	}
 
 	while (b->deg > 0) {
 		gf_poly_mod(bch, a, b, NULL);
-		tmp = b;
-		b = a;
-		a = tmp;
+		swap(b, a);
 	}
 
 	dbg("%s\n", gf_poly_str(a));
-- 
2.17.1

