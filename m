Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868C43F7D59
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 22:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhHYUvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 16:51:51 -0400
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:32960
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242649AbhHYUvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 16:51:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lepIwevt9dGw4vVJKzHMdSXD1kGINgH4S+WQNX/Tr39OMzYDfREN7XjRw8/swGh/xTQw8+T5FfyZSmF0uIisQY+Jwa8QHGkkEEvwR5hH6SFwMUFqFE2PvAKKAnrnt5ssIE3m6klJjNByqzRoHNEu3t3FhuSotpE/kAyWwxlToTy/0Yxh+13F+g4+BtzB4eq2wQYuAuJEmxUTey4hak8HdTBN3jy5N9ajw36wThLJTOTi2Jtf0Zb87madO50B9mnfY4bqZdhz8EGgd+3s/ShsBAwSkGkOjwDFBC3QUAf/WYIrIF/pHcsjRz0pk8ciS/gPK+YyoyZN+o+jeHy/umeEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO4tgIcD7V4KgMV7HeoTe8JV85mbgUQ/5/aORkM0vng=;
 b=I54AobY/b7avvqSEZLUsTc8VPEdVvIycMlPFg8iWs6tnpwoRqliZ85UvxQYYFE0HDLZBBRLqaO3MSYeig/TlXXRWkQEgKh069hjg3oWJ7uXFG8Kd1VrTcVB25z1Xj6gDT+nwP/h5wVUNElga4ff+v/L4Vx5rPdImg2Iic4UlHGGuxe5YuoEnTpzDHZuZgXUWJGD6L+jx/VG74kaRrVS//62HaAJJrnn61gZ0xaDymXjM0b3ITdfLnEdO9Gdmn+tIy3Sd5NrymzS7A58bJaZ4EGEpuT2syC4k/1YyR1wsEaSzYacRYuklFwBiTG6LsU/rx414+aXmopH+db22fr1CCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO4tgIcD7V4KgMV7HeoTe8JV85mbgUQ/5/aORkM0vng=;
 b=Ke+aeXUTCHGknBlAouMMNuROCEX9POlhdb1pJsLTWG6IJ7PwA6Ri/c5wQtD0XHB5mWTvYEa7cxSuQCRvopR68kSgQvGxPZKdwee5XXw60j+tWm/x8NX1WuzjL0/Ch1vSJ+MeIod5uGNX1rlgfn/rnrPjiahFiIN28E4cg8nFETg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 20:51:00 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0%2]) with mapi id 15.20.4436.025; Wed, 25 Aug 2021
 20:51:00 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] regmap: teach regmap to use raw spinlocks if requested in the config
