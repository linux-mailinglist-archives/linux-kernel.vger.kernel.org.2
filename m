Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2EB342C19
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCTLYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhCTLYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:24:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E81C0613B5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 03:46:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso6074269pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfzq4riviQTCJmp4u8lCCdEJbdtAEz5ZReI046C37rk=;
        b=LaqQ7kpJMX3XgAlt5oNlTxStC8bO3jbvHHJVyfVa01S4QRr74PfIrCJyHXYe/dckRp
         OmNKQXqbOpb5dlFGex0IYCZP/El7LkTEoM+XXW/wrCIMW5QD7kW2VgaapSLGApVHwcoG
         W5S9UD2LZIk8y+CswIe00xgQy71MRJT6AgY9vH4m+kBeYEeuMKmvNSlryqhVUz4RSuef
         8bQpMMCs53gSsOA++T77E7rtjshUgxrT5puhSETIXpBtwR/oG0QVqYQNSYbgKbu9pKze
         x6KUER8J0Rl95/anTvIeqley4d+47fWYjC84YYHFtWFBgIk//0wouIMZjZarvrBScadk
         /WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfzq4riviQTCJmp4u8lCCdEJbdtAEz5ZReI046C37rk=;
        b=aOS7xVZ87HCl/eDJMHivSWxc0JrmSEtyDpjmLG4p6MWl8M8DFXsxqz3WFY3Jqc0Z87
         CSg7QuTYAfzCtP9/k8hnxhltWncGaUPV15El8sdBdBOgBnpscdRfVph0xdvgu1bF9CmJ
         HKbICXL+WoRR0KXlb6CIi9EWjAjwcXRwiaSU/ZlEfXrD+qJCRR/AQWW4tL6gE7Z8HUeV
         eLaFaQKCK6QB2YDEVSgqhXY24alzrW+N+sAkqd4PqYU/hTZE7GOepg292Ei2KYarghW7
         9YDPdEZ1/DHTw5yFXAdjfC76wX03IbUb2sYYZkAO8ptJsqx7t+FG/AjEvra9PglPLUQA
         xdXw==
X-Gm-Message-State: AOAM530CRF79JU4UmhMUBwNDwmyUOEq9yk/zAYDvBs1LvLBQ0Cb9XNHZ
        aaqVCMXiYZTzN242DlZbKw4Uow==
X-Google-Smtp-Source: ABdhPJyCzV0j7K0loGv7SPnjWuqP4ylVyBijNgWRRpMs67Ujkyaggj+SXbblJjeARav+l4U95WHCkQ==
X-Received: by 2002:a17:902:7401:b029:e4:5992:e64a with SMTP id g1-20020a1709027401b02900e45992e64amr18245639pll.75.1616237162657;
        Sat, 20 Mar 2021 03:46:02 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id m5sm8184700pfd.96.2021.03.20.03.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 03:46:02 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf test: Change to use bash for daemon test
Date:   Sat, 20 Mar 2021 18:45:54 +0800
Message-Id: <20210320104554.529213-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When executed the daemon test on Arm64 and x86 with Debian (Buster)
distro, both skip the test case with the log:

  # ./perf test -v 76
  76: daemon operations                                               :
  --- start ---
  test child forked, pid 11687
  test daemon list
  trap: SIGINT: bad trap
  ./tests/shell/daemon.sh: 173: local: cpu-clock: bad variable name
  test child finished with -2
  ---- end ----
  daemon operations: Skip

So the error happens for the variable expansion when use local variable
in the shell script.  Since Debian Buster uses dash but not bash as
non-interactive shell, when execute the daemon testing, it hits a
known issue for dash which was reported [1].

To resolve this issue, one option is to add double quotes for all local
variables assignment, so need to change the code from:

  local line=`perf daemon --config ${config} -x: | head -2 | tail -1`

  ... to:

  local line="`perf daemon --config ${config} -x: | head -2 | tail -1`"

But the testing script has bunch of local variables, this leads to big
changes for whole script.

On the other hand, the testing script asks to use the "local" feature
which is bash-specific, so this patch explicitly uses "#!/bin/bash" to
ensure running the script with bash.

After:

  # ./perf test -v 76
  76: daemon operations                                               :
  --- start ---
  test child forked, pid 11329
  test daemon list
  test daemon reconfig
  test daemon stop
  test daemon signal
  signal 12 sent to session 'test [11596]'
  signal 12 sent to session 'test [11596]'
  test daemon ping
  test daemon lock
  test child finished with 0
  ---- end ----
  daemon operations: Ok

[1] https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097

Fixes: 2291bb915b55 ("perf tests: Add daemon 'list' command test")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/shell/daemon.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
index ee4a30ca3f57..45fc24af5b07 100755
--- a/tools/perf/tests/shell/daemon.sh
+++ b/tools/perf/tests/shell/daemon.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # daemon operations
 # SPDX-License-Identifier: GPL-2.0
 
-- 
2.25.1

