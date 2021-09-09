Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6110E404218
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348245AbhIIAMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347955AbhIIAMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:12:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC10C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 17:11:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b84-20020a253457000000b0059e6b730d45so131760yba.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 17:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OkkMNftYlLqb51L3L87eZeReDTQzaYdqqe7hZPbzoyY=;
        b=LZ1qPBu6YIlfQM30nXC0EsFQJ5WzJ3f4s3xQJ9b2am9gQeid8/VVtcHCmrVWgrlQGu
         r5DHwP8wSmms4cUaLHQejnaK6tbNsWLyyNSi2rXrq8lmrdpuudlGHZrzHF6qYK5PBbXt
         m1gLHROn4av2GRLyYf8Rn9ieF0N6IZAfxhqVmpQRSvqfwNkf/g8ULey8VZ3RgHi9FQuU
         kuPOjmb2x94ofoVRPTG13fsMF2q3mv76ezvzy8/nF8SNYxbPwGfIZvNm1wPVkjth74iB
         d/bVMWhWNX8keudOfJCYGFFkthPssVhzc/QfGzsMsHjeBW2Etm2V8xnnTvokfAvuDGMK
         yEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OkkMNftYlLqb51L3L87eZeReDTQzaYdqqe7hZPbzoyY=;
        b=cy6u0xr4AYej9+4APP970PjHHk+Yq6sPivuOX3/iNWL0lqQ50diueUYwbBQytk/LLs
         6nxIyCsKzgSxroSPaAUOilBmyNT5WBnJ2aTt38t25hW/nJyO9HpTZvIf7KB26JZAlKAt
         MSXriY8yvNp+NdsQpoo4LJ8mdcBy1G0p/wAAJOWPIliHJVdOV+L5IPnRn6FAZRLqgfrq
         U7YNS4sSdO38yHLPxcBKbXwPBaVNMDBwEVmDX3lCH+GrWFF5/TE1xxIotZsjQi1t36xR
         rNSmW1OLCFnFjnrQbzYDXl1dc2eqInUqW0FttvCjr3MlhCjTd1wCeWBso8Y817OIYZsN
         0Mug==
X-Gm-Message-State: AOAM531jSJd7KrISkYhtlq3HEn3p+CMk84GSUlGX07U58VEeMkQtkrrI
        vve9JUGwyJbZGmOClzIKozTyIgXfnL9weA==
X-Google-Smtp-Source: ABdhPJyZOGMNXmqx/HbgiN3pPnVsL5tAMKQwbrSFXwKag+rczy6YCcMIluafMqK94X2NnYDcAmeWOUufga2LSw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:68b6:f792:6cb6:9052])
 (user=dlatypov job=sendgmr) by 2002:a25:12c4:: with SMTP id
 187mr147543ybs.248.1631146266980; Wed, 08 Sep 2021 17:11:06 -0700 (PDT)
Date:   Wed,  8 Sep 2021 17:10:34 -0700
Message-Id: <20210909001037.2842954-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 0/3] kunit: allow running test suites/cases individually
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow running each suite or each test case alone per kernel boot.
The motivation for this is to debug "test hermeticity" issues.
This new --run_isolated flag would be a good first step to try and
narrow down root causes.


Context: sometimes tests pass/fail depending on what ran before them.
Memory corruption errors in particular might only cause noticeable
issues later on. But you can also have the opposite, where "fixing" one
test causes another to start failing.

Usage: 
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test example

The last one would provide output like
  ======== [PASSED] example ========
  [PASSED] example_simple_test
  ============================================================
  Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
  Starting KUnit Kernel (2/3)...
  ============================================================
  ======== [SKIPPED] example ========
  [SKIPPED] example_skip_test # SKIP this test should be skipped
  ============================================================
  Testing complete. 1 tests run. 0 failed. 0 crashed. 1 skipped.
  Starting KUnit Kernel (3/3)...
  ============================================================
  ======== [SKIPPED] example ========
  [SKIPPED] example_mark_skipped_test # SKIP this test should be skipped
  ============================================================
  Testing complete. 1 tests run. 0 failed. 0 crashed. 1 skipped.

See the last patch's description for a bit more detail.

Meta:
The first patch is from another series with just a reworded commit
message, https://lore.kernel.org/linux-kselftest/20210805235145.2528054-2-dlatypov@google.com/

This patch series is based on the 2 patches in
https://lore.kernel.org/linux-kselftest/20210831171926.3832806-2-dlatypov@google.com/.
(That's what adds support for us to run a single test case by itself).

Daniel Latypov (3):
  kunit: add 'kunit.action' param to allow listing out tests
  kunit: tool: factor exec + parse steps into a function
  kunit: tool: support running each suite/test separately

 lib/kunit/executor.c                   |  38 +++++++-
 tools/testing/kunit/kunit.py           | 127 +++++++++++++++++--------
 tools/testing/kunit/kunit_tool_test.py |  40 ++++++++
 3 files changed, 160 insertions(+), 45 deletions(-)

base-commit: 23fdafa5ae209688d5d5253786bab666bdb07b69
-- 
2.33.0.309.g3052b89438-goog

