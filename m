Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840C2441245
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 04:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhKADG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 23:06:57 -0400
Received: from mail-eopbgr1320103.outbound.protection.outlook.com ([40.107.132.103]:10688
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230233AbhKADGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 23:06:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZRcVfkBFJBMKNOgQmiXZX1zFvtPiGdHGqdZTfoD4nmaYeGgJetx+p3V8z8MXiUvk9BnafJUGNqIZAGdXvvmmmnKgba5/TlRnDTLXiUjkiirStH2ANsgJHXBiGu98JAwR3GWS6qjF++nte2tinrLnKZqvw678S6FWVnkYByEV6bpKPJbX60QXiQUV92nbvrG5ZkNxKVAUkkQOPYloipsMGahrl7MDdcQg9mQ58PgWQ6XNjAntcAA6U5fH6J7vaXCbkHVVK/hG5tS679dqO2XvjTtUP6B6ZtXP8kd41MXk83OlmU0JGBu2pTLTjwUGsmBPWOB9c416y/CPps84wHBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEnHH/pcKTanG+0sje3tTvfI+OFoTBrNuphMlAzcZy8=;
 b=X7JXjlxDXoPI7BuY5i5+1wogpt9y/soYL3sLwQCiuAVDqinK2AYqoXTJsU/1e6teckjSJts2yDNZdD5c6sHl6Ec1BRUKD+RGP24/TJ+4J5u1DcpAsDLriN+YpoanHJNHdXuOlF3SSj0MIQ++WCIG72o/KspSRakYhWAfAo9C/tXVehv/n9eDKWREUyXva2CATLdYUM8Gjp6aq84ZJKP6Cs1IpnCOyoWiIkC65KUxrFdlHK88dsz57rj5Eu0zT4vTdzt8UcbC2+xB0/3bQmB+1ffJ0QLKI58XKcEtN8uaosDm29YCLTrBEgNf1L/E050uNmPUbTQ55PyFoi/Rctdvsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEnHH/pcKTanG+0sje3tTvfI+OFoTBrNuphMlAzcZy8=;
 b=NlQ2xKgYgc1n7lZFbHggcuR4HIDQof0iaWdAaMpL3kqrtmquePC93gSns8vE/jfK8o3jN9hbooh7VPPl6gcVh4EUIDXB+ezlSVrlGq+sOqPmrF10TDuoxKsjKSvaBAUl8ruHVkHp0zNH3xRj90de4duy9r56OatGOFeX69OUMiE=
Authentication-Results: HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TY2PR06MB3183.apcprd06.prod.outlook.com (2603:1096:404:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 03:04:20 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e%7]) with mapi id 15.20.4649.018; Mon, 1 Nov 2021
 03:04:20 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Yihao Han <hanyihao@vivo.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Sven Schnelle <svens@stackframe.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] parisc: using swap() instead of tmp
