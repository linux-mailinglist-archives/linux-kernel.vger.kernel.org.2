Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA55633AD21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCOIOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:14:24 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:41387
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229995AbhCOIOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:14:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsB3nr+6yiylanfCrmVtS5xj3v5xLQ60AAQ1cojZav+dHu8kP0RJyYJ97z1+EM7Nm/d2NWEgn0xhWvEhcdd0pKVGxh8X+6TX4ie/SUbOgB/5SpuhD2fX19Ui2YS71+WElvCcwMbKUqFMBKmlvW0iKDyHUQyCYfhvvZ/SzO12+4CHh2ft2BXbEBM/ZbidmjK/AEt9PGnmK1LgvK3fvMyIZ3fgfD95VtJSXBcDti+tQWEhnrsVVdY3kYeYXWUAff1bDrS7I12/3fhPTJsDffrIInG6RYNIks4K4GE5PdF4iGBkGhwPR9pZaiYONrgPIM4oEymbWz++Kn0RSl56H9H3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Din1U4ynDawHHcQ+RnHhwjtg3VbBEI8S68X36DwxLac=;
 b=iWVfpyIkqZuRWVpWi3qLqFOPHsKP7Yu3jL+6j2MGmnlguEw6XVE7dauWE4kE0tecPIES0PhSzhOrX/IdN9fNcUoN0qejU6xCau/8ePgkFk1cj9cJ/yb77luqKx1hXICz61NEjiZ+ZJNURHZS1eP1WetLKaorxdPIul1EEAwiQmfcbIdlKttqen+xUqaI7I7QHCK2O2jYBdTyTDF9d1U83jqJwMfdk7+Qht+FTGCWdXVGvpS5bbzNRrqgduw3LkP0QYSuLXjiMBqjmZYfOMYG9GvqjODPdh3nrsMxKN1rkHGl99whARuKdF7W7TdcyDRvTd8LS29na2JewA2sd4Wp9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Din1U4ynDawHHcQ+RnHhwjtg3VbBEI8S68X36DwxLac=;
 b=I96UwFw31IwX0ivO6CNa8nSBUawJnWz3qM6HbqO7LZDxtPNEGpBiSp6ZlOeeyNOkHGZmHJmrhKj72RcmsZU9xr0qgFB09Lig0W6LLACMYRPw6uzWcU6S0gOLVsfTIKjVVFCv2mfS6RoFWWPZ5JaDcnDhUXiyCXJl7U3W6eZwaQQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3624.namprd11.prod.outlook.com (2603:10b6:a03:b1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 08:14:00 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3890.042; Mon, 15 Mar 2021
 08:14:00 +0000
From:   qiang.zhang@windriver.com
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     dvyukov@google.com, linux-kernel@vger.kernel.org,
        syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com
Subject: [PATCH v2] bpf: Fix memory leak in copy_process()
Date:   Mon, 15 Mar 2021 16:18:47 +0800
Message-Id: <20210315081847.16180-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0198.apcprd02.prod.outlook.com
 (2603:1096:201:21::34) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1-vm1.wrs.com (60.247.85.82) by HK2PR02CA0198.apcprd02.prod.outlook.com (2603:1096:201:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 08:13:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3eaf97e-7c4a-4be4-f186-08d8e78a49b7
X-MS-TrafficTypeDiagnostic: BYAPR11MB3624:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3624A0FD41BF913715E8E9C5FF6C9@BYAPR11MB3624.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCvw1YrcT7YPvrjB639nRPqJQv8W34AGE3mRdN5/CKXp8dtRg60bYxf4t+GMM+YaOioIm0M11aLpET6Ud0DCVMsk+ntr4vM/WshQGYJEqQepcggK6xA3045xEXdLQFUtO9jtI5/3BwilVvs53diZmMA9U6y9T5OaciEak8s83zdKoUcFQ8o/A1LWsztd79k+Tii3ZT8pBJGGHQngYLQMXiT1T0gfni7yFfxjiNDVENG/Xv281cBrA0SAEMGwWbMZVQGOHVqy4ryhNN733qFP3t5YDjavKgkoOTs25oBO0SGnrIt91XdUyqfi9/JxOlcRuwkpi+enmMeCIocqxmTHkKE7glYVk6WZ9wdVodyg0r8ygAngBiHZeEY/+/D5ASQkJ8AgCEWE63TKQ+15UlvgQ3KIPQMHWEs+cGbmrNZvrGmyL3fHaY6qvcGWo8C+Clf0mJONYgT+VeM9/EFlJUmXGm5XMWldWfFhIHSIhI7ICcDKfcG7igmZk8OL2E+fyviA3gdSYFeXigmgN//aZwacg0AvuffTeastYeGgzAGpK05nekECEVjxbaHZmlAfPcR9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39840400004)(136003)(396003)(346002)(16526019)(6512007)(26005)(2616005)(9686003)(6666004)(1076003)(956004)(186003)(2906002)(6486002)(8936002)(478600001)(66946007)(66556008)(36756003)(52116002)(6506007)(4326008)(86362001)(66476007)(83380400001)(5660300002)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tLXPpZdgrHiD5ODBxqVytwA8HGsHIzNGkNwd9USZ4ykU1YHH3qS6GQRaKj3t?=
 =?us-ascii?Q?FB1YJGnVpyyEakMbE1Dab7H1gQfJIiZPNhel6VQ582iJVRXKV42ktmgnCk92?=
 =?us-ascii?Q?5HsMwY0Xpg9NsCzNGVttFCwuB85GxfOGBetM2bR0mgwsAh0GAGVFsnPatZ9Z?=
 =?us-ascii?Q?3r/GdL32t01jV455UwX07VGpbnuOnXMtddIZpDEa6jubZkeUB2a8fVClIkVi?=
 =?us-ascii?Q?wqQlCddlwiM9uCiN9Xu5XDvettCniQAvomIrM8+NKThUa8A+ot8kP76In73d?=
 =?us-ascii?Q?wm4EeCl7b0KKEBNLqr+MIKQFF/im2NXZ8nZOksRo3mCGz1ISEJkXJFF9BDnu?=
 =?us-ascii?Q?fwNssveIwSR4wJOHuQfTmy5CH/ECCmHtA4C7XJ8p0tgBzDusi/p+PxIXCabn?=
 =?us-ascii?Q?7l3uiHB7YBM7lG0cVpPvC4VL/tisYy3e+CtpBdOs4KGlJIPN68IrsvWYPvFH?=
 =?us-ascii?Q?CCtI6503D/APxOLExw1Af2Oyjd82j043uvNNs+PraDcpvnlLDAGIqHyLvt+o?=
 =?us-ascii?Q?VCJCKc1Hk5ME0oDJ4Czxh85oMJNQbg0iqfUWBGJ7pKIEQga02IO4eph0xMLO?=
 =?us-ascii?Q?uofUixAEqZ37GGRkhlRVTuAbvblm3UOSZVR7QEglb3zJ37cz9l1u4RyngM83?=
 =?us-ascii?Q?SzjpLuD1NMmmOJKLxrQGBh9qUY8GFCf5p+aUQa7c6zI5Ua4An/6ItzmbJhog?=
 =?us-ascii?Q?dNoV4lPFBDZTV1W2YrBdtxXa71JU7ScPNRqUsudiugn+q6g0XAaTKCUoqkC0?=
 =?us-ascii?Q?VwI+C8OHWt4CC5A8oL6TjojcODeyKqg8GxfpzIx9T62vv2qmqaBZ9/BQH/0q?=
 =?us-ascii?Q?/MVsd6Pjz2FYVvK1RFL4vSn8yebq0HBsD64wVQKgZ0VdCsihU7TgksaHGDK+?=
 =?us-ascii?Q?dV/N+T+mLktoJFjkoEcdaMopVjtRqdyd3Oe9D9fVwBdNtOh/UX84/xAkxfPO?=
 =?us-ascii?Q?dXjV4c2Xw5z2gSdf31znouxwa6PtAqNAJH986ysttIX0HCxP3rsKdZuqpvPA?=
 =?us-ascii?Q?QVyQEki3od1gTdx9H6vgOJUjI+NQgHk7YN1Y86uyM1IC0yiaXpXXz8YHU1Hs?=
 =?us-ascii?Q?ZPTdXXoOQnKGREf2Yyuvd6fC8j5pcIEN4cCyk3IRty7cz8vkimG2/gh83jAc?=
 =?us-ascii?Q?Yp5Ew6eIJzhNXX+E3IaRvb6Bkx9vf5+49A1ZdXiFYwOWedI38vul5nQUBjM1?=
 =?us-ascii?Q?rQntmKIl89YrLewYEN6ta5w6XSdiZQYwsUPPsPJEAGPRX1VrfrzOFNmtlC/Q?=
 =?us-ascii?Q?q25PoETuNt6FQzg1RfedS2ykITYJlZfmP5bqr6/gjY7whoBE2373aeLJujbt?=
 =?us-ascii?Q?FJN/CCAxvimPq0yXX5EcostA?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3eaf97e-7c4a-4be4-f186-08d8e78a49b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 08:14:00.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDTm9JckdiOL438VYiPHzG8SfHf6g2THS+E5QZw9pZLxhHsA/M53OfQKthFW6ccGrNNOBaCuZIfpMmpRObMbfsFjhm+3D35iz5Spu4jVubQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3624
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
 v1->v2:
 Judge whether the pointer variable tgid is valid.

 kernel/bpf/preload/bpf_preload_kern.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index 79c5772465f1..5009875f01d3 100644
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
@@ -61,8 +70,10 @@ static int finish(void)
 	if (n != sizeof(magic))
 		return -EPIPE;
 	tgid = umd_ops.info.tgid;
-	wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
-	umd_ops.info.tgid = NULL;
+	if (tgid) {
+		wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
+		bpf_preload_umh_cleanup(&umd_ops.info);
+	}
 	return 0;
 }
 
@@ -80,10 +91,15 @@ static int __init load_umd(void)
 
 static void __exit fini_umd(void)
 {
+	struct pid *tgid;
 	bpf_preload_ops = NULL;
 	/* kill UMD in case it's still there due to earlier error */
-	kill_pid(umd_ops.info.tgid, SIGKILL, 1);
-	umd_ops.info.tgid = NULL;
+	tgid = umd_ops.info.tgid;
+	if (tgid) {
+		kill_pid(tgid, SIGKILL, 1);
+		wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
+		bpf_preload_umh_cleanup(&umd_ops.info);
+	}
 	umd_unload_blob(&umd_ops.info);
 }
 late_initcall(load_umd);
-- 
2.17.1

