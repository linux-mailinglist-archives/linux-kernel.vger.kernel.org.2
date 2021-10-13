Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6757042C7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbhJMRui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238651AbhJMRtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:49:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185DAC0613E4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:47:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso3982079ybc.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rvl7RBST+nSKJGhidpF9xQRHS3IIm9lv/B8zXURs+EY=;
        b=cO5/xrPbpB59HhoZfe9lQWNgmN9oM59A+f+4usmsFeHlnuL/AIAyTdW7ni41Awu7t3
         TjYos4QT17uTDhYuKnhFSB8aRJQRK985jEKt1InHznMmUUIlJV4aTu3o02H5Xv0dIO2b
         HhT178JHVMJKomBmvtqGyvPa79Awdf54DhpxyGfitfnk9e0jX8qYXZ+GG7Muw7sQaoHT
         yS4NqkHUZwUU2bvwmyZfpL9j+56dKA01IEldaAOrYPJuPlVoEjrULcR8wIe4O3tR7Cwl
         GeJeduCBUd0DYMWytKldTzJFGGsgaa201ONsEQ+O9YQvDh53hh7b//aZ4BucrrHfxDPw
         7fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rvl7RBST+nSKJGhidpF9xQRHS3IIm9lv/B8zXURs+EY=;
        b=3KGn6RSPAeBBFGFD9kiCtNq6l5CRiP3DxqmIjo1T47ygesOXvWKlZAfs0+HgdaJ2Vd
         /WphWwl0Fwf/rdnFA+TekFTsCcEtfNLwftbgL7lmQrZfdk+M3I7L97wYZEnHDSh5/CW1
         46cjeLKuOlsIc7jC+JZbLTicQt1FPdbqe9+TCd5IG+JEcrZ6Ixwi1NkdimVgASVS753y
         4c7KgHKNjLBV8bz9IDM1/mr7M7KZYNeOdjYKkhsSwZgUQ83zs/iKg7VvQo656RzQdYA3
         ho2kE4m0NEL8VqTle7iS4eNPtvz/dxUa1y8TPu3pCo5LaQJOvdlves67QJ69DKu0vDFb
         x+Lw==
X-Gm-Message-State: AOAM533mSVQILBu8KSdPO+ovwjBsBcQYpQvQ/hA74eQk5oe8CNhnm2tw
        frRlSpjQahwNkPEwq9agCsCgYotJOU0C
X-Google-Smtp-Source: ABdhPJxIJ8sWcssJyCNy7Bp6mwE+DIJ1YQGImGi9h0vHMl5yRqebGAo/1aaS1palHYIt2qDbaZ/LPJQbmmly
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:2681:: with SMTP id
 m123mr866254ybm.7.1634147222308; Wed, 13 Oct 2021 10:47:02 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:59 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-18-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 17/22] perf test: Convert time to tsc test to test case.
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

Migration toward kunit style test cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/perf-time-to-tsc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index d23740f80c7d..594013e94ed0 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -198,8 +198,13 @@ static bool test__tsc_is_supported(void)
 #endif
 }
 
+static struct test_case perf_time_to_tsc_tests[] = {
+	TEST_CASE("Convert perf time to TSC", perf_time_to_tsc),
+	{ .name = NULL, }
+};
+
 struct test_suite suite__perf_time_to_tsc = {
 	.desc = "Convert perf time to TSC",
-	.func = test__perf_time_to_tsc,
+	.test_cases = perf_time_to_tsc_tests,
 	.is_supported = test__tsc_is_supported,
 };
-- 
2.33.0.882.g93a45727a2-goog

