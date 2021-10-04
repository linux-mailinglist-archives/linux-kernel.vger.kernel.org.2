Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6AA4205BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhJDGPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:15:55 -0400
Received: from out0.migadu.com ([94.23.1.103]:28135 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232736AbhJDGPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:15:54 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633328042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdlL5nxCjGeUtk7PBO7npyqMWSmseCHKCkKUjUjDJbk=;
        b=gvBJ0tPHYr5GmsmevFSd4WHLsLMmdjXTjN/iRiRtpYBT1efX+/kUG1+PPe4+UsxVe/ICpI
        erz2XydsPouAPpx9r3ZJT5Ur2fBknQ3M3FncDI1jb0BHr5ewrrmHlz1933UZdXsYS9pGU0
        GdvD7JKTozaF/4rYn7haVISxRrfOdTQ=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Christian Hansen <chansen3@cisco.com>,
        Changbin Du <changbin.du@intel.com>,
        Bin Wang <wangbin224@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] tools/vm/page-types.c: print file offset in hexadecimal
Date:   Mon,  4 Oct 2021 15:13:25 +0900
Message-Id: <20211004061325.1525902-4-naoya.horiguchi@linux.dev>
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

In page list mode (with -l and -L option), virtual address and
physical address are printed in hexadecimal, but file offset is
not, which is confusing, so let's align it.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 tools/vm/page-types.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git v5.15-rc3/tools/vm/page-types.c v5.15-rc3_patched/tools/vm/page-types.c
index fdb1891faf90..b1ed76d9a979 100644
--- v5.15-rc3/tools/vm/page-types.c
+++ v5.15-rc3_patched/tools/vm/page-types.c
@@ -390,7 +390,7 @@ static void show_page_range(unsigned long voffset, unsigned long offset,
 		if (opt_pid)
 			printf("%lx\t", voff);
 		if (opt_file)
-			printf("%lu\t", voff);
+			printf("%lx\t", voff);
 		if (opt_list_cgroup)
 			printf("@%llu\t", (unsigned long long)cgroup0);
 		if (opt_list_mapcnt)
@@ -418,7 +418,7 @@ static void show_page(unsigned long voffset, unsigned long offset,
 	if (opt_pid)
 		printf("%lx\t", voffset);
 	if (opt_file)
-		printf("%lu\t", voffset);
+		printf("%lx\t", voffset);
 	if (opt_list_cgroup)
 		printf("@%llu\t", (unsigned long long)cgroup);
 	if (opt_list_mapcnt)
-- 
2.25.1

