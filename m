Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F62F3A42D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhFKNPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:15:00 -0400
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:51473
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231777AbhFKNO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:14:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bv7XBeg/1Ynk6H8KoyuWAmiltFauCA2vGWBdql10kfhbcTrQQJrfYNSOPrj5ydjOslcLqd1+8//kF1eJotuWSJ/1sGshGuT6S49IrXfXe1qY64E6rHWsZ5AVcRGQg3B8WVpjMnczqLoDzyLbD1gTOqfwv/tG6HiLrzPyD6MKJQcI2h2B3ECWSbu+ElNMnMFBwcyQbQoGKj4BkKU9iyuoIDxZCLoGt/P6xuyhdGwokNqq9KMhKBJax2YefjCKIpumx7BI9l8OesX1ywFSxlomrBU1xiW5X582vlbHDGgHXKme6avIvithDwLwUxT5nFPKUfGfXYEJAeiz2KgLLVrnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMpfsIPY2/S7DikLvKZr/U2M6vzvgaE0blbiK6orvdk=;
 b=gTpPuhd2DE9707nqcKPFqP/x4BVgnVzrYlQmfO/a1aYqJA4BuhgBlSe2AEpKA8sRBJiKhrZWhR+NtyIEguWycdvj46m2GRea9nsBOOhBO+bJyyMLenVZVRnLBehyizTfmK3KrBrluaDVgTlKj4U0ndHjAMi9eCfVDVyzWZBUuS+/3d/JI0NpJQBoox3RpNpV0eCuQeLo8r3nC/zOAcp+Na1rZcOVG4bjkIvtYEvOOEOh0+JXuI7NfykycfI6XQsRahlhWmig23Izou6m49ZDIn/DqPpNX4GE7ZS9TP1ytyZty/go6pyrFFIDQB0IpiEAoIHuk6xw14ftsHSTCL1I7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMpfsIPY2/S7DikLvKZr/U2M6vzvgaE0blbiK6orvdk=;
 b=PIQq3AU3led6g1Eh1uYqfsAOwSBhlP4DWHIv26EEm5JmfMW51tWwSe+/GisZl+LfFudvTVg42FRMxancaNQz6C0Knj1kLilt04kO54cqY2MZqhytFIpgHWHcBuL3gMSPrvR5FYk/6DdopLIUMvrtQzrvYtinor5m0+EUq9Xc7qw=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8710.eurprd04.prod.outlook.com (2603:10a6:10:2dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 13:12:58 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2%7]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 13:12:58 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/2] of: of_reserved_mem: mark nomap memory instead of removing
