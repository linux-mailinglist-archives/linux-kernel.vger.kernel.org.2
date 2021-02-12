Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D366131A20F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhBLPtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:49:06 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:26274
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230307AbhBLPtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:49:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVK2yl3PPOOPgXon12lWTcS8Pv5gsNPIl7OD1SgI2GUdthtvE/kpmjh8V37lM0NlHkF9Ecuwati5mszhhyBEmmo/CniY75AwydQSQ3plpZKegeCdpRUMglM6Ns2tT4nfXFxeYeaQVn9tjcWOVNWvMOT1/RtPu+nzZsu/ulLg/bvv6PY02fu/chpGZ8qfwsZESUZjWFzmLipmGHA0uAOmbqWi92HJFVAkxwtNnPrXumavnEY2sXLvseCA6whdCipS8yO3wXH+4Z/ZOfTVrXOnsPZhitRUrmDPEaC0XDSVKLxxKIio7fcKG9UBGcsgh5d0rGVpe3QbnBB513IrnIX+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4r7I4luoyjLjroamEzld0DxXr9UzgaI7rqNJRT9bIY=;
 b=Z0r23fvgLsXXcollrgzWnp1ayxxGFVAu0YgFq9/w/5OBfGaliUDDTeg+qCx6WFuU62LDnX/5xWC2Fxukqe7pAWAlXIAz6eZXA8jPHCiX0y+KaxUBGWhZ6XFokHsRICtmolUwyV70Xh2XA+MnyZFNJ59RnQlbO1uPRQ3GwpssGZjy69hNGc2uZzrjwgvnPXsJqhOVqhLzEueZlbiV6Rvn5eRBqelmryj+9rlMJM2wxaSb9bYhQO4zhYm5p5GFZlKF98Q7q+qyFQ5Qg0m1mtSAMps0+qDioNQ/iTXvlNpQ/kpN2JX9EQHZzp7evv4424s32nUb61E0EwFbzrudHrQB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4r7I4luoyjLjroamEzld0DxXr9UzgaI7rqNJRT9bIY=;
 b=uccZ29u8JVjrYd6ywWdPDtvpQ9wATIWZ+Rmb6bC2xRrfJ1UxTSnZrS9ShTGK5NdySg5esEgXfMt/Q3Fxu56n572+73+yFDlVGUznjpAO1vxlzE/rYl+2DdzhiVjQW+oVoFC2iM5p4nbtosIjZGYDkFfbLg5Qg4rj5qoGZO7eonQ=
Authentication-Results: witekio.com; dkim=none (message not signed)
 header.d=none;witekio.com; dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB1104.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:a6::18)
 by PR3P192MB0699.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:49::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 12 Feb
 2021 15:48:13 +0000
Received: from PR3P192MB1104.EURP192.PROD.OUTLOOK.COM
 ([fe80::7cb9:2a79:ba90:743f]) by PR3P192MB1104.EURP192.PROD.OUTLOOK.COM
 ([fe80::7cb9:2a79:ba90:743f%6]) with mapi id 15.20.3846.026; Fri, 12 Feb 2021
 15:48:13 +0000
From:   Mathieu Dubois-Briand <mbriand@witekio.com>
To:     mbriand@witekio.com
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: sfdp: Fix out of bound array access
Date:   Fri, 12 Feb 2021 16:47:17 +0100
Message-Id: <20210212154717.362233-1-mbriand@witekio.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2a01:e0a:4b9:9060:a10d:9ac4:ab20:2729]
X-ClientProxiedBy: PR0P264CA0250.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::22)
 To PR3P192MB1104.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:a6::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from WIPC17090108.witekio.dom (2a01:e0a:4b9:9060:a10d:9ac4:ab20:2729) by PR0P264CA0250.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.26 via Frontend Transport; Fri, 12 Feb 2021 15:48:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4430ec44-0b4e-466c-47ad-08d8cf6d9ae0