Date:   Wed, 25 Aug 2021 23:50:40 +0300
Message-Id: <20210825205041.927788-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210825205041.927788-1-vladimir.oltean@nxp.com>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0187.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::31) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (82.78.148.104) by PR0P264CA0187.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Wed, 25 Aug 2021 20:50:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6c055f0-2548-4c2a-eeab-08d9680a0b68
X-MS-TrafficTypeDiagnostic: VI1PR04MB5853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5853DE031635EB2771F2398AE0C69@VI1PR04MB5853.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1h+MjeqzR5djzyrwbv9g4cmfT2lS5Ip3YBPuaDPmc5wiv87hgeIyp0wsgbxVdFU/Zd6Pil2l67+5KYVVlkTW0GaiFWNVmx5EJV7IGLytZjBzvkE9ljgm4gUFByRyJoMfyQnqxlu47XdC7es7YxAdIs7YP7aQAyc9G36LJzPC+8zL2QyfIIaf3HLWhJ/n+3B9+54iq/az3bOI/29NKma3Z5URp7KlPk2P+DmyDFewJOsKP/trgsMxK6jCkvF+6iLrnXLTB3H60kXOzRsamIuCVkbYiI8WmaD5AF/k7tn2Lt2w4/InCqnVe0LQsoIyBYPb/nDZq75TKOZvhHEUH+Kman+ub+WcD7kYneqklYsrYByKwcDLYvTX9MVLoPlZIGnoltGZK3u2z/lKixO72XVJ57Q6UXSUX1cB/GXDH59ls13fvQgkl0uKibweYqWzCvk3uQyeoDpbc8k3WsLuzRRZtOk9skmJbv40Rlz9/QNgxcc76l7kbkYNJ6kjWD32uUasBtneHaB5dsY0cDJyq50J8es/Nnms1+11xhJTD0tK6iqWUkYUPYeByqK01mGKayPHwfp7EA+JIDYiaM2LTzgDNt7SSExFpX1gHN1ATDcnKeYnkmrXqqYmd/WnhzzRM58c0XRHJ/rK4/iriPuhfNrNfqj0RPCOJLLOBnbGQatgdo+BOM2jjAVK292Q2JN+g9pQDzAAHXrRdd6nwGtiWtiQSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(136003)(376002)(346002)(316002)(6666004)(36756003)(54906003)(8936002)(44832011)(83380400001)(5660300002)(86362001)(478600001)(8676002)(6916009)(6506007)(6486002)(52116002)(2616005)(66556008)(26005)(66476007)(38100700002)(38350700002)(4326008)(1076003)(956004)(2906002)(186003)(66946007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZT80pt2/kli6dvMYNFN+iDxrtrSFgM6j8KzF07RBS4yof4HPLEfWo2GFx3X?=
 =?us-ascii?Q?5E3bk7BKEAFtoMI5gnaWijJV95qxV0OcCtUXbkxKYLgTV+XLqQ9ibk8ujXC/?=
 =?us-ascii?Q?rD4gAqHVkv98kC/rYFAPDz/+jJ4M8l/0h/vHC/ehkIfijR2Rm+DD9+UFp6Jq?=
 =?us-ascii?Q?zmUCXJqV41FUBsT54eKZyhjfppZkz0IxASVSxp/dtLvlduht1yPzOiwKLteW?=
 =?us-ascii?Q?aqcIoCunTzVfXh4wppX6HYeZwagEPIk5jUVhm9xgk8bRWTTdIrDODgTTlry8?=
 =?us-ascii?Q?RLpK5FbTNjX4k9NOD0MgVJhfKJEEgKrlNRfkqMkPFuXEM902ajMICeBLBsCN?=
 =?us-ascii?Q?7nhQ3AUEGj7qGKYM/1OEurC9/xWk0ok3ccDrjZjlBA8ivbVxr8/A+VWXg5sq?=
 =?us-ascii?Q?lagagS41cmss5PYE4BWuFi/0EiVEpdN3vz6o3eVwcmrD2F9ZmeZi2XGoxJFN?=
 =?us-ascii?Q?cpwudqIACKkz7WGJeNE0pyjtj43vMAe+ONYvuwMJBue4ZmuXjDeD6HqLFQV2?=
 =?us-ascii?Q?yuCHeuVL/1ikX7pq/ZoemgehSIjGuvKz0mqFCiSaEWYgFRDRteXudBSNDjfK?=
 =?us-ascii?Q?qCo39e3x+IllCqLAy2EZJd4iwgaDB/XugCcWVdV3LsfGzdOevd+7iPP64l0n?=
 =?us-ascii?Q?EPO26+6mjpj80VGHxZgxsXv2Q+2woRXsqsnIL488pA5bUunUd/2V/MjY8vMk?=
 =?us-ascii?Q?WZSegwJzHzf/QZ0ualE/4If+yIhAFP3O4fNitAxfUf8JKYlzCyyfbZdle84L?=
 =?us-ascii?Q?gZfHJwXpMTX0/B2vwZVHGsjw5u52/xWPzBaqya+EgS9djZ7XGwQQ/1SLE0mm?=
 =?us-ascii?Q?AqPomDD82RbQhJKFBUM9DCszUW/nO2HxH9MC4gN9KCWkd9YDTLNzaSneg3xQ?=
 =?us-ascii?Q?mteWUj6OpiFt+QtYs0/3TDcMu/6YSkm780Yd3VTmFqtemAipp/lgUtI4VUIC?=
 =?us-ascii?Q?vRZb2ORrDqPxyFpqfV4LAmt3dcFhWtg2urh2paI4bAM0PZfj9UWw5PmsQ5gI?=
 =?us-ascii?Q?UA2Cct+ujB3qxuAwmwbTut22INWLglv2QQYLSpMcbdRUkrFiod7RyM+UufQ7?=
 =?us-ascii?Q?dCo0OgNhjZU2bE/s6EYO+1Z58GADDW6lXO7YzwvA/6pbm8fal+gdXZsoHyG5?=
 =?us-ascii?Q?PEiTnAEzEUy7XAuIP2phI9G7qeYGjIbxL6iZGBjaNd/DLCS5FgMdnjsclIxT?=
 =?us-ascii?Q?Hw62CG4plZ2QnF+q/MfX0ggQohhl9tQ5D9Od3W38HGiVv0b+Yp+kdJt9KyCx?=
 =?us-ascii?Q?JsQAMPZM9WrQp63mUyfNgyyuOw2UhBmbA7kVAcmYvisxE6yOVZt/bIrIA+D1?=
 =?us-ascii?Q?QHNcE0mvmCa1lVUlnYzakzBn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c055f0-2548-4c2a-eeab-08d9680a0b68
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 20:51:00.3511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCQfPCkFleZpRHas1WaLjxZ7dOUD3eHhW337OQWe6LxWjTLJvD8hxdiND1C4/BMozi7IB03Z9fcbJqk3YdNWng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5853
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers might access regmap in a context where a raw spinlock is
held. An example is drivers/irqchip/irq-ls-extirq.c, which calls
regmap_update_bits() from struct irq_chip :: irq_set_type, which is a
method called by __irq_set_trigger() under the desc->lock raw spin lock.

Since desc->lock is a raw spin lock and the regmap internal lock for
mmio is a plain spinlock (which can become sleepable on RT), this is an
invalid locking scheme and we get a splat stating that this is a
"[ BUG: Invalid wait context ]".

It seems reasonable for regmap to have an option use a raw spinlock too,
so add that in the config such that drivers can request it.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/base/regmap/internal.h |  4 ++++
 drivers/base/regmap/regmap.c   | 35 +++++++++++++++++++++++++++++-----
 include/linux/regmap.h         |  2 ++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 0097696c31de..b1905916f7af 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -53,6 +53,10 @@ struct regmap {
 			spinlock_t spinlock;
 			unsigned long spinlock_flags;
 		};
+		struct {
+			raw_spinlock_t raw_spinlock;
+			unsigned long raw_spinlock_flags;
+		};
 	};
 	regmap_lock lock;
 	regmap_unlock unlock;
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index fe3e38dd5324..e7ae477d2fcf 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -533,6 +533,23 @@ __releases(&map->spinlock)
 	spin_unlock_irqrestore(&map->spinlock, map->spinlock_flags);
 }
 
