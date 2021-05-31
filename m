Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469C13957FA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhEaJWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:22:16 -0400
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:39493
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230476AbhEaJV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:21:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKKXKX/hqwGLyGi0TShAM+280CLaDMMKTu2dkfQo/I5uiiPfMwONlONkXgPd383WHT5hKlVeNTn7tXdGpeZB5iZICM9YwI8hOKfy+avfrcD8QauvFKqCSj4UxAsezzCzC3Gv900xZPs1yLIPiWqqswjImTQH7pctzz8SsrJjmYMwZy2AdA89wkf8+aAsZmFwZgT5eUqHA2pdyTPMsWyz9ehTn9bwJEZf21m2LnlXeS4YjPhb/KguoAxOTEBcNkVuNilZwOGeit5bmk0qYEvZanaXfXVjBE58eglUrHLWgBjVmihuMFRyEJlPpRuNkVwU9WCxEMNqczfjNHFqLvUqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5E15WeK54qXCVAt5mqCnnur/1GikCKJoEcIWRxOzmw=;
 b=SIhnvAjr3S01fHnzyPPH11gtqmR2LNzEh0YGRVwZ0Sgoy0DQ9lHl2etbXwWOUtYhhTGIlZgbyt+HfWj9EylbBjEfB0vQR5gh1Z79L3VC8lep1V+MYlzhNu43gYB2mDaoEyOy3kP+KOGCL2iVbb590MtL6yT9Fb6OEELnLjQNJDq+bvsWCXfScmRt4gPyx3W0fADs0D2RFZDwhCpbLFht7ICXeGKtAbv7a2NV8DlLr22pM33ff2YkwnsiggOBSGAob0NjGhVv2cHyJ2pDDApFx6J/k7FG1TwfGW19bnyapKBvW5l7AuukZAI/49bm0AJf5riXb2isM7SZelCRsU+7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5E15WeK54qXCVAt5mqCnnur/1GikCKJoEcIWRxOzmw=;
 b=G/86bFFSBW2wXObq2eNvIYbyfvUQ73QVuL91C/iyHtl8XFi9lokpCPvgeCXY8UwaUsb4zqX/cB+tSSIKsVQJENIWkOcid/JL2+6fagWaieyM6rpQ9xUbU1uFsabAuOaLUtLuzLExtZWoBrtVWQj/TZGfalgboIjkP07+TsNR6ek=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8998.eurprd04.prod.outlook.com (2603:10a6:10:2e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Mon, 31 May
 2021 09:20:14 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a%7]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 09:20:14 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH V2 2/6] mm/sparse: free section usage memory in case populate_section_memmap failed
