Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0C42C7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbhJMRuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238626AbhJMRtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:49:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F3C06177B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:46:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so3971466yba.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xt1TFSDSUWFug6DVlfOCDuvb8C2sq6W0M9BYTuaRxyc=;
        b=RgK0RuioznOpmLB+Duy3GhEKZnCSVo98dQxDPV5kuF7tIKsfYLmcbRZpy0MRQZzazE
         qPpbjz4UTJ6RTrAE7MOaHHOdQUZ4jUx5nkCX9ux+6qYMfNOi6ix1NG7mfR+eIutwjV8L
         MUzMdPG09KaDyhEFa/b/X/PWRZTtkBJ3mDL9wfk2PsCRyamuQZbKW9VfFRNL6D/C9pww
         rzjk9j0yZ7c2kh3B4UrVIlt72n5Pc0efcWAU67tfw0WFj/HmhtqkYMiz5k9aL+jWNC2m
         vPtDT/6Hukf++smJuwNNBMJcWSH3JDWRZZv2vXlQaIWy/+RqAYksKrXIooWOaXPbGMUV
         TV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xt1TFSDSUWFug6DVlfOCDuvb8C2sq6W0M9BYTuaRxyc=;
        b=NEEAYqxPODIIKMTe8iHToMbycuggtCb+qvorudphYQ+amvklIdvpuoEzqfY1kbgUnd
         hWdDD3AXWhkcbRpvnpI2Rpu2JiJPCbObTQHZ7E3mnWrqJeev3JB6NnANsX/UK3TLi2gy
         fFU2dFSONXPDc5tIhmrEaS9EbohjCEh0r8O6CFqXTHODAN0iQ8WHM1Cir0drTh8U/ar4
         1R1hP68qxruVojnlRtOryKpSD6rkwUbdHXOGeM3y8NcmvQTnYXhCrl9v7NJ9BhARSY/b
         muK/vc1AGaD3LeO6ZtkG2GFvbLf/1O+4vlQnPqTAVRe66tkpaEFSAvj3P7swIVSFy8b3
         CI1g==
X-Gm-Message-State: AOAM533B3IPnDnY/n3oiPNPR33bVDM+QE3Y41xOaNJq7MWpaT8v1d5az
        Wiwt4NO2N/E7D3BBn6CubDnrY8PF3s9J
X-Google-Smtp-Source: ABdhPJzpuMn12BzkD3tp3gYxQjnee5Dfj4mNjG7ZW9Mjqllh23gCV5wBoqBDykp3bqHyHWvhSeRnRlut4pB6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:348b:: with SMTP id
 b133mr870613yba.264.1634147217655; Wed, 13 Oct 2021 10:46:57 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:57 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-16-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 15/22] perf test: Remove now unused subtest helpers
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced by null terminated test case array.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 11 +----------
 tools/perf/tests/tests.h        |  3 ---
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 916faeee04ff..c98c7134b552 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -119,9 +119,6 @@ static int num_subtests(const struct test_suite *t)
 {
 	int num;
 
-	if (t->subtest.get_nr)
-		return t->subtest.get_nr();
-
 	if (!t->test_cases)
 		return 0;
 
@@ -134,14 +131,11 @@ static int num_subtests(const struct test_suite *t)
 
 static bool has_subtests(const struct test_suite *t)
 {
-	return t->subtest.get_nr || num_subtests(t) > 1;
+	return num_subtests(t) > 1;
 }
 
 static const char *skip_reason(const struct test_suite *t, int subtest)
 {
-	if (t->subtest.skip_reason)
-		return t->subtest.skip_reason(subtest);
-
 	if (t->test_cases)
 		return t->test_cases[subtest].skip_reason;
 
@@ -153,9 +147,6 @@ static const char *test_description(const struct test_suite *t, int subtest)
 	if (t->test_cases && subtest >= 0)
 		return t->test_cases[subtest].desc;
 
-	if (t->subtest.get_desc && subtest >= 0)
-		return t->subtest.get_desc(subtest);
-
 	return t->desc;
 }
 
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f87129b63d92..9bf448f7429a 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -43,9 +43,6 @@ struct test_suite {
 	test_fnptr func;
 	struct {
 		bool skip_if_fail;
-		int (*get_nr)(void);
-		const char *(*get_desc)(int subtest);
-		const char *(*skip_reason)(int subtest);
 	} subtest;
 	struct test_case *test_cases;
 	bool (*is_supported)(void);
-- 
2.33.0.882.g93a45727a2-goog

