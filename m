Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C39325B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 03:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBZCTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 21:19:10 -0500
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:17121
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229707AbhBZCTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:19:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDNMxoUm/AiLk68fc6DOYKAIVAFx9phXATeLekkSCKtSOKjoUM9F753Zm/qoQNKoHCbrWWBLxg1nkpS2oreOf0K4i0JUPdgMBOAPKruWfYp6Lc+PlX3zuSXOLp3fwEpb5WhLLoQdyz7dsD26jsjUzGU/0zaCILPKke1Bm2wK0c2HZ/2BgMkjhRozOqaSeQCvc75mWJPy7a9PCwT0j0RiJKK7jmVagxdL+c2Meiy84VRz7/+Ps21X8bEdKclH2XDIcSGff//0IVFuF9oZjZgg5qLlhKL2YsSCfKlbEYttBQe7I4Kh/G4K7DDDxtsZB1fwILvvRDmcHISDEjnV6sOkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6juJEFkkKVHON73LjUVqpNnWJLqEWcVgOfnHaBcAUUs=;
 b=Lu7/6cE979hWhz7Dgh7Bcjpl7oU+AeOVtiq2XcSYtnBwasQmWRBGETy4w/cFf8pn/V0SsFbAcsviCepi1zmmpu/PivXGOZmSolKE/su756tu+8COqahHRj7lndSWPRKrG4B0dok9xdkxhXtDWVWSapsIQkC/V4QUP1rBUZlKGmgShV24zrYR11Zs8li8VX0G3y3x/CukfyJyV+4TqqJ8gjTpmdSKjAV8S0HQV2gNR51S8sKkDecjE8Snni0nEZk2WBmCEqJGGzZKBiP6Y7wsQd3E4thrp/miCVaTCzpRN9QaX0PUCp9MKIKe5rjka4J5oiZo9WUr4dGF8EcZ1vfIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6juJEFkkKVHON73LjUVqpNnWJLqEWcVgOfnHaBcAUUs=;
 b=OSG3+r+tOzKDP7rTNl/1Y5XGMvbMrSXpAVLs3jkOE+eVAaNC4e2oOE/QKv9aMkoNXyIRTt05pd0S1EScTTTA6OsMvYcMsxNjQ/tGot8JHuOxlAMbT6vUefwPhChVUQDu0jGoLzYaNhykRK49ZEASc1qsr6wi12i9UIgjudraWkc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 by MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Fri, 26 Feb
 2021 02:17:56 +0000
Received: from CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b]) by CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b%4]) with mapi id 15.20.3846.047; Fri, 26 Feb 2021
 02:17:56 +0000
