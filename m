Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8D4354879
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 00:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbhDEWIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 18:08:48 -0400
Received: from shark1.inbox.lv ([194.152.32.81]:45928 "EHLO shark1.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232628AbhDEWIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 18:08:47 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Apr 2021 18:08:47 EDT
Received: from shark1.inbox.lv (localhost [127.0.0.1])
        by shark1-out.inbox.lv (Postfix) with ESMTP id E285911180BD;
        Tue,  6 Apr 2021 00:59:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1617659991; bh=W6RzugFv4ZB8VRs7yTU8D9UltTC8y6pq+sRljJAFCg4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=VNSFb4OuHdZjq2R//Bb+Xh531EAoqFk6g2f+3tvVseP3Ws5FUV5DL26R4eJ9j/ohC
         D8EsSc/ZB0+rzIqmWkTVb4e158RgoCmw7Dd5yrUO04fpU2F+E7NfD8W+gskj96HY8I
         7txfRH9MO/nlkZwNCn4KfvSnIqjC9tIoIWByBnKo=
Received: from localhost (localhost [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id DD28811180B5;
        Tue,  6 Apr 2021 00:59:51 +0300 (EEST)
Received: from shark1.inbox.lv ([127.0.0.1])
        by localhost (shark1.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id hD014udIxnnt; Tue,  6 Apr 2021 00:59:51 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id 161D011180B3;
        Tue,  6 Apr 2021 00:59:51 +0300 (EEST)
Received: from mail.inbox.lv (unknown [79.105.70.177])
        (Authenticated sender: hakavlad@inbox.lv)
        by mail.inbox.lv (Postfix) with ESMTPA id 73A0E3E60170;
        Tue,  6 Apr 2021 00:59:49 +0300 (EEST)
Date:   Tue, 6 Apr 2021 06:59:44 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Stillinux <stillinux@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, liuzhengyuan@kylinos.cn,
        liuyun01@kylinos.cn
Subject: Re: [RFC PATCH] mm/swap: fix system stuck due to infinite loop
Message-ID: <20210406065944.08d8aa76@mail.inbox.lv>
In-Reply-To: <CAKN5gChSwSs1Zy1r7iXHw7ZSKy7Nkr3NqcqJSn7z9yZPr3J2AA@mail.gmail.com>
References: <CAKN5gChSwSs1Zy1r7iXHw7ZSKy7Nkr3NqcqJSn7z9yZPr3J2AA@mail.gmail.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: EZeEAiZdhRs1tcaiWPdhhYb4v7a+UVM9vCf/0Low93Nesa+jx9N0dm6WEoPnHwG8bg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the case of high system memory and load pressure, we ran ltp test
> and found that the system was stuck, the direct memory reclaim was
> all stuck in io_schedule

> For the first time involving the swap part, there is no good way to fix
> the problem

The solution is protecting the clean file pages.

Look at this:

> On ChromiumOS, we do not use swap. When memory is low, the only=20
> way to free memory is to reclaim pages from the file list. This=20
> results in a lot of thrashing under low memory conditions. We see=20
> the system become unresponsive for minutes before it eventually OOMs.=20
> We also see very slow browser tab switching under low memory. Instead=20
> of an unresponsive system, we'd really like the kernel to OOM as soon=20
> as it starts to thrash. If it can't keep the working set in memory,=20
> then OOM. Losing one of many tabs is a better behaviour for the user=20
> than an unresponsive system.

> This patch create a new sysctl, min_filelist_kbytes, which disables=20
> reclaim of file-backed pages when when there are less than min_filelist_b=
ytes=20
> worth of such pages in the cache. This tunable is handy for low memory=20
> systems using solid-state storage where interactive response is more impo=
rtant=20
> than not OOMing.

> With this patch and min_filelist_kbytes set to 50000, I see very little b=
lock=20
> layer activity during low memory. The system stays responsive under low=20
> memory and browser tab switching is fast. Eventually, a process a gets ki=
lled=20
> by OOM. Without this patch, the system gets wedged for minutes before it=
=20
> eventually OOMs.

=E2=80=94 https://lore.kernel.org/patchwork/patch/222042/

This patch can almost completely eliminate thrashing under memory pressure.

Effects
- Improving system responsiveness under low-memory conditions;
- Improving performans in I/O bound tasks under memory pressure;
- OOM killer comes faster (with hard protection);
- Fast system reclaiming after OOM.

Read more: https://github.com/hakavlad/le9-patch

The patch:

=46rom 371e3e5290652e97d5279d8cd215cd356c1fb47b Mon Sep 17 00:00:00 2001
From: Alexey Avramov <hakavlad@inbox.lv>
Date: Mon, 5 Apr 2021 01:53:26 +0900
Subject: [PATCH] mm/vmscan: add sysctl knobs for protecting the specified
 amount of clean file cache

The kernel does not have a mechanism for targeted protection of clean
file pages (CFP). A certain amount of the CFP is required by the userspace
for normal operation. First of all, you need a cache of shared libraries
and executable files. If the volume of the CFP cache falls below a certain
level, thrashing and even livelock occurs.

Protection of CFP may be used to prevent thrashing and reducing I/O under
memory pressure. Hard protection of CFP may be used to avoid high latency
and prevent livelock in near-OOM conditions. The patch provides sysctl
knobs for protecting the specified amount of clean file cache under memory
pressure.

The vm.clean_low_kbytes sysctl knob provides *best-effort* protection of
CFP. The CFP on the current node won't be reclaimed uder memory pressure
when their volume is below vm.clean_low_kbytes *unless* we threaten to OOM
or have no swap space or vm.swappiness=3D0. Setting it to a high value may
result in a early eviction of anonymous pages into the swap space by
attempting to hold the protected amount of clean file pages in memory. The
default value is defined by CONFIG_CLEAN_LOW_KBYTES (suggested 0 in
Kconfig).

The vm.clean_min_kbytes sysctl knob provides *hard* protection of CFP. The
CFP on the current node won't be reclaimed under memory pressure when their
volume is below vm.clean_min_kbytes. Setting it to a high value may result
in a early out-of-memory condition due to the inability to reclaim the
protected amount of CFP when other types of pages cannot be reclaimed. The
default value is defined by CONFIG_CLEAN_MIN_KBYTES (suggested 0 in
Kconfig).

Reported-by: Artem S. Tashkinov <aros@gmx.com>
Signed-off-by: Alexey Avramov <hakavlad@inbox.lv>
---
 Documentation/admin-guide/sysctl/vm.rst | 37 +++++++++++++++++++++
 include/linux/mm.h                      |  3 ++
 kernel/sysctl.c                         | 14 ++++++++
 mm/Kconfig                              | 35 +++++++++++++++++++
 mm/vmscan.c                             | 59 +++++++++++++++++++++++++++++=
++++
 5 files changed, 148 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-=
guide/sysctl/vm.rst
index f455fa00c..5d5ddfc85 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -26,6 +26,8 @@ Currently, these files are in /proc/sys/vm:

 - admin_reserve_kbytes
 - block_dump
+- clean_low_kbytes
+- clean_min_kbytes
 - compact_memory
 - compaction_proactiveness
 - compact_unevictable_allowed
@@ -113,6 +115,41 @@ block_dump enables block I/O debugging when set to a n=
onzero value. More
 information on block I/O debugging is in Documentation/admin-guide/laptops=
/laptop-mode.rst.


+clean_low_kbytes
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This knob provides *best-effort* protection of clean file pages. The clean=
 file
+pages on the current node won't be reclaimed uder memory pressure when the=
ir
+volume is below vm.clean_low_kbytes *unless* we threaten to OOM or have no
+swap space or vm.swappiness=3D0.
+
+Protection of clean file pages may be used to prevent thrashing and
+reducing I/O under low-memory conditions.
+
+Setting it to a high value may result in a early eviction of anonymous pag=
es
+into the swap space by attempting to hold the protected amount of clean fi=
le
+pages in memory.
+
+The default value is defined by CONFIG_CLEAN_LOW_KBYTES.
+
+
+clean_min_kbytes
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This knob provides *hard* protection of clean file pages. The clean file p=
ages
+on the current node won't be reclaimed under memory pressure when their vo=
lume
+is below vm.clean_min_kbytes.
+
+Hard protection of clean file pages may be used to avoid high latency and
+prevent livelock in near-OOM conditions.
+
+Setting it to a high value may result in a early out-of-memory condition d=
ue to
+the inability to reclaim the protected amount of clean file pages when oth=
er
+types of pages cannot be reclaimed.
+
+The default value is defined by CONFIG_CLEAN_MIN_KBYTES.
+
+
 compact_memory
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d3f..7799f1555 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -202,6 +202,9 @@ static inline void __mm_zero_struct_page(struct page *p=
age)

 extern int sysctl_max_map_count;

+extern unsigned long sysctl_clean_low_kbytes;
+extern unsigned long sysctl_clean_min_kbytes;
+
 extern unsigned long sysctl_user_reserve_kbytes;
 extern unsigned long sysctl_admin_reserve_kbytes;

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index afad08596..854b311cd 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3083,6 +3083,20 @@ static struct ctl_table vm_table[] =3D {
 	},
 #endif
 	{
+		.procname	=3D "clean_low_kbytes",
+		.data		=3D &sysctl_clean_low_kbytes,
+		.maxlen		=3D sizeof(sysctl_clean_low_kbytes),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_doulongvec_minmax,
+	},
+	{
+		.procname	=3D "clean_min_kbytes",
+		.data		=3D &sysctl_clean_min_kbytes,
+		.maxlen		=3D sizeof(sysctl_clean_min_kbytes),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_doulongvec_minmax,
+	},
+	{
 		.procname	=3D "user_reserve_kbytes",
 		.data		=3D &sysctl_user_reserve_kbytes,
 		.maxlen		=3D sizeof(sysctl_user_reserve_kbytes),
diff --git a/mm/Kconfig b/mm/Kconfig
index 390165ffb..3915c71e1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -122,6 +122,41 @@ config SPARSEMEM_VMEMMAP
 	  pfn_to_page and page_to_pfn operations.  This is the most
 	  efficient option when sufficient kernel resources are available.

+config CLEAN_LOW_KBYTES
+	int "Default value for vm.clean_low_kbytes"
+	depends on SYSCTL
+	default "0"
+	help
+	  The vm.clean_file_low_kbytes sysctl knob provides *best-effort*
+	  protection of clean file pages. The clean file pages on the current
+	  node won't be reclaimed uder memory pressure when their volume is
+	  below vm.clean_low_kbytes *unless* we threaten to OOM or have
+	  no swap space or vm.swappiness=3D0.
+
+	  Protection of clean file pages may be used to prevent thrashing and
+	  reducing I/O under low-memory conditions.
+
+	  Setting it to a high value may result in a early eviction of anonymous
+	  pages into the swap space by attempting to hold the protected amount of
+	  clean file pages in memory.
+
+config CLEAN_MIN_KBYTES
+	int "Default value for vm.clean_min_kbytes"
+	depends on SYSCTL
+	default "0"
+	help
+	  The vm.clean_file_min_kbytes sysctl knob provides *hard* protection
+	  of clean file pages. The clean file pages on the current node won't be
+	  reclaimed under memory pressure when their volume is below
+	  vm.clean_min_kbytes.
+
+	  Hard protection of clean file pages may be used to avoid high latency a=
nd
+	  prevent livelock in near-OOM conditions.
+
+	  Setting it to a high value may result in a early out-of-memory condition
+	  due to the inability to reclaim the protected amount of clean file pages
+	  when other types of pages cannot be reclaimed.
+
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7b4e31eac..77e98c43e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -120,6 +120,19 @@ struct scan_control {
 	/* The file pages on the current node are dangerously low */
 	unsigned int file_is_tiny:1;

+	/*
+	 * The clean file pages on the current node won't be reclaimed when
+	 * their volume is below vm.clean_low_kbytes *unless* we threaten
+	 * to OOM or have no swap space or vm.swappiness=3D0.
+	 */
+	unsigned int clean_below_low:1;
+
+	/*
+	 * The clean file pages on the current node won't be reclaimed when
+	 * their volume is below vm.clean_min_kbytes.
+	 */
+	unsigned int clean_below_min:1;
+
 	/* Allocation order */
 	s8 order;

@@ -166,6 +179,17 @@ struct scan_control {
 #define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
 #endif

+#if CONFIG_CLEAN_LOW_KBYTES < 0
+#error "CONFIG_CLEAN_LOW_KBYTES must be >=3D 0"
+#endif
+
+#if CONFIG_CLEAN_MIN_KBYTES < 0
+#error "CONFIG_CLEAN_MIN_KBYTES must be >=3D 0"
+#endif
+
+unsigned long sysctl_clean_low_kbytes __read_mostly =3D CONFIG_CLEAN_LOW_K=
BYTES;
+unsigned long sysctl_clean_min_kbytes __read_mostly =3D CONFIG_CLEAN_MIN_K=
BYTES;
+
 /*
  * From 0 .. 200.  Higher means more swappy.
  */
@@ -2283,6 +2307,16 @@ static void get_scan_count(struct lruvec *lruvec, st=
ruct scan_control *sc,
 	}

 	/*
+	 * Force-scan anon if clean file pages is under vm.clean_min_kbytes
+	 * or vm.clean_low_kbytes (unless the swappiness setting
+	 * disagrees with swapping).
+	 */
+	if ((sc->clean_below_low || sc->clean_below_min) && swappiness) {
+		scan_balance =3D SCAN_ANON;
+		goto out;
+	}
+
+	/*
 	 * If there is enough inactive page cache, we do not reclaim
 	 * anything from the anonymous working right now.
 	 */
@@ -2418,6 +2452,13 @@ static void get_scan_count(struct lruvec *lruvec, st=
ruct scan_control *sc,
 			BUG();
 		}

+		/*
+		 * Don't reclaim clean file pages when their volume is below
+		 * vm.clean_min_kbytes.
+		 */
+		if (file && sc->clean_below_min)
+			scan =3D 0;
+
 		nr[lru] =3D scan;
 	}
 }
@@ -2768,6 +2809,24 @@ static void shrink_node(pg_data_t *pgdat, struct sca=
n_control *sc)
 			anon >> sc->priority;
 	}

+	if (sysctl_clean_low_kbytes || sysctl_clean_min_kbytes) {
+		unsigned long reclaimable_file, dirty, clean;
+
+		reclaimable_file =3D
+			node_page_state(pgdat, NR_ACTIVE_FILE) +
+			node_page_state(pgdat, NR_INACTIVE_FILE) +
+			node_page_state(pgdat, NR_ISOLATED_FILE);
+		dirty =3D node_page_state(pgdat, NR_FILE_DIRTY);
+		if (reclaimable_file > dirty)
+			clean =3D (reclaimable_file - dirty) << (PAGE_SHIFT - 10);
+
+		sc->clean_below_low =3D clean < sysctl_clean_low_kbytes;
+		sc->clean_below_min =3D clean < sysctl_clean_min_kbytes;
+	} else {
+		sc->clean_below_low =3D false;
+		sc->clean_below_min =3D false;
+	}
+
 	shrink_node_memcgs(pgdat, sc);

 	if (reclaim_state) {
--
2.11.0

