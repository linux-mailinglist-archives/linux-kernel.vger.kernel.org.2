Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F5D3CAE8A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 23:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhGOVer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 17:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhGOVep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:34:45 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DB2C061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 14:31:50 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z1-20020a0cfec10000b02902dbb4e0a8f2so5155099qvs.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+0CqKbStwjYWWb/ryAHBHEWWcIXAfliOA3KIW2RGcrc=;
        b=plB8GojpEEkoNTKH3F9DdwVbb84EzvTN2m4GMmtRucpxcGFdCDzVIxbnay70zWIV6t
         5hVxnxwSWEa9XFvJomnSp+YQiVM/IBpi3WcaDhs8tV0ATvHvtvaDYv6W4Nq52ScI+bh2
         GCPZr2YtZqI/+t4lP2vjUCAZRYKB0YJG63RZWMuxoy8z7ywSwZqAyx4c1luEzbTNZMEO
         Nv9abzba1NLEFeW+ia/ynIwfAnzOmUNpGepjvR67IlB3mRs7XfTSyoo/0qYqOU6h+S7N
         ecSSfblKFR8FMG13Zn6dqYXsr2QaXQHgFKphlzp9vY8j0hos6t/AF/d0nzjSNkxYMbOB
         ZHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+0CqKbStwjYWWb/ryAHBHEWWcIXAfliOA3KIW2RGcrc=;
        b=QuDnf7a7ikZm1k65g+yG2sFMh3Cf3JtHlqvEDTLAMyNAyQ63rNQnFgW0ZbsWgLVUoT
         0oNuLBZvdIGZ7ZgR2CWQD12TwQ+c2VLxgUX23QKINkkxww2RXw7jXal1hWGo6eHy7xZG
         F0wZMsMrcLutTdNyCHoLrL7xigXV7vQh3PclxK3EIC5rZvfIkzghrqNYq19BvZBr0UGn
         7nh4MkTTkiuaGQGojpbFGKOtYxj8NHea84YmqQ5ucabTLJXNHmDl6429t0xg8PaNnVx7
         OJ9diYEWrrgHvUYu1iJzxlD+Ah0Z5O82mLMS0t2oRZ4DdO/0pFSfz2SwjiNgHvdFB7/+
         1bQg==
X-Gm-Message-State: AOAM530XMyIGYvE1TN0Ax1ydsF9XlMEYvuPJ1FTItnUsS4oiUYmvx2Lt
        sIAoYNWiT6i9wm/ErPwbM+prgGdpjvfICg==
X-Google-Smtp-Source: ABdhPJy/eBmCYCwMjQaNiQaXg29RMcXkX5uWK7li3SQGv473sCsY4R0anVECgOPekGVLsF1hq3x81kSSI9beYA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:24a2:4c13:4cc0:8818])
 (user=dlatypov job=sendgmr) by 2002:a0c:c352:: with SMTP id
 j18mr6454516qvi.7.1626384709654; Thu, 15 Jul 2021 14:31:49 -0700 (PDT)
Date:   Thu, 15 Jul 2021 14:31:36 -0700
Message-Id: <20210715213138.1363079-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [RFC v1 0/2] crypto: tcrypt: small changes to run under KUnit
From:   Daniel Latypov <dlatypov@google.com>
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcrypt.c calls itself a "[q]uick & dirty crypto testing module."
One that "will only exist until we have a better testing mechanism."

This RFC seeks to start a discussion if KUnit can fill the role of that
"better testing mechanism."

As-is, these example changes don't make the test code much cleaner.
But they do provide a new way of running the test that's hopefully more
accessible, namely
$ ./tools/testing/kunit/kunit.py run --kunitconfig=crypto
...
[16:53:16] Starting KUnit Kernel ...
[16:53:19] ============================================================
[16:53:19] ======== [PASSED] tcrypt ========
[16:53:19] [PASSED] tcrypt
[16:53:19] ============================================================
[16:53:19] Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
[16:53:19] Elapsed time: 8.806s total, 0.001s configuring, 5.764s building, 0.000s running

This series contains
* an initial patch with the boilerplate needed to run
under KUnit and track pass/fail status in the `test` context object
instead of passing around an int.
* another change to plumb the `test` context object to other test cases
that could previously fail w/o affecting the overall pass/fail status.

I haven't reformatted the code for now just to make the changes a bit
easier to read and skim over. checkpatch.pl isn't happy about the
spacing in the second patch.

== Other pros ==

If we want, we can go down the path of trying to structure the tests in
more idiomatic KUnit fashion to get some benefits like 
* automatically freeing memory at the end of tests when allocated using
  kunit_kmalloc() and friends instead of having to maintain labels
  * can be made to call arbitrary cleanup functions as well
  * this hopefully makes the tests more readable, at the expense of a
  bit more runtime overhead dynamically tracking these allocations
  * doing this just for the kmalloc's and __get_free_page() directly in
  * tcrypt.c saves 100+ lines of code.

* flagging test cases with KASAN issues (and eventually UBSAN)

* a bit easier way to dynamically run subsets of tests via glob
  * e.g. kunit.py run 'crypto.*sha512*'
  * KUnit currently only supports filtering by the suite ("crypto")
  right now, but we should have test-level filtering support soonish.

== Cons ==

The main cons are we'd be slightly changing how these tests are built
and run with these example patches

These changes are mainly
* building the test now requires CONFIG_KUNIT
* Running `insmod` on the module will always return 0, even if tests
  failed
  * the test instead prints out (K)TAP output to denote pass/fail
  * this is the format kselftest uses, but it's not fully standardized

And if we eventually try to restructure the test as mentioned above:
* more disruptive changes to how the tests are run
  * we'd have to move away from using the "mode" parameter
* a decent amount of code churn

Daniel Latypov (2):
  crypto: tcrypt: minimal conversion to run under KUnit
  crypto: tcrypt: call KUNIT_FAIL() instead of pr_err()

 crypto/Kconfig  |    5 +-
 crypto/tcrypt.c | 1063 +++++++++++++++++++++++------------------------
 2 files changed, 524 insertions(+), 544 deletions(-)


base-commit: e9338abf0e186336022293d2e454c106761f262b
-- 
2.32.0.402.g57bb445576-goog

