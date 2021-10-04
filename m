Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB9D4205BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhJDGPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:15:49 -0400
Received: from out0.migadu.com ([94.23.1.103]:28048 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232670AbhJDGPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:15:45 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633328036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3zybDAbiFx8eNx5Xj1zigIuKK40gVXN3QG9GqRjgOCg=;
        b=rYPPc49RliyGGQtOMJyEcO9RqQkzxDopSpMvcRrD4d/GqzvRu+8TvlwsqjvSzg5QGHMAif
        pPMUHeSzLaDa0XG0O7AOt2u8TyZuA14D/B8a0d0RZjPEQoxViUS1qLNaMYbOqxHYTqutEt
        DwJ3R14NxEOF9Kzn/bdaH9xeQtqXGc8=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Christian Hansen <chansen3@cisco.com>,
        Changbin Du <changbin.du@intel.com>,
        Bin Wang <wangbin224@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] tools/vm/page-types.c: make walk_file() aware of address range option
Date:   Mon,  4 Oct 2021 15:13:23 +0900
Message-Id: <20211004061325.1525902-2-naoya.horiguchi@linux.dev>
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

-a|--addr option is used to limit the range of address to be
scanned for page status. It works now for physical address space
(dafult mode) or for virtual address space (with -p option), but
not for file address space (with -f option).  So make walk_file()
aware of -a option.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 tools/vm/page-types.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git v5.15-rc3/tools/vm/page-types.c v5.15-rc3_patched/tools/vm/page-types.c
index f62f10c988db..b14376af1f16 100644
--- v5.15-rc3/tools/vm/page-types.c
+++ v5.15-rc3_patched/tools/vm/page-types.c
@@ -967,22 +967,19 @@ static struct sigaction sigbus_action = {
 	.sa_flags = SA_SIGINFO,
 };
 
-static void walk_file(const char *name, const struct stat *st)
+static void walk_file_range(const char *name, int fd,
+			    unsigned long off, unsigned long end)
 {
 	uint8_t vec[PAGEMAP_BATCH];
 	uint64_t buf[PAGEMAP_BATCH], flags;
 	uint64_t cgroup = 0;
 	uint64_t mapcnt = 0;
 	unsigned long nr_pages, pfn, i;
-	off_t off, end = st->st_size;
-	int fd;
 	ssize_t len;
 	void *ptr;
 	int first = 1;
 
-	fd = checked_open(name, O_RDONLY|O_NOATIME|O_NOFOLLOW);
-
-	for (off = 0; off < end; off += len) {
+	for (; off < end; off += len) {
 		nr_pages = (end - off + page_size - 1) / page_size;
 		if (nr_pages > PAGEMAP_BATCH)
 			nr_pages = PAGEMAP_BATCH;
@@ -1043,6 +1040,21 @@ static void walk_file(const char *name, const struct stat *st)
 				 flags, cgroup, mapcnt, buf[i]);
 		}
 	}
+}
+
+static void walk_file(const char *name, const struct stat *st)
+{
+	int i;
+	int fd;
+
+	fd = checked_open(name, O_RDONLY|O_NOATIME|O_NOFOLLOW);
+
+	if (!nr_addr_ranges)
+		add_addr_range(0, st->st_size / page_size);
+
+	for (i = 0; i < nr_addr_ranges; i++)
+		walk_file_range(name, fd, opt_offset[i] * page_size,
+				(opt_offset[i] + opt_size[i]) * page_size);
 
 	close(fd);
 }
-- 
2.25.1

