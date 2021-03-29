Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4229034CC92
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbhC2JEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhC2Ij7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:39:59 -0400
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on0625.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1680AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 01:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRaVM5CPp76wU3QUe6bVeFaU+4t7CPoc5n2Obzx6kdb8QMCaNa9tgIgNwm3qOypg3tYoTFTuLjY2v26J3U78uoy7CQ0TaNaleXDJsdPv+FKsz6Ij3bfuKMZ8hRlfYjGn5BEnVT7qLgTTCJZfWfoxCKSpwcOxljTWIvnxhm15tf9JDzFafitCMd5664NlkqOKuE38bv4iuv5A6ti+wc+Gxip0nhK5cADhPGJhwXBPZKGjjkJ3Wivcc55lv9x5YQ0cipXlr5QZxRWRG5LP6fF14qvWMUAyrPN3IPO+941CwjelTkSFvGU9DjCNkyrw2Qow1yA+x3BgKb/Dc/HNJpIP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEgdNA2NUInjuBAAy1PFLsqRy3o6GhJ2o+3Vx1HOiuo=;
 b=JVNjXFzZLxkxk9Xw7yc3jPwFdoq+Ott7NHfmDLqC7za/I3REH7hD06Bd7XcSdDfVoyMWth5127zlvUm1pmQXENyBCVDog+gamB0gi4RgmmMNbpdrDjhcD5NN7F1aspgnVmZvUvXpPQVwDpmqtAXxM1K3SzZNgbodrBzEaZg2/RAWrQ7+havKjJ0obum9xVEOsvdW2GllKxFe+55uMOafEz2xq4cgwIDgV3qgsIKBJXQnQuQQOck4yR0T0kQdkg8kDq1Ue4h1MST+iwyxmugTQnKRkRFtkoB6OfQGvPf454jdyiQiVjmRb0qZD3zKXc9rJo3oydv9ARtHP66w9OBpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEgdNA2NUInjuBAAy1PFLsqRy3o6GhJ2o+3Vx1HOiuo=;
 b=SJrA8sTDemR2CCViWD3C3+fMdJ9OJll5IKVmRPx3VVopAhqaYLu7MN2VTgyXWuRYtq3I5T4iml+RLrFtiO+vOBYaTUnyeh3zuuYCG1PUtY10+a/pMaXo9THHSKDu3K0Io7IVedsiodrta3mEM+lKZqeaRWIANDa/ssbC/alZD1U=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 08:39:56 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 08:39:56 +0000
From:   qiang.zhang@windriver.com
To:     akpm@linux-foundation.org, glider@google.com,
        gustavoars@kernel.org, vjitta@codeaurora.org,
        vinmenon@codeaurora.org, ylal@codeaurora.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: stackdepot: turn depot_lock spinlock to raw_spinlock
