Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263B640786B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhIKNw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:52:26 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:2989 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235880AbhIKNwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:52:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uo-bkdu_1631368267;
Received: from localhost(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0Uo-bkdu_1631368267)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Sep 2021 21:51:11 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     yinan@linux.alibaba.com, rostedt@goodmis.org,
        mark-pk.tsai@mediatek.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scripts: ftrace - move the sort-processing in ftrace_init to compile time
Date:   Sat, 11 Sep 2021 21:50:42 +0800
Message-Id: <20210911135043.16014-2-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20210911135043.16014-1-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ftrace is enabled, ftrace_init will consume a period of
time, usually around 15~20 ms. Approximately 40% of the time is
consumed by sort-processing. Moving the sort-processing to the
compile time can speed up the kernel boot process.

performance test:
        env:    Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz
        method: before and after patching, compare the
                total time of ftrace_init(), and verify
                the functionality of ftrace.

        avg_time of ftrace_init:
                with patch: 8.352 ms
                without patch: 15.763 ms

Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
---
 kernel/trace/ftrace.c   |   5 ++-
 scripts/link-vmlinux.sh |   6 +--
 scripts/sorttable.c     |   2 +
 scripts/sorttable.h     | 109 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7efbc8aaf7f6..c236da868990 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6189,8 +6189,9 @@ static int ftrace_process_locs(struct module *mod,
 	if (!count)
 		return 0;
 
-	sort(start, count, sizeof(*start),
-	     ftrace_cmp_ips, NULL);
+	if (mod)
+		sort(start, count, sizeof(*start),
+		     ftrace_cmp_ips, NULL);
 
 	start_pg = ftrace_allocate_pages(count);
 	if (!start_pg)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index d74cee5c4326..57f53b0f4a8a 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -409,6 +409,9 @@ if [ -n "${CONFIG_DEBUG_INFO_BTF}" -a -n "${CONFIG_BPF}" ]; then
 	${RESOLVE_BTFIDS} vmlinux
 fi
 
+info SYSMAP System.map
+mksysmap vmlinux System.map
+
 if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
 	info SORTTAB vmlinux
 	if ! sorttable vmlinux; then
@@ -417,9 +420,6 @@ if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
 	fi
 fi
 
-info SYSMAP System.map
-mksysmap vmlinux System.map
-
 # step a (see comment above)
 if [ -n "${CONFIG_KALLSYMS}" ]; then
 	mksysmap ${kallsyms_vmlinux} .tmp_System.map
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 0ef3abfc4a51..11a595ca256b 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -30,6 +30,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <errno.h>
+#include <pthread.h>
 
 #include <tools/be_byteshift.h>
 #include <tools/le_byteshift.h>
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index a2baa2fefb13..db6c38c61986 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -19,6 +19,9 @@
 
 #undef extable_ent_size
 #undef compare_extable
+#undef get_mcount_loc
+#undef sort_mcount_loc
+#undef mcount_loc
 #undef do_sort
 #undef Elf_Addr
 #undef Elf_Ehdr
@@ -41,6 +44,9 @@
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
 # define compare_extable	compare_extable_64
+# define get_mcount_loc    get_mcount_loc_64
+# define sort_mcount_loc    sort_mcount_loc_64
+# define mcount_loc     mcount_loc_64
 # define do_sort		do_sort_64
 # define Elf_Addr		Elf64_Addr
 # define Elf_Ehdr		Elf64_Ehdr
@@ -62,6 +68,9 @@
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
+# define get_mcount_loc    get_mcount_loc_32
+# define sort_mcount_loc    sort_mcount_loc_32
+# define mcount_loc     mcount_loc_32
 # define do_sort		do_sort_32
 # define Elf_Addr		Elf32_Addr
 # define Elf_Ehdr		Elf32_Ehdr
@@ -84,8 +93,6 @@
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 /* ORC unwinder only support X86_64 */
-#include <errno.h>
-#include <pthread.h>
 #include <asm/orc_types.h>
 
 #define ERRSTR_MAXSZ	256
@@ -191,6 +198,62 @@ static int compare_extable(const void *a, const void *b)
 		return 1;
 	return 0;
 }
