Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363B34345D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhJTHZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:25:37 -0400
Received: from mail-eopbgr1300094.outbound.protection.outlook.com ([40.107.130.94]:16753
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229910AbhJTHZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:25:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjH8E2FD0XZOmfvPEpghD60F+2+u5Jdr0RPgRqZdsopegq9u7ifOqrr8o2bSaurP6Xr3FdLAlxx0W2jTP2+/bA8JwsUDwQeOBr/unAiQ27r4eK+qz3OoCISL6a9Vx1ix4dYePPbxkPYzuptJT/am+Sz2dcyX2myBlNyPuJIY0lbCQU/TGqSZvy+LksE/ClSkuGHXN0iGw/xfhGrPVniZ/5odb/vFOuyt3wgSSGrgKASncO1tVBuyRLGryCMKwggNOW6ouDgp8GRWrWl7BEy1Yz3EJEUfnlF0cCF9iEHLRj5X4KpZWLTQwruOqBNw+yXv0UN0LPrnWuU9VbQWhqcIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcl1robhb4eTcbO3LtN34ZFaECAdtR7uIVmWpkzlKaE=;
 b=W7hgjuww2JjxrOD1/8YBzLKr2uvriqJPeQlKGvkJmK4+mL15Tb9vxXkkxpfIn9+NVjMc87wGF8iaips3Z9ivN+U+DUjL+n9AuUUYF1meV5yIZ7+YpGH8JMn/oGUTt27/DK3EUh865IbciYD80Pk2/mF1cUj7ENz0aKUB5DvgVpcCBrRo547tkokcP24RScFT4qFlP123dMl/0S7ZEy45wj+Iiq38gSeBbSr5MvT2rjqwzZB9UvHhLxc1KbBll45VzwiWPL2DV3TppimSdOGqa1DNzfsb9pHPErhJ2hWfeXY9SZJzoV6a5pv4lgOrTdZ3JYqRCRPlyCIbwWhs18vawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcl1robhb4eTcbO3LtN34ZFaECAdtR7uIVmWpkzlKaE=;
 b=E1D+lZig6nP/QhO/Gev1gUdfuPFSdvtMv7QbyXG6+27KTaEoIXkWKwajsXPexKiatXnGzge0Pp8CYSFyK3SpmfcrLWCE7jPueEn1S59YGI+E4yhEHcZuAiAJsgpVudgE8jn2ojwQeghqw6rGZDufpW7H6LNo6GER7zREe8m9VEk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3242.apcprd06.prod.outlook.com (2603:1096:100:32::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 07:23:11 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 07:23:11 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     linux-kernel@vger.kernel.org, tiwai@susu.de,
        gregkh@linuxfoundation.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] firmware: edd: simplify redundant logic judgment
Date:   Wed, 20 Oct 2021 00:22:50 -0700
Message-Id: <1634714570-58098-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:202:2::27) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR0401CA0017.apcprd04.prod.outlook.com (2603:1096:202:2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 07:23:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ef8b553-3a06-433c-e10e-08d9939a78e4
X-MS-TrafficTypeDiagnostic: SL2PR06MB3242:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB32424839C5ACE210C5D54CA8BDBE9@SL2PR06MB3242.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+aZrZwVk3EeaxYSHi9M6ibPDSYRxmFCrlDNVEhUYRTsi7aS59qmOBa+2xalMB+fa6gtB3o/+CNJjPw+WZsYTvs4juEl51yMWvqP7vs8HkMI3xjKlu4tSCoIrQYn0Zim1YuUINvhUkIKa1OOLHySWBclx+cb581bpyhszd70GHSzhDk57jbaFeAiJoKY73T2bxsh/AVrF18BxtSaalKAIhlH4QkSJelmX7I15+jssZG2RLdBvO1NXpr/vZx5umFeRGPYPosgAXOX9032/z50N3yQUHn+2P9V0bm84cdvhvpE8hS4QR1PxjK2olp+SkBVfpZzH2KaGKNBspmtQTA4K8xlgssP37uX2m2z1wGRP9Ujh1J/ZVfTv9UtORTG0rSnQGnflwzHOAn882BIqoLdLvzIpX63bhwD0CafW0qSlhdqiWFQXWgY/5jKbwHOjcO30GK/X7TIKqfbDap5tQc/TD1EJIUl2I1DhF4Gbmpp7V0FyRHvnW+DpR3ZS0GOAhyOvoiO/k59MZiZfeS7b1/a3F7N/H1IKpI8G3lXLrqoPfQ5afoBjxvieCQWeUhb15s05NyrnnuUAL+7YAPBP4qik57WcTIoXyDlUDXwTYaHFv03e5am0EkSf7bjvK8PCEUbTaaxa6KjSblwohGoj4V70rLC31JH+r/gy73It8g8LDAT9AEiXsBkVzC3Cozz1uvkSk2dVUwi9RK7S3eQSHRTgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66946007)(508600001)(38350700002)(66476007)(186003)(26005)(38100700002)(4744005)(6512007)(83380400001)(2616005)(52116002)(956004)(36756003)(107886003)(86362001)(5660300002)(8936002)(6486002)(4326008)(2906002)(6666004)(8676002)(316002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T2FSAHFo0a5uMt4K3/6FKcU3vzcVK/HU8c7XsjExVgTkYu7Z3aRzyJ9PK2wl?=
 =?us-ascii?Q?Ef8Vtkd8tASzlNcJjnzdWTluH+ZTU7lKo6TThSBe7HXcQyc0Ihr6+Y5IryAT?=
 =?us-ascii?Q?eUAV7UcxV6THqN/v8+0FPg+aOmyET49cxEitzyGSb1eF6GOCvNLVSaq5lbHs?=
 =?us-ascii?Q?vkaXgEX/bzLsi/Q+REnimVSByiqicU90mapMstHKx+okpD6EtT5b4gNGE9CB?=
 =?us-ascii?Q?pUByXcpTtMId6YZsmGoQYPbJmBJzaSsWWtm1T6GY8kOAAYKWmUVuKIoSUD7A?=
 =?us-ascii?Q?biUrTihWM77dhe9cSWOzkKni0Gbh8pShzSyjgL/gFfffVgCBFxru6K2sz3KI?=
 =?us-ascii?Q?LD7ElM5XFPwK9dZfFTiRC2bqEXWGzRt/K5ouO78+pYogxBFfb0iMgH6IA8PE?=
 =?us-ascii?Q?wFOZpuHgAOY5eVN8VgnjdQaVAsDuFySXDxcZTzCw1+vEkQACbrIddBvSER+A?=
 =?us-ascii?Q?MDRgAIkfNagH0C0EIy49SphRwNjkujuIz6SWq7s2s4OaihOyoY5XR/fUTt+I?=
 =?us-ascii?Q?o1yE+F57dvhGY4vUnMDIXfXvO60koPgLIYuAV8Tz9/jDr3yH55CQ2I5IzpR5?=
 =?us-ascii?Q?rdagfI6mE4u3Gf3bdSElj3x9bSGIXuvcNr4rjiOxiSR/W4P6jacLO/VGgCGU?=
 =?us-ascii?Q?RZHfyTf9yQtVLiIdzWL72DBOe+2UoaUAUvrS2OLVRZ9Hki3V2SJvYGYt7d2B?=
 =?us-ascii?Q?xXXt1ZdFiskWjfb9cUdcNxzmpxztZ4k0c9R6GwsclW8ewzyEfUmg4CPznVMP?=
 =?us-ascii?Q?o+HSu/LzXj+vfeMB97SVXS5Wc4dY1KKxikW62yXc5GxRwTKl00Ws7xL/Xn98?=
 =?us-ascii?Q?7n7uOlDBQWMA3LfkDqEiHka+h3tIakKDyinA66ozbYtru2a70C93QH2vhzBy?=
 =?us-ascii?Q?mJKGhaZlmgfLIiIqTs4s+rbqyyiW99BzriR11gd9zXMjTHEfd7Wzz3hybJaX?=
 =?us-ascii?Q?dxr4vdKBr6ki1UBTS6tObenPoNeEWAIaPwdKWOeCBJ/kHjKBjBDQiVIxz8zh?=
 =?us-ascii?Q?oDnh+PoLjOidQHtVmryrMF7hd1Wa3vjpr+YL4cF2iof10VqT3uUd32LVbvxe?=
 =?us-ascii?Q?7t/syqOAFKaN8yCPS640SjE6gJDvzDdQD5FX93Nhg60fA/1i617AesgCeFNR?=
 =?us-ascii?Q?bNL04+8B7M/yXpKbNteymZkuoCI/OhfmYEPtQSLPcArr3k9xMaYEDytDOUA3?=
 =?us-ascii?Q?6Gf+qKIN6naGnhQySb6XZDZmtjIEkXOyWpGIsYougsO2HO/7DsY2MU+ZqN4S?=
 =?us-ascii?Q?28fO+GRr94nwERmrdDjBgv0Qj/vMjEXwHwSiwNKNGlLmfSfZyEDQRj2jruu9?=
 =?us-ascii?Q?0rINMeJWsDSIee04vmffbKyB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef8b553-3a06-433c-e10e-08d9939a78e4
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 07:23:11.4436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBRgjLUTufEHvDEMMXc9VoE3xmvMoVB9TIybQK1UQJam4CQ1kXz5i/kcoZYtgHqX7mV7K0nUkdzJDyszB4btMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3242
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

A || (!A && B) is equal to A || B

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/firmware/edd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 14d0970..e8b409e
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -694,8 +694,7 @@ static void edd_populate_dir(struct edd_device * edev)
 	int i;
 
 	for (i = 0; (attr = edd_attrs[i]) && !error; i++) {
-		if (!attr->test ||
-		    (attr->test && attr->test(edev)))
+		if (!attr->test || attr->test(edev))
 			error = sysfs_create_file(&edev->kobj,&attr->attr);
 	}
 
-- 
2.7.4