X-MS-TrafficTypeDiagnostic: PR3P192MB0699:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3P192MB0699A76323F9B04054BA2431A88B9@PR3P192MB0699.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWDjR528rkaTsDMRXN2HrN/sjO4w89itWXJSmkIM5jIU701OeKID5faSNd3+LPj8B+t9dsZpEMM5sNSM5cUqT5a7OMrF61o7S5kpY3LYwn0tTMLq6U983IJQLxUQAS//4HzIx6tqKe/7Iw43pPxIs8OSjpfhkkif0qh2dw8whtGZN/FFGK1vKyGpaF23x7Uz5zkfZWypUXv6n7ZiK7gcPh53RxO64DfifU7smWw/KEID342wLVGLSv3Gj30eXNgaHR4XyUy+3xLudAfKKOw8hY29AFUKOaSGaSODOIlOF6sUncs1rRDxAWbrFKunvIwSqYjvSPaJQDmrhBkvZyBDRNA5PerELZKNUd1tn5oxXc/wOAyZwafhKp3StLUvf6Un+OWJGlmr6BzsDU/8URC8m62yjrUi/dW1lLTlLJCneETLnYCCHALF10NZpH8Ix7tMPR+vbQ5ZSCu9zLoto9I7/sbl3FUA58vEZaETtfTAC+wTv5z3z6nhKp14lZzOiOyHrHBGc7ukMV5h8jas1+G4uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB1104.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39840400004)(396003)(346002)(366004)(136003)(5660300002)(66476007)(6512007)(66946007)(316002)(66556008)(34206002)(8936002)(8676002)(6506007)(478600001)(52116002)(86362001)(6486002)(2906002)(54906003)(4744005)(2616005)(186003)(83380400001)(1076003)(4326008)(37006003)(16526019)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?q7kDmkf7jlntrMs40HmBF9FHIiOYLbSDhQXvaWkGJyc1q9TQ/PMKvB8m21ji?=
 =?us-ascii?Q?QSjuAu1KzIE2cRQ2GZxcBLa4axa0tTReYikinyTGdZa0F9n7AorlIYV8nqj6?=
 =?us-ascii?Q?nPQ7TKn6pHfVixYEzoPbMWr83ZYxsxjrlSuRsIIybCMkwziaHo1jnb3BqVa2?=
 =?us-ascii?Q?ujjDwGKX9ObxUKFN1RXfJAEbsrelafi3jrvW58LxiPlCuHh0vzLofkI95spl?=
 =?us-ascii?Q?1w5Rvbe8R77bKYsvcpjcJYkJDdpQeB32ByVaSJrV1Y9JytvsqqjGnuz/U7j8?=
 =?us-ascii?Q?CtTMpYBZe1a5pUTRd6i2JqxHrIzHDrOPTJPkNZhh/uUXzmAdvIUnMseixjkj?=
 =?us-ascii?Q?u2d81PfIQ4z93q6mTCPXJlnDHX2i/dTs6prnZGR4thZBh47hPwgwUqhW9h1q?=
 =?us-ascii?Q?jvk8BixrhLJRePlMlEmFwBgpQNv4lk1v0OOG96Q0wVYeW/QOc1dTlinoHF8q?=
 =?us-ascii?Q?AvQV1RrQuMNxlLQT10KUp4Mk2kUvMJqJUdiJR+bFjH3JJshOcJ9UHJSoPmYJ?=
 =?us-ascii?Q?90Dq39hqXUGQnZqFWRNLCeRWkHbMEAR9LQElrTvybVaL6v30G7dSCaeP3Su0?=
 =?us-ascii?Q?XEKoXFOTkt2ofGS3gYgNnNlRgGFnM8zYp69C8Qh8PqcPwlbLXgaL2BUWGEun?=
 =?us-ascii?Q?/YpSPV47P4wtwcW/l2gvgcV4dEzGCNJ9J3IJ+w+FbTV7LdX0zU9bALk0Uv7X?=
 =?us-ascii?Q?0iFfTu3kpxd/85Cj3NZmXrBn2f/nrLMe6VFxgIPoX2DMDJ5TrnuuA2TDMLlj?=
 =?us-ascii?Q?AxI+EF7p5MqMD2WGF6nLyJLKmgSJnQ/SI3bz067jyRSHLvT+9FmCbCj0vuEY?=
 =?us-ascii?Q?dX/WjkQL6vwYeJCd/SSZXr+Wlc7f6hfo47c7pPwsRk/A1ZGFnFWxliEn0Df3?=
 =?us-ascii?Q?SZ7CpypSGHGx9J3jrfWpHS5R+5D1h1FuvziaoYTBl3qG0zbSisguOF0zI6Q3?=
 =?us-ascii?Q?eMrR7dFnQ5u0UVEpneDi7cZSUt49BlwVeFWkjTiqc0qPqKmj9NE9OOggZJTC?=
 =?us-ascii?Q?3nklHzlzOEs8bbukunVXYK/YwzYTzQNXYtxD2cKe0G84m2IMkboK6uRVKL4y?=
 =?us-ascii?Q?5oab4o3TUlCN3Lg7sBql1n/Bklrfo68L77LL0o/usgq7lvLqVMxHno98wlBy?=
 =?us-ascii?Q?3DF4+JOfmBqcZC9NIgCXdHAbGq3p95U2/0Kdk/YzZZD+3CxdNfiojpPyefBX?=
 =?us-ascii?Q?swvv3qZOq86LVbUfkRk6k6uTjkM3tzdFvzQU/dbZeShbfQHwi9lUZ7IhkdSr?=
 =?us-ascii?Q?x60HgUcdW7A6RW6q/tPN7wLMUBwrG+oTVO8Z4CBnc1hOE+JW/ICBJCCUCuIy?=
 =?us-ascii?Q?1ryCceGF6VKHmIFwqoD1600Q+QdRwOs/IJ7QAHUQzmktGOR+Z7M0vkoqNxOi?=
 =?us-ascii?Q?KTcPjbomJmy58a+qtNflkBpbvGUQ?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4430ec44-0b4e-466c-47ad-08d8cf6d9ae0
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB1104.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 15:48:13.1671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyzyI+sI0y0nsMF0ASjHleRLXQJ6QGq0ysSnSt47KvlnLhdwLbP+qBibdOQ/N5/37w0w/084ujsF0+CzZkbtrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0699
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix array index: explicitly use the array length to access the last
element, instead of an incorrectly set iteration variable.

It seems this code was correct before following commit, were the
iteration counter is reused, leading to a value that may be out of
bound.
Fixes: dc92843159a7 ("mtd: spi-nor: fix erase_type array to indicate
current map conf")

Signed-off-by: Mathieu Dubois-Briand <mbriand@witekio.com>
---
 drivers/mtd/spi-nor/sfdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 6ee7719e5903..11cc5d19e286 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -881,7 +881,7 @@ spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
 		if (!(regions_erase_type & BIT(erase[i].idx)))
 			spi_nor_set_erase_type(&erase[i], 0, 0xFF);
 
-	spi_nor_region_mark_end(&region[i - 1]);
+	spi_nor_region_mark_end(&region[region_count - 1]);
 
 	return 0;
 }
-- 
2.25.1

