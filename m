Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55193E0E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 08:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhHEGjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 02:39:20 -0400
Received: from mail-eopbgr1310138.outbound.protection.outlook.com ([40.107.131.138]:59392
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230183AbhHEGjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:39:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne0YZlImbVocUhSS/mL/QkMFrXJhd0odAV7qzrtX1XJI0WOB+op0ayyR9AeZbNiBIurxxxVN/hzMtKEYDKKWKyIhcTypYvLiVVYu9hL46mM9f5342M8QV2oTyNKE5RYUc8QV6ju+KkrPnb7uvM0hfd5rusEJ1p/BB9NiAm74hY2i+GumVfLL3u9mNVuPCZpyydQ6wTSlc+5uq3RlxsGk0ISpthbN6InXeUfpRDZvXeP5E6avIHVEkOgk5Gz3BZREy60czCZaR2J88+MOUM4bh+LTqWphdHsTaU3GJB3LCQF5HjqaTr9H91Hm+ZwDWN0ro6BPVfMw2evo081BPKJsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQPIktSbJ2X8FaFVAuAix71n5zAUPKwrmNlYYTCPOhw=;
 b=ZXuonecxYeZoKfUFLjfgBr48ogIuVpV1qCoRe/lRxKmTZiTE3uUc0IZ5YEYY5KuZ791m6+CluxLv23CkGlBvWeKawb5AqiLB+54Z4Hz0kqlisA+isljnotHqDAXLNJ4EZ7v4qdoqioz72F8bE5W26f7GbyDNmaTTTYxtKuW4jBxBYiB31pyCohemF9cfAV5Wp7YgiRyjbAVYi/V62SI9Mj2JZ4rdMtcr2SCG5jFcWMXE+z2/ZOVf2Zkloww1ci1hXVunzreJjKq/Zjd8BE1U9VEhKAVyN+1jlLkt5kYoMGhK72ESOj/a+kDsK6/+y47N0YglGM/bANbXVuzLpA8ulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeku.com; dmarc=pass action=none header.from=zeku.com;
 dkim=pass header.d=zeku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQPIktSbJ2X8FaFVAuAix71n5zAUPKwrmNlYYTCPOhw=;
 b=AeL1evHxHB5WI8sQOuGI6RqgZFltR0lrOEBdS7roL7azKTa6BaSe3XM4FgspXhk3hk2TwcEO/gF7BZrHK6VFlaHeD07+g+4Q4ZXgP/P8OKpOKmLGK9U58wQRLdegUmwtzHnliehI6n+YykD3189wiIAqyFF6zabDCqZR335OXooPc2KLIPdCpo6sb8KUehkO/EQ8YR9MPzqPjVIseMg1EbL3cpp/PPGuOT6NingKT6zGnYCn64hssiRzd1CwAtC/cYGeLQS1FLpDHfiSJNqu4QDmK5ZG6coZuyiADGhSP05K+3xkdvktoVoWz/eTwobn2niF4LNsAekA2PiGIdb0GQ==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=zeku.com;
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com (2603:1096:820:5a::11)
 by KL1PR02MB4739.apcprd02.prod.outlook.com (2603:1096:820:54::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 06:39:02 +0000
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::c93f:f5ca:e24a:cdc6]) by KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::c93f:f5ca:e24a:cdc6%4]) with mapi id 15.20.4394.017; Thu, 5 Aug 2021
 06:39:02 +0000
