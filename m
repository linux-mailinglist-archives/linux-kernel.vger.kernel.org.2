Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3735A41CCF9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345829AbhI2T4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345870AbhI2T4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:56:33 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D5C061769
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:54:50 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 13-20020ac8560d000000b0029f69548889so9725885qtr.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cmJIpf0DwizpXlrk/HvWpomrFuR6W2E4zR+m6Uv+l5U=;
        b=MT9OV30DeaVmPZQ81HvXbzyPi4vSansk777G+fi0QTkGXydBM5FiCyPyk7TNhjUwkN
         j2j9tdDMyFiXc1etAueGqimaGOYRwwbd68plfIAiL5HuLskDZRFEdC3sSgvSlDSzNNpe
         MbZc8wXMVolQBaPuiyuc5zxO+WrizsKJ6yqgWDoYRudjUAPN3pyUyYKkX056/DLKM+1v
         egcOi9yRZS0XQt/a/eAK+FRItN3tpyxTAAfgfqjxM5CplupNNBy6HD+2KvytGKp7xYf3
         B+bazfnOoBbQB3e3NiC3GKwoCDiQJ/Ber/Fw8QGMhszpnvKm5cH7sBGZoNLLN6mIw2hu
         6fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cmJIpf0DwizpXlrk/HvWpomrFuR6W2E4zR+m6Uv+l5U=;
        b=WTZvVrFuAD0ZLSNLki+/crCqK+3eiFi4LeaiA1yowyL0mvJOwCRnWu0Mea+uaXUrd+
         CIXDTCHmzgdgIxV+IYGZE2mrNSGxTHrlVM4bi3NB4ESsYdis0QOWcAjQOFlqZBUO4Q8i
         PHu/Cv9fuY1Fw9ZHeq8ick9BJoFN7s4IQdiijaueinLtYrX6u1/bouCcBe/Y2k8L1okQ
         i8bBCKK49ggDUUJ7cps7IKmRDli/7VYmMWmX8tifaw9lsa4SQNXBp/6lVFcCdg1jfOJD
         S8XJWu7Hy+bel1ZpDmex7uJLvXnCZ8h+lD74KOrD8JjxzmOiZC+as2Q++jz3fBRBbIKM
         yjVA==
X-Gm-Message-State: AOAM530hNXMdFwlT6U6WsfQKuqvXJqRjyJl7ykhkGFZGrayOhMN5Biml
        Ee8n0kNNPzmhjyvaxBGuOLfn4xe75I6oMA==
X-Google-Smtp-Source: ABdhPJxfeptZl2iUjrSyGrbe8zmkprqvzOOpOKXK7kDNqkmogEgEmmhaSKjTNdHiQbPquSGIZPk2N3KWNJhILw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:e473:7cd7:9986:85b7])
 (user=dlatypov job=sendgmr) by 2002:a0c:cb10:: with SMTP id
 o16mr249962qvk.57.1632945290110; Wed, 29 Sep 2021 12:54:50 -0700 (PDT)
Date:   Wed, 29 Sep 2021 12:54:35 -0700
In-Reply-To: <20210929195436.1405996-1-dlatypov@google.com>
Message-Id: <20210929195436.1405996-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20210929195436.1405996-1-dlatypov@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 3/4] kunit: tool: actually track how long it took to run tests
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a long standing bug in kunit tool.
Since these files were added, run_kernel() has always yielded lines.

That means, the call to run_kernel() returns before the kernel finishes
executing tests, potentially before a single line of output is even
produced.

So code like this
  time_start = time.time()
  result = linux.run_kernel(...)
  time_end = time.time()

would only measure the time taken for python to give back the generator
object.

From a caller's perspective, the only way to know the kernel has exited
is for us to consume all the output from the `result` generator object.
Alternatively, we could change run_kernel() to try and do its own book
keeping and return the total time, but that doesn't seem worth it.

This change makes us record `time_end` after we're doing parsing all the
output (which should mean we've consumed all of it, or errored out).
That means we're including in the parsing time as well, but that should
be quite small, and it's better than claiming it took 0s to run tests.

Let's use this as an example:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit example

Before:
Elapsed time: 7.684s total, 0.001s configuring, 4.692s building, 0.000s running

After:
Elapsed time: 6.283s total, 0.001s configuring, 3.202s building, 3.079s running

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 31eec9f6ecc3..5e717594df5b 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -101,12 +101,14 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
 		filter_glob=request.filter_glob,
 		build_dir=request.build_dir)
 
+	result = parse_tests(parse_request, run_result)
+
+	# run_kernel() doesn't block on the kernel exiting.
+	# That only happens after we get the last line of output from `run_result`.
+	# So exec_time here actually contains parsing + execution time, which is fine.
 	test_end = time.time()
 	exec_time = test_end - test_start
 
-	# Named tuples are immutable, so we rebuild them here manually
-	result = parse_tests(parse_request, run_result)
-
 	return KunitResult(status=result.status, result=result.result, elapsed_time=exec_time)
 
 def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitResult:
-- 
2.33.0.685.g46640cef36-goog