From:   Meng.Li@windriver.com
To:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     meng.li@windriver.com
Subject: [PATCH] driver: regmap: set debugfs_name to NULL after it is freed
Date:   Fri, 26 Feb 2021 10:17:37 +0800
Message-Id: <20210226021737.7690-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To CO1PR11MB4849.namprd11.prod.outlook.com
 (2603:10b6:303:90::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HK2PR02CA0176.apcprd02.prod.outlook.com (2603:1096:201:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 02:17:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06a9b0d9-a804-4741-8426-08d8d9fcba73
X-MS-TrafficTypeDiagnostic: MW3PR11MB4555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR11MB4555BDD6A4B632036D994804F19D9@MW3PR11MB4555.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUIVOfHVSejXQjcmzCndRCy2oh671DN9Gen/X4ma31L3AA4cLEeChE6phCI1ydQ1UvGXpOE75vDZXOqPiURZax3kd/1j5SXrzarnmUtMu9bFLkA4IxPlhvOpOatPxvTnrU06V/Mq5P9bhUBjXsbbrsUwdmfv957CXKaWzo86ulnaJYfkJSUUfSd2RfhFA/t8fs7ioP7ZGHIoo/DdceqjyP1RzcuI6aupkub/ROZhhrtdYyvhXGe+i8EP7kK7o4es/amqFkVSN2aZakvGG35IUTR4ZTSxgPsQp5wSqN0q8p7rGe8WR7PRmKsIjs6m9LBVMsK+Ai9LCbAyhP7OHGpeMcBCvFAWn35ZrNujnJemJdBV9J8JjtJfH/SRqAaUFuksrF5pOFz94xOq1527dZbTgpTHuZbWe7keMtvEmBSGMY6ZFk5EkWjNZLDl44Dy7odxzemzqvyYgQ2Qnqq6jkixjFLRwKz3NbsTumEB+Z/9dlngwJqtTdvaWCCqcui/ElQKJxCaUXltuHCR9e8W4dsJ+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4849.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39850400004)(396003)(346002)(2906002)(26005)(6512007)(6486002)(8676002)(2616005)(86362001)(186003)(9686003)(956004)(4326008)(478600001)(6506007)(16526019)(5660300002)(83380400001)(316002)(66556008)(66476007)(66946007)(107886003)(1076003)(6666004)(8936002)(36756003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hpF/pjq3p/Y8yL6bWyiofT+tBxDnyBlEVvFC3sYDtkWhFjh0HzBtsC1F3psp?=
 =?us-ascii?Q?5pLMJYWq534WpmxfGVT/GPiaXEh3BS07N8FqFrGJ5UdWjvLHGaP0zvJ95ojI?=
 =?us-ascii?Q?rIvbQ3Xk03mOcF2GNxo/7KmT2hOO6UlZ2q3XucFtcUduaU8GUB20bAFnkjfE?=
 =?us-ascii?Q?b8XNdgnVtsOMqZ4wvfmGOc1tS5HL4BetCfftIpuzkF20ZhjDr8FMwTk+Hu0I?=
 =?us-ascii?Q?LgEB0bOeLWAOrgjCytXRFvPFARbgdCsNk9Z/WzUn7+XZ6qOjtdcDc8rNamt9?=
 =?us-ascii?Q?alONGRhUYtRuoXYo+OSGWDMt6HMe6nXfNEtwaCR6stdf1p4tvaLnlU34P4/+?=
 =?us-ascii?Q?AsMWVEqtJDQ4k4JEVjUWL/X4+YezKTd3Gy3IXKMiMTS13Dc7VqQvdvvj2Rf+?=
 =?us-ascii?Q?lPVXZIkAHq1zR7XS3jwALXnYdLq25BTj6E4DlyGDiBuQi9OIetqhWSQdTSzx?=
 =?us-ascii?Q?BcIGJwAWhwrNOTYh46VrNRCtsRQBFv5Dfer7WpHcZPGtLbo2HydN4Ol8m9R1?=
 =?us-ascii?Q?f2QTfX9+md6JVqEvE8w8KCAbrfJw3hiCSAMMjmgWKmg0ufQdZz4UnfAyyW5e?=
 =?us-ascii?Q?omp2BQ7ASZhMA0V1ZmxJkboYcH8r/GrB3OujKfYEHJdGe5HlTxFxt+fzMXos?=
 =?us-ascii?Q?wTYnp9ELCK5sKNDB+SJ54dsYvU4PDrjC4kYedhgGK5JnJVT58AS7JbuunzLz?=
 =?us-ascii?Q?0EPh6xbnAqCp43oFpQ56FYyIt6zIfgCG9jkxi20W0u5BS83WyF6Qt8BEusNt?=
 =?us-ascii?Q?qsCcNH9YdHW4PZM2KW5sQ+FiF6IEEjZBm2+DomR0NdcYIUxten1clu66hp2/?=
 =?us-ascii?Q?Y+ZEwDs8KHEw59Vx4EnClgxczTWxV2OI74fDK6zufyBdgYHgd6FRTOO7uoKD?=
 =?us-ascii?Q?VbpCxrr1O5qEKbGXK+mkBcacMZpbhVaPHoMKFsmAzugpQBeOa1neN3J5rX3t?=
 =?us-ascii?Q?i8b0hW2VgrMnpCfKIyDTLHivPb79HyL0rDHe/Emaeh7oT6+EjtUXc/XGvMt2?=
 =?us-ascii?Q?iB5T7H4ff1GPIAg7pMDEu+9NGUm+RdBKf9iJZpBzP3PxQaR8WzUxMmRHr8OJ?=
 =?us-ascii?Q?wEiafrothEsJw1zmSZtkZ+5gF0r3v9McyMZtseGZTp+VZMUn6BIe1xPwU1/L?=
 =?us-ascii?Q?tFHikjuQX64M+pvtTev3ROm1tEW5/gu8FeE+L2DPkSLOtHgePJ4BcDYvqpjp?=
 =?us-ascii?Q?lN3tPQ9NjyhPwRK2Bc+up2gUA78cEVlnjq7tiL/RieT2ULeVlITxmqUFoYL7?=
 =?us-ascii?Q?rwjvlkZnMflUVLaTO8O9nolIxAKeOxgRA2gX+Tr9wctfF5nuI5JgJJtYfuS+?=
 =?us-ascii?Q?J1f0M+xYYTbS33gMBOjqSYUU?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a9b0d9-a804-4741-8426-08d8d9fcba73
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4849.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 02:17:55.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+VDqc1TtAC6l5+yDXgxbUgh/M7cYPNAlDIiJXcY83jpuf6DWItHcxQtku+CmqYKZPoPEYozf9XtFY3aGPdrTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4555
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meng Li <Meng.Li@windriver.com>

There is a upstream commit cffa4b2122f5("regmap:debugfs:
Fix a memory leak when calling regmap_attach_dev") that
adds a if condition when create name for debugfs_name.
With below function invoking logical, debugfs_name is
freed in regmap_debugfs_exit(), but it is not created again
because of the if condition introduced by above commit.
regmap_reinit_cache()
	regmap_debugfs_exit()
	...
	regmap_debugfs_init()
So, set debugfs_name to NULL after it is freed.

Fixes: cffa4b2122f5("regmap: debugfs: Fix a memory leak when calling regmap_attach_dev")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/base/regmap/regmap-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 398991381e9a..4f2ff1b2b450 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -661,6 +661,7 @@ void regmap_debugfs_exit(struct regmap *map)
 		regmap_debugfs_free_dump_cache(map);
 		mutex_unlock(&map->cache_lock);
 		kfree(map->debugfs_name);
+		map->debugfs_name = NULL;
 	} else {
 		struct regmap_debugfs_node *node, *tmp;
 
-- 
2.17.1

