Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60E8452B22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhKPGov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:44:51 -0500
Received: from mail-psaapc01on2091.outbound.protection.outlook.com ([40.107.255.91]:63488
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231759AbhKPGoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:44:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9v7hcqdIKN9ZvUysK4ISnez62ksVmYntePrdU7DvlSY3DFPxERBxQvB7SjEt8+5J8bYN7zKtHEjjkH6mmSaQ0LbCerI6Q27OQ6g7AHySLZtrl460m8zK+a1X1MhU6DTPGMxCr/AdMEIqFz+K2K31+J8naP0hTNhmlxE4+Ghj9etoz6jaVxH4AQZ9WcFWG0befTPaH9TldZHsEmIxasP7AMLFbq6XZH3CXZJzpsAP9L2kt4isjyeK2q/iQFQXQlSysaIorr5q+tibsuG6IR+Yi+lGmDnCik5VqV1tNhNoWSvV9M2p9eS+2NU8usNFfbBUYamJQGOTD2QXikEMt3V3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4rex29SYtDNyhH08CwsoaIQgoQIHUNk3dHEnGMpwoc=;
 b=CP588UBfGcveY2mJ4KaQdGcrxRmKeEBh2HINJNuQS9mC4mj6jCV9rMKEAVHB92mFrR/xjeiZb2ynzKhIsVtLHkR3DevfJn4k7U8Ah5su/dAV9pRshYkrYSICKUwZ5byfn0zmHZvp20uJ9N1jHRShD4m25vR+5mEjj+hPaITLWkIG7q2gJjmffh1lEPgDTDudaMca+4bngXEGNbVROCntktySAGzW0Poqf6F6W5duqJlxHScKR6F/5M96lxOmrdgS4hus2usDxcl6COhlKQQFL4IrJyD1bM34Pm0yKd+3LfPWdvWzyapeBtUSWZOaMbptLlS8Tu+l0tjkfnt34TgWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4rex29SYtDNyhH08CwsoaIQgoQIHUNk3dHEnGMpwoc=;
 b=d97PuUgtSaDXxIPP7t+mMrUZrUOugoo6pBoqmTkmKxG3QzuvUOBB2esaE8/HF9BF5T4nOQvGf7AIxsb0h0gGD7k396wkEN6XIWzxGQnfgtq3znbwGqmYuzeL9euVnGompbxQV9JCdcMuerKMKLqXUiiPxFrEaLnY66jhHhLNAMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB2100.apcprd06.prod.outlook.com (2603:1096:203:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 16 Nov
 2021 06:41:39 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 06:41:39 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     kernel@vivo.com
Subject: [PATCH] staging: r8188eu: fix array_size.cocci warning
Date:   Tue, 16 Nov 2021 14:41:06 +0800
Message-Id: <20211116064124.8833-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0014.apcprd03.prod.outlook.com
 (2603:1096:202::24) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HK2PR0302CA0014.apcprd03.prod.outlook.com (2603:1096:202::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.16 via Frontend Transport; Tue, 16 Nov 2021 06:41:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aafc597d-baea-4a77-9a91-08d9a8cc247d
X-MS-TrafficTypeDiagnostic: HK0PR06MB2100:
X-Microsoft-Antispam-PRVS: <HK0PR06MB210088A088EF4CF73A6562D6C7999@HK0PR06MB2100.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/U6gSPzgVw+4sfbKWebz3LNM8EyCQkj250XIGsXhjejjqdXDhlBHoQWXb7X2tQeyY6nZl/S8uwYDSGukvlDDO2mg2uZlj4tM2oWYfcRCPCFHx37yqxoLxJWRj01L0A2ycKMhqGKuA9ASFnZIRvwVyhnYcKnSy9LsHGUNqVfjGf4DvhvOwxfltQTa++XbqylhlMZ+ZKGdHQWQUdeXN+IQ7wvPJ84n8hsxJiNLsmFEcJkfZe5PCpTAWZTKbPdkfkht4JIlElYFYpNHQpv2xOQtPIF/Wj9hD08dPsm60kyJ+jPLltwTcZkS4yMA8v3TwC3K7b9Ylt5B/jF+yCIp86gv99ZJIvQKfYCMJnkkdXvb5gvcaGDyQt3+jn5e7xYKAqI8fCvSacCkVu146fPcyfWtUQt3KYBVbu2yl6pK/TeIcrIjlHKx+SpjOh/S70Kud9GmLkal3AtldNW4Cy8UMyMOO7hNB6bSV+AyqyQ6OVkcpv8yQT/Xyj3eL4kJEFxJjhe64ZuaczFGcNTlEqUDcTkj8vaDJyNQP1MRymemjIV+QQpSNPtAavQJ6rQ8e8Cm9AZNyH0BDUIoi826OE+M+aFedYu7/FJHk5uUyMZ+opkwEeW3Rv83+b3Ix+ZPhc83n52RuAtkE93UjC05Sf68YzZ+YVCvuQR62M8TO0FiX1TSq6fIKOiWux6SH71qjLoy9ujYFp+dZCjm9vKXxqOv0L5Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(83380400001)(66476007)(26005)(186003)(66946007)(38100700002)(508600001)(316002)(66556008)(38350700002)(8676002)(6486002)(5660300002)(1076003)(4326008)(6666004)(110136005)(86362001)(6506007)(52116002)(107886003)(36756003)(4744005)(2616005)(2906002)(6512007)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0SjT4vZrVDluX6zlSIIvjkpbTIPcQexsPJsKq8i+U0l32M3JCpLneBtfkWXc?=
 =?us-ascii?Q?rI0mZw1ohj2elK84d9yO0PJfrw5jGOXNdiuAMDbnkFTUi2IcEhD9Z8PbWi+i?=
 =?us-ascii?Q?yW39Zs4IAWGNeLBZPZaWQz3nrJ2v9g/PMLffc+OXFYfr3pcuZUF8iVlSYyJj?=
 =?us-ascii?Q?2+ebL0liXnxhp0KJGqN9JvHOU8OukHjDrRiZE2jdESaCIYVzZhAKwyKoaVpc?=
 =?us-ascii?Q?81AOqBiO5Yc8BgJUgOY2qDFjAT15/v02sjTtrfnN/R4FmljCU3PI0t/yUU+a?=
 =?us-ascii?Q?F0zc/xsUMW9SxeC8jQXjNqWmTtCkEPwf4Pr3iYgHiJZL+IfB1YAmfM0SuqBh?=
 =?us-ascii?Q?asHWQwgclHqFWkggD35w7uu0q4+q7jZw/dgFF7P8RrhcfX2P1p93WHZss9RO?=
 =?us-ascii?Q?MpqzPFIZdADUdXJCeMjqPWGkec1x6YCVaoIpJxT8jEvKgBgwN41suM9VnB9j?=
 =?us-ascii?Q?IkBgLleOdkI8LOobiKuu+yARS/PpYo2Q0/IGiNRAe4YKgHblwdDkJ4Rlh20A?=
 =?us-ascii?Q?sK06OjG9r/v/7P0dXbkGYxXU05czxj07XMWTFoqd0+8QMm7uqfliwoaHlXCe?=
 =?us-ascii?Q?BK6umM9FPcR6RJX+ZqMzedIiWt9vYpIH+kJsrON+qJItoP6Re65xrV/7ybj1?=
 =?us-ascii?Q?iVS5pT4nHY/byGV718Mx8qXa9wSL8buhXMcEp1GhqD7JOY7kg1/79/EqBU9J?=
 =?us-ascii?Q?9i6080IVmBopCyywLByldVts+7Z0Uv/NYuwF7hETcb4bYzZGNHd8amikCyV5?=
 =?us-ascii?Q?6C1mLuHiJNoHj0tiLyFu3taksNTeaWKEuFS+1MaevZuLMTA+J5r8QrhwuE/g?=
 =?us-ascii?Q?44qxoRoG2YpjsDb4mJ3yNgDBi7TMZjrhBVkLNG0ujO3E7dxuI1jbWtUU0/jc?=
 =?us-ascii?Q?PVAg6kuuaLFRx7jjI6as2ShjXJXVg/8+5qw/Rva6Q+bg5KnMOVbQRiuyEvax?=
 =?us-ascii?Q?yuCpcCw2EUzipQ3ID4/sRvldKi6unXz9tQQY7p2LPNuVG3iZCgVMNi5kRHkh?=
 =?us-ascii?Q?cxvCqrmcXOKnAdRSMu3NJ5082O0vOu4BDiFzV80iX863CIM4ddd7PTuWpAf2?=
 =?us-ascii?Q?ENY0tEHAxZsy2F57+j4k+q0+MEIbp4t2BSoXC94XEhM1yZsY84zwioska/7R?=
 =?us-ascii?Q?1hMWddwAy+doMuRQLpO0TY4NS5o/Iyhktn/Mpl9NE4tpkNEW7CyXNHtM/XvX?=
 =?us-ascii?Q?Uebcuq6fL1jX5mPAbD3cSOMqSIpkNcN5BDDksBUSRa/lVHzsrtn1yOi+DSwv?=
 =?us-ascii?Q?TzfM6lAVxjfYqFfkLS62qKpazpUzrb+hobkPjX9lZpMX6+VjjIg6dkQJxzUq?=
 =?us-ascii?Q?+g4D4pT7cUUczpkCHlLHzP4cJHlz4tBNBqMw07gFGLE3RfWl4H9Sv2k/ZS0T?=
 =?us-ascii?Q?xQ2No83pHlz9zE4hl0WQfgtYT80r89IQMNu1x7GHAXKGczEA4DJN+P4ipwhK?=
 =?us-ascii?Q?o394F2KJTVdLZiDyfc6PWITMTfYsrAzA2BxLl6NKdYewW+vMDwAZZjqnX6TV?=
 =?us-ascii?Q?XReecvFJf/gT6WZyiCejtuGtkwtZ4t4BpNYv0KcvDraQbsm4j6En0HkzJTdh?=
 =?us-ascii?Q?3EGGHj7W1bBve4rODbLRVGFlpThhoCXrcELmfbnj4SDJhsZ596V1cG2THHMo?=
 =?us-ascii?Q?IODcL9IMLTxxpSO6kSkGh2k=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafc597d-baea-4a77-9a91-08d9a8cc247d
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 06:41:39.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JA4jSWyCXv5Jx3mMkA2Av/6nFKwLYvPi5UZEnkO9n9SCTLyW2XaF7RARVVu+qubyTUGD7lVg6sT6oQebdhS6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following array_size.cocci warning:
./drivers/staging/r8188eu/core/rtw_rf.c:38:48-49: WARNING: Use ARRAY_SIZE.

ARRAY_SIZE() defined in <linux/kernel.h> is safer because it uses
__must_be_array().

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/staging/r8188eu/core/rtw_rf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_rf.c b/drivers/staging/r8188eu/core/rtw_rf.c
index 2ec56012516e..e704092d31d0 100644
--- a/drivers/staging/r8188eu/core/rtw_rf.c
+++ b/drivers/staging/r8188eu/core/rtw_rf.c
@@ -35,7 +35,7 @@ static struct ch_freq ch_freq_map[] = {
 	{216, 5080},/* Japan, means J16 */
 };
 
-static int ch_freq_map_num = (sizeof(ch_freq_map) / sizeof(struct ch_freq));
+static int ch_freq_map_num = ARRAY_SIZE(ch_freq_map);
 
 u32 rtw_ch2freq(u32 channel)
 {
-- 
2.20.1

