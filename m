Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC02832F8E9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 09:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCFIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 03:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCFIIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 03:08:47 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC870C06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 00:08:47 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id r1so3767930qtu.9
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 00:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=J7c6HwCSrHIjAPd6cvDqTdYprXjy9UuQFzSXZwXz9Y4=;
        b=MZO0zByJv6dcATO1w2/1PfcYCTdniouCO3Uf65GbttWfV1LoXi8yxMXnHFRg6KriaN
         o002fBvKHLHRB8WrxARBVTQq+s863QuacJNjA7SGzfmFqYNFkHJv2QEP+AkujI4/rvpD
         ZhIS0H4QQqteToHhXw8hnKXwzaifbTYdqy7wDxIeQCNrHZq3SsFIbkqlZKhpcWe1yqRT
         Hbb7jQcE2c7kILs1qXwA93tdzfb5o6gjndpe54WWvjLhtISax8qeDadf4bWPL2uouY5v
         TtJmso9eUPUY4fCguOLQ5zI9beDUzMg1nfatoE5oPFmpZjwGEbo7Mt07wNoA2ytIV33h
         agbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J7c6HwCSrHIjAPd6cvDqTdYprXjy9UuQFzSXZwXz9Y4=;
        b=OEUyOapg1T7XCGPcMMKwofsXIEA7kxlB68jTQgSkE6i7cAmuQVGbsNz1t6D2a2Iy+F
         Vs4VIxcJIjSTOcH/lC6p5Ni9NOtjH6LLuJdBKVsB84HiTdOFwszazji75exeFCsm9Lc6
         eoXKZ49VAXLFmi8ZyN+dGl0DB3Psfd+a3WaihQbxRglVbtCNzLEaFkchiwaE7qOtxu0q
         DTfExFl/AIPkR/8F7TTtNDwklm9rXVmx9QUgmp01fFeChhieXWYJdHavVzfkLvfToE6x
         i/6wWNgqFlcIErOaV1x0Xo/CumtZp0Yvd684DVvAQDTIY2AaNe34Ar8GUJ0jXrMzvoXs
         g/vw==
X-Gm-Message-State: AOAM531S337WiIbZUsMZXTf4pgj5Zp6lflQcMca4k69PC5A5DilUEpul
        k8c5mZDBMSJRosP7Pxp7rnSXcTnQS3eW
X-Google-Smtp-Source: ABdhPJylpcKgSZ7ocoonqoagYBMLtu690bCYf67BrHZ9UeYx1iNstk2vCLdu08cTPFApTGo6ijRG7duJzwXi
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:d9f:b4b1:d43b:2030])
 (user=irogers job=sendgmr) by 2002:ad4:58cf:: with SMTP id
 dh15mr12040166qvb.26.1615018126930; Sat, 06 Mar 2021 00:08:46 -0800 (PST)
Date:   Sat,  6 Mar 2021 00:08:39 -0800
In-Reply-To: <20210306080840.3785816-1-irogers@google.com>
Message-Id: <20210306080840.3785816-2-irogers@google.com>
Mime-Version: 1.0
References: <20210306080840.3785816-1-irogers@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 2/3] perf tool: Enable warnings when compiling BPF programs
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add -Wall -Werror when compiling BPF skeletons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5345ac70cd83..f43d2551f3de 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1029,7 +1029,7 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
 		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
 
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OUT)
-	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf $(BPF_INCLUDE) \
+	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && $(LLVM_STRIP) -g $@
 
 $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
-- 
2.30.1.766.gb4fecdf3b7-goog

