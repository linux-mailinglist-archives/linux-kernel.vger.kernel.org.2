Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ED3376B54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 22:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhEGU4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 16:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhEGU4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 16:56:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821D1C061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 13:55:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so6267195pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 13:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjJoLbgf5BX/TlG1bI+Kk/boPZKnP4KZr4LpucGo6G0=;
        b=DFII9SqWyqrDU9lhR3hYRV3l31VXnZO90h4xMn9cSkQqpXilJjFYmS44q9qHsxCuRt
         q5BaeNKIvn2kvWqzxsiWNybBlHP1OesIS/6xJKcf5t/SlBCjdY/doLp6V4/LIfoTvjS+
         Ci6+DW0Zojpe3elbVT9wXx6Wx2XmyBU7gk/Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjJoLbgf5BX/TlG1bI+Kk/boPZKnP4KZr4LpucGo6G0=;
        b=bZxrFRUJeDl/nZADvor6jAyYzSfnb5yNce09jz43ocg8Cv5EnGsxKaJ6iW3xgQB5zE
         OijOzPuWcKc830M8cT1ipE9VSbM9zUfttacZbis5p8iKFrwfDb6wTMVWsJQjPfJilinS
         UIzhIJni+aK36nNA+Wfvn5heLdHBn3J63LQiIc/C3cfJdlNsWQcrv3GqQ4LRR4F1nKd6
         soII6s8ZopaacduzlQ/mXscXWaVj4YE815M6idGcrT9ARHQN4B7uu05GSFffCl3ec+CX
         xg/C3+v+pUZsHN7zvqxVFsTxN5BhBHm6bsopgJeYNx2eIdY/9lCRvNT+yTA2bMgn/9gE
         EU+A==
X-Gm-Message-State: AOAM533Wn6521LFq8Hn9OlcAr5aCoCppdtIill9vjA8OfmOHQZfnlcw9
        cUUI0sKy0CQC2CL26ocpgocjag==
X-Google-Smtp-Source: ABdhPJyup01PkZ3ncI/RlK/Tat7KsSkKwUimMvrvTTRMPZsXwtUPvKcfNKmieitwxrPoVXhlbByzEQ==
X-Received: by 2002:a17:90a:6c62:: with SMTP id x89mr25313809pjj.213.1620420939064;
        Fri, 07 May 2021 13:55:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3c7e:d35:3a19:632f])
        by smtp.gmail.com with ESMTPSA id ge4sm13161565pjb.49.2021.05.07.13.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 13:55:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Seth LaForge <sethml@google.com>,
        Ricky Liang <jcliang@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] arm64: perf: Improve compat perf_callchain_user() for clang leaf functions
Date:   Fri,  7 May 2021 13:55:12 -0700
Message-Id: <20210507135509.2.Ib54050e4091679cc31b04d52d7ef200f99faaae5@changeid>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210507205513.640780-1-dianders@chromium.org>
References: <20210507205513.640780-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that even when you compile code with clang with
"-fno-omit-frame-pointer" that it won't generate a frame pointer for
leaf functions (those that don't call any sub-functions). Presumably
clang does this to reduce the overhead of frame pointers. In a leaf
function you don't really need frame pointers since the Link Register
(LR) is guaranteed to always point to the caller.

Clang's optimization here is a bit of a pain for us, though. A human
might have an easy time figuring out if a function is a leaf function
or not and in theory we could have a way to lookup a given PC to find
out if it's in a leaf function. Unfortunately we haven't passed the
Turing test and we don't have any auxiliary data to help us.

If we just ignore this problem then the end result isn't terrible. It
just turns out that the _callers_ of leaf functions won't be logged. I
guess that's OK, but it could lead to some confusing traces.

Another option (the one proposed in this patch) is to always log the
first LR when we're tracing, assuming that we hadn't already decided
to log it for some other reason.

Good things about always logging the LR:
* clang leaf functions are handled better.
* if PC is right at the start of a function (even on non-clang) it's
  handled better.

Bad things about the LR:
* We could log a "bogus" PC in the trace.

I believe that the most common "bogus" PC that would be logged would
be a PC somewhere in the top function being traced. As an example, if
we have this function:

  non_leaf():
    1. Setup the frame pointer
    2. Call example()
    3. Do something slow
    4. Do something else slow
    5. Call example2()
    6. Return

If the PC was in the middle of "Do something else slow" and then we
tried to trace, our stack trace would look like this:
  Top:  a) A PC in the middle of "Do something else slow".
        b) The return address that example() used, probably in "Do
           something slow"
	c) The caller of non_leaf()

Specifically you can see that there would be two PCs logged for
non_leaf().

To me it feels like this is a net-win. It also should be noted that
the consumer of our trace records probably _does_ have more
information than we do. It could fairly easily ignore this info.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/kernel/perf_callchain.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index e5ce5f7965d1..b3cd9f371469 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -326,6 +326,20 @@ static void compat_perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 	while ((entry->nr < entry->max_stack) && fp && !(fp & 0x3)) {
 		err = compat_perf_trace_1(&fp, &pc, leaf_lr);
 
+		/*
+		 * If this is the first trace and it didn't find the LR then
+		 * let's throw it in the trace first. This isn't perfect but
+		 * is the best we can do for handling clang leaf functions (or
+		 * the case where we're right at the start of the function
+		 * before the new frame has been pushed). In the worst case
+		 * this can cause us to throw an extra entry that will be some
+		 * location in the same function as the PC. That's not
+		 * amazing but shouldn't really hurt. It seems better than
+		 * throwing away the LR.
+		 */
+		if (leaf_lr && leaf_lr != pc)
+			perf_callchain_store(entry, leaf_lr & ~BIT(0));
+
 		/* Bail out on any type of error */
 		if (err)
 			break;
-- 
2.31.1.607.g51e8a6a459-goog