+struct mcount_loc {
+	Elf_Ehdr *ehdr;
+	Elf_Shdr *init_data_sec;
+	uint_t start_mcount_loc;
+	uint_t stop_mcount_loc;
+};
+
+/* Sort the addresses stored between __start_mcount to __stop_mcount */
+static void *sort_mcount_loc(void *arg)
+{
+	struct mcount_loc *mstruct = (struct mcount_loc *)arg;
+	uint_t offset = mstruct->start_mcount_loc - _r(&(mstruct->init_data_sec)->sh_addr)
+					+ _r(&(mstruct->init_data_sec)->sh_offset);
+	uint_t count = mstruct->stop_mcount_loc - mstruct->start_mcount_loc;
+	unsigned char *start = (void *)mstruct->ehdr + offset;
+
+	qsort(start, count/sizeof(uint_t), sizeof(uint_t), compare_extable);
+	return NULL;
+}
+
+/* get the address of __start_mcount_loc and __stop_mcount_loc*/
+static void get_mcount_loc(uint_t *_start, uint_t *_stop)
+{
+	FILE *file_start, *file_stop;
+	char start_buff[20];
+	char end_buff[20];
+	int len = 0;
+
+	file_start = popen(" grep start_mcount System.map | awk '{print $1}' ", "r");
+	if (!file_start) {
+		fprintf(stderr, "get start_mcount_loc error!");
+		return;
+	}
+
+	file_stop = popen(" grep stop_mcount System.map | awk '{print $1}' ", "r");
+	if (!file_stop) {
+		fprintf(stderr, "get stop_mcount_loc error!");
+		pclose(file_start);
+		return;
+	}
+
+	while (fgets(start_buff, sizeof(start_buff), file_start) != NULL) {
+		len = strlen(start_buff);
+		start_buff[len - 1] = '\0';
+	}
+	*_start = strtoul(start_buff, NULL, 16);
+
+	while (fgets(end_buff, sizeof(end_buff), file_stop) != NULL) {
+		len = strlen(end_buff);
+		end_buff[len - 1] = '\0';
+	}
+	*_stop = strtoul(end_buff, NULL, 16);
+
+	pclose(file_start);
+	pclose(file_stop);
+}
 
 static int do_sort(Elf_Ehdr *ehdr,
 		   char const *const fname,
@@ -217,6 +280,10 @@ static int do_sort(Elf_Ehdr *ehdr,
 	int idx;
 	unsigned int shnum;
 	unsigned int shstrndx;
+	struct mcount_loc mstruct;
+	uint_t _start_mcount_loc = 0;
+	uint_t _stop_mcount_loc = 0;
+	pthread_t mcount_sort_thread;
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 	unsigned int orc_ip_size = 0;
 	unsigned int orc_size = 0;
@@ -253,6 +320,14 @@ static int do_sort(Elf_Ehdr *ehdr,
 			symtab_shndx = (Elf32_Word *)((const char *)ehdr +
 						      _r(&s->sh_offset));
 
+		/* locate the mcount_loc */
+		if (!strcmp(secstrings + idx, ".init.data")) {
+			get_mcount_loc(&_start_mcount_loc, &_stop_mcount_loc);
+			mstruct.ehdr = ehdr;
+			mstruct.init_data_sec = s;
+			mstruct.start_mcount_loc = _start_mcount_loc;
+			mstruct.stop_mcount_loc = _stop_mcount_loc;
+		}
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 		/* locate the ORC unwind tables */
 		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
@@ -294,6 +369,21 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 #endif
+	if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
+		fprintf(stderr,
+			"incomplete mcount_loc in file: %s\n",
+			fname);
+		goto out;
+	}
+
+	/* create thread to sort mcount_loc concurrently */
+	if (pthread_create(&mcount_sort_thread, NULL, &sort_mcount_loc, &mstruct)) {
+		fprintf(stderr,
+			"pthread_create mcount_sort_thread failed '%s': %s\n",
+			strerror(errno), fname);
+		goto out;
+	}
+
 	if (!extab_sec) {
 		fprintf(stderr,	"no __ex_table in file: %s\n", fname);
 		goto out;
@@ -376,5 +466,20 @@ static int do_sort(Elf_Ehdr *ehdr,
 		}
 	}
 #endif
+	if (mcount_sort_thread) {
+		void *retval = NULL;
+		/* wait for mcount sort done */
+		rc = pthread_join(mcount_sort_thread, &retval);
+		if (rc)
+			fprintf(stderr,
+				"pthread_join failed '%s': %s\n",
+				strerror(errno), fname);
+		else if (retval) {
+			rc = -1;
+			fprintf(stderr,
+				"failed to sort mcount '%s': %s\n",
+				(char *)retval, fname);
+		}
+	}
 	return rc;
 }
-- 
2.14.4.44.g2045bb6

