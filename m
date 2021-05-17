Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D40382ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbhEQLXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:23:20 -0400
Received: from mail-am6eur05on2047.outbound.protection.outlook.com ([40.107.22.47]:30560
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236739AbhEQLXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:23:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS1UT9jUWKq9re1CmR/MbqronzDJkniTCcjJZ30F+dh7G3DjdUwDVZkAKG8kpp/kYh2AbtZe8oBJuaOWPDrEA31Oc2xojsTamRIuqiAQLpvFjneWuNMEGXsFFavY3mSqeoGc5c6Mv66Ydg9P/wsTr9pSAWq9iNVkaXTTB4F5rkBNUoL0/Ps3MpV6vbrHTkbdWwtmN4tINbfvMdifVHU/sH1ENOy1gaDqlPNyMweJq/yXqDFO0YKtLYG4HlQZTFIZqBLh6OqPRlm37Efyro/1CVCZyXDZEUlxuTnc3sQzGd8etEHnl4dUvIXLjIx1o3Lob3i63dGEwS2pGXTM6BfRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgKm3n2FMXJ0wWUVkRm96IhBO2Hn8MPzkr3GFvuD29g=;
 b=LkEZPAliqIfl9BIeWw6vvYjPZ/Kh0RPyWpkbJL/Fo9CtR637G9WWACTHpglA2J+ZGHgrwkYSjrotlrwN1VLyJidH+39ULzFO/Y754yocMmCuA0AODEr2yuzzLHhyz51oDf4GQ4qvei7Pg+X6/rkY1IW/FO5ZbYdWHZKHrUocfemC3YFkKwXoFSrpNn/saTzYJX3x1q+Z1RksEMs7mU8Ep7UUfE2v41F7CDEnwm8QS0XWCiHa7lJ6/1V1TPo5zuKn5NmRjOaLFCxlXUTE7I+4vSe5jXm4S2HGJSwo26TWWoDXTpmG/c6m7q5GdY9dYffobNn0/kCGCEQv0JGxHi9ptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgKm3n2FMXJ0wWUVkRm96IhBO2Hn8MPzkr3GFvuD29g=;
 b=HOTt+OOly6QPDSlPJyo5mpVUCu2W3WQS2UCPQm8UtxMflkGUt6Nu1TFpMDQJUpG6IhdEt+0RSEqPM+dR0uq6Jfo2cArDpHTLpPdqgRQfv3Bym/xAigD6XE2DJVlEPzvxh701EYWRoKtX4e98KmIz+05WUnfQa97dA+ySmmyAqWE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6519.eurprd04.prod.outlook.com (2603:10a6:20b:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 11:21:57 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 11:21:56 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/5] mm/page_alloc: improve memmap_pages and dma_reserve dbg msg
Date:   Mon, 17 May 2021 19:20:44 +0800
Message-Id: <20210517112044.233138-6-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517112044.233138-1-aisheng.dong@nxp.com>
References: <20210517112044.233138-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0132.apcprd01.prod.exchangelabs.com (2603:1096:4:40::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 11:21:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6d8e86e-126a-4f1d-20e6-08d91925fb10
X-MS-TrafficTypeDiagnostic: AM6PR04MB6519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB65195BE1870CDFE8300756F8802D9@AM6PR04MB6519.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:183;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKG5u/JBoHqQWUofJwuFavrAWkKHQWU6nffP2HLVLxI1LCfo46Pw5tXSyr1WquEF2jzjkUp5nOj28eq6v5JGTYF4b+/qfmZEKkTTzOShTHZJi9H1PEfPeV024vvIZkfeJeQOSP5Swbl44aKxoWHvaADGK/sgJsrnR+n+2jLHTZL06m4JKyaNtxwc/K1DN0OzFRV9JXGEhxpWkVdn7ETrIfN8DwOLR9tVuc1NXhDhu5a17nKTcqiVqgQn/BEJHlnlcAvQOGgDyOKAT7iUe/pB1h4nwL7tW0+EypwW5cll9ikisHBmTl/ZlEgorLTE8Kyj2RwBAIbuUxeWIf+nI3ssENoVEvCjhi3Ml+V3aZ1fNUfWjY7n4iFQkcNentvqfkeEQbr2nfArMlV9EqCbIz1Vsypj4bUpQ2otOw2kS/t+HE2lmzn8TGLXRE4/kKmPt+pyEBfQe29Il5t0uocg7ae8jLkAibq8yDh7N8i/+SjhFOLi9Hkt0ysPprY/UNjgWFGzy9rpukGqakypBUxJmeXnVZwYPU05wEwpi9gXMQO/lQZe6CfrxUmLrmajGUr+PFOdqgYy93O63Qq8f6eQWZAcor/jNGLMlVxJLXVrqhsU0o75Rfaa1ApDZDkjNRoys9HgGppPiUyJGJNVbDuDUD2JoxpOiNE4KIrcTAS+1u1HOy6u+1KazcxZ9KzB5F2H6+u8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(6916009)(5660300002)(6666004)(316002)(66556008)(186003)(16526019)(2906002)(956004)(36756003)(66476007)(26005)(66946007)(38100700002)(38350700002)(6506007)(83380400001)(86362001)(52116002)(4326008)(478600001)(54906003)(6512007)(1076003)(8936002)(2616005)(4744005)(8676002)(6486002)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?r63b0vMd8nxY3G3lA0Zc9gK2AX7YICqpEiSZd51swituFXLIbEdeSSAXk/cH?=
 =?us-ascii?Q?HtU2DHJqaY/ilppY0tBh2nL1hqXLIrnHVQfdTY6o8zS8IGd5+CfQqA8bGmJe?=
 =?us-ascii?Q?gAPv4FxRE5nav9K0lM9e1pSA7S0SfwSLaALe3iqmz4fIgYFocV8P9uTi3Mmt?=
 =?us-ascii?Q?fyBC2ylwXWOmCnY6QrS8NLiv1R8G94qaxYonVICzO0xSDGquL+QGMQC+mxpx?=
 =?us-ascii?Q?LL6j0ETmWVbp0OfAgS2sL1uKwhttIAoVgYIaOJSOag3dj++D3/F2qzCDTTHA?=
 =?us-ascii?Q?zTg1KQAoNucWER34ObURZbR7+2mhLY7CLJn3RkOK8PZPNTJHribZdqFN3MXc?=
 =?us-ascii?Q?XEdRLWyylvABpdUOGSZWQvkUVU0DyMhu2Tv8JK5/ZbXBfS5KP0bdhnNohXG6?=
 =?us-ascii?Q?05Fqtul52J8/Kb4k/6ukEGiVMfByU9nBlZXlVkEEi6/94FIHiepbvuOU2JpY?=
 =?us-ascii?Q?1o2Z3hsO+SyQTBgOWINQMGacdpmy1HtKCXRiDYWRdOm4TY/+CnZJsZtJxWft?=
 =?us-ascii?Q?a8T+TyWBd0fHh1X4NXCspoGxvCUl8DpiVsEVeEG1hfiYiqzHt/Zh4Kshgh1w?=
 =?us-ascii?Q?dlOKIAjl/YVFyU7q8qGY9jzbLvxB169LBfiuqRne8PYYc2JjDuzHY8iHcVJ0?=
 =?us-ascii?Q?dFUXhGfUiflGD1JLj/7fApGQHy1TLA9GB6jtM8h3r5zPJ6uOGwBDG1IsdOoZ?=
 =?us-ascii?Q?jMDNs26NkfW+VGWChQy3zff/j4lEKyDtzJBBSxXiH5K657q9nInUIHFol4ie?=
 =?us-ascii?Q?MMlbpeOKcXqaBV6yqydOcNymn+zQYzgwMPVdB9P/FlhK9iixe/RdQA9wEld7?=
 =?us-ascii?Q?zX7PNV1yAM/kdJP9mHdwYHHUv1vr22NfvBAw5sz6hxkSroVDyTZLjwp8NkpE?=
 =?us-ascii?Q?FK+WSwp/VX7hRsBdpQUhFyu+DBUNuuqcW+Zl0iof9m5cYmXV0es7c/xw6wXX?=
 =?us-ascii?Q?8Vr1ApHt0EgPn5rJzvuSXa+ZKeZbLdecJfJtrEPR/aFE5TwQwWbQgfN4uRHv?=
 =?us-ascii?Q?BkMntqO9BBWHR+gGDveAUY0l8y+2J0OBWGaLb0iCHFx2OsF1/XaDoJzTe/Yr?=
 =?us-ascii?Q?jjsYHYFAHQvL+AxeblyydZzUy16u1DkKqd0//CBjLuybld/ag1GjyLMNxnm2?=
 =?us-ascii?Q?9Mx8bu4f6lXuRQqMN1y932b9Paz4V5pKXn5heMTVz2CKTJtRgjhjM2PnfTMB?=
 =?us-ascii?Q?oErVY6BbcxLP1stnrc/1GK7XiiUgaVPgaxx0ew3cRdZRnXgKabIc3qBslWuL?=
 =?us-ascii?Q?B37jATLUoMhNhK+DLSnFBDPayr2BCgeffxxJIf+9fjzecLwDyDdtFvsZYQaP?=
 =?us-ascii?Q?QgNhFNnhvFmfJD1gAxtJltXd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d8e86e-126a-4f1d-20e6-08d91925fb10
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 11:21:56.9126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0ynK7/8hxe3kei+jDedtAw1CJrFLfTIX99rc2ZGC9/J7kVs70Rsszotf+IxhBSZA0kpfM8GUbzuOEKEeYWHsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6519
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make debug message more accurately.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 mm/page_alloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3100fcb08500..16f494352f58 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7263,14 +7263,15 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 					pr_debug("  %s zone: %lu pages used for memmap\n",
 						 zone_names[j], memmap_pages);
 			} else
-				pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
+				pr_warn("  %s zone: %lu memmap pages exceeds freesize %lu\n",
 					zone_names[j], memmap_pages, freesize);
 		}
 
 		/* Account for reserved pages */
 		if (j == 0 && freesize > dma_reserve) {
 			freesize -= dma_reserve;
-			pr_debug("  %s zone: %lu pages reserved\n", zone_names[0], dma_reserve);
+			pr_debug("  %s zone: %lu pages reserved for dma\n",
+				 zone_names[0], dma_reserve);
 		}
 
 		if (!is_highmem_idx(j))
-- 
2.25.1

