Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A949B35BAF2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbhDLHkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:40:22 -0400
Received: from mail-eopbgr1320123.outbound.protection.outlook.com ([40.107.132.123]:63568
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236781AbhDLHkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:40:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZldjMBxX3p56NFo7J3jewB3wAR7XHamvpccu6JlBJDUtEvqkZz/ZQbGY1v1HLvOma0xNqFkkf38qmx9Hxv3CiLixxtQLAVT/9SGijc+54xmQG8Tm7RWt4d88XQQ17eVGuKgNilFFG0CiwYPgpd9+v98QG8Wed8BlUZiiov8fiKh4wY67Alfvg95nSlXZrZX8Hg/nkQe2H2Bt70N8uuSJXFSrKcNMR4rLyJIL2RMZ+OqKG7GjPA6J97jQsLSksEHNGPy7siipZJxBbr6YCq+advoj/dV8dixBNfs1WuuaxHZlm8APloN6Ar0QEt2XkJKzSbneR/WIXa21uuf1jQwxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMlnVTV6YF9wrrCxSWuGpHw7kjqRQGKY615UXe3kvNs=;
 b=Id82elAgkNCg64naFncrOymsALy5iw4sQ2KnxMm+bRXkLAGLhdzT6cbS8B4da55KGMyXx4/V2J6ifBD08WM3by69gzQOWXlJjONGXgNU8ZqIVGrhCVBM1CZ6CfswKRCmw0RlqEQDKoSmck53WhBBj4F03dSg0+jIm2YqwfDXoD6zChbNOGixCW7FQeDWA03ZhSNc/vy9rh/dpcxTQVxUJgVeufoOz2bjIRLoQOeTM+nKJX8BgJQAiKqCoxxhI/grPJPQrrDOYX/RqGN2RaReEYisXRXToEs1b6h+7HIpqjViM++1SK6P+m8GvmSkVFHd7WeggJAFe/yexgC9Msjckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeku.com; dmarc=pass action=none header.from=zeku.com;
 dkim=pass header.d=zeku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMlnVTV6YF9wrrCxSWuGpHw7kjqRQGKY615UXe3kvNs=;
 b=Wbo5m2Yygqn3k4+TX2g8tiqgM2ODYoSuGlbB7MStVZjKMBR69Z7XtE6lL8n2Dj11hKDXtAtQXs3NER5/5n4cZSyBdvV9YKMwhsKRX9A5kqRcUoK8rzXYD2NeLr4IC84DVCDtxTFsfwy0upyyq0fQ6/PmzKLjcZb6FZqalaC13jalbZqa+u1hlvEJT95BveBW+LYEJF6k71oO2Z/T8n4ZevkkUiKyCSI+1rdgumTV8I8djDRaXAAZaxponxj+8mtIHyarINfsTyHbN2PlAiP/YdeaTYLMH1ypynGEI6LBwKgmNLFypOna8uxWQFh5xxFLuVTiv5Cnh5vtOZt2WpLd2g==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=zeku.com;
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com (2603:1096:820:5a::11)
 by KL1PR02MB4707.apcprd02.prod.outlook.com (2603:1096:820:39::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 07:39:58 +0000
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::a855:85ac:f58b:5769]) by KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::a855:85ac:f58b:5769%4]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 07:39:58 +0000
From:   Hui Su <suhui@zeku.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     Hui Su <suhui@zeku.com>
Subject: [PATCH] sched: remove the redundant comments
Date:   Mon, 12 Apr 2021 15:39:28 +0800
Message-Id: <20210412073928.1120823-1-suhui@zeku.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.103]
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To KL1PR02MB4788.apcprd02.prod.outlook.com
 (2603:1096:820:5a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.103) by HK0PR03CA0115.apcprd03.prod.outlook.com (2603:1096:203:b0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 07:39:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbaef2d1-f4cd-45c2-6a4f-08d8fd862c2f
X-MS-TrafficTypeDiagnostic: KL1PR02MB4707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <KL1PR02MB4707B79AEA3EEE3796B0B40CC6709@KL1PR02MB4707.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAuzVw0xoxS3J4cfbXLJIHomFOtIbfeO3vqg2S3G4ikEFWAddxXpy7fCNlheD+woc3/sV5SsveXm9Oa3FUF1J+by4Z6DOKmXEqTYKDdqYEhYB6loFeQ+4+GhZziv83KpqzLzsNXGb61f/OmwLYMTTTDhK8bitzLfohIrmtkUAAWQKqMxuZXTZXWxyDsXy1F3AzEm3g6EhNs45xvxTjxGPCox0mJWSf+aiQl1yXDRf2GHTNYzbtRF9j/l3noah23uNcCBy60D/FetNynEva5uj9mojeZzaekwNTpHoSr/5BoGFCdxBWlCq9lZbKkysCyn1HWeeGI4PtR8ydrcouEjzjXL1AR12fYAYOzCQpLi/CfFOAkbQtEl4hTfzNs3zdAC09ouXWYt6kxGemo66O1bFpYNiabnMqakK/lEpF7q8JpBgT91/I0AkLtbCLaWmW7QpvKewZ2D9h8nERQYvafx2irQnmy8vc8hsW1wPM+2Aasqn6UKU+k7BVifPM94nwUsQBtF7O3GWhu0BqzhyWhjAstWQNg/j0ijsu4JCmU5jT+sAtRhIWTb7udQQNpO9B1oTm9LiRzDxPs3lGk2KHNH6HMfHaP2xj/j609qUe+YCZcf078qS9zdS3eHYWs4pE6QKJd9UoVqYDRWPizWwWW4IDpuKxH24duSJH+4SuuhrdmquJOeuf5ccw+SEA9LtL+WS0R/3cKX6KNEnv9R5gHnvmPT7KFM48YoET/Cfk1ks+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB4788.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39850400004)(136003)(396003)(921005)(66946007)(478600001)(66476007)(107886003)(6506007)(38350700002)(66556008)(4744005)(7416002)(316002)(2906002)(6666004)(8936002)(5660300002)(8676002)(36756003)(86362001)(956004)(83380400001)(1076003)(2616005)(38100700002)(6486002)(69590400012)(6512007)(186003)(4326008)(16526019)(52116002)(26005)(11606007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?boBOdXmod2jN04DdxMi1++OJ1KhwuqCTJ9HpwTtNG5zseL2Hm0Nbm4GtyH/5?=
 =?us-ascii?Q?Qd9pPyeumWzNeEdGSppBFkKti58cds0sIvexPa16h+/YlgyTb+uKCiUql3MG?=
 =?us-ascii?Q?uOO5feTnRK1tigNriXpNtPMTQJkewCpluVq9buW+iiiHx5zNHLZSm9NduQN1?=
 =?us-ascii?Q?83A6CmtXakwg3eusAf/Kv8LwVOglbHtLJr5xmlvSzSmuvTGqnagGYBz+ZiQP?=
 =?us-ascii?Q?j1QbZ+a/dpfGK92hjpVkDwzdO8mbkjsV+5BIshbL2+n13feX2bT7TazOtqmP?=
 =?us-ascii?Q?4Gi6YP0YBER2biQBarUocJq4koExZWJhpspS0XSpBhyGQCOiRKiMM9rFQ0Zb?=
 =?us-ascii?Q?MRjDWRQQHXpJBQPYbTFxHZy9jpOkiTlHuuczVXQWe0IRKoCX50hj/bwBO/tT?=
 =?us-ascii?Q?N/QN5egzYpNWF3tLQQD5uwj57GoeZyM5Rmho3QDexsclYYgbBn4+YDrwxicP?=
 =?us-ascii?Q?ARjvVtquESl6xFINzWfRPQP4oN2BwlmUjZzyFMbfoeIatfyyfsWvpwfVZe6b?=
 =?us-ascii?Q?KAYGQA1CcH25c4dTWpALu0pRP2ZTJ63GP/Riwp3R4SWWcXEUyWFqpoorzU+U?=
 =?us-ascii?Q?iaizUm2kSLyH+oZi3EsMPG1bFRLoSplvKvHysrhJbIbHlx1+wa/uk2rqgZcH?=
 =?us-ascii?Q?MDjj9l6cCaFe/GOXSKgCeZ0ykAunjl+bHyRL+mOB595prUNp0iRCD1cAgYG8?=
 =?us-ascii?Q?l10OYIcOAtj9+fPHg1x6V8wVt7HJ2VBCTSW6wi9rLnVx6VHabanqmhb7oMM+?=
 =?us-ascii?Q?CUOF3xfSp0158bayIJbbLgF8z7K/mkjyk9VdK8uJrCVpKxoNMZFsz3OM6iuD?=
 =?us-ascii?Q?seGD/p+kOOng4dRP5IoSP/cQR27uj/8xeuTJrQuRNuhUhBOWBmAuRJ3tb/Vg?=
 =?us-ascii?Q?X2RLpPaPIKqYj+UnbhRvlFR/UNR+Tld58Bx0XyJ2eZGwkamXmwumYe2bpIbQ?=
 =?us-ascii?Q?zjmvzWf59SUaUWhfq0T6VBgIwC1dTwslnz87H8CoCnjbmdsLWM2EweM+pAs5?=
 =?us-ascii?Q?s3sl+vOS8d085BgHF+WCYv1bJW7qIpYqHGbcZiLrjdbgtub44nXM3WJsOhZL?=
 =?us-ascii?Q?kDJMdK4tyUt9bd/zqEN+mInBI6s+FgCJz8SMe/+v8dKZ2pV9h6aeRQ93vLEm?=
 =?us-ascii?Q?sK5ROEurNWbBihgE0v9dGa3tIfBHtFWNOF1phtdOaVskEfrWHy1zWmSoEjXE?=
 =?us-ascii?Q?qHjTXuREkmkRyLwn38nEJ+/a+PxwwC/slq3vFBTznbXgQsksMgHnIHFhe5gh?=
 =?us-ascii?Q?vCxbrrgQRk/jCy1HFymoVvKcfuOfbJC1q+IUAP63Y3BpJz+Oo0swGlTwTkMY?=
 =?us-ascii?Q?fzVK0wYk7wHXzKgb4gfyVAWK?=
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbaef2d1-f4cd-45c2-6a4f-08d8fd862c2f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4788.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 07:39:58.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98DGIHFwGZwGNiy2uO5t3Nkqsz+VbGNVVCRFzD2Vy/RwD7Q9k1Qaeb9rBMy156CV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB4707
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 55627e3cd22c ("sched/core: Remove rq->cpu_load[]"),
we don't need this any more.

Signed-off-by: Hui Su <suhui@zeku.com>
---
 kernel/sched/sched.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..2232022d8561 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -897,11 +897,6 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
 struct rq {
 	/* runqueue lock: */
 	raw_spinlock_t		lock;
-
-	/*
-	 * nr_running and cpu_load should be in the same cacheline because
-	 * remote CPUs use both these fields when doing load calculation.
-	 */
 	unsigned int		nr_running;
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
-- 
2.25.1

