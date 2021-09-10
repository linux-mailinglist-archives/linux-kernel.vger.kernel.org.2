Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559C34065DE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 05:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhIJDFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 23:05:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16246 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhIJDFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:05:08 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H5LKm4qvpz8sx1;
        Fri, 10 Sep 2021 11:03:24 +0800 (CST)
Received: from huawei.com (10.67.189.83) by dggeme759-chm.china.huawei.com
 (10.3.19.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Fri, 10
 Sep 2021 11:03:56 +0800
From:   Zhenliang Wei <weizhenliang@huawei.com>
To:     <akpm@linux-foundation.org>, <tangbin@cmss.chinamobile.com>,
        <zhangshengju@cmss.chinamobile.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weizhenliang@huawei.com>, <nixiaoming@huawei.com>,
        <xiaoqian9@huawei.com>
Subject: [PATCH] tools/vm/page_owner_sort.c: count and sort by mem
Date:   Fri, 10 Sep 2021 11:03:43 +0800
Message-ID: <1631243023-47849-1-git-send-email-weizhenliang@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When viewing page owner information, we may be more concerned about the
total memory than the number of stack occurrences. Therefore, the
following adjustments are made:
1. Added the statistics on the total number of pages.
2. Added the optional parameter "-m" to configure the program to sort by
   memory (total pages).

Signed-off-by: Zhenliang Wei <weizhenliang@huawei.com>
---
 tools/vm/page_owner_sort.c | 94 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 9 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index 0e75f22c9475..30dcc606c493 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -5,6 +5,8 @@
  * Example use:
  * cat /sys/kernel/debug/page_owner > page_owner_full.txt
  * ./page_owner_sort page_owner_full.txt sorted_page_owner.txt
+ * Or sort by total memory:
+ * ./page_owner_sort -m page_owner_full.txt sorted_page_owner.txt
  *
  * See Documentation/vm/page_owner.rst
 */
@@ -16,14 +18,18 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <string.h>
+#include <regex.h>
+#include <errno.h>
 
 struct block_list {
 	char *txt;
 	int len;
 	int num;
+	int page_num;
 };
 
-
+static int sort_by_memory;
+static regex_t order_pattern;
 static struct block_list *list;
 static int list_size;
 static int max_size;
@@ -59,12 +65,50 @@ static int compare_num(const void *p1, const void *p2)
 	return l2->num - l1->num;
 }
 
+static int compare_page_num(const void *p1, const void *p2)
+{
+	const struct block_list *l1 = p1, *l2 = p2;
+
+	return l2->page_num - l1->page_num;
+}
+
+static int get_page_num(char *buf)
+{
+	int err, val_len, order_val;
+	char order_str[4] = {0};
+	char *endptr;
+	regmatch_t pmatch[2];
+
+	err = regexec(&order_pattern, buf, 2, pmatch, REG_NOTBOL);
+	if (err != 0 || pmatch[1].rm_so == -1) {
+		printf("no order pattern in %s\n", buf);
+		return 0;
+	}
+	val_len = pmatch[1].rm_eo - pmatch[1].rm_so;
+	if (val_len > 2) /* max_order should not exceed 2 digits */
+		goto wrong_order;
+
+	memcpy(order_str, buf + pmatch[1].rm_so, val_len);
+
+	errno = 0;
+	order_val = strtol(order_str, &endptr, 10);
+	if (errno != 0 || endptr == order_str || *endptr != '\0')
+		goto wrong_order;
+
+	return 1 << order_val;
+
+wrong_order:
+	printf("wrong order in follow buf:\n%s\n", buf);
+	return 0;
+}
+
 static void add_list(char *buf, int len)
 {
 	if (list_size != 0 &&
 	    len == list[list_size-1].len &&
 	    memcmp(buf, list[list_size-1].txt, len) == 0) {
 		list[list_size-1].num++;
+		list[list_size-1].page_num += get_page_num(buf);
 		return;
 	}
 	if (list_size == max_size) {
@@ -74,6 +118,7 @@ static void add_list(char *buf, int len)
 	list[list_size].txt = malloc(len+1);
 	list[list_size].len = len;
 	list[list_size].num = 1;
+	list[list_size].page_num = get_page_num(buf);
 	memcpy(list[list_size].txt, buf, len);
 	list[list_size].txt[len] = 0;
 	list_size++;
@@ -85,6 +130,13 @@ static void add_list(char *buf, int len)
 
 #define BUF_SIZE	(128 * 1024)
 
+static void usage(void)
+{
+	printf("Usage: ./page_owner_sort [-m] <input> <output>\n"
+		"-m	Sort by total memory. If not set this option, sort by times\n"
+	);
+}
+
 int main(int argc, char **argv)
 {
 	FILE *fin, *fout;
@@ -92,21 +144,39 @@ int main(int argc, char **argv)
 	int ret, i, count;
 	struct block_list *list2;
 	struct stat st;
+	int err;
+	int opt;
 
-	if (argc < 3) {
-		printf("Usage: ./program <input> <output>\n");
-		perror("open: ");
+	while ((opt = getopt(argc, argv, "m")) != -1)
+		switch (opt) {
+		case 'm':
+			sort_by_memory = 1;
+			break;
+		default:
+			usage();
+			exit(1);
+		}
+
+	if (optind >= (argc - 1)) {
+		usage();
 		exit(1);
 	}
 
-	fin = fopen(argv[1], "r");
-	fout = fopen(argv[2], "w");
+	fin = fopen(argv[optind], "r");
+	fout = fopen(argv[optind + 1], "w");
 	if (!fin || !fout) {
-		printf("Usage: ./program <input> <output>\n");
+		usage();
 		perror("open: ");
 		exit(1);
 	}
 
+	err = regcomp(&order_pattern, "order\\s*([0-9]*),", REG_EXTENDED|REG_NEWLINE);
+	if (err != 0 || order_pattern.re_nsub != 1) {
+		printf("%s: Invalid pattern 'order\\s*([0-9]*),' code %d\n",
+			argv[0], err);
+		exit(1);
+	}
+
 	fstat(fileno(fin), &st);
 	max_size = st.st_size / 100; /* hack ... */
 
@@ -145,13 +215,19 @@ int main(int argc, char **argv)
 			list2[count++] = list[i];
 		} else {
 			list2[count-1].num += list[i].num;
+			list2[count-1].page_num += list[i].page_num;
 		}
 	}
 
-	qsort(list2, count, sizeof(list[0]), compare_num);
+	if (sort_by_memory)
+		qsort(list2, count, sizeof(list[0]), compare_page_num);
+	else
+		qsort(list2, count, sizeof(list[0]), compare_num);
 
 	for (i = 0; i < count; i++)
-		fprintf(fout, "%d times:\n%s\n", list2[i].num, list2[i].txt);
+		fprintf(fout, "%d times, %d pages:\n%s\n",
+				list2[i].num, list2[i].page_num, list2[i].txt);
 
+	regfree(&order_pattern);
 	return 0;
 }
-- 
2.12.3

