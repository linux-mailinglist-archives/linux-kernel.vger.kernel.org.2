Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12E53E447E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhHILQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbhHILQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:16:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CAEC061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:15:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so25000379pjn.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JMq6WExUFZd1HuHAVA66lulQNaTcfPFd0CC3jcolhg=;
        b=qN71of/nY++30vujtrg1iMgGE8+tyr2ifcCQm07A1XgMO9+eChLUqIseOeqsjFRgHH
         8ku1r4t8/7rw7h5EwnHHpnMhr8q/mFzNekJ/vwDqv3HG2g0wAPHtxxocjkLEgfSz+Jz4
         z01Q/Y2F2Y4IN++t3Q0mybMcnAeInTWGTDfEWvNY5IPAZjhrF2l7aPU6sdY1HB+lstJR
         azDUqHXylKnf8F9VNfwGANP+zmpTqP4D5P2rXzz9UqO6BPSZF+1WFJGyt3ATJZGaSfRd
         mUfdK4QNCcbowtG2qyQtGvQxNyYqjIBQcMoZbSXIZ5SylmpFYz5S7M5WD2s9dJaKvrsr
         YpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JMq6WExUFZd1HuHAVA66lulQNaTcfPFd0CC3jcolhg=;
        b=DimH4vSgqxYSVudjGvxicbBUiIrAAxkWp9vIXs2MSAgL2FocJxVUmCOA1asBGpB3ey
         SgnlO61NtXwH8MDSO0zCdA7vREoI4tg8UivzX9QiBuN5jEUX437c6HMa5JgC4toiuZ5d
         JIXszV1EMBmm6zznx9b2KP2lcHBuhx6L/8KGcZhvHixlvcDrFJg2jJyhzw+RJKVnvV1j
         nb0Q6SgEpvYJ1oE4N3GqVUirlsLJqRRWmCVlgPj60ll72xDKspxFObNOLCkjDAL6JosA
         u+ukmkzqM5pFfIy5iGFTsv52ojNDQZfPAY+F+/4pWkDy42+XPjZD3ueLKPbhg6JTHftQ
         tARw==
X-Gm-Message-State: AOAM5303zxhCX1aBtJ3OMxDtgggWXN6K3tb5mkVbRDmqjKKGYgtn2ali
        tZCKOdzaojeo2u+RG2UBOgAtDg==
X-Google-Smtp-Source: ABdhPJy4Lb89rmwQ6aIgcsF8VixeS8FYlX1FHs9yh3GLEZbP9g0XXsNh+2B0qVPBSdiiHJTk1XVC+A==
X-Received: by 2002:a17:902:ecc6:b029:12c:44b:40bd with SMTP id a6-20020a170902ecc6b029012c044b40bdmr19695914plh.33.1628507739583;
        Mon, 09 Aug 2021 04:15:39 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id t8sm23234797pgh.18.2021.08.09.04.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:15:39 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 8/9] perf: Cleanup for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
Date:   Mon,  9 Aug 2021 19:14:06 +0800
Message-Id: <20210809111407.596077-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809111407.596077-1-leo.yan@linaro.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the __sync functions have been dropped, This patch removes unused
build and checking for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT in perf tool.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Makefile.config | 4 ----
 tools/perf/util/auxtrace.c | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index eb8e487ef90b..4a0d9a6defc7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -349,10 +349,6 @@ CXXFLAGS += $(INC_FLAGS)
 
 LIBPERF_CFLAGS := $(CORE_CFLAGS) $(EXTRA_CFLAGS)
 
-ifeq ($(feature-sync-compare-and-swap), 1)
-  CFLAGS += -DHAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
-endif
-
 ifeq ($(feature-pthread-attr-setaffinity-np), 1)
   CFLAGS += -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
 endif
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 2dcf3d12ba32..f33f09b8b535 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -130,11 +130,6 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 		return 0;
 	}
 
-#if BITS_PER_LONG != 64 && !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
-	pr_err("Cannot use AUX area tracing mmaps\n");
-	return -1;
-#endif
-
 	pc->aux_offset = mp->offset;
 	pc->aux_size = mp->len;
 
-- 
2.25.1

