Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E6844A6C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 07:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbhKIGWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 01:22:02 -0500
Received: from mail-eopbgr1300110.outbound.protection.outlook.com ([40.107.130.110]:61264
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230059AbhKIGWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 01:22:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJxdjtsMhByxt62pDey978acd6ED4QRnHquhLYfjDKylGy8++0/S8gWeNEpRarFeOI+qyl/NduiOsNmwgWOhJnOC6S4kDNSoqZ2eTxYLMtUtDc3unuy9hJLUidRB5PgEZqNpeFu3vBHNj84wLv4tvzxCL3mazX6YiPbuvsEYAQrsAM4gDEIKUVR8D3IUzEmYHyOyLmtqNLsTPaBTVpQ1paSUFAV7eLAY6LGNGAFYIrAurZQ3gUW9UANlyAgpvZlfiZB3T+xvdTTfI8h0/su6z23fC9A7aMF5thxjlB6ACKqUcZR3ELW06CbugWz/BBRnJ7jbl/FdhEIoN5E6XIaetg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaGD6IsEYorvzIy9NUsVcmFzMhlqspn1TMyvUVzumrw=;
 b=L91ksSqh9951o9qjF4Q4qO2sH3nny8riW/WKBGHYWPpDOFxUOJyRhuYhG5A21lU9SwlcSVPcu6jjqmXSYvyr5GY046LvdD/PGM+BDPR4+q3d0s5nve4zc2/ntUSWJWQyQGRT/zbeuJa3XlXopqPv+NEg4eDCpcoL3EcRA/Ea1J7sZdLqZJfdj3MZf68+45ZSINghG01nKmQdJV3+jzvAseSoQmXdOBFpWOft6//eOTBwPHKjejt2QFBOPbRAizkcihXL10wlW4hRgNctRa4q/ICfztA4nTmZ2pKxq5W4aLr+0YvIeVYPr3v5JZfS2m9ChLVMYaVsOJrXLbXPiWd1gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaGD6IsEYorvzIy9NUsVcmFzMhlqspn1TMyvUVzumrw=;
 b=kFXs+dr8RS0XHj40kjj7J+OQtkeA1pDxMJfPP23jlVM8W8/YQMP+24GsMhbeunDjm/aPc7mINX4SWNzgymkIAXflo2ShF0PSQ280j1EQRV0rGq+vKl8jfA39p/L8w5cTZuDL9YAYlonhi/aMdbnSVPa6/U3WSEMpfeEOHzCx9eU=
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TYZPR06MB3949.apcprd06.prod.outlook.com (2603:1096:400:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 06:19:12 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e%8]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 06:19:12 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Yihao Han <hanyihao@vivo.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] lib/bch:using swap() instead of tmp variable
Date:   Mon,  8 Nov 2021 22:18:41 -0800
Message-Id: <20211109061846.11032-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0152.apcprd02.prod.outlook.com
 (2603:1096:201:1f::12) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0152.apcprd02.prod.outlook.com (2603:1096:201:1f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 06:19:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e94d814-a0f5-4bc4-078d-08d9a348d92e
X-MS-TrafficTypeDiagnostic: TYZPR06MB3949:
X-Microsoft-Antispam-PRVS: <TYZPR06MB394950E513D273E4B0853D9AA2929@TYZPR06MB3949.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:78;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HEPXl2qo3VmyWOzZtAvHicAJxuqIsW1a8lLKeo6yi1CMs7e/tZpgRItz72cRDRGH5sILvNStrciaKT3UnzEZiJgVsaeXI9BEvRhK5Gw4ASA28wvCbnIhfg5K2Ejkri5TY90YCK6ZS/kLgRDgaqMl1JxZF6JumveraXC/N/THG494OkCGSSwJeRI519eOFgZPqlbDOPlxsazcmPuf8G0El11SQ+/E6lOHkemMSmz0ZmlKbts3Jwk2XRumluW1TYkL/jxyZFnkdX7XW4sgC/II/W6hACmcOmo2VOPJLZKnaVvbH0r0PefQmo9eALrEeN9HpD7caQS8TiSZPRrJ6+vBFT0zMx9FwaRjEt3VKCTU/wI9uvd3TNjQoJSa1+UVW/qus7BM05tpHn9g6U6lS4esJcuJ8xwj8jJs93s2YbZKMipAxmg8cShCWPCMfEz5tGg6IM/s+CtgMpKqtjPxPZPb+qfC9Ut7JnebAjjqmx9VV1Z83XYQW5g9vla543XLjDkgKqNUIFXWrJZHi/l9Q0ymwALa3S2pYHEa4fPpL52Lkgv3cOR03IDqA0XzMhuEE0ru6v8S0rtjJEDpTouGus+060QkUJjua4P5W9Kw3oRjP/v1IuqE1P64oPeARrWaDyR/oHjTfrblQvk5X6Au1zH4Rkf1mTMhS9/FNizrDa4eWlwIgIrJ34gJDCddwCho9rWYEqcvOnE55WolbtVUq4zd8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(38350700002)(38100700002)(107886003)(186003)(36756003)(66556008)(6486002)(66946007)(86362001)(110136005)(6512007)(316002)(508600001)(83380400001)(1076003)(4326008)(66476007)(2906002)(26005)(6506007)(2616005)(956004)(6666004)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jdFIlTf4RHoSIFeuVdhiuXBu0kZkF1fb93NaFJgC+c+V0eAatXsmSom/wuoC?=
 =?us-ascii?Q?UOcIipSsa5TEpOrouCHxj3JFtRH4D6itVCeOU/Xc3P4pFMxsUCJUwATl4QID?=
 =?us-ascii?Q?epWq/ldADxCZ9ps05ZjjVhBLwR5bTDQYVmxtVxqOCdPL1+B/zLl6jCai8GrS?=
 =?us-ascii?Q?41uN3To+rALlfcawizmYYogPF7qd+sQKU+QMJD0AA/nEft+5D44rBSUmXKEu?=
 =?us-ascii?Q?3d2zWWAfV70OWgSNN58SoaSMG6UpZNm97OxCMAeCHWrk1i59aEHTamL3JN72?=
 =?us-ascii?Q?H+OlmXqgE3OZR0+0flXJG7kaPL7Y7qRgzZQwcCZruzJ/EckBFR9QU1bWp0tP?=
 =?us-ascii?Q?eH1FPOOqz06Y8Egr1bZJFNM878bpmtHBnXJC/i3SCwtQKrUW+sOkV3omnT32?=
 =?us-ascii?Q?dTToq47kZdUlzpXqiA42H2tCJ1JBva0NHKj0ctM9nVjRVgRXMsPO2z3V1qOr?=
 =?us-ascii?Q?+s4WbqTj7M2JNjI0kMy01NGpOvTRft2WzjTaeeO78K1Jr3YKoX9AfFKauMWD?=
 =?us-ascii?Q?bsr5GUlZJlhOZDYxoqZcaN9TiOtzTziT25KuZFJ9V6Tg+j3gY0zIdrGLSkzb?=
 =?us-ascii?Q?guxdb+W5fXeJ1DUbyaHqMPx7JEA56F2QUZv98TOhOaRImdu5iWxHWgS+QNXf?=
 =?us-ascii?Q?XSShTo7SdwK4hl2TZAqu7KRgLVRrYp30ItMnCZd5dO/DOLvFVPNc7SJj4cQE?=
 =?us-ascii?Q?VT45xnS8p2055h4A3yktZ6GpLeagETPfkdMgbLDTb+fsUKD7PqhaDJvTNjaw?=
 =?us-ascii?Q?9cfCtjezAwSeLaGJauuRrWrq2wBCGSIDCS+lpBqkRKwxVuoLIyXuZVdj7ctu?=
 =?us-ascii?Q?czZOA0GcdPsR4tE6qG+eyS3OirnWXRjxVfB4qCdQDkgQWT5xCTLPbjaOaRUx?=
 =?us-ascii?Q?N0qJpVA1yggOarbm+FsOcbHesJM1QeZZCV0tKlW94iuRyi3g2UK5p2U1+g3X?=
 =?us-ascii?Q?mIhZy6Jm72Gw9CEngfLJCOOoSDm/VigKrTu2aMoSkFPTAf9cPDGQtCCmWx8A?=
 =?us-ascii?Q?+tSvS9yO7X5FIdveqScaOvkHpo40wS7QXEPOaA51WDhKAwRicPwJ8mtflBUV?=
 =?us-ascii?Q?hEF7ezYGT5y15yJv9PWpgGF1+RiMlP+kNdhGsgzwzk4G6FQhNaJrfsQiFZEw?=
 =?us-ascii?Q?QRplFVi2YujfkPJeX4OXO0MVQP2u0ETU77ebpdWrZFQtN5jLm4zQ7AJbyzsX?=
 =?us-ascii?Q?kwavF1Wsf+vO2xvZzSztUeWKXg72uNLHMH58VytVzTljFnIX4P/8KwZFkl/5?=
 =?us-ascii?Q?KeflTd7gPHUoxTwwEi3idsIU6xAntqp+LRCJh96/WPvzZ3Mq2M2YVySOmAf7?=
 =?us-ascii?Q?yGUKTF5WfMM8TN+F7BdOvCwyPHIHs/FPF4BRdVUBqlqcmGOArSURqUXCDMMD?=
 =?us-ascii?Q?dYuOugVd36go3ZSY/1XHSwEw5y3qAZV6ahs7jVPr+vK65jYb9Q8gBnv/exx4?=
 =?us-ascii?Q?ERU/8cneyMXOJ/QWwe90DLDT7ntcW28KcNRbMbMdwOsRaRrQxlGTxqLoLFra?=
 =?us-ascii?Q?7wyjUmGIotLOz7Gxso33IImjiASJ2z799hlJK5NqHa0orDKaGs0wugou496y?=
 =?us-ascii?Q?cUrsn1iY0sGGIZekRSfFRoQwidW+KoeAuy3d/VEuRN0UvSQLAGYcydqzZZvo?=
 =?us-ascii?Q?Q6lxsL09tZKPi8CpMsSmwS8=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e94d814-a0f5-4bc4-078d-08d9a348d92e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 06:19:12.7655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOwWNVPenzimQPtomoMRpNAHyaOLye1gKE82JrCm6rN8/1NWA6BSpNY8VQ2fjCb9dRvMQGPbcKI/gSQV6S2Y/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3949
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap() was used instead of the tmp variable to swap values

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 lib/bch.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/lib/bch.c b/lib/bch.c
index c8095f30f254..0d6a2942ad20 100644
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
+					swap(rows[r],rows[p]);
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
+		swap(b,a);
 	}
 
 	while (b->deg > 0) {
 		gf_poly_mod(bch, a, b, NULL);
-		tmp = b;
-		b = a;
-		a = tmp;
+		swap(b,a);
 	}
 
 	dbg("%s\n", gf_poly_str(a));
-- 
2.17.1