Date:   Mon, 31 May 2021 17:19:04 +0800
Message-Id: <20210531091908.1738465-3-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531091908.1738465-1-aisheng.dong@nxp.com>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To DB9PR04MB8477.eurprd04.prod.outlook.com
 (2603:10a6:10:2c3::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0157.apcprd01.prod.exchangelabs.com (2603:1096:4:28::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 09:20:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c07f66d-a599-4419-3334-08d924154c5a
X-MS-TrafficTypeDiagnostic: DU2PR04MB8998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB89988494F17759FBBA3474D2803F9@DU2PR04MB8998.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXPcjNaeATFjNt91E094X+ob6v0qPFQw0zeLfzxbkPEXa8/RI6BycS5zoafUhiHcO116ZaHDhO5wO20Wmr0h7YnFms+rXuL6PVuA0Fq6FJ2eR/PIKUee7SZHvFAfQr/QPUS/mH99EdiUZ94F1m3PgPmF6aZLX74Sfp4qRVkoy/6IQjHAPvOJDB8HPWOqT7+lP/S2SCaO8/cQn5fXhvLClH6MjZ8ejzhhwjZ7Ze36sN7w8iHDIZMgKG4ShfgdDgXWJREAsCo/Ju1jFYRueX6ifJ3oG9V9BGSEq19qrmEGfq1X4vl1W+7gBKa60/q4UJugtea/Oc7WDHLiQbbcQSKTvonvW5RSIaWsDz4LRxGCtYFQEuSgX3qk3k6rqsOJ8j3uh73VJaQuj02KV0lnq0p1Iz1KEB5w/b/eIW2Scvo+OAWDXXlRuch1aXe4jSuOwQ5G/ctIPI7yWGfmjL/tC3/yw3+mmcml0UbaAcTOQu63mg1zgC/ezVO09koyc31FcYC8l6D5yFIIkV8vmEu6IvAiRW4eH64tgMDShVl/vwUkXzh2Vp+0VOHjJ7PQCFtG9K/CGoVjLC82Tmo20I2qdReGFV4MXZldLZMSdJqj7i9pl479CTmv4NrBhf4DqE5/TAbRSPq7pTT/l2ZrVUpvLZBKwyFxYVN//pZ7iB8/GS6UwDLZ5E3rz40wxf0gjitvZFe5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(6666004)(38100700002)(38350700002)(956004)(6916009)(83380400001)(6486002)(86362001)(16526019)(8936002)(2616005)(186003)(8676002)(478600001)(6512007)(316002)(5660300002)(52116002)(4326008)(26005)(6506007)(36756003)(2906002)(1076003)(66476007)(66946007)(66556008)(54906003)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JueKtCTcYycMZps+ebzISA87zihoOI1dVSzqlVprvVilCLv/txNBEQCjefAe?=
 =?us-ascii?Q?deZ5iQB/k99vl54O5AHc0TsMa0+Dq7QYmnKv345co2QrA/KIFIQcdYt3oLdi?=
 =?us-ascii?Q?vxwWZzUeuY/PDnKDTpeEo46eYkR5Ymxi79JNp902vhPnKtymiGD9nLgs2OI2?=
 =?us-ascii?Q?xSdyGFJgYOBTCDekLx3Ns21gKC1RawHDVpjHCPgZqLwiIcskmptjd6k5W1Bb?=
 =?us-ascii?Q?wc/leBYv0vcW9/6wmpE2uleLNylmFMdrq7xUigz5HUza9RS/6JuzyWnWLkFS?=
 =?us-ascii?Q?tHCev8UPa98vci98w3YmvzuR58gIPr5sNCu6rJxrRvfcPB72OrYZ3OophufT?=
 =?us-ascii?Q?seEenuFIO7RUnuLjw1RzS7yVv1UkRhhpN26OTKyXniljRZwz00IgZ/VvKR0j?=
 =?us-ascii?Q?2JCp2Ze2Dk5SzyzUS//kkCpKRuA72xmKJegbTHTUPxVxV02o1FVJ6CfwHDKY?=
 =?us-ascii?Q?LLfUMQnuqIcaXa0HP4VsWewJp5/pSporGQSHzicLb5qNTewgUP8lqpmOVXdN?=
 =?us-ascii?Q?6y9l0r6M8lFWUEeIvVdfu/h4eCAy7JV6RCRwp8VUtbwrfPjMKw420Faobjr1?=
 =?us-ascii?Q?IFK3qfcFmjMzf1beIU8ICCZmjQDnyfH9S4uu2MpfF5xkkf7N7WeijgxJOoNP?=
 =?us-ascii?Q?/9kJgtgMi0DdqeNE6caaPIyQYZ7KW+MXXISY/dVD9vz3AalRUxi4K5GV61l7?=
 =?us-ascii?Q?3htVtyKaVaxAi/Lh9RRjZxm1ZOH9jeD8OL7T9aVlbxoGTQoqcp2yeehjgUJx?=
 =?us-ascii?Q?JmKo5Ex3nBpj3wkpDcFWGtmoqDn9RDP4rhB2w4zt2xaEDdGbCd/4yXUTLxY1?=
 =?us-ascii?Q?8M4pk6yfiWG0pia3Pkli75aeQWa25VRMbjwMsfIy3raRfVk61UPX8WdmFqhD?=
 =?us-ascii?Q?etKvRusnyXhpb9KVd6S6ZBdAdqPL4wxGHSz1MhIE6BQvBRqdaMR7kZuRCgbS?=
 =?us-ascii?Q?E0HMJ5enveVmJGEieqSrqlaSs5jVisa1oOMrw27FNB7CQsP1gTQ//UsDGaeU?=
 =?us-ascii?Q?nQk6JvUs0RfzVIWauttP6xGsZRoVjrabG+tJzor08iZ2FxAonk4N0bpKIE6D?=
 =?us-ascii?Q?5GmVL/1gALL58HjaFQwcqYWFeuQjeGmKVJ5PDmoMgD4eQY5swF+Bl/JP4csl?=
 =?us-ascii?Q?wHVS/brk8W0sL2Zf3caj4JYwhyGpMAR5EntGKTI4gB1QLUd5wM+Tg5RYP9m5?=
 =?us-ascii?Q?k1tqY66JB57i2RL5e+QeRkd8k+BoMnjKbqSOnDg43DgH+eR1HkJieLtqFdVC?=
 =?us-ascii?Q?1c8mluQrzy634mHINTrP9GgsmvXV/OJ6hA+F7O/CxiroY+k9hYcMc0alZ4+/?=
 =?us-ascii?Q?+pnbimayiV6e9FvuS2JsbeAq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c07f66d-a599-4419-3334-08d924154c5a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 09:20:14.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtA88W5qFaCG4/DDE41ZrJECjdwqHZPxNxXdlLKSl7hhkPNqylrNZW/PX1yKV3tI8oLjKBiBzki3TGbwGuRkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8998
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free section usage memory in case populate_section_memmap failed.
We use map_count to track the remain unused memory to be freed.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v1->v2:
 * using goto + lable according to Mike's suggestion
---
 mm/sparse.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 7ac481353b6b..408b737e168e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -533,7 +533,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 			mem_section_usage_size() * map_count);
 	if (!usage) {
 		pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
-		goto failed;
+		goto failed1;
 	}
 	sparse_buffer_init(map_count * section_map_size(), nid);
 	for_each_present_section_nr(pnum_begin, pnum) {
@@ -548,17 +548,20 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 			pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
 			       __func__, nid);
 			pnum_begin = pnum;
-			sparse_buffer_fini();
-			goto failed;
+			goto failed2;
 		}
 		check_usemap_section_nr(nid, usage);
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
 				SECTION_IS_EARLY);
 		usage = (void *) usage + mem_section_usage_size();
+		map_count--;
 	}
 	sparse_buffer_fini();
 	return;
-failed:
+failed2:
+	sparse_buffer_fini();
+	memblock_free_early(__pa(usage), map_count * mem_section_usage_size());
+failed1:
 	/* We failed to allocate, mark all the following pnums as not present */
 	for_each_present_section_nr(pnum_begin, pnum) {
 		struct mem_section *ms;
-- 
2.25.1