Date:   Sun, 31 Oct 2021 20:03:17 -0700
Message-Id: <20211101030322.23532-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:202:2::27) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR0401CA0017.apcprd04.prod.outlook.com (2603:1096:202:2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Mon, 1 Nov 2021 03:04:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 365f5bb2-2032-41a7-c28c-08d99ce44ce9
X-MS-TrafficTypeDiagnostic: TY2PR06MB3183:
X-Microsoft-Antispam-PRVS: <TY2PR06MB3183784A7EFABE8E3AA78BEFA28A9@TY2PR06MB3183.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6eCipW0bF3uF/HSRCeG2eJjT1lUg7/Sy86ek6wtqEaGRXL072SvrJ1LxYKICNcTrk4XULnR27hK6L4WCnjHch3lVQHqykP55w2UMgiMtgARzoFzSxW1+WfanwbQYB+2xWewt2qAn7lwTRic1cl1aBc6HXjHZTBx60bhLFMkDYjULg+ii7ovDeNovoQE+Dy2oi/6X9ufjXpSZfEzA/sT5SNbqEJKWOvCC7qZiL4P1OQADaZ7Z2VB1abBbxWwyZmVU8DrDHLoqSvj0qoMD398boHsJEG0MOBbHXa3n4BcoZnON51aDHaO8HQ4vBAX71tPLQNdhQGDNJciTwhl8FZSTszOSeQmLBnq08ammsYHfInVApU0nJXtAuEDlLuJYtU+y4zZcjnQzmgvODvfAmmkzCqLegmkGz7fLmlpQtFEO8XiSfYikgYeM4uCojGLbste4V2UxXp8sgBLZbQRB/k0eUiwi4hGNhbaYfZQP0INbrN27mGWDH28qGxKyYo7tyJNJks+drl8/8JBI76YZt3wdwL8Qwj0ta+vavcJVjnOLu6tuwnMthhR5WKPLKOvBw75pHWInaORDgHPxBxABZyo2Jt0A6H2g1oG+JMAyt7vD+umXEzpqDpsKkqfk7ioIU8pIKTbvITByK/ZA8fZ7e4ibrion90kBMZY7mxoOYOZ66LDqVk23IgburVCvRFCrzb4Z85ntJJuzO1/ocOLPazDC7JcyB0N0WvyGAzopS7xbz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(5660300002)(921005)(38100700002)(38350700002)(186003)(508600001)(6506007)(86362001)(66556008)(956004)(66476007)(66946007)(6512007)(2616005)(316002)(2906002)(8676002)(107886003)(8936002)(4744005)(83380400001)(6486002)(36756003)(110136005)(26005)(1076003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/zFN1AfUoi/q0Zyzyj0Q1WoNmuEPA7lP7eRihUmXZ8FpfOzLidMzgZ825tDw?=
 =?us-ascii?Q?cGcW6P2VM+hU1JJf8duakeJ6E9Wj2erpreO9zV1UanwBtxeAtq3mauETGXu5?=
 =?us-ascii?Q?1lxQ3+5ZhJpWd6IJNQ6bDf6eH/4ftag8q3E9adgOpqYYQWrl4tQBwzpMBp0f?=
 =?us-ascii?Q?HCZaGGvIutHyc6zd3i+S3Ch6YvfRLiU2eYVydoyw1BdTEDvEcKZEhW9O81XL?=
 =?us-ascii?Q?TjZXsVxpHufsdUl+VV8wU4ZET0T6nyVJhe9/H+1HfVhUd0/uoIOXrVrhNBxz?=
 =?us-ascii?Q?5FvH2bU1SP8NVkb/1O19BUByprzCXg0MozqYnFUFKkOL8DewyDGCLKNZTOGN?=
 =?us-ascii?Q?qgHvEnrNHajXruGsOFGnb/VUlmB+cQzhr3mspsGoHQrPzk74GWdrREDb7E1Z?=
 =?us-ascii?Q?HyYTSnIzeZYbpWzpQiUPQI5jUZgER+CI8PzLYJQAsUC7+e+AxXAjr0khu6pV?=
 =?us-ascii?Q?U7I/M8gv9J9hq0sgRDuQVEOao3WWkZGY0jGyUaII7mKduACj7Wzd18l3pwIW?=
 =?us-ascii?Q?dWsYSy206yi7AjJBKJruMkHK9rpc4Cj3i1b7v+7we9hFigCQUnF8cNbfSqvK?=
 =?us-ascii?Q?D5aPvMg33JlOMshkUVIoKbNGdnCFHtCx2Jb9PHGhO/swTqduC8wWkUUk0eao?=
 =?us-ascii?Q?3urtgThkqZRWbqD2B3nD3bzWiNpxN/dCFZUyNXUHb+8uajhRf9EP7HBbFapA?=
 =?us-ascii?Q?dXUoN0JbTpZQA7Jxrl+pQ7mMmmGN3OgXQveL+Ahac7Zp+szj45JYysp612uK?=
 =?us-ascii?Q?Fy7raxlMz5bSqc9f+wccUxRBeov+a7gKIH8bLJJgZYZgqKxUc6SVnEnm4RqV?=
 =?us-ascii?Q?LunLQ9KD8KoD2mcXVOG9ndIcmvWPgIR/sjMyjaKzQmzTsRPYUw0sP6I5l92D?=
 =?us-ascii?Q?GewEG+xtS4uRkM6sfiOvRjtBvt8WgBsVZ+AksezQGKkgvPyqS/8pyIP9Jydo?=
 =?us-ascii?Q?fFCIswVpyUem73rpxHQeAXzO2GfCyFKp/yoDE/Y0CkKR7v+IY3T0p1vvmg4r?=
 =?us-ascii?Q?MoVoUeZpTlfwjN3Z9wJ4CtwPAuGeEuPU+G3XE0qvyTe2UFEiHNFyjDHUHx1/?=
 =?us-ascii?Q?VgarYd2Cu2JER7kRpN5MzmLgTiQmQR60L+wl6xRXfoazmgi6IK7YDyqDAU9l?=
 =?us-ascii?Q?INufb83sf60UQ0tevV1GC4m5kvf0Hn0zYKa+MaxDsM0ze8mYOsYX/wKi9vEv?=
 =?us-ascii?Q?QB8f8dIu9EenUPununDvtteceqcWPdwff1YYC8DvEHD1KLHVaYvK7kue3RMS?=
 =?us-ascii?Q?4HmaCcbWhOcOiVDRBvKS0zGnhZUP6wfd6m7m7A0ghNvDaDH1fJAB25YYhuDw?=
 =?us-ascii?Q?HeO++T0bIpu6G6a9NFzngVBkbb9tdt2DAeHh42jmP3iix96pitpvblKJ7cjg?=
 =?us-ascii?Q?u+z11VspxdfGMkTfNr61eKJyStrJcE/VO75EDM7VUrZsx6PaS/9YDTKmMyc/?=
 =?us-ascii?Q?3S2G1Gbv83HA5Zwqct+A+c76X5ayu9GBHae8Eq3ypawLQW47fREMbzphOm3F?=
 =?us-ascii?Q?HGTqJP/OlH1oYyBBGzbPkJh2K5LUxt/U83Q1yBkzC2sItwX15uS7HdCBYwd0?=
 =?us-ascii?Q?OhMKX/IfCWb+AD5CTJ7x3oqYDtyfYrezsV4SWPhST3KpvTI0zWR1V1Bk4FWl?=
 =?us-ascii?Q?VcT4Lw7ThdKAiqeWFTWn1nQ=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365f5bb2-2032-41a7-c28c-08d99ce44ce9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 03:04:20.7934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vz2003Wt+q0Og1gVJnkid3v4nIrf04LVtgN4Jejnd8EME4Jdlc0xyGEG6DVtv5tRWZdSDYGzrxHTuvD2NNiAYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3183
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap() was used instead of the tmp variable to swap values

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 arch/parisc/mm/init.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 65f50f072a87..1ae31db9988f 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -127,16 +127,12 @@ static void __init setup_bootmem(void)
 		int j;
 
 		for (j = i; j > 0; j--) {
-			physmem_range_t tmp;
-
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

