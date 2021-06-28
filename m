Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F5D3B5EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhF1Ngw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbhF1Ngl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:36:41 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD63C061574;
        Mon, 28 Jun 2021 06:34:14 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id t9so13531033qtw.7;
        Mon, 28 Jun 2021 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CdmoOZ7ERpqE0Pemw7A7kG9xTI1e7uOovwF3DOxLIPc=;
        b=vYDAKdUvgK5nNfdkjl/K/c0tEw7qEgFnE3m+Er0Z5Jrido86OF46IYugbtosuIpPrg
         ET+fWW+rUm+xOmWkfj2CmnsU5b3f1diwOlCxdeeuY8lMQKR+AdMd6dTpbo+PueU41L7R
         ppiaA4FWClC6LNjUIY6B5f+RFImoabvBSgut3jX8wmCMg/mx1obDP3hF8E9bcVq4/eyI
         7aNsGZ+ntJCJXrR6qZ3P/r7U1CRdoU+Za5wdGWn9EUMSp5knchQrJvUcY3HDI3RA39/C
         Ko0izeLwpJ0143nDzUnapvBfRhUxhTUnfPQfeMfZOdW14ASTmtZ2pPJzZz6x1Tyl/kN8
         8IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CdmoOZ7ERpqE0Pemw7A7kG9xTI1e7uOovwF3DOxLIPc=;
        b=PVXJJYUW8lZdNV5pv2NtU4UCXd9jpc5NISUIjqn7gH4AxaOxzJu8up4MAeADk0KfE1
         UGycM4CYz9tWTAdVOFq6GS1rA80xYgZvdwAzFmGzICYgGNfWXl90T/+CgMFVnza09SBv
         csK7awbdNpALnM2jcz7avD/CZSrb1LIbtTTcdHagCC99DTrTo8cOMX7XfS63ff0VQMqC
         PDWR5T9+MEgv5BB0UO1h8jIxOYSUlDv2t9rzUDL6n+AJ5f7tTJg89dHzNKrc6KTrUIUu
         jA3yOKrJo6Elfu/HKOKmaNmtvjdBpLKiDMD/OvfH1uAx1flzjJfBPt1X3h23Cp4omODv
         Bvrw==
X-Gm-Message-State: AOAM531m2mBK1xeIE1juURiw1E28d8ZoKeBPf1FWflQgJBiZQKSIHZAJ
        d5rbNdsk8F3pZnTbyXweU6o=
X-Google-Smtp-Source: ABdhPJxMIloxv2HBpgaknc/DPwdbEZo/DkTvwtlWr9IG/sZNy1B6XOpy95m0B+9Qkj+VQpehNLRyXg==
X-Received: by 2002:ac8:7516:: with SMTP id u22mr21746585qtq.160.1624887253973;
        Mon, 28 Jun 2021 06:34:13 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h1sm2276030qkm.50.2021.06.28.06.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 06:34:13 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        mheyne@amazon.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, sieberf@amazon.com,
        sj38.park@gmail.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v32 04/13] mm/idle_page_tracking: Make PG_idle reusable
Date:   Mon, 28 Jun 2021 13:33:46 +0000
Message-Id: <20210628133355.18576-5-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210628133355.18576-1-sj38.park@gmail.com>
References: <20210628133355.18576-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

PG_idle and PG_young allow the two PTE Accessed bit users, Idle Page
Tracking and the reclaim logic concurrently work while not interfering
with each other.  That is, when they need to clear the Accessed bit,
they set PG_young to represent the previous state of the bit,
respectively.  And when they need to read the bit, if the bit is
cleared, they further read the PG_young to know whether the other has
cleared the bit meanwhile or not.

For yet another user of the PTE Accessed bit, we could add another page
flag, or extend the mechanism to use the flags. For the DAMON usecase,
however, we don't need to do that just yet.  IDLE_PAGE_TRACKING and
DAMON are mutually exclusive, so there's only ever going to be one user
of the current set of flags.

In this commit, we split out the CONFIG options to allow for the use of
PG_young and PG_idle outside of idle page tracking.