Date:   Fri, 11 Jun 2021 21:11:53 +0800
Message-Id: <20210611131153.3731147-2-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210611131153.3731147-1-aisheng.dong@nxp.com>
References: <20210611131153.3731147-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 13:12:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: febd4de1-6ed7-457b-776c-08d92cdaa20a
X-MS-TrafficTypeDiagnostic: DU2PR04MB8710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8710A816F50C09CBE6A3F7B380349@DU2PR04MB8710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tMALSzJPY7CFzcNs6e8GL1SGJt/r2amjvms9Lm8S+SiO9nEu0MSSNctrKQEft/2RT1DVebhdBEJKFhz/EPFFhPV5hfyXU1KUACxVi/nf95hrLo3T08qrxYV9u9iL15ZzUoKixoa6WV9HTDvkOSR1/oNZz8gAn6V3+4eIkGH9Q2qD0ii3f/eIMxmKapYG3enC+XNH1miwv6PK0zrXtbb2WOYXcD8jaSw9vSMHr6eb6rWDNDCt8FzkHd64PbhHleegyI5hH2EDNDTGxinfY0nCaLsyZ/xD9Kl6Tc6vVyx0GHTt6327od2b+AKUfA6kjt/YrTJcm2k4cBhphOCnDWWeKE2vAdhUHvdfzKxIqScSfv5XTCVBt2GDO5ZBMTEji0J9zOFCtAjIQtINe2NcvM1JRI3d/P7QObWI7Crp8tGbrkMxm4A5OCFN68URIclLgjNiyENxrAMtol2WW7/5RJV2Umih2N9+lFGxlCGOnuwKtCLpTWhI/Ak0pdLD38hFd+4yRY7QlINM3Aru9G+0IrdU/SgtpMMwFOdfU4INXFpH/PZWiE3kx1Uyf3uib0VDxsUYALQLTzq/43X1RGweJLN+cmweA6Jumfs55zAtqJ1YE9H4BR7dyJ9X725JKGtp+4eYdZxGhiVYIrwG99PC39RZ+zdJ2fdVKHgZrs3UBE70+qTqfG+K0VkvbCtoI7nCzQ5V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(6506007)(52116002)(478600001)(186003)(26005)(36756003)(66946007)(66476007)(16526019)(66556008)(6512007)(1076003)(5660300002)(4326008)(956004)(54906003)(2616005)(8936002)(6666004)(2906002)(83380400001)(6486002)(316002)(38100700002)(6916009)(86362001)(8676002)(38350700002)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iB9nQjq66CSGOoX44UPyjtjYIph086vasE8IE+YniOCHh9Bgu5gCeAfr5dGm?=
 =?us-ascii?Q?mxELYnnOyrPn5CMchTxWs79/DwjnPQYt/oQ7r9IYRYXr5KmYTUiZWx6YaYaS?=
 =?us-ascii?Q?5wFm3sR8xrIz1qVraPod/7ZFBYE+kr4Vv/dfKAY6J/Za5O6E+PfYMtPbT2xX?=
 =?us-ascii?Q?HOu/3kHxlkaQUaPL3bG2AcH7uCCq25ypT4FNYGs9ZSB++3VK6JNKsjpY9m42?=
 =?us-ascii?Q?A7u/C5j3DzsZeHsHLpHt89fJLzmUwEC69yjf3Ya1Yh9/PVdBIz3vu1Fx5trk?=
 =?us-ascii?Q?tbakR3R/GhIMMTTPZ/fvVykBgPZIZ30ql+bQjiyE5BN8dKK8p0aQEt9U4C5y?=
 =?us-ascii?Q?3FkUew5zDwU31H/QDXdkcRbj+E6889g4tKrTfCel1k9wljB7PuJdQ48y/4Zk?=
 =?us-ascii?Q?mer979Yd4RaJIojxJg3CYNotK+28JY4VoYeFP1jth6qZ61zPWZ+vC8ZX+Efc?=
 =?us-ascii?Q?XEzXns5k99WlFo+uDSXKnZ14dwRQGM6Bd9eUpJStrSvf/AoQ9coZJ2sEu8A8?=
 =?us-ascii?Q?n/DcCdRBt5G4/sgzk2Utma41+ymwjWfD5h1p7E1MoMmQjsaZn8OAWSo2g+jt?=
 =?us-ascii?Q?iWn9pvITw9o/PYMmDOaGuhNNlPWCXKMAOGYR17k0XHHS9mRqlnXdSV9BEVLq?=
 =?us-ascii?Q?fCgj3q5klfxsgcjesn9arc84XzvHZ3q95wLPhDL/PAhJbg9jkYp2h3UbjwRB?=
 =?us-ascii?Q?1U3GbIuwbr7jV6MesZeQvteSi8hcPviDx9qfxnJu5bpqx92LTN7xLK5shcoP?=
 =?us-ascii?Q?AXXr9yRSgrw5bwOBFX0qkYFEQGhytTebaE/gF4gEd7l//tipCEE8cpKZcXGI?=
 =?us-ascii?Q?XWTpv3LFsdr3ZLhlE6Q3/91CqPQp3Jh0/pqAz1P3q0pRwGn7Hz7Su/lQqExD?=
 =?us-ascii?Q?DsPwIAkE2q94dkFYwbWWkwOSSqzzdXkTPcqn+z3zUwjgazJWRz1wNNjtkAPu?=
 =?us-ascii?Q?5mgDVmeNTGi4O+NDUZSRhUF5LG2nVrYRJEn9lr5WE+dvkk00xdd3revvfAsC?=
 =?us-ascii?Q?+XAbZvPxbE3aP/DbY4j7ZtERKtob5VXdczKPuVvNkQOpExBtA0EsomDE8MeG?=
 =?us-ascii?Q?hMpcyAv8dQnzJLW1EzwwEwOZJp/VatbwZ47NkLXUF/XLzUqUZuSvQZsfkabh?=
 =?us-ascii?Q?52zOU613YPUfFt0yJm9v5umrcYUJAq3O9jkwkwg3Z3lqC7IquNlk/1ED/Xjl?=
 =?us-ascii?Q?GqXmdpKqh0/rjKQqzGEJIB6IIETsIo2WYPs2AHBuwp20FzpC/ek1plWeIaun?=
 =?us-ascii?Q?+lRF8UuAhjdrxkVZrsMWwK/TunqmL4sKwTE4dOgO3eItA5QfPd2AGDKBx4DR?=
 =?us-ascii?Q?8AIjNRr7iEOUCJUkRcsCdgdb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febd4de1-6ed7-457b-776c-08d92cdaa20a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 13:12:58.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZgWb7KmxWVGK+cAtxQwysuQm7xxWd5sTTQMDYyV2HUXQKXfXRVS6gDXWDAavrkAbwRbCNfN4qRAnNBLYB/+HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8710
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 86588296acbf ("fdt: Properly handle "no-map" field in the memory region"),
nomap memory is changed to call memblock_mark_nomap() instead of
memblock_remove(). But it only changed the reserved memory with fixed
addr and size case in early_init_dt_reserve_memory_arch(), not
including the dynamical allocation by size case in
early_init_dt_alloc_reserved_memory_arch().

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/of/of_reserved_mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 367f298a83b2..ebba88395bf8 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -42,7 +42,7 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 
 	*res_base = base;
 	if (nomap)
-		return memblock_remove(base, size);
+		return memblock_mark_nomap(base, size);
 
 	return memblock_reserve(base, size);
 }
@@ -276,7 +276,7 @@ void __init fdt_init_reserved_mem(void)
 				pr_info("node %s compatible matching fail\n",
 					rmem->name);
 				if (nomap)
-					memblock_add(rmem->base, rmem->size);
+					memblock_clear_nomap(rmem->base, rmem->size);
 				else
 					memblock_free(rmem->base, rmem->size);
 			}
-- 
2.25.1

