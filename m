Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EFF42C7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbhJMRtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhJMRsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:48:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B70C06176C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:46:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q193-20020a252aca000000b005ba63482993so4060187ybq.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/xV+yd8shPjaclxuqTvIDa73tXcckmYdVvwoghqARxQ=;
        b=kNJqEjH8HEILP8x2KxuakMlpCEGlctokNIlTLHGG42bIZEL+6NAxBqvH6ghU4VEggo
         BVyfMTsys3O3CfhHqlI9iTPOKmLY+dVX5X06eNzaaBx7NDMTPIMSM5GZJjgsom42CEoa
         /YzFSnbY5ApTDGVNpaxh3cFRyqSa7DG+C89Jdyh34FlVZFlOqz50IwhYBwMvL24t6FL2
         pye1WVYKXD64L2aVK0JvVYwl4ZLq8dwcBvBX2WEqVR5Kh/ldApVG7JxJw53OWQcZEqQf
         fyVDQrErbWtLxHivrWGtm7ZxTyayZMWQHftUN9rANyFRBPrOzoCCAMcFJ6wo70UaBVC2
         FySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/xV+yd8shPjaclxuqTvIDa73tXcckmYdVvwoghqARxQ=;
        b=o1k8OG40RMWlNSR2dF1wws1lpSIliC7BneXh9Owln3sMD9lWDvyXdz1W5Im3Ld6Xsw
         zFIIqGgea4kSeBNpjR95JTxrzdTzA977+CEymBZDtL6gIG1ko/NY5f3TM11mSddtyaFQ
         h81afFgM5kfBTfjldidVqMHi9QKnT4XspS0gVZHYsgWr8nf+BrXeuXAVlUke7Bu7zjhi
         x3Vydd+uGmHZ1MVtAlC8h53WKDVy8luSxmdUzIOnpAH/IsnlzHO4Um7XFMwNCCdfReVL
         C+ewuiG7raN3RKP3wNMyrM26MBwHAlDxIRSrOoEyZZnrOryUTe2PYTEwIDpNM0xs89fN
         Lhow==
X-Gm-Message-State: AOAM532b6DqrJDwsn1bOLION6k/v86KfF3SfayqgLwMZW3xnGBhstxNj
        e/dewNN22sLrs+Grm1NVclQzzG2WUCoa
X-Google-Smtp-Source: ABdhPJwgBN/PZSuLspT5sVvjyAgeaZZ/h/UlYlCoYCGoHGBWDu1hHtIKrhtMlELpREyy3MikUrW5qh1WXOs0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:1186:: with SMTP id
 128mr780480ybr.547.1634147200702; Wed, 13 Oct 2021 10:46:40 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:50 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-9-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 08/22] perf test: Add skip reason to test case.
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

This doesn't exist in kunit, but will ease the transition from perf
tests.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c |  3 +++
 tools/perf/tests/tests.h        | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index a6d84feba483..916faeee04ff 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -142,6 +142,9 @@ static const char *skip_reason(const struct test_suite *t, int subtest)
 	if (t->subtest.skip_reason)
 		return t->subtest.skip_reason(subtest);
 
+	if (t->test_cases)
+		return t->test_cases[subtest].skip_reason;
+
 	return NULL;
 }
 
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 71b8d2c88e5c..f87129b63d92 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -34,6 +34,7 @@ typedef int (*test_fnptr)(struct test_suite *, int);
 struct test_case {
 	const char *name;
 	const char *desc;
+	const char *skip_reason;
 	test_fnptr run_case;
 };
 
@@ -61,7 +62,15 @@ struct test_suite {
 		.run_case = test__##_name,		\
 	}
 
-#define DEFINE_SUITE(description, _name)			\
+#define TEST_CASE_REASON(description, _name, _reason)	\
+	{						\
+		.name = #_name,				\
+		.desc = description,			\
+		.run_case = test__##_name,		\
+		.skip_reason = _reason,			\
+	}
+
+#define DEFINE_SUITE(description, _name)		\
 	struct test_case tests__##_name[] = {           \
 		TEST_CASE(description, _name),		\
 		{	.name = NULL, }			\
-- 
2.33.0.882.g93a45727a2-goog

