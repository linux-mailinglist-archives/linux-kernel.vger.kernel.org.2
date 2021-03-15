Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF6933AC73
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 08:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhCOHpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 03:45:09 -0400
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:42721
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230173AbhCOHpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:45:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL5qqJd7o116MvmeVIld4AbfLZupu0d/G2F3NXJcACXOEeLNmv1v+QWBDDJVK7UpSxEGzy0hSoENVbenWBsnb/jtUwzhbH/zfCAljvO2W1oAfk2+OzVHrQCEIYu9eS70vrBswaq1Hc2+H3DuhmaIkw3iHh22S+6ZOyE1q7Cq9Uq4AAR+s2WjeqFS0RhV69S3PkJiqVKqf7jQpeX1+jM+SDznbnA1ShDqjOKKJ71tj9OdJAE1Ko2b9VeoTDIzNOZ9ow467YWlIISBCApM5tSerm8i3QimImeDEwXD64jyC4AsuykcGewYvQ+A386WweKE9r08WdekKrUn9NwWeJPPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTGylOPk+tGg2gbDbNmR+uGjptsFvOjaHO4tac6N4JI=;
 b=mPn+kbsSTkqe7EHpQrH6/t6gL3adXgN+Kb0dwHBH/+9xScOc4PX9cRsXB+zzOnSBK/feObHiDptVU95eShL4mZGe1UlYyX86k6PwKqBagMMWNiEdJ61+3DcKdadWyAG4poEQomUbWeb6UQ/g9cQmBJs6AXFhD5EpKsWUNGZjBVeT6MYZzPN45VWhVoS0r4S62mmHkh5T7VSliKy7Idl3JRHNTmRbLlh/z1pUi1kcc3ufPFdArJRqFdOFsmNA1J0NooeTCF8aemCgjPO5VatwCppZLJX6SaerwQrKpd5le3BnBKWasw+mhxwK+nFSG3KVrcxoZD/XSPhYFAe6ZIFZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTGylOPk+tGg2gbDbNmR+uGjptsFvOjaHO4tac6N4JI=;
 b=jAA/0q44v4xghiQJpyXjoG1CvGxTAbqJfHsGM+O9u1mcUxxt557PhzDKru0DKx1y2QReBJrXT1vkBvXZVLDiJC1g5lqz4p+zqsBkapKffFj4zmTtJud5NVVN/TaPTMOqZihWM/k0MGEB7mYJ+sGT8EFEyVAGz/FNFa1y2iIAfDE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB3973.namprd11.prod.outlook.com (2603:10b6:a03:185::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 07:45:03 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3890.042; Mon, 15 Mar 2021
 07:45:03 +0000
From:   qiang.zhang@windriver.com
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     dvyukov@google.com, linux-kernel@vger.kernel.org,
        syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com
Subject: [PATCH] bpf: Fix memory leak in copy_process()
Date:   Mon, 15 Mar 2021 15:49:50 +0800
Message-Id: <20210315074950.10859-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1-vm1.wrs.com (60.247.85.82) by HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.9 via Frontend Transport; Mon, 15 Mar 2021 07:45:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29f59606-8b02-427a-d804-08d8e7863e5b
X-MS-TrafficTypeDiagnostic: BY5PR11MB3973:
X-Microsoft-Antispam-PRVS: <BY5PR11MB3973CF80DFCCBBC5E86B40E6FF6C9@BY5PR11MB3973.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpQRffJu76kxYyN1SQS0oaTuv2YdFJMgLXg+fLtbSWREg68UHfurRc57YtUtwdPakEalJlWsaStnnkkS1CixG455ngIxHc1FJCSu7rJVepqW4yZT1r9Ee2wpKiP0K/8zSGI6Gj+ZJ4to5fJFqt+ZichpVRgP+9AlJSnrLebG+HGwZNGD3SGDc78Lt+WzYtv+W0Sc1MlacZx5U1IB3dOg7f3LKw82Xtxu0cYdvCfpBoZP0dfMslQ5cZR2x2+GZbc6v4Q0iH9h10Mu0rkbigaTTblrVfDT92zfGN6ZSn0cm8z41VXFVqmaPKwRAw3Yp+/a7P12lYMg5SEFseluhujOupuEHvndR756NUJTlHSwQeRO3iMBBq48nJkrTYuenop7B48jrt3y7BuV8QVw6NAnNfbeBAjeETmbtq3R/jtv3lkbl3adaMnNGg1cVpWkA3VTUACfrt+0GOaKB9U75N9Ru6xiOYuFGfNeLiDWJjGoOR9dBCSHbX/1I0BA1iQDmoxOLM8vDaRZ04Yo1sw3F/6z2o34foGBZ1zPDhn51UJmpOJ/s8DV13VuWhEOUWQ27O4h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(366004)(136003)(346002)(396003)(478600001)(66556008)(2906002)(186003)(66476007)(66946007)(6486002)(2616005)(16526019)(8936002)(5660300002)(8676002)(6506007)(316002)(26005)(83380400001)(4326008)(86362001)(52116002)(6512007)(956004)(9686003)(36756003)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1pwZ2xP2za+B40lBWKsUA10RQSZKMLPpJdz9K06eAk61ZlWb5Z1dHaOJSw8y?=
 =?us-ascii?Q?zUejV65eJQr1OfgfybgaoPm91oKoauqPMJLlaclXaGjPSrajEcDVcZRBtD4f?=
 =?us-ascii?Q?IGwhMZCCOeEcYn5U1W+eWJS5FT6IHdZtwpCKZ9Zq8gxAJDU3tYlNk7wiwyqo?=
 =?us-ascii?Q?FvdFTpaZf0QxGfD79i3fz/kSikvndTeVe1hUDoEiyiOn0rKqPzbvir+JpbYH?=
 =?us-ascii?Q?9VhdHXzIROtC0DWig9QTkuiFszuZR0cZAHbSvtUKwCQrTnpm0vMsA8oMw6p7?=
 =?us-ascii?Q?2mTSIs048iUik/t+l32ydedj0Lg1NK/QaSNFLmNQWrIbsAB+QLP0ycKzaVwW?=
 =?us-ascii?Q?55sEyRaokmh+MsVLqJ7H+7FX+ZagmQU/aG0Dt1rxY5KBfdvtOuojguUVT1fc?=
 =?us-ascii?Q?5KBoqyZsgB53Bbz3qGgagAyPESOkiOGAfwdHuTSPy/tMf5kzuc6E/75Q9JPT?=
 =?us-ascii?Q?JdCL6pGv1NoA/YtqvYTw2p/AI9xbw2qdDxH4ipiKQjKT2GNYedRgbKkJzXf7?=
 =?us-ascii?Q?y918dynlcpj0h53T0mQYXFA7TtvA4F7r7N8nLSH47mSo/bRpSH8qdDvZ27mB?=
 =?us-ascii?Q?5atWDSW0A8XQYkd582VFSpTg0AVwH5VqGBcW2+Iiigdm/sbzpj3YiDrxCj+Z?=
 =?us-ascii?Q?CjEC/KlPrWCphQc3iBH0vbBe31lzimW/0q3tTxyCqmFlZDWt+A7ozbyjKwAO?=
 =?us-ascii?Q?KtvtuhrP3kQzUJnpRS8FVvexbs23UuNOQcjIn93Sh7GJnrkez8Zxi4PcTejN?=
 =?us-ascii?Q?yHL5LmNSrRKTkDPep9W321to6uRYzjNySnoM3TSTUy5NBALpAqhLd9CO8xWJ?=
 =?us-ascii?Q?E48zEn9BmbKjHYkw9TYI3A92Qkjj3pHkgHyBz8iYG9W3/IqduiMmLOVO+1Xl?=
 =?us-ascii?Q?5ZcHHd26/ltrSdEr9l8DZUQentZDwYizV8fWG4z+eqR+EiKZEB4mGfkv2/FQ?=
 =?us-ascii?Q?K5815GHgNfs3xCfHqTKJIOCG8Pp6kJFfLzVEarVvn/Yim9FQ01bffspwWLTl?=
 =?us-ascii?Q?0vHCKdQzESyp2huUk9yqZs5DqMyFmbICtCMUZLx87QWoC/ZU6b3j2UJHUGpb?=
 =?us-ascii?Q?0fdjtjtnDBzXTqly7dqwMqtIld5GvkiIoFg1mLtLdqPb6AJt4NAWA9Gz5Ce4?=
 =?us-ascii?Q?YudBNhRGZSS0IQe0JZb7L4cXkiWcr7LDiM9Sly3ZQ/aqbqzg6AdRhDT5E/6h?=
 =?us-ascii?Q?y1MV0Il3YLKKdTSky2d2gTm6dHLBXqUYsBaxto3jCVfXNW0Ih1P0+yi2YW5s?=
 =?us-ascii?Q?u1qqYfXQ8mvcRrYHPsd+S9LMP8RPinF+JiG9soN9pqHbY41oYjXivaXEBjYj?=
 =?us-ascii?Q?r2M89Qp0PS+ujPhi/kFyBPkJ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f59606-8b02-427a-d804-08d8e7863e5b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 07:45:03.3434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8+dMow4ggiSIXQPGWqQBLgzmw5peTJ43w1xmzgQHKooAEODBpvyqywgp07JvGbZsTk8ZMyF4wVA9Iqcq71hnrlh45l5CB3tQ1861q6/az4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3973
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

The syzbot report a memleak follow:
BUG: memory leak
unreferenced object 0xffff888101b41d00 (size 120):
  comm "kworker/u4:0", pid 8, jiffies 4294944270 (age 12.780s)
  backtrace:
    [<ffffffff8125dc56>] alloc_pid+0x66/0x560
    [<ffffffff81226405>] copy_process+0x1465/0x25e0
    [<ffffffff81227943>] kernel_clone+0xf3/0x670
    [<ffffffff812281a1>] kernel_thread+0x61/0x80
    [<ffffffff81253464>] call_usermodehelper_exec_work
    [<ffffffff81253464>] call_usermodehelper_exec_work+0xc4/0x120
    [<ffffffff812591c9>] process_one_work+0x2c9/0x600
    [<ffffffff81259ab9>] worker_thread+0x59/0x5d0
    [<ffffffff812611c8>] kthread+0x178/0x1b0
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30

unreferenced object 0xffff888110ef5c00 (size 232):
  comm "kworker/u4:0", pid 8414, jiffies 4294944270 (age 12.780s)
  backtrace:
    [<ffffffff8154a0cf>] kmem_cache_zalloc
    [<ffffffff8154a0cf>] __alloc_file+0x1f/0xf0
    [<ffffffff8154a809>] alloc_empty_file+0x69/0x120
    [<ffffffff8154a8f3>] alloc_file+0x33/0x1b0
    [<ffffffff8154ab22>] alloc_file_pseudo+0xb2/0x140
    [<ffffffff81559218>] create_pipe_files+0x138/0x2e0
    [<ffffffff8126c793>] umd_setup+0x33/0x220
    [<ffffffff81253574>] call_usermodehelper_exec_async+0xb4/0x1b0
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30

after the UMD process exits, the pipe_to_umh/pipe_from_umh and tgid
need to be release.

Fixes: d71fa5c9763c ("bpf: Add kernel module with user mode driver that populates bpffs.")
Reported-by: syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/bpf/preload/bpf_preload_kern.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index 79c5772465f1..5a6226f3243f 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/pid.h>
 #include <linux/fs.h>
+#include <linux/file.h>
 #include <linux/sched/signal.h>
 #include "bpf_preload.h"
 
@@ -20,6 +21,14 @@ static struct bpf_preload_ops umd_ops = {
 	.owner = THIS_MODULE,
 };
 
+static void bpf_preload_umh_cleanup(struct umd_info *info)
+{
+	fput(info->pipe_to_umh);
+	fput(info->pipe_from_umh);
+	put_pid(info->tgid);
+	info->tgid = NULL;
+}
+
 static int preload(struct bpf_preload_info *obj)
 {
 	int magic = BPF_PRELOAD_START;
@@ -62,7 +71,7 @@ static int finish(void)
 		return -EPIPE;
 	tgid = umd_ops.info.tgid;
 	wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
-	umd_ops.info.tgid = NULL;
+	bpf_preload_umh_cleanup(&umd_ops.info);
 	return 0;
 }
 
@@ -80,10 +89,13 @@ static int __init load_umd(void)
 
 static void __exit fini_umd(void)
 {
+	struct pid *tgid;
 	bpf_preload_ops = NULL;
 	/* kill UMD in case it's still there due to earlier error */
-	kill_pid(umd_ops.info.tgid, SIGKILL, 1);
-	umd_ops.info.tgid = NULL;
+	tgid = umd_ops.info.tgid;
+	kill_pid(tgid, SIGKILL, 1);
+	wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
+	bpf_preload_umh_cleanup(&umd_ops.info);
 	umd_unload_blob(&umd_ops.info);
 }
 late_initcall(load_umd);
-- 
2.17.1