In the next commit, DAMON's reference implementation of the virtual
memory address space monitoring primitives will use it.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Fernand Sieber <sieberf@amazon.com>
---
 include/linux/page-flags.h     |  4 ++--
 include/linux/page_ext.h       |  2 +-
 include/linux/page_idle.h      |  6 +++---
 include/trace/events/mmflags.h |  2 +-
 mm/Kconfig                     |  8 ++++++++
 mm/page_ext.c                  | 12 +++++++++++-
 mm/page_idle.c                 | 10 ----------
 7 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5922031ffab6..5621d628914d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -131,7 +131,7 @@ enum pageflags {
 #ifdef CONFIG_MEMORY_FAILURE
 	PG_hwpoison,		/* hardware poisoned page. Don't touch */
 #endif
-#if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
+#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
 	PG_young,
 	PG_idle,
 #endif
@@ -439,7 +439,7 @@ PAGEFLAG_FALSE(HWPoison)
 #define __PG_HWPOISON 0
 #endif
 
-#if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
+#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
 TESTPAGEFLAG(Young, young, PF_ANY)
 SETPAGEFLAG(Young, young, PF_ANY)
 TESTCLEARFLAG(Young, young, PF_ANY)
diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index aff81ba31bd8..fabb2e1e087f 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -19,7 +19,7 @@ struct page_ext_operations {
 enum page_ext_flags {
 	PAGE_EXT_OWNER,
 	PAGE_EXT_OWNER_ALLOCATED,
-#if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
+#if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
 	PAGE_EXT_YOUNG,
 	PAGE_EXT_IDLE,
 #endif
diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index 1e894d34bdce..d8a6aecf99cb 100644
--- a/include/linux/page_idle.h
+++ b/include/linux/page_idle.h
@@ -6,7 +6,7 @@
 #include <linux/page-flags.h>
 #include <linux/page_ext.h>
 
-#ifdef CONFIG_IDLE_PAGE_TRACKING
+#ifdef CONFIG_PAGE_IDLE_FLAG
 
 #ifdef CONFIG_64BIT
 static inline bool page_is_young(struct page *page)
@@ -106,7 +106,7 @@ static inline void clear_page_idle(struct page *page)
 }
 #endif /* CONFIG_64BIT */
 
-#else /* !CONFIG_IDLE_PAGE_TRACKING */
+#else /* !CONFIG_PAGE_IDLE_FLAG */
 
 static inline bool page_is_young(struct page *page)
 {
@@ -135,6 +135,6 @@ static inline void clear_page_idle(struct page *page)
 {
 }
 
-#endif /* CONFIG_IDLE_PAGE_TRACKING */
+#endif /* CONFIG_PAGE_IDLE_FLAG */
 
 #endif /* _LINUX_MM_PAGE_IDLE_H */
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 390270e00a1d..d428f0137c49 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -73,7 +73,7 @@
 #define IF_HAVE_PG_HWPOISON(flag,string)
 #endif
 
-#if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
+#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
 #define IF_HAVE_PG_IDLE(flag,string) ,{1UL << flag, string}
 #else
 #define IF_HAVE_PG_IDLE(flag,string)
diff --git a/mm/Kconfig b/mm/Kconfig
index f63aa00fecca..a39fb58d0b0a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -742,10 +742,18 @@ config DEFERRED_STRUCT_PAGE_INIT
 	  lifetime of the system until these kthreads finish the
 	  initialisation.
 
+config PAGE_IDLE_FLAG
+	bool "Add PG_idle and PG_young flags"
+	help
+	  This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
+	  Accessed bit writers can set the state of the bit in the flags to let
+	  other PTE Accessed bit readers don't disturbed.
+
 config IDLE_PAGE_TRACKING
 	bool "Enable idle page tracking"
 	depends on SYSFS && MMU && BROKEN
 	select PAGE_EXTENSION if !64BIT
+	select PAGE_IDLE_FLAG
 	help
 	  This feature allows to estimate the amount of user pages that have
 	  not been touched during a given period of time. This information can
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 293b2685fc48..dfb91653d359 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -58,11 +58,21 @@
  * can utilize this callback to initialize the state of it correctly.
  */
 
+#if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
+static bool need_page_idle(void)
+{
+	return true;
+}
+struct page_ext_operations page_idle_ops = {
+	.need = need_page_idle,
+};
+#endif
+
 static struct page_ext_operations *page_ext_ops[] = {
 #ifdef CONFIG_PAGE_OWNER
 	&page_owner_ops,
 #endif
-#if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
+#if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
 	&page_idle_ops,
 #endif
 };
diff --git a/mm/page_idle.c b/mm/page_idle.c
index 64e5344a992c..edead6a8a5f9 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -207,16 +207,6 @@ static const struct attribute_group page_idle_attr_group = {
 	.name = "page_idle",
 };
 
-#ifndef CONFIG_64BIT
-static bool need_page_idle(void)
-{
-	return true;
-}
-struct page_ext_operations page_idle_ops = {
-	.need = need_page_idle,
-};
-#endif
-
 static int __init page_idle_init(void)
 {
 	int err;
-- 
2.17.1

