Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD1B395801
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhEaJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:22:43 -0400
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:39493
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231204AbhEaJWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:22:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKzmUWz1RbQQVuLbhmiNH1yWesS7gx5TL5yHccn6wRGFCzYY/Mf7kMM9hA8EHugSiXiC586+UIIiP3egzpn0GaYurjuM+MYhEVdhBJKdPik27yjXpeHSSKceTHLm1JK1y6k0foLfWA70sGD2pcnRi3e5Z1Y1o1OeSR1GQaO1fLtNCopwdF4rwZtWBRfYm21+CpANSyZ24chWwD8+ZxNqLjzMLgs6432PFPuY9C2CDRk2SagtFFxWjt8GworSmvgXvS3jTaLY2uaBEdRrSxjyRKSzxqflyOtIf2xGZuHJner1I8nb5IumnpPh+7XQG3NHrWJA60Ic2MEUIIW73Rq6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0rLvfQ6UUy1HVounnSKQ6V/ecVVJanikB9xGjsKMs8=;
 b=JcqclJik/pqyTa/7yaaRfHCdn0yT4qX5sHL1cunT5JT5BLYyIFekWAcqr7otfRun361iRuHrDlcOVfKeACKiLdJ/rwxK6vHdhGIjfafy1PG2f3vLqhlIrQKfzl0fm01X9U5KBYBX6Mrc2okpr8g7yxkRKdVgTEveaBr7oUhL9a1FMip1rrSGIgTLK+aHAFJkc2cZCNcBMqS6F1SU4FQ4P9TEGrlLrUJwKmZTaiPe/ouPs7AiAVasQWSYeAh8cO8bWXTtF9ZhMFLSVYZs1BGsRXD8TPbFAWm8oi/uveUjRQ3PQ9PL9V8dpZoehAcsvsITNMR41W/1trIaNnvOm4NAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0rLvfQ6UUy1HVounnSKQ6V/ecVVJanikB9xGjsKMs8=;
 b=ZMMKo1hTLqOSxgYKwz4moHIpPYgAbooHzi4x9P5+lM6QpqhJ8z2ddd/EzcU1qtsr13RNGQaRxoGoxykrdQXdGydvTNT15VquS2KeIpkiWLX1QYbebt03sXk+mjL48124K1mvhorwvk06SqStsLnE0T39nkYcRz42UcJs41vk3p4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8998.eurprd04.prod.outlook.com (2603:10a6:10:2e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Mon, 31 May
 2021 09:20:25 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a%7]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 09:20:25 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 6/6] mm/sparse: remove one duplicated #ifdef CONFIG_SPARSEMEM_EXTREME
