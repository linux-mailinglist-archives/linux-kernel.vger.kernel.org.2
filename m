Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152D24205BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhJDGPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:15:52 -0400
Received: from out0.migadu.com ([94.23.1.103]:28097 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232670AbhJDGPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:15:50 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633328039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPBrR94hmnPPNepjSn2ZICgVkNVAvVg7Myu781yfczI=;
        b=DRqwC7OkYgZDWQQ04/eYRnB5FT+9m2KOlXZURm0bSO/J/wJnAEhqfbjQmW0qFIJ4iamCeb
        rw3Cs9ci/5uQeiPPQiXsajwN5EJE8SKPPBEGYPMqiZCEWZu2Z5nej4QQyCTakRv+n0TkUt
        GAnqyiRwAJk0JTjD2AKAlTEPYFKsouE=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Christian Hansen <chansen3@cisco.com>,
        Changbin Du <changbin.du@intel.com>,
        Bin Wang <wangbin224@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] tools/vm/page-types.c: move show_file() to summary output
Date:   Mon,  4 Oct 2021 15:13:24 +0900
Message-Id: <20211004061325.1525902-3-naoya.horiguchi@linux.dev>
In-Reply-To: <20211004061325.1525902-1-naoya.horiguchi@linux.dev>
References: <20211004061325.1525902-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Currently file info from show_file() is printed out within page list
like below, but this is inconvenient a little to utilize the page list
from other scripts (maybe needs additional filtering).

    $ ./page-types -f page-types.c -l
    foffset offset  len     flags
    page-types.c Inode: 15108680 Size: 30953 (8 pages)
    Modify: Sat Oct  2 23:11:20 2021 (2399 seconds ago)
    Access: Sat Oct  2 23:11:28 2021 (2391 seconds ago)
    0       d9f59e  1       ___U_lA____________________________________
    1       1031eb5 1       __RU_l_____________________________________
    2       13bf717 1       __RU_l_____________________________________
    3       13ac333 1       ___U_lA____________________________________
    4       d9f59f  1       __RU_l_____________________________________
    5       183fd49 1       ___U_lA____________________________________
    6       13cbf69 1       ___U_lA____________________________________
    7       d9ef05  1       ___U_lA____________________________________


                 flags      page-count       MB  symbolic-flags                     long-symbolic-flags
    0x000000000000002c               3        0  __RU_l_____________________________________        referenced,uptodate,lru
    0x0000000000000068               5        0  ___U_lA____________________________________        uptodate,lru,active
                 total               8        0

With this patch file info is printed out in summary part like below:

    $ ./page-types -f page-types.c -l
    foffset offset  len     flags
    0       d9f59e  1       ___U_lA_____________________________________
    1       1031eb5 1       __RU_l______________________________________
    2       13bf717 1       __RU_l______________________________________
    3       13ac333 1       ___U_lA_____________________________________
    4       d9f59f  1       __RU_l______________________________________
    5       183fd49 1       ___U_lA_____________________________________
    6       13cbf69 1       ___U_lA_____________________________________


    page-types.c Inode: 15108680 Size: 30953 (8 pages)
    Modify: Sat Oct  2 23:11:20 2021 (2435 seconds ago)
    Access: Sat Oct  2 23:11:28 2021 (2427 seconds ago)

                 flags      page-count       MB  symbolic-flags                     long-symbolic-flags
    0x000000000000002c               3        0  __RU_l______________________________________       referenced,uptodate,lru
    0x0000000000000068               4        0  ___U_lA_____________________________________       uptodate,lru,active
                 total               7        0

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 tools/vm/page-types.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git v5.15-rc3/tools/vm/page-types.c v5.15-rc3_patched/tools/vm/page-types.c
index b14376af1f16..fdb1891faf90 100644
--- v5.15-rc3/tools/vm/page-types.c
+++ v5.15-rc3_patched/tools/vm/page-types.c
@@ -1034,7 +1034,6 @@ static void walk_file_range(const char *name, int fd,
 			if (first && opt_list) {
 				first = 0;
 				flush_page_range();
-				show_file(name, st);
 			}
 			add_page(off / page_size + i, pfn,
 				 flags, cgroup, mapcnt, buf[i]);
@@ -1074,10 +1073,10 @@ int walk_tree(const char *name, const struct stat *st, int type, struct FTW *f)
 	return 0;
 }
 
+struct stat st;
+
 static void walk_page_cache(void)
 {
-	struct stat st;
-
 	kpageflags_fd = checked_open(opt_kpageflags, O_RDONLY);
 	pagemap_fd = checked_open("/proc/self/pagemap", O_RDONLY);
 	sigaction(SIGBUS, &sigbus_action, NULL);
@@ -1374,6 +1373,11 @@ int main(int argc, char *argv[])
 	if (opt_list)
 		printf("\n\n");
 
+	if (opt_file) {
+		show_file(opt_file, &st);
+		printf("\n");
+	}
+
 	show_summary();
 
 	if (opt_list_mapcnt)
-- 
2.25.1

