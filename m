Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4EF3237C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhBXHR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:17:28 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:12239 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbhBXHRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:17:16 -0500
X-AuditID: 0a580155-713ff700000550c6-bc-6035f6376939
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 50.3A.20678.736F5306; Wed, 24 Feb 2021 14:46:15 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 24 Feb
 2021 15:16:19 +0800
Date:   Wed, 24 Feb 2021 15:16:19 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>,
        <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>
CC:     <x86@kernel.org>, <inux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <yangfeng1@kingsoft.com>, <yaoaili@kingsoft.com>
Subject: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210224151619.67c29731@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsXCFcGooGv+zTTBYOFGKYs569ewWXze8I/N
        YtpGcYvbB9YwWlzeNYfN4t6a/6wWlw4sYLK42HiA0WLzpqnMFm8u3GOx+LHhMasDt8f31j4W
        j8V7XjJ5bFrVyeax6dMkdo93586xe5yY8ZvF48XVjSwe7/ddZfP4vEnO40TLF9YArigum5TU
        nMyy1CJ9uwSujJeLFrEUTBev+Dj7IGMD4zqhLkZODgkBE4mLr46ydTFycQgJTGeSOLroKiOE
        84pRYtHpOexdjBwcLAKqEj9vmoM0sAGZu+7NYgWpERFYwCix+fdDZhCHWWAuo8SRv8dZQKqE
        Bdwk7u1ZyQpi8wpYSTy83QFm8wuISfRe+c8Esdpeom3LIkaIGkGJkzOfgPUyC+hInFh1jBnC
        lpfY/nYOmC0koChxeMkvdoheJYkj3TPYIOxYiWXzXrFOYBSchWTULCSjZiEZtYCReRUjS3Fu
        utEmRkjchO5gnNH0Ue8QIxMH4yFGCQ5mJRFetrtGCUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        p241SRASSE8sSc1OTS1ILYLJMnFwSjUweYiXZzH7bZdNixcQMr5Sdjbs8oYtoiWnIq/81xW2
        dxCRY+bQ3H48b9fzqdrn9t3RXcQ8tU3+hfquCDsJ/eU6ax9qrZWOE4z3F5t279B1v8TLuT8u
        TTq64bB1y3LZjKdeGX2Xn9ltmqhvlRTrEXYtkE8n9PoE2Yo7Li55KkuLl08rLBUyuN6zWNFU
        Z+eORkF/9j03OK3Y9yz5IZ5RV7PGUWTj86pJLzrOxPKHiHW0F5/4fb18b9eJTZf5Ciz32yU+
        b3VpiO+ftmnNhx3OC5fsEvfmcvywvSb0aMyOTYxXSs2WeKvlX/50ZtOxsCtKefv9RQ5rTHzc
        KrCBWaIv/2GRhnW+s+XFn6uvuF1bOsdViaU4I9FQi7moOBEAoaWicgoDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the page is already poisoned, another memory_failure() call in the
same page now return 0, meaning OK. For nested memory mce handling, this
behavior may lead real serious problem, Example:

1.When LCME is enabled, and there are two processes A && B running on
different core X && Y separately, which will access one same page, then
the page corrupted when process A access it, a MCE will be rasied to
core X and the error process is just underway.

2.Then B access the page and trigger another MCE to core Y, it will also
do error process, it will see TestSetPageHWPoison be true, and 0 is
returned.

3.The kill_me_maybe will check the return:

1244 static void kill_me_maybe(struct callback_head *cb)
1245 {

1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT,
p->mce_whole_page);
1257                 sync_core();
1258                 return;
1259         }

1267 }

4. The error process for B will end, and may nothing happened if
kill-early is not set, We may let the wrong data go into effect.

For other cases which care the return value of memory_failure() should
check why they want to process a memory error which have already been
processed. This behavior seems reasonable.

In kill_me_maybe, log the fact about the memory may not recovered, and
we will kill the related process.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 arch/x86/kernel/cpu/mce/core.c | 2 ++
 mm/memory-failure.c            | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e133ce1e562b..db4afc5bf15a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1259,6 +1259,8 @@ static void kill_me_maybe(struct callback_head *cb)
 	}
 
 	if (p->mce_vaddr != (void __user *)-1l) {
+		pr_err("Memory error may not recovered: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
+			p->mce_addr >> PAGE_SHIFT, p->comm, p->pid);
 		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
 	} else {
 		pr_err("Memory error not recovered");
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e9481632fcd1..06f006174b8c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1224,7 +1224,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(head)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 		       pfn);
-		return 0;
+		return -EBUSY;
 	}
 
 	num_poisoned_pages_inc();
@@ -1420,7 +1420,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
-		return 0;
+		return -EBUSY;
 	}
 
 	orig_head = hpage = compound_head(p);
-- 
2.25.1