Date:   Mon, 31 May 2021 17:19:08 +0800
Message-Id: <20210531091908.1738465-7-aisheng.dong@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0157.apcprd01.prod.exchangelabs.com (2603:1096:4:28::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 09:20:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 561c105a-1ad1-4f37-a19f-08d9241552d5
X-MS-TrafficTypeDiagnostic: DU2PR04MB8998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB89983258F5758913CDBC1285803F9@DU2PR04MB8998.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8L8fUJsUEMn9tzAUFsERXJllppY1zjgDT4Jw8sPmCxKAepaOkOx26RzWzdxoxrvCps+yJ+gfxDiKDLQvQIFXe8Tkv+NE+coSABtaN0RYT2eD2ir1/bKS62+qOuWnNXgOVrr6YQqWJDuAFeH3Hyp4v1nbrUUGgkMdbnwhx8kUT+0jBqTHeZ6OT4MyIzn61Tozkv5bNY1NZdD2+aJ5lV1cnO1VCt23Qk90DAzmkJR4qJZ+HwCM9qjxVVTDxIuXZnZQWP3yj3MsB8zDgJAb8BMpKrJUHl9suR1CjUXTDS20093n0ujUHp4XIvVuXv1Ajr27xr2cu8nbb3pN09eU7/SvhsbScwoa4SY4YmXodeqs6tZ2i2Tl9soYiHGBpSoSNQAM5TjXNfWVMGGexFHBW0tda0YLD1KqsSjE+Nh2wmkoQW4F+54ITow5aMas9936fB8V4Vu08AOhL0Hg61YfBP/w2yWz4q/RnsOwiiPLLB1wICngZD0tF2HQydVLwAbISZoW6K64EJCxOIXzaBDoKv7ZCpK6wDlFgeL/VGuCYEZznjh4okO6kEFEoLenws8m5Ibns5SP+k86ll2VyMUgMoORuJEdqxzs/kACaTIaJl5XivgGivh1OE8O2Uarf5jo94/ZgvPm6hAbKzFfTbBqpQCSKIgIsAZTVrROnCmrzlpmnVzgVz0mU9frYvKSLGkQ9kz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(6666004)(38100700002)(38350700002)(956004)(6916009)(83380400001)(6486002)(86362001)(16526019)(8936002)(2616005)(186003)(8676002)(478600001)(6512007)(316002)(5660300002)(52116002)(4326008)(26005)(6506007)(36756003)(2906002)(1076003)(66476007)(66946007)(66556008)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5JqaqKpMwpHvSrx47YaGXelvExy4vuadm2JzFRZFrW1WoHLeEVjRe4FN3BHA?=
 =?us-ascii?Q?S5spM8WdjddrLgApTL4otb761esb1vadEA5wFcZmRhADIQctVKdVOKOP5LM/?=
 =?us-ascii?Q?KrjziHbjCW+hGkHtgznZVAgS2xrs89X0w2uQ0AAJe2vhdkYcIWSBQft8c0JI?=
 =?us-ascii?Q?kORuo68TpydViN1XLulOhmrqmfXQmT5VxmA7MtV8H0vgCCoCtDbpz9A/igX6?=
 =?us-ascii?Q?U/5qswfrq6jJPwCjlo/Oaz+bAjHyttxaoiW49b55W0FbsjzJtYOWKT6Y+8E9?=
 =?us-ascii?Q?x8hGObwy2QRZ53qQJFCMNLqY9ZBGED0aRxj5q2JEwSLNxIuSW6ZKTkeGvKE8?=
 =?us-ascii?Q?7z7gxzcqiU13cPaGNp84bGzC3/OsnvK/RY1yuKDekCs2sIlnLxTozmW3FEX8?=
 =?us-ascii?Q?KJxnxfiEcSNs3HKvv0XZn1n1m2hG+bIpg5eKSy+C02n+ybEk26oFJSyyz1Qe?=
 =?us-ascii?Q?XMGKzt0aikronetSLJa4ZysEfST3iUNB8XfFp3yct42kzgN+VYitZ9MBfmD3?=
 =?us-ascii?Q?ZCVnfMFdx7QkGMrifemufG3aHnEUk7s+fid7lCASucNQs3eoc3+Q2o6K/W4I?=
 =?us-ascii?Q?jNXvxTVp5dwK2J3AW8AweCVEkcL3FFilV4JNpk+erJpgarRfMe0iPpJoyXl6?=
 =?us-ascii?Q?EgzfrKMXrFeiIwfB9TBae+0PW8S0Fx+Xti6uye89Jhf4mh5Dih/Ux40Y+RGS?=
 =?us-ascii?Q?Ev1ggktLBiPUmM0S676g3XY5bKse0VEhtxKESdGQ1JdAehJywZw2hxZehoB+?=
 =?us-ascii?Q?3BgLid7mIXdh2vtDYhA2Ht40yUOLQuvOLLNkPnbpP5xaIn2gE7/XOZvwHs0a?=
 =?us-ascii?Q?cIU5UDswlQUPlRiWqG4JfU/FMdZ1V14VXRa7RkyUQDZWZo5RKJN+z7RxUCX/?=
 =?us-ascii?Q?DLNXS2rvzN2anaSC4s1eYuIoNQ3FW8acpxWkoRJj54tnK4SaqBaLD6001ChD?=
 =?us-ascii?Q?apoyXn6DmWhsK9whm+Td41pvRLpHALxHhR+zbYxp1ARvqe+rn1vF1rsgfCbq?=
 =?us-ascii?Q?lNMjjeUEJ/D8EHr8N2tU/8T2NnocQdaw7D3H7J8PZWZlJ8H10/FA0PYpqH2j?=
 =?us-ascii?Q?hOxB7mpVJC8bwLGfP2iQ43VIDfTyCLyrc4Rgw5EhPEQWMRATOduBjibmDj1x?=
 =?us-ascii?Q?kVJ/xGz7/L5Rs4Ro1ASN/5EzsN/rjxiK2NeShZDrliZ2APUWZHSLUTAox2HA?=
 =?us-ascii?Q?BYeWcqrNfl6SJe6jPrjIsvxvQ/6XK94WTfykojtOa+9w2dXYoJReTbRwMvFV?=
 =?us-ascii?Q?EHbGKkV+Oe+dp4d8skdLlzKfx/5uH9XPZpc9DAnZ/KZu2lTXVBT+8rARB4Jl?=
 =?us-ascii?Q?OAilMj6G5Go+Jt01yCqZ3M7q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561c105a-1ad1-4f37-a19f-08d9241552d5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 09:20:25.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVUawWF3dkDqhB0qmFW0ZRg/G5eqPQXZ8MLvAg5HkNonbUqIj6Hdf4XDgC6KrewP3oWwoCdmYMcviGVzJtyypA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8998
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those two blocks of code contained by #ifdef CONFIG_SPARSEMEM_EXTREME
condition are right along with each other. Not need using another #ifdef
condition.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
 *new patch
---
 mm/sparse.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 6412010478f7..2905ee9fde10 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -114,16 +114,7 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
 
 	return 0;
 }
-#else /* !SPARSEMEM_EXTREME */
-static inline int sparse_index_init(unsigned long section_nr, int nid)
-{
-	return 0;
-}
 
-static inline void sparse_alloc_section_roots(void) {}
-#endif
-
-#ifdef CONFIG_SPARSEMEM_EXTREME
 unsigned long __section_nr(struct mem_section *ms)
 {
 	unsigned long root_nr;
@@ -142,11 +133,18 @@ unsigned long __section_nr(struct mem_section *ms)
 
 	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
 }
-#else
+#else /* !SPARSEMEM_EXTREME */
+static inline int sparse_index_init(unsigned long section_nr, int nid)
+{
+	return 0;
+}
+
 unsigned long __section_nr(struct mem_section *ms)
 {
 	return (unsigned long)(ms - mem_sections[0]);
 }
+
+static inline void sparse_alloc_section_roots(void) {}
 #endif
 
 /*
-- 
2.25.1