+static void regmap_lock_raw_spinlock(void *__map)
+__acquires(&map->raw_spinlock)
+{
+	struct regmap *map = __map;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&map->raw_spinlock, flags);
+	map->raw_spinlock_flags = flags;
+}
+
+static void regmap_unlock_raw_spinlock(void *__map)
+__releases(&map->raw_spinlock)
+{
+	struct regmap *map = __map;
+	raw_spin_unlock_irqrestore(&map->raw_spinlock, map->raw_spinlock_flags);
+}
+
 static void dev_get_regmap_release(struct device *dev, void *res)
 {
 	/*
@@ -770,11 +787,19 @@ struct regmap *__regmap_init(struct device *dev,
 	} else {
 		if ((bus && bus->fast_io) ||
 		    config->fast_io) {
-			spin_lock_init(&map->spinlock);
-			map->lock = regmap_lock_spinlock;
-			map->unlock = regmap_unlock_spinlock;
-			lockdep_set_class_and_name(&map->spinlock,
-						   lock_key, lock_name);
+			if (config->use_raw_spinlock) {
+				raw_spin_lock_init(&map->raw_spinlock);
+				map->lock = regmap_lock_raw_spinlock;
+				map->unlock = regmap_unlock_raw_spinlock;
+				lockdep_set_class_and_name(&map->raw_spinlock,
+							   lock_key, lock_name);
+			} else {
+				spin_lock_init(&map->spinlock);
+				map->lock = regmap_lock_spinlock;
+				map->unlock = regmap_unlock_spinlock;
+				lockdep_set_class_and_name(&map->spinlock,
+							   lock_key, lock_name);
+			}
 		} else {
 			mutex_init(&map->mutex);
 			map->lock = regmap_lock_mutex;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f5f08dd0a116..7a3cda794501 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -344,6 +344,7 @@ typedef void (*regmap_unlock)(void *);
  * @ranges: Array of configuration entries for virtual address ranges.
  * @num_ranges: Number of range configuration entries.
  * @use_hwlock: Indicate if a hardware spinlock should be used.
+ * @use_raw_spinlock: Indicate if a raw spinlock should be used.
  * @hwlock_id: Specify the hardware spinlock id.
  * @hwlock_mode: The hardware spinlock mode, should be HWLOCK_IRQSTATE,
  *		 HWLOCK_IRQ or 0.
@@ -403,6 +404,7 @@ struct regmap_config {
 	unsigned int num_ranges;
 
 	bool use_hwlock;
+	bool use_raw_spinlock;
 	unsigned int hwlock_id;
 	unsigned int hwlock_mode;
 
-- 
2.25.1

