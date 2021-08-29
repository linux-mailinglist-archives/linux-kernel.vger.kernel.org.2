Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5DA3FAADC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 12:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhH2KXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 06:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhH2KXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 06:23:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B819DC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 03:22:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id c17so10495130pgc.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 03:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZCTED9Rc9DrmSApqJuoEoooUilGQMSmT0h7tdXp9XtE=;
        b=QufaFJu8mn5eZnC8eoPjdR2WJTrXvJonp/QxAFjYZP5Nsh82uxSJPA7zyDpSAzDlUE
         SdBU38oRyd6Tdep1zZ1Zfsmv9ECc4sTlKiKZDKz+vvL8G4Dd0RbIqbDHYaik+PbDdk6m
         IcU+d47a91XFLkmBo8CY8yJcY2JqOonklCqq05Se0jsXU3PP1js2+AdJHViVphQgM4X1
         5pzH21d1dObhQicJQZ+QO3L3Ec6MdF6tgvQZaev5owukc50DfhKof2ppU2q8YS34yxb0
         93pBYylYeszdet0oV8dFJlAcg9aZyxW0uqIUNYYOnKH/ybSNLxSVNzTC0r9q76+Zmce2
         /5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZCTED9Rc9DrmSApqJuoEoooUilGQMSmT0h7tdXp9XtE=;
        b=i4sZqNDJvSZoSKyigrO2kBCJA0CrrCj60SAbP5SqATz1EL5e4qfAKOj+y8a0LR9dzl
         DCxusRX3TYHKtnLNS/mpud/HXSrOpEL1IYX2s4/GsAzPwE32PrvsyXjHjztBAvYRw7hY
         TnlXoa8dQ5J+Akq/bUA6e0hSw/SqilY4rxA8pxDZtl87dfFp2Iz9onVy1eQu5QjDLKbt
         et9Fkcz40Xm0CMWVlSAs1nbvDXyEHWHGl5nWfRKJ/Eup0eGpUul4fmClSt30uIG0+2GZ
         rvbqrmQzHJGa5S6lW+fvEr+udwdAqnaM4dvKA3gQCjMzm7n0Uv+49O1K5rkcA9gMdSoD
         mgzA==
X-Gm-Message-State: AOAM530WyDRNMJV2tXw9EVHz30gbecyGwGKFVDlO8IWSSTLkMOd2Z6Lj
        D0tH9q7/0tBUGoeSBMXYRZPs5Q==
X-Google-Smtp-Source: ABdhPJwZHsG7wyWCUEelUzrj0hy6XWetupcOjR0KhJsxKIDEkzgBBgA/+6dQ7sIOD8m6FxUzcpEF8g==
X-Received: by 2002:a05:6a00:1245:b029:30f:2098:fcf4 with SMTP id u5-20020a056a001245b029030f2098fcf4mr17823079pfi.66.1630232578143;
        Sun, 29 Aug 2021 03:22:58 -0700 (PDT)
Received: from localhost ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id y5sm11266623pfa.5.2021.08.29.03.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 03:22:57 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/2] perf auxtrace: Add compat_auxtrace_mmap__{read_head|write_tail}
Date:   Sun, 29 Aug 2021 18:22:37 +0800
Message-Id: <20210829102238.19693-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829102238.19693-1-leo.yan@linaro.org>
References: <20210829102238.19693-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf runs in compat mode (kernel in 64-bit mode and the perf is in
32-bit mode), the 64-bit value atomicity in the user space cannot be
assured, E.g. on some architectures, the 64-bit value accessing is split
into two instructions, one is for the low 32-bit word accessing and
another is for the high 32-bit word.

This patch introduces weak functions compat_auxtrace_mmap__read_head()
and compat_auxtrace_mmap__write_tail(), as their naming indicates, when
perf tool works in compat mode, it uses these two functions to access
the AUX head and tail.  These two functions can allow the perf tool to
work properly in certain conditions, e.g. when perf tool works in
snapshot mode with only using AUX head pointer, or perf tool uses the
AUX buffer and the incremented tail is not bigger than 4GB.

When perf tool cannot handle the case when the AUX tail is bigger than
4GB, the function compat_auxtrace_mmap__write_tail() returns -1 and
tells the caller to bail out for the error.

These two functions are declared as weak attribute, this allows to
implement arch specific functions if any arch can support the 64-bit
value atomicity in compat mode.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 88 ++++++++++++++++++++++++++++++++++++--
 tools/perf/util/auxtrace.h | 22 ++++++++--
 2 files changed, 103 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index f33f09b8b535..8d2865b9ade2 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1669,6 +1669,82 @@ int perf_event__process_auxtrace_error(struct perf_session *session,
 	return 0;
 }
 