From:   Hui Su <suhui@zeku.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     Hui Su <suhui@zeku.com>
Subject: [PATCH] sched/core_sched.c: remove some unused func declarations
Date:   Thu,  5 Aug 2021 14:38:52 +0800
Message-Id: <20210805063852.304-1-suhui@zeku.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:203:b0::16) To KL1PR02MB4788.apcprd02.prod.outlook.com
 (2603:1096:820:5a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from N50001309.adc.com (58.255.79.106) by HK0PR03CA0100.apcprd03.prod.outlook.com (2603:1096:203:b0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 06:39:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10c3afc2-969e-4031-8148-08d957dbb6db
X-MS-TrafficTypeDiagnostic: KL1PR02MB4739:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <KL1PR02MB47398EBE487CE84D79BF0A61C6F29@KL1PR02MB4739.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MuthbRULXXYsAgmiB7D7DZY69UVUwZUIx/Mb9gYArtAcq9sjW5rEMAm5XFQe6c+T2Mbjoghjb/U8PA5mFhCmSBzDpCnKYsl1uOhl6+Mc3X3rVRZtiwKY/OaO/VdFVFcwoKOxssxkqeeXhqm0hv9qRPa1JIAJx2ISPjCxlgGGj4yntB5kE6Zh99y1S/Bpo5hbJL9eIdlrXXRtP0uTdgtJWRM7KlH4dRS/ECu1JfNxfSIzWw2iDdos2rEf1SGmPlIc3/YWMRdIuzdEm17LYDIQ5UuR4TotVe/GnktvoCBshyXxT5PxHRounJzm8CDTpJ4BXdlwSy/UCd/UXpiMDnhZ6nlZsldMDXkx2ak4Aqap7Mp6A/p0nsLPSiUaLaop9ySnhlLAqVFPqzx8+ovhpzuWtd51ClMducbGK/KVZwsfe7ldGrxd/upJ3nb+BLHbb6/zIkaXO/VIg6r/mhaonDoANfjTwy9vs/CeZqsq8qeXStdky5tfrZjvNMkZYLmyabegQq38SNLbP6VOxxfVN+UEsktk+YdwQfMrbVxa1uyYLc3P8pR0UxjxSx7x2RdgeOpmAPhZ8KPT0GoX3GFHjctTttH7uHgB39zSewwVoGv1WtGxibeIkslMq7V8t392nTcAR2J8gFWhmDh4OrqGN5sGxU2QtMbjBeaSwV2MrQoYQM/IWXwT+TGvms0nYm5fqPnA4fV2OPpTfB9e24oahMIsS3SEzbmHXjfOiBQuAucMwyNVqXO7Mj8OteF4jxkWRgQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB4788.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(7416002)(6512007)(921005)(107886003)(316002)(36756003)(8676002)(8936002)(6486002)(52116002)(86362001)(6506007)(4326008)(38100700002)(38350700002)(2616005)(956004)(6666004)(5660300002)(83380400001)(26005)(2906002)(66476007)(186003)(66556008)(66946007)(1076003)(11606007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tzkTYt6dfXD6VkESmJSExc/vQw1CgWEBF37xb0KtF0ihTulMp+AgspXgBsJI?=
 =?us-ascii?Q?DxZfj5aeH/WkEYycuhk4fbzKimKwFYUWbJIJ3UnuTi24fNLf6gBgJDpqevH0?=
 =?us-ascii?Q?ZSgjtw1i7r0NhhWtRzu+bgjp2an9W8/OlOnrzlL88WOOml7y2ryAGg/e8yKD?=
 =?us-ascii?Q?4/ptdTqKwqJ8EmUzB0We6MhdpMbHGWJ90W7cvGwNbHCda6R3+w+VTTyVJ4GQ?=
 =?us-ascii?Q?+N34T1QuJEMBM3fvpTqb5hY449t4z9B/9dLELLTGKnmw9IwhdmPFjOsUNakN?=
 =?us-ascii?Q?wF3tnVncg1G2NTnsTii9z4VIr5Hw2Vsso28w/a9PoeNNw0O7AFT65NdMsxsL?=
 =?us-ascii?Q?Bk0KmUwC4BaTLk9rbfU65gxDT7hdISc2cmfgcCSQo7d/q1wVYdy5LdYgHxNs?=
 =?us-ascii?Q?BjZA9vrKJVnMWyoCjwi5mO+wh4PDLtq5y2ZZ7k/RCCVd+S4fIz6BaRga/rst?=
 =?us-ascii?Q?THkaDjtIf7dhpoLp0gOKB5RgIVRoob5OCO8uvNOmHGfQISSnBbPlVREBflnW?=
 =?us-ascii?Q?fIfbfXcSAWEdCf9ohFcyEq1grSVUJi2Fejj+tIAVvs5SPTt6EzvgL9Jd7/03?=
 =?us-ascii?Q?BR7o1WJM6/rUg2704zxvMXvtu0tdq5L2LJuBB1oSDp5mDCCN0J/keMcoizWm?=
 =?us-ascii?Q?mm3y4oHCjfY3b6mQCjqOo9BaHoZZf0PIes9WFKewtAPFoT4+xzGimF1Xu3SE?=
 =?us-ascii?Q?imiUTv+dUt9yN5upjWSWy/GbeCvyB7nrJ/bvlZMXW7g0K8F7/rKMw2LyFBl/?=
 =?us-ascii?Q?XEfja1cZGALMvbSDcnZaQXd/UJxCVzoAGsxkoV6vgeeJwfPcRJxb8GzJrd7z?=
 =?us-ascii?Q?7Jz2uTNpdGiRMgDgTOkTfbWG+LdYGYMPSFI4VPTCfJLv0zbBItHjSiXZYWFp?=
 =?us-ascii?Q?pg55eG7vv1upajVFXzQGWSTOC0z/coOk7YG5W0+pUSBUZrqzMrSu2wJYjs9B?=
 =?us-ascii?Q?MAAtedyHv22+2jzqOUAOTqLl6pcMfgqHbRO8iCdlr8srG4CLNU896yKy5oOb?=
 =?us-ascii?Q?JFgxpTLDX7L1u8d4oOcjuJfZVZkP36X+E0uK4JdcN+v3khBAZe1WmEyWKkli?=
 =?us-ascii?Q?AORXg0vPNFBicmt81Gv5S9+9DVzTjNgqz96kZ4tmjOJaDNAaXM1fVXEH+brd?=
 =?us-ascii?Q?H11vOTGLqPMNVlXK1ZPrdA36mNVIXC+TdFr8yYyd/0oeiE3u9MKVui0xexJL?=
 =?us-ascii?Q?49XUcyMx9qbZi+2Q3fN7BAONfW416TKriAyAABoGaNkPMvgKnMvJR+BCsMEM?=
 =?us-ascii?Q?g95GobwVE68MSin7DF5K7jLFot5TN8dG7v9JS9K4btQBmHSYMTkKwMM3eT5e?=
 =?us-ascii?Q?7LUezX44tzZP5wtreC3daja6?=
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c3afc2-969e-4031-8148-08d957dbb6db
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4788.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 06:39:02.8591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cv5OvUuQ82ANF8ZVu89F7IGWstmnt8kT2bf31Fhk7NSKx/tJe/PjXl9kwF0oaGiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB4739
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove some unused func declarations and make
the definitions static

Signed-off-by: Hui Su <suhui@zeku.com>
---
 kernel/sched/core_sched.c | 9 ++++-----
 kernel/sched/sched.h      | 5 -----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 9a80e9a474c0..3ddfed5231c8 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -11,7 +11,7 @@ struct sched_core_cookie {
 	refcount_t refcnt;
 };
 
-unsigned long sched_core_alloc_cookie(void)
+static unsigned long sched_core_alloc_cookie(void)
 {
 	struct sched_core_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
 	if (!ck)
@@ -23,7 +23,7 @@ unsigned long sched_core_alloc_cookie(void)
 	return (unsigned long)ck;
 }
 
-void sched_core_put_cookie(unsigned long cookie)
+static void sched_core_put_cookie(unsigned long cookie)
 {
 	struct sched_core_cookie *ptr = (void *)cookie;
 
@@ -33,7 +33,7 @@ void sched_core_put_cookie(unsigned long cookie)
 	}
 }
 
-unsigned long sched_core_get_cookie(unsigned long cookie)
+static unsigned long sched_core_get_cookie(unsigned long cookie)
 {
 	struct sched_core_cookie *ptr = (void *)cookie;
 
@@ -53,7 +53,7 @@ unsigned long sched_core_get_cookie(unsigned long cookie)
  *
  * Returns: the old cookie
  */
-unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie)
+static unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie)
 {
 	unsigned long old_cookie;
 	struct rq_flags rf;
@@ -226,4 +226,3 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 	put_task_struct(task);
 	return err;
 }
-
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14a41a243f7b..69b5da925da3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1244,11 +1244,6 @@ extern void sched_core_dequeue(struct rq *rq, struct task_struct *p);
 extern void sched_core_get(void);
 extern void sched_core_put(void);
 
-extern unsigned long sched_core_alloc_cookie(void);
-extern void sched_core_put_cookie(unsigned long cookie);
-extern unsigned long sched_core_get_cookie(unsigned long cookie);
-extern unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie);
-
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
-- 
2.30.2

