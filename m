Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E624C3D31E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 04:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhGWBxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 21:53:25 -0400
Received: from mail-eopbgr1300091.outbound.protection.outlook.com ([40.107.130.91]:33872
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233217AbhGWBxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 21:53:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUS6uQilgbfOWaWjvvG3DerwqD30SxJgBpbgaXz61XhmXNKoHnWfYfte8XSaVyDaUSWUraymG7jRZ19TUaQYRIUDLVI+XKSdUbmAozhz/IP09q/MKqP4cytlgIMIKqNOQsVY9lSl9zgojLrM3bPr87GN8M9IfRPM4VWZ7YAnWKtiBpmp2wvkzVIwCAUTyGilg+9RJIw8XYsHLA6vheyogGQ7uun2/AOIzR34GTwMLdJMPxefErXqg4EQ4AoaVWbzFwcb+AAOVovqGcQOdAp0OYnLRkLieAOgP9UCiEzl9lpleJLYLR2sCl8xpZ9AMlnjiT9sPmgFQrzGo/u1AwRWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BZV+fFBMKgAaWDV0nvE2K/bUROEyPmiuCzOe87Hwp8=;
 b=XxjIT0q5nLHJa7EQPDQwv4fVNLeV5eztnxsZoGBIcvJKe6sbUc3Cz3olqsdb3CILacu1zaXozF3pdYrYbjYlhXuGIdCDDGiIpQOTiiZfnd6VUvaABpnRyP0t4O2xuP8v7YDFpkQ48T8hk0cyPlS84Lj/9kxLA1a1+YM2Fl6TsFKisgZ1O/Kb9Tz4qeIifWs4ZHS+EYxyaAdCis2O4O7qA4RSuQJWd04H1K4NFMheAYIyXUJcZtQ99DihM9AfOWh0Ta9SXssyHOltTNzjlrrF5c97EpPXLmi9GiYZVwIWVxgSNZJNQIiwhs09wjmKnUqRsrJVISjXur5qwAE47S2iLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeku.com; dmarc=pass action=none header.from=zeku.com;
 dkim=pass header.d=zeku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BZV+fFBMKgAaWDV0nvE2K/bUROEyPmiuCzOe87Hwp8=;
 b=5e6GyCcmBKA+7cCCH5Oxz0IbqmKgOM8+pjJCD+0YIji+66GH68IKyV7B4Ek0Wu0DVtxihf1RcvrP70ngSm2VYNQmfn/RlyTRSrpX4FPrGkrXZrqhst9fEO827rlGVtE0UGXo8NDaWjnicSvZmzbOUl52i2/jR4wwBsrAHZxlijqr+x6P8b0Hk15eZ1TFzplKCqeAfA101FEdwkeTFwhlRUuFvYlXiUuoFeEipLh3XJT5L3lliPCRVVXhkyRvmt/fAOzYY8Og4PRYnmiAQttBtXOa+PyVKtCB/KLS0suCCh5J6knzbpdhdlqfCEXYgZRuGy/OWMKoQE9FO5dyHrwOww==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=zeku.com;
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com (2603:1096:820:5a::11)
 by KL1PR0201MB2135.apcprd02.prod.outlook.com (2603:1096:802:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Fri, 23 Jul
 2021 02:33:55 +0000
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::883f:a6d7:92f5:c16b]) by KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::883f:a6d7:92f5:c16b%3]) with mapi id 15.20.4352.026; Fri, 23 Jul 2021
 02:33:55 +0000