+/*
+ * In the compat mode kernel runs in 64-bit and perf tool runs in 32-bit mode,
+ * 32-bit perf tool cannot access 64-bit value atomically, which might lead to
+ * the issues caused by the below sequence on multiple CPUs: when perf tool
+ * accesses either the load operation or the store operation for 64-bit value,
+ * on some architectures the operation is divided into two instructions, one
+ * is for accessing the low 32-bit value and another is for the high 32-bit;
+ * thus these two user operations can give the kernel chances to access the
+ * 64-bit value, and thus leads to the unexpected load values.
+ *
+ *   kernel (64-bit)                        user (32-bit)
+ *
+ *   if (LOAD ->aux_tail) { --,             LOAD ->aux_head_lo
+ *       STORE $aux_data      |       ,--->
+ *       FLUSH $aux_data      |       |     LOAD ->aux_head_hi
+ *       STORE ->aux_head   --|-------`     smp_rmb()
+ *   }                        |             LOAD $data
+ *                            |             smp_mb()
+ *                            |             STORE ->aux_tail_lo
+ *                            `----------->
+ *                                          STORE ->aux_tail_hi
+ *
+ * For this reason, it's impossible for the perf tool to work correctly when
+ * the AUX head or tail is bigger than 4GB (more than 32 bits length); and we
+ * can not simply limit the AUX ring buffer to less than 4GB, the reason is
+ * the pointers can be increased monotonically, whatever the buffer size it is,
+ * at the end the head and tail can be bigger than 4GB and carry out to the
+ * high 32-bit.
+ *
+ * To mitigate the issues and improve the user experience, we can allow the
+ * perf tool working in certain conditions and bail out with error if detect
+ * any overflow cannot be handled.
+ *
+ * For reading the AUX head, it reads out the values for three times, and
+ * compares the high 4 bytes of the values between the first time and the last
+ * time, if there has no change for high 4 bytes injected by the kernel during
+ * the user reading sequence, it's safe for use the second value.
+ *
+ * When compat_auxtrace_mmap__write_tail() detects any carrying in the high
+ * 32 bits, it means there have two store operations in user space and it cannot
+ * promise the atomicity for 64-bit write, so return '-1' in this case to tell
+ * the caller an overflow error has happened.
+ */
+u64 __weak compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
+{
+	struct perf_event_mmap_page *pc = mm->userpg;
+	u64 first, second, last;
+	u64 mask = (u64)(UINT32_MAX) << 32;
+
+	do {
+		first = READ_ONCE(pc->aux_head);
+		/* Ensure all reads are done after we read the head */
+		smp_rmb();
+		second = READ_ONCE(pc->aux_head);
+		/* Ensure all reads are done after we read the head */
+		smp_rmb();
+		last = READ_ONCE(pc->aux_head);
+	} while ((first & mask) != (last & mask));
+
+	return second;
+}
+
+int __weak compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
+{
+	struct perf_event_mmap_page *pc = mm->userpg;
+	u64 mask = (u64)(UINT32_MAX) << 32;
+
+	if (tail & mask)
+		return -1;
+
+	/* Ensure all reads are done before we write the tail out */
+	smp_mb();
+	WRITE_ONCE(pc->aux_tail, tail);
+	return 0;
+}
+
 static int __auxtrace_mmap__read(struct mmap *map,
 				 struct auxtrace_record *itr,
 				 struct perf_tool *tool, process_auxtrace_t fn,
@@ -1680,8 +1756,9 @@ static int __auxtrace_mmap__read(struct mmap *map,
 	size_t size, head_off, old_off, len1, len2, padding;
 	union perf_event ev;
 	void *data1, *data2;
+	int kernel_is_64_bit = perf_env__kernel_is_64_bit(evsel__env(NULL));
 
-	head = auxtrace_mmap__read_head(mm);
+	head = auxtrace_mmap__read_head(mm, kernel_is_64_bit);
 
 	if (snapshot &&
 	    auxtrace_record__find_snapshot(itr, mm->idx, mm, data, &head, &old))
@@ -1764,10 +1841,13 @@ static int __auxtrace_mmap__read(struct mmap *map,
 	mm->prev = head;
 
 	if (!snapshot) {
-		auxtrace_mmap__write_tail(mm, head);
-		if (itr->read_finish) {
-			int err;
+		int err;
+
+		err = auxtrace_mmap__write_tail(mm, head, kernel_is_64_bit);
+		if (err < 0)
+			return err;
 
+		if (itr->read_finish) {
 			err = itr->read_finish(itr, mm->idx);
 			if (err < 0)
 				return err;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index d68a5e80b217..5f383908ca6e 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -440,23 +440,39 @@ struct auxtrace_cache;
 
 #ifdef HAVE_AUXTRACE_SUPPORT
 
-static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
+u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm);
+int compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail);
+
+static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm,
+					   int kernel_is_64_bit __maybe_unused)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
-	u64 head = READ_ONCE(pc->aux_head);
+	u64 head;
+
+#if BITS_PER_LONG == 32
+	if (kernel_is_64_bit)
+		return compat_auxtrace_mmap__read_head(mm);
+#endif
+	head = READ_ONCE(pc->aux_head);
 
 	/* Ensure all reads are done after we read the head */
 	smp_rmb();
 	return head;
 }
 
-static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
+static inline int auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail,
+					    int kernel_is_64_bit __maybe_unused)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
 
+#if BITS_PER_LONG == 32
+	if (kernel_is_64_bit)
+		return compat_auxtrace_mmap__write_tail(mm, tail);
+#endif
 	/* Ensure all reads are done before we write the tail out */
 	smp_mb();
 	WRITE_ONCE(pc->aux_tail, tail);
+	return 0;
 }
 
 int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
-- 
2.25.1

