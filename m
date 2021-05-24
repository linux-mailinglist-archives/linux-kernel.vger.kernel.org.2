Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46ED338F5DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhEXWw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEXWwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:52:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506ADC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:50:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso10343585pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/pojpx49nBgoCnLv6PJmHiEPv+NEb0CeEA3aP4w8RUc=;
        b=mP2HHewmqhCSjKSKOLAYOsHDfAshYWTCZ8rDihDMMKh+z5Q1E+7zYXjP8375zooPUL
         UGxn8zYCS2ZtzW254pKR35tNnnvjDCneg28CAr1QRhDyBTW3sH5sBbDC/Fgzj4TvgfA4
         xMksnwUSyE9o+j7bZWcOS+3pnkwlOPbHz5n/MByxOybnlm21JshPQu8xwSZIxt8zlBnn
         Axzt/DnFQAtbiv1ESu7XbcffKkjFRJ6bA6pW3tyMjaFkWC9dtF0HGY1UJg3rpotldEKX
         8OpKN13/mNYB1zJybEdhwTIaQYxhJoqTZFnLCQ1urmcFuoBMtQ+RDh9Hg0+T2UR/M0lw
         oT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/pojpx49nBgoCnLv6PJmHiEPv+NEb0CeEA3aP4w8RUc=;
        b=GKD14G49eOBuzqJ16jWjc69OUQklbcJEV4j68UZvc8Yd/+ReFmBCsu+R2q78vqQGwp
         e4F38T6RHuzJbe4X/emNSP40rvAxG15mVQk/ZYsp4fzFCMIL346yUl/9IBlM673XKrkA
         SaF2S6dHb/kYx/qTse4vz5GdnpPVTGLeor26g50yD3rjcCdqhNSCEWq7cwbwfqY0sq05
         w+DZae+KMjAmWdWDdRJuRq4rVpgXGaC14VqGdEzr33yGx3CEnh9AnVJpPJrXe9EyV0O4
         +u66J/YafEl0zUkSYSpCWeyY4zg8oB2TdeO8hkH9QuAHeYlZa6WXl3IQhuMTJNASfAjA
         zb6Q==
X-Gm-Message-State: AOAM532z/gXnGQAONaR4eoPUPToU0+VdJgaRM+h6GNqPZ6Bvd8eUNoti
        f4ydJDnkibFQ6yVkgtZhqN8=
X-Google-Smtp-Source: ABdhPJzMV0jdqD/FG13vcKrB4QMuqxs6hXZQEU2oylKcv/PnocXjpnTftvl5jb3hl/jn8JpvyFVinQ==
X-Received: by 2002:a17:90b:188f:: with SMTP id mn15mr26821411pjb.219.1621896654899;
        Mon, 24 May 2021 15:50:54 -0700 (PDT)
Received: from balhae.roam.corp.google.com (173-13-151-221-sfba.hfc.comcastbusiness.net. [173.13.151.221])
        by smtp.gmail.com with ESMTPSA id t14sm1959459pgk.21.2021.05.24.15.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 15:50:54 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/2] perf inject: Do not inject BUILD_ID record if MMAP2 has it
Date:   Mon, 24 May 2021 15:50:51 -0700
Message-Id: <20210524225051.1190486-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210524225051.1190486-1-namhyung@kernel.org>
References: <20210524225051.1190486-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PERF_RECORD_MISC_MMAP_BUILD_ID is set, the event has a build-id
of the DSO already so no need to add it again.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 8bbaa46eb7e6..5d6f583e2cd3 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -399,6 +399,18 @@ static int perf_event__repipe_mmap2(struct perf_tool *tool,
 	err = perf_event__process_mmap2(tool, event, sample, machine);
 	perf_event__repipe(tool, event, sample, machine);
 
+	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
+		struct dso *dso;
+
+		dso = findnew_dso(event->mmap2.pid, event->mmap2.tid,
+				  event->mmap2.filename, NULL, machine);
+		if (dso) {
+			/* mark it not to inject build-id */
+			dso->hit = 1;
+		}
+		dso__put(dso);
+	}
+
 	return err;
 }
 
@@ -440,6 +452,18 @@ static int perf_event__repipe_buildid_mmap2(struct perf_tool *tool,
 	};
 	struct dso *dso;
 
+	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
+		/* cannot use dso_id since it'd have invalid info */
+		dso = findnew_dso(event->mmap2.pid, event->mmap2.tid,
+				  event->mmap2.filename, NULL, machine);
+		if (dso) {
+			/* mark it not to inject build-id */
+			dso->hit = 1;
+		}
+		dso__put(dso);
+		return 0;
+	}
+
 	dso = findnew_dso(event->mmap2.pid, event->mmap2.tid,
 			  event->mmap2.filename, &dso_id, machine);
 
-- 
2.31.1.818.g46aad6cb9e-goog