Date:   Mon, 29 Mar 2021 16:40:09 +0800
Message-Id: <20210329084009.27013-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR03CA0058.apcprd03.prod.outlook.com
 (2603:1096:202:17::28) To DM6PR11MB4202.namprd11.prod.outlook.com
 (2603:10b6:5:1df::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK2PR03CA0058.apcprd03.prod.outlook.com (2603:1096:202:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.15 via Frontend Transport; Mon, 29 Mar 2021 08:39:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9f2cbdb-95c7-4301-9de4-08d8f28e3a8e
X-MS-TrafficTypeDiagnostic: DM6PR11MB4723:
X-Microsoft-Antispam-PRVS: <DM6PR11MB4723B743B1E987220BFBEEADFF7E9@DM6PR11MB4723.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hT0A/5VE8AZv2DneJ8BeMxo+BOnqeX6yWyy3R7BhZ8GMfF4OY1VK8qstMIA7LrRU/sZnUVQoSs3gnBSnW688tLcWfuO2+XbFcY44XzeZ9gJZrRvRanLSEG/LXWg733bDNPFagSNz7Ce99HBs71/eR+iTrRfoX+r8mCPzYvFZwNEcsktQDdbJJA9z3vY7e7fjhXaiSx8BW8kmsluJnwltz2R3BSy1usfmLsavboJEAcNHU5T86kuO7mpzwiNlF2dhc3dQihz58aqd5cACQau1rfweNFGpBB5bQiU4ZumGahSejt+1GPim2TZlh9+6e/mgwL2EA+AjLi0uK/BXJ65tzwC3O1DOjZ56zkDDhfMV/gqt0gSjQvKg1xOcKi115gBxhq2UhP8j8DMSoaFRyqQT+NBB9dzuDI19ek2+zPaMl1Flz3Cu+SnUCy0EvTZxicl6p3GjVLkM+4QFJMmD4kYjkI2OOukts7D5BbS8K5r1dEQL3cDUHIJvG+mVUr1s2bCG1ceb6wv/bBFGpf/m2nu5DXNDbbVZsu/jtb/h7Vjk9Ka8NWzGeCtMCheKSJ9MnxO+Ux/Oc4PwzhCqsPFoCcD7ilorLLxrLfxzd0OdGhK8L4YlcxP99rbBzjWJoIY+Bz3oBqx87iU0/+wkLotTFKCeEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(376002)(136003)(396003)(346002)(2616005)(956004)(66946007)(8936002)(83380400001)(66476007)(1076003)(4326008)(66556008)(5660300002)(186003)(6486002)(86362001)(38100700001)(36756003)(6666004)(16526019)(316002)(6506007)(6512007)(2906002)(478600001)(26005)(8676002)(52116002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YJMpxkCpUPxfB4GdAQEHynzqtF2wYm/ROcXYGkyWXrJKE2iMLKL+cFyYJ49x?=
 =?us-ascii?Q?0YgHJuQ8bYlX0mRD85ZW4ldHl7ii+deFpUb1q5TtShAtxcLB/+8cWowRUJB/?=
 =?us-ascii?Q?pJB7MAbVFHyWr66QqbxyXSP/lV1p+3Bay3vRMrmhV5pVGT0tQudoaBGH8byo?=
 =?us-ascii?Q?QEIpY1+ZVt+6pruypZp6OxwYJcFaxASzSsucANtlMbAZeTkE47Ad6N8EbYht?=
 =?us-ascii?Q?1EJSBXbp8JWLINcxEzNVQJmE6pM5bVXiIVBWmUYGThd+n+iQvzWK5ragnkGH?=
 =?us-ascii?Q?jlErG6CFJtvN7jJ7BHtSgbD2IKPFNbne2MimtxGk8dcVx8LnB1PDA7+Xr9TM?=
 =?us-ascii?Q?o50M3AfxoOYd9USLHfKP4nGykjhOT+kZ43Bt4WIZHBRFu2D7c6tKwdmFe5FV?=
 =?us-ascii?Q?PqFez1GtFqhaXM8hWZ8QzXvr+EtMDpEXeM0quWGA1rSpFEmMl9f+lloGPy5f?=
 =?us-ascii?Q?qs4yRHXHDR6bmxc+PzszoeMja64Ijh/YIQGgF0OEF+7oXop5UQUjbb0ShKeW?=
 =?us-ascii?Q?FBx74IIyM9Gp6jnDQ8KnyXYbUyNwcDPlREu/9J9CKSA6bvU3YPzI9ze0GdI8?=
 =?us-ascii?Q?HrZVCo4wceFvCSXT1EHqKxSgBvO/1/K7XvE6D40qVMZbTY4Zcoah2Tkiv8LI?=
 =?us-ascii?Q?a8XYY1qyHdMNzYjbL3NcKHWAyOaOcu2DnNIxVp95XWore15UJfYnMjgFLysM?=
 =?us-ascii?Q?ucZ3O9TqntjiPM8EdaSH07u8w3y93g1/mqX/lcLfTRxwdExbr4kFN8+bdgWq?=
 =?us-ascii?Q?ZkihE4bYYXMpyXblCUqMWV0KV622BfBEbC868YWYgbcSOPL0334QKOI42NHt?=
 =?us-ascii?Q?6lMl3vht9Al2dU4oJgPFVGn6ecjhspeNZhE5LMGp0TwkE8ROchvjVqWeyNQ/?=
 =?us-ascii?Q?FEg3pdFabcjP4FNl+kdSdYysgRVkDArdbR3hUxqs5XdK4Bz8dQr/gV1ij22V?=
 =?us-ascii?Q?VM2oIQY7qUYSQo7Y2Ts7GaHEgso5EwaiyB/DBRIPdMhVkHwUQ5eRzgkXKZz7?=
 =?us-ascii?Q?iog5PtbWlyfremac8hGWhxBM+Nzd/HvsJTmxVifyvE8dGa1q9K0kOyODLT5i?=
 =?us-ascii?Q?h1o3PkKzwTGy8sCquSaoXlfHsktzplRwYdqj4HlaAZbQFKQMMzMrEC6sDObE?=
 =?us-ascii?Q?vKj81zM/zMjo76UH6MJ7Bd1xVpROCF45kTQDzkKUyLIh5wbxiKvzoi1rH+/a?=
 =?us-ascii?Q?q6Dysh6FDKFm7YcMbHlVhQ0awj3WtenPyg565WmLDq4ItFTXYJPq5bAjav29?=
 =?us-ascii?Q?2ke4Bjmi1EnnN7Vsy1ds/xZSzFU2yYXdnv4yp5/eqqNrLRWBnDZM4U15NdC4?=
 =?us-ascii?Q?CIrn3n44zjSG48M4ULR/NJQg?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f2cbdb-95c7-4301-9de4-08d8f28e3a8e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 08:39:56.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdR3GeVO1lKJ9r4QnJt2S35mBivOfcOleY/cJw4paDWwOo0z5Xhqdn1/hwhl2Lv6HvEeMJgyGg6CwaJd/rEgy6y9r9LgaX9LZnlYA7n0wQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

[    2.670635] BUG: sleeping function called from invalid context
at kernel/locking/rtmutex.c:951
[    2.670638] in_atomic(): 0, irqs_disabled(): 1, non_block: 0,
pid: 19, name: pgdatinit0
[    2.670768] Call Trace:
[    2.670800]  dump_stack+0x93/0xc2
[    2.670826]  ___might_sleep.cold+0x1b2/0x1f1
[    2.670838]  rt_spin_lock+0x3b/0xb0
[    2.670838]  stack_depot_save+0x1b9/0x440
[    2.670838]  kasan_save_stack+0x32/0x40
[    2.670838]  kasan_record_aux_stack+0xa5/0xb0
[    2.670838]  __call_rcu+0x117/0x880
[    2.670838]  __exit_signal+0xafb/0x1180
[    2.670838]  release_task+0x1d6/0x480
[    2.670838]  exit_notify+0x303/0x750
[    2.670838]  do_exit+0x678/0xcf0
[    2.670838]  kthread+0x364/0x4f0
[    2.670838]  ret_from_fork+0x22/0x30

In RT system, the spin_lock will be replaced by sleepable
rt_mutex lock, in __call_rcu(), disable interrupts before
calling kasan_record_aux_stack(), will trigger above calltrace,
replace spinlock with raw_spinlock.

Reported-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 lib/stackdepot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 49f67a0c6e5d..df9179f4f441 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -71,7 +71,7 @@ static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
 static int depot_index;
 static int next_slab_inited;
 static size_t depot_offset;
-static DEFINE_SPINLOCK(depot_lock);
+static DEFINE_RAW_SPINLOCK(depot_lock);
 
 static bool init_stack_slab(void **prealloc)
 {
@@ -305,7 +305,7 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 			prealloc = page_address(page);
 	}
 
-	spin_lock_irqsave(&depot_lock, flags);
+	raw_spin_lock_irqsave(&depot_lock, flags);
 
 	found = find_stack(*bucket, entries, nr_entries, hash);
 	if (!found) {
@@ -329,7 +329,7 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 		WARN_ON(!init_stack_slab(&prealloc));
 	}
 
-	spin_unlock_irqrestore(&depot_lock, flags);
+	raw_spin_unlock_irqrestore(&depot_lock, flags);
 exit:
 	if (prealloc) {
 		/* Nobody used this memory, ok to free it. */
-- 
2.17.1

