Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837F344FEFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhKOHIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 02:08:09 -0500
Received: from mail-eopbgr1320117.outbound.protection.outlook.com ([40.107.132.117]:28009
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230319AbhKOHIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:08:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pfd4y+K2f6A1dXRXAR+qxBmqdCx1iWEP66CeU8kd10Ud6gMiPOcTGor/9Y8GxMi1b0RCy1HIAfxybQ1gH5870XjZrBbdYx+K+Fz8M1uSxOElGE3nDu7PYZ5xWtKZVu52ITJ/fAaHmVKhIVBoWV1WN/41HxPNAbKMuBoI/CZ/Uejy6oIoOz6NJGKRQK77V4ofIwABgUM8sIybRBIfoLhDTe3VkadOon3dsmaJcblFGi1QOtXc8YcaLPkhBP8kSW7n7dBc040XAnazrQC4Nl3BKy+G5rq8o7W7xdZ31XRapQECbTVUc/U8p2HmlSMQ/QWNRVKMcUnBKybi5zxYYWM7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fsOXJ24NMO7/JgY8U1GoM3StO2c37jzer9K49jXTEg=;
 b=DLWZdvvnylT/9Q1URYdPmheYnqLlwFSAhnTSGEgIQdnijKh6hibhUUL5WMp7nLTgjDK1jLCcZzwAL4aUaCctCHDzXZhXGI38Y/+dyTF2A02cRlY6ASRprh9igNvBtParhYEGimU2pYP5ZVdNOF+bL28WNcYwaf1Jt/tZvaFa51GsKsIWTqA8EqkwgbpnNW4S2tOTlpYihLcDc/MfyIyoFuViWkPnEJGj+pEN/Y2GA1cN7m8hTlpoVoXo5g7ytC452aO/TqXNJE+/l1b1qx2nONtCfBLj3Vf2uQNsBz0XIlVBIa1B4EZ9EeEz3Ro0rLrFT8yeorci7s+jbRxgzagBlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fsOXJ24NMO7/JgY8U1GoM3StO2c37jzer9K49jXTEg=;
 b=PUqRWKe/xgnRq+7qPlCyKwiFV4xYMmcEuClw3cD/MhMgtoIoFBEdz0WjMfgK5mbkl9qli74QD/d+s1LljBg98ggtSJoNwo2QWA7RlGTwPo1cBIpmoAe9FHvW7AnWmMO+unOO0eCZqc8xdsxOFWQKoEyoH2XmGN0PgfXGJUzaHJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK2PR06MB3428.apcprd06.prod.outlook.com (2603:1096:202:31::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 15 Nov
 2021 07:04:36 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768%7]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 07:04:36 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org (open list:LOCKING PRIMITIVES)
Cc:     kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] rtmutex: fix boolreturn.cocci warning:
Date:   Mon, 15 Nov 2021 15:04:10 +0800
Message-Id: <20211115070411.6842-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25 via Frontend Transport; Mon, 15 Nov 2021 07:04:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d92de98-d14d-4c9a-ac2c-08d9a8062eea
X-MS-TrafficTypeDiagnostic: HK2PR06MB3428:
X-Microsoft-Antispam-PRVS: <HK2PR06MB3428034E98FE657C400749A9C7989@HK2PR06MB3428.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gUz2PHUXFMHExOSHm+QmbXvZMw+//IpC2+1ozQqiuwJf6QDuVQ4X6AytmpWy3EFLaCMFbSA5G+GR4A1Am+uathfPbFVYEYqoFoLRSn0GaMJxLxy1MB8nwpJZKQQTTah8/AtXwLELncz5N8JOe+XLv3HorilYnueYfzskjgmmRiB1HPMRXWjM3AlqJ1JeKRu8xbaYtz6bmd2UN98VWznyuwtft9YlabbOCl9B5Ma0n1rxPw5O0z7HiXLmzwHk8Qu3WVehXNcGNqngGdxPkV7pU2mc/uD8BwHMm5w+4D1s3bxrtP+of5RF4eXaXtLOODePfPjFMp3KF/RDDW01/MDk+YrUSD0G68T9cge8xWeoRghy5XyMdIZjgOLOl059BfOEOciP0Fcgv/Cp65DX0OoYOm5rVSyIW/trJkCrDw6XzxcU7X9JM52d/MlHj77niI8FTO4QbkSjB/q0skW1IBd5bgyZfNfIF2VfdFUEbwWEhzWIq/S/99V6VmvLetPvRimR7H0SFoh47eVYSHfwFyBcXJ1aeMgLW0x4N00eGH6QyrO4tCjuZgiWd11SeTdD4aca7SL3/vKGVNCx+7fuy1S7rw9pTHeRmt/PP5UiTHv+cXTiaBnv31N35bNPdJii5RKrCJxYDWktsLebmvTLw2h4ufUWJYpaO/oZ3qTaBX34HxK6j3Pxwodq+/DIPedoGnhi8k9He4Z68LQMeEghOHZsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(52116002)(107886003)(83380400001)(66946007)(1076003)(316002)(8676002)(26005)(4326008)(2616005)(186003)(6486002)(86362001)(38350700002)(6512007)(956004)(8936002)(110136005)(66476007)(66556008)(38100700002)(5660300002)(2906002)(6666004)(36756003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?77hM8kB+EWzw8v6MAnf0teWF5Hit2OCz1hYqWvx07yGJmD65OAPMtUgA2/IK?=
 =?us-ascii?Q?vGgLmUbe2n/6qrqw0oKb6PnxblrqNaHN3JvTkh5qrf0nz33RinmExHsPZ7/v?=
 =?us-ascii?Q?vFLJy6ZH0E7yrFypv57d8x54b1uYB8WcFISCPqk8ZZBXPjLA0nIXLrOY/4AA?=
 =?us-ascii?Q?dNizwvUoSZin1hytluTl0LIFtPlpe2iSw4oTFfeQXIJmfzqjbGC7azn1K4Kb?=
 =?us-ascii?Q?MqsvYY1PejK/bb74vy7HIZJRR+B/XbwxZ+Uz2UH4SNtuyviJ0Vx63+FJT2RQ?=
 =?us-ascii?Q?fiIu5Q7QohbcU9B26USSmsuhVDYPGaTLHR5kZ/XUZRE5CFGorvjqTK7WlSyc?=
 =?us-ascii?Q?8mql4JQWCB5z3WIoWlDIF/gfosv492frxXT5a0tO854Qnqau6iDevEKZoLGO?=
 =?us-ascii?Q?kQdeEmxWv53P5Y2bUclAVAxxeSDjAgMCcoYPleYXMRGmY9apcvoqR86hMDyT?=
 =?us-ascii?Q?bAMzyOCbKNmM9pvXyt91s+8CrrU6FUMWwrwJ+fV2v9LHHLChGwZlZhiR1rRJ?=
 =?us-ascii?Q?38Tc9AmoH5qUE1gKGwtyt4xUUHGEZy071JUniIAP8ZGijNmmnefhbup+MGCG?=
 =?us-ascii?Q?/K37dQfP19i/jHxat6ANHoCglL8qDQGUZbl96Gty0dVYmQtr8t8A2T4YYXL3?=
 =?us-ascii?Q?eeXS0RXHP466xPsyhPj8DvbX0vjY24XvJzSKGTERPXTPjCViuAWyW6HlX7uK?=
 =?us-ascii?Q?VWMQm/hv6mTaSmo/goelJyamb/dvu04RwzqjcNNqRRJFZPdBQtMYGelADymt?=
 =?us-ascii?Q?ZinArKX6d7NxggHmGkKT6D5UNuCf5ooDg7Vo2xszadjxjTDBt4HAPOigAvUb?=
 =?us-ascii?Q?8lpHB1kosOJmf0NjHbXahes5nx6zBb1RdGznOVAuP4HaB8eBLaUtjow55OWl?=
 =?us-ascii?Q?a+bADbAGsUM9lP33uWxrYMsc1BQL1AFJ52BNej4kx2Rkzuh7i9he2Tg+VRjH?=
 =?us-ascii?Q?vWeIDssPO5WYeiPi0u2XwOqgVxrt6AEMkYUfDAiIpW9JP6TePT6ct+/i50e8?=
 =?us-ascii?Q?DrpYiCtyjJ7Zq7vx86u2gPssK4b6GUmhbiITQ7Qty9N9PDDxR6xoUjBo4yF1?=
 =?us-ascii?Q?PVQDtLgF53WtHV1HlCue2fCs9bcD17QxklbphTQYdNTw2l+Xnfr5Hcbgw35+?=
 =?us-ascii?Q?27+Zaud0SmFcA0zY/OovcUkEfB6IqHr6rjAXgFYfr+M/UEOIyeKomrae8vkE?=
 =?us-ascii?Q?p/IZKJNmUIVkbMujrpF0+6HRK+p82HVdAmx+LVPZmaAbD1AUqYYI7Q5d3nbV?=
 =?us-ascii?Q?ZsdNfv/sUJ13fFEuATXgoGGS22ZTeigUo4fFVXYg9KQt+d2CsGJ9nsT3+GI8?=
 =?us-ascii?Q?Ljqj2Ar3VW7C2kXXXQ3/rYoOLsMm05yjXHVXgoAViN3/O7/CZNWnFhhio9b4?=
 =?us-ascii?Q?/iQcnwwtIJ5JuXtG7rGAyUn/Towczd5DOfsqGicmOP9tzCY0UX9h2mZojCGi?=
 =?us-ascii?Q?F0b07f4RAdoU/wNABWlndBHQqwcGytptU+YHt5sSaEczzuj2Ob5Dwak1JBHy?=
 =?us-ascii?Q?jWJnvFcK7UiWF5tzie6WpWAdLxTUezd672xbTSsw+FEYD5jbtIaymwIDMbK5?=
 =?us-ascii?Q?0STjdZ9Pij+y0I6AMoxytQoQUykJazjlUkAVAJ4C7CRa5NhGT/WcrIr/lAJD?=
 =?us-ascii?Q?Jszh8OobdNAnPZwUcLnmkks=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d92de98-d14d-4c9a-ac2c-08d9a8062eea
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 07:04:36.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUqUSDW7PJnShlN/CqUCOX50xpI7uhdFth+aMlPH81KKn13jX31MQ+C/gNEVVlqFowFv2HX2cKajkmuNLFryeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3428
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following boolreturn.cocci warning:
./kernel/locking/rtmutex.c:375:9-10: WARNING: return of 0/1 in function
 '__waiter_less' with return type bool.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 kernel/locking/rtmutex.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 0c6a48dfcecb..fbdcf61b6824 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -372,24 +372,24 @@ static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_nod
 	struct rt_mutex_waiter *bw = __node_2_waiter(b);
 
 	if (rt_mutex_waiter_less(aw, bw))
-		return 1;
+		return true;
 
 	if (!build_ww_mutex())
-		return 0;
+		return false;
 
 	if (rt_mutex_waiter_less(bw, aw))
-		return 0;
+		return false;
 
 	/* NOTE: relies on waiter->ww_ctx being set before insertion */
 	if (aw->ww_ctx) {
 		if (!bw->ww_ctx)
-			return 1;
+			return true;
 
 		return (signed long)(aw->ww_ctx->stamp -
 				     bw->ww_ctx->stamp) < 0;
 	}
 
-	return 0;
+	return false;
 }
 
 static __always_inline void
-- 
2.20.1