From:   Hui Su <suhui@zeku.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Cc:     Hui Su <suhui@zeku.com>
Subject: [PATCH] x86/intel_rdt: use __this_cpu_read in pseudo_lock_fn()
Date:   Fri, 23 Jul 2021 10:33:42 +0800
Message-Id: <20210723023342.3015-1-suhui@zeku.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:202:2e::20) To KL1PR02MB4788.apcprd02.prod.outlook.com
 (2603:1096:820:5a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from N50001309.adc.com (58.252.5.74) by HK2PR06CA0008.apcprd06.prod.outlook.com (2603:1096:202:2e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Fri, 23 Jul 2021 02:33:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50e870ea-939c-42d6-ffa5-08d94d8250f7
X-MS-TrafficTypeDiagnostic: KL1PR0201MB2135:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <KL1PR0201MB21358B7C5E3C6A1EB6F44CD1C6E59@KL1PR0201MB2135.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuPfAbXO4Z7SaBD70152XS3qxPUn9WWe2jwaizHpPIMnh8scdrBbf3yQR/MVcU4+Q765FllQthjSxEL76j/xmLcuDyDQHTdL/SFJiZ/SUEvjebsQnG/rLoZo5cc9ZtW/t+Nm9P5xD0GaGrrDAEgLqajnOoVYxg0W4nvWkPTKlO6FM/8lc7rUv1vn8Mvkn8ZoAhdDgOAoSbTVb7PVQMqCoXg++NJCjoOkeAwXOltzxvTOdAp0MHrYqmEz/ptkd2yDNWGoRSNrfmMZRdoXOVIrxuhFn+1e4C8IDRd6z99HnJtc4UQ56qAO0SYJKbOqYckx+7Y63F3KzAW3Z9Cm6m81zvSzNFlQl14hs5ik0yoT+KCgChF0LXEGlLCg/FCXtYk3iiTbvPSgChaZLtTe1EhZH6+oIQikWjQvyE213sWzOW0V6ODh2xDV8NPIZy29Wfy6/0HB7lLgAb9o5oKiTx4jrQffHc7Ngk4SCPtjkSLGemjORZ+nXblMgHh6Oy+Ck65PEcPVT3XASzx8FsMqo8VooB2ZQBjdG2lwuXpBIgEuM63bUYoH7aseN26v/Ax1uEblFsU4pbhk+v/lIptLOgPGCYHnQJUg5LaxVxoEMk529msj0Bm8UqqLnIOGSlLgac10ABpa3UBJTERMZFSfxOAuUHuTM8mp5oCdHcxd2Vkx+UH4VRaEHXpDULWy3SdagYGeV2O8W/FORcAK1QbILm2wpdIlPqmsdgynEmlXqlcHBLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB4788.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(366004)(346002)(376002)(396003)(26005)(8676002)(8936002)(186003)(6512007)(38100700002)(38350700002)(83380400001)(6486002)(66946007)(66556008)(36756003)(66476007)(6506007)(316002)(52116002)(5660300002)(4744005)(6666004)(478600001)(4326008)(107886003)(1076003)(2616005)(956004)(86362001)(2906002)(11606007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0f/RoDcFmYgELfMFQKtgN2vpLsIcOPagLM7K+y6JI+1y6YQkf7NleCW1N2LX?=
 =?us-ascii?Q?NqphvdC4ZME44YzN3F63eYlm6TW2b3RpaEFoEyb+BnzuIRO9/SUiXAPxs1k7?=
 =?us-ascii?Q?lUzzy9oD4uDM7osMA6Z2nhhhTnjzIlKQOyveErDQeNZV+qZdYJMVrdtV449b?=
 =?us-ascii?Q?MaFwfSgL1w9cyBsLlTLFsXDMX7O1qe5m3rKxXi9Vb6NFzT8jMcO64isOY6RT?=
 =?us-ascii?Q?t+YNqwHbENCJwu7V9+AuW/PkUeZxTI2W+OFRsyOeReVEb3jNVcI42vrwIkfV?=
 =?us-ascii?Q?1X8KUjktd/5cSJsDBAMTKgJnEnbc8+KEj2LKoY9XpyKOZ5UHOSxpFA5PQflg?=
 =?us-ascii?Q?J+G4R/Dr1D48jeLllsa42I+8pfw+nQyGntZ0Ddu7kXCAC1ZNvhP8FX+MOVOG?=
 =?us-ascii?Q?v3TNjEvgNl23USxO/DEvxNyUrxCJl/y06brrGbuAhf+GzvEweuGIaUwkaL3N?=
 =?us-ascii?Q?NwcrRaxOGU9lTZfsiqySgIZVq0YkaPCcAT838ob18vjR65J78DJ5/V5nb9Tb?=
 =?us-ascii?Q?WnZtrw+l84E1Osdm9slJHUX9pAFe7SkDekwleRxL/9Z281PSRBEnxjfXYDLZ?=
 =?us-ascii?Q?OdUOJEyKpzlrYZrEZ3wBMBEiaeKRutaqTmt6wIhxSVia7ziCM3coyk27csLu?=
 =?us-ascii?Q?W9/7t8kgYgrf9rtINOM9gjmb3tf3/0xBza9n6XdXPYTLUvuDUh3uxql0qBV9?=
 =?us-ascii?Q?1KnaOLfm3/31Lq2tLjBn135+md5zD9a6PW+kOyfdOgJI6QLL80Z50mlOKuZ3?=
 =?us-ascii?Q?Rzk/rgdqgdW/6lgw8Sl9jpyd8yXT03qDilRgj1cNzI5fUTPTfqBUg283BWjt?=
 =?us-ascii?Q?zICk6EqCzSsQTZKbpKDtZwNlClwlQ7sLOMAvwi1ZlPC4Dgh2awoFFRrVyVIB?=
 =?us-ascii?Q?u13AgQuiXk7v1uPlKwi27lPPiAOyMAEQnuWLcLAnATfd0yvYnnJj/D02uYyq?=
 =?us-ascii?Q?WlVLB55N8MH1l5UTEpU01tPyXRQZHcwNxnPahMNzM2HhbItenyjbfSlviQ7k?=
 =?us-ascii?Q?o4MqAJEttHNnnUMBsmlWUE4jxNwC8OO6XICYgutl4haIPTn2eiV5B86Vr7ka?=
 =?us-ascii?Q?tHyXGG6QKoykdnwro9LCxPuitZXtwxDCihuJkxujbCp4RU/CcYPX0JQ+PVjG?=
 =?us-ascii?Q?aAt5rkchpZxAxg+nmxTWqVccNk/lT6emfRoPEhVlf6XlKHz/R5+0auuZ4I1t?=
 =?us-ascii?Q?7TBn8+0X47MojwS0QhXHfQxIpU3M8217qAddxhl2isWWw+MJOuSeWsVk8Pzl?=
 =?us-ascii?Q?hL4Er7L8l+xRD51d+HGIqBMEwHc7qkj0L0+uVVAn2LfDm9nzqDykBenFZOrL?=
 =?us-ascii?Q?NQ8DIDAxb1r3AH79INnBWwOX?=
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e870ea-939c-42d6-ffa5-08d94d8250f7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4788.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 02:33:55.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKU8Nas5qylPwLNcBtjosTfRBd6YjGfU/f6pdYLZpERp2cM1kKDXeM/VPVWfzFw+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0201MB2135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code is executed with interrupts disabled,
so it's safe to use __this_cpu_read().

Signed-off-by: Hui Su <suhui@zeku.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 2207916cae65..f0cc0a89333b 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -464,8 +464,8 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	 * cache.
 	 */
 	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
-	closid_p = this_cpu_read(pqr_state.cur_closid);
-	rmid_p = this_cpu_read(pqr_state.cur_rmid);
+	closid_p = __this_cpu_read(pqr_state.cur_closid);
+	rmid_p = __this_cpu_read(pqr_state.cur_rmid);
 	mem_r = plr->kmem;
 	size = plr->size;
 	line_size = plr->line_size;
-- 
2.30.2

