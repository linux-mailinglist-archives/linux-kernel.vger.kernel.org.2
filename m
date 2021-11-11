Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5739344CE34
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhKKAYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhKKAYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:24:03 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66526C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:21:15 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id w2-20020a627b02000000b0049fa951281fso2871971pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=B4UOtBBGhwmFrPOJWP3A1UYwMSaQEiu5wNaDtht975w=;
        b=RLcalrnYrMgV+HOP9Q0u3v6VRm1BeSgsihRjym6UaOXaWJ8BXzqHlOFQ/EA56CoAz7
         sMXmVgc28aypxk1q3Qy5Djzzt29xcodDbsVzT7Iz0RuYkbK60druwwJOWbhDloxXEBnR
         7B8mzzXxvke4FD5AA7ro7oUhLtHSKQel6+PkTeJC5V/Mn25oRDm1gnnRwlcNuCZstngs
         FzlUHm8wwxStwrWJDlm7SOYHJ9B5e98skVr8ck6Rd7ly1bZR8iRwM0QzhqPp/h4bX0+E
         qRBQJVMk9vEL5Pgj59LN+68FQ8UoxrTqcKgQUhp7FDq873ahtGNdQwLykXtG4bv2sQ0c
         4VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=B4UOtBBGhwmFrPOJWP3A1UYwMSaQEiu5wNaDtht975w=;
        b=OwRXHtp77MPeBrhPaz462zZSgn0st58CB4T+Mw2LHl43Rg8b6CyXGTDVOIeHzX3Yir
         wCfTLZO5DHLrJjYV3cExTS1czTTm3PEQirLEmaBrY3pIBfFhCOg5EKB0J0zrPBBCxS/W
         wiZXOOZst/pPscbrvRXovE9YhsIZUwVCA1dUO0rqfKmTnLiiWdXm8Z4NAL6+riyvr6k0
         gDVisRrXFPTCVZIy3yfahyXr/o9Yxe5V6pwJsbxhDdNv3889xcvoDdj/CSEk+abls7jV
         NbPnOW6oGt2ORxcSfkqb/jjZ+GkSY9AX5OTaWHPR4xRlT/HGNk57iu2UDi1V9BqPrP8j
         WjpQ==
X-Gm-Message-State: AOAM532Rsv78c9p8t2WbGcoOOWT5nyKbwmz6raER4fpnRfiSRztMIvVW
        ttsrug7f7XZCRslAVGtiig8G+jtoCY7S
X-Google-Smtp-Source: ABdhPJxyr9glynTfEax3JRIPMW8SOOucQ0kEAcAAFvFY6h/WeRJ8AqbCxSOpNAe6C/+xnCzT/4p8LVIXqtAK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9510:b6b5:241:e409])
 (user=irogers job=sendgmr) by 2002:a65:4bca:: with SMTP id
 p10mr1870204pgr.391.1636590074888; Wed, 10 Nov 2021 16:21:14 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:21:01 -0800
Message-Id: <20211111002109.194172-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2 0/8]  New function and literals for metrics
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for hyphenated events that are common with Intel's icelake
topdown events.

Try to tidy the existing cputopo code and make it more consistent with
the sysfs ABI. Refactor the #smt_on literal parsing into a general
literal token that we can use for more literals. This is then used for
num_cpus, num_cores, num_dies and num_packages literals that use the
existing topology code. Finally, a source_count function is added
which is used to determine the number of events contributing to an
aggregate event. The intent for these new literals and function is for
them to be used in upcoming metrics.

v2. Split the handle_id function refactor out of adding the
    source_count function as suggested-by Jiri Olsa <jolsa@kernel.org>.

Ian Rogers (8):
  perf test: Add expr test for events with hyphens
  perf cputopo: Update to use pakage_cpus
  perf cputopo: Match die_siblings to topology ABI name
  perf cputopo: Match thread_siblings to topology ABI name
  perf expr: Add literal values starting with #
  perf expr: Add metric literals for topology.
  perf expr: Move ID handling to its own function
  perf expr: Add source_count for aggregating events

 tools/perf/tests/expr.c       | 34 ++++++++++++++-
 tools/perf/util/cputopo.c     | 78 ++++++++++++++++++-----------------
 tools/perf/util/cputopo.h     | 33 ++++++++++++---
 tools/perf/util/evsel.c       | 12 ++++++
 tools/perf/util/evsel.h       |  1 +
 tools/perf/util/expr.c        | 65 ++++++++++++++++++++++++++---
 tools/perf/util/expr.h        |  4 ++
 tools/perf/util/expr.l        | 16 ++++++-
 tools/perf/util/expr.y        | 72 ++++++++++++++++++--------------
 tools/perf/util/header.c      | 20 ++++-----
 tools/perf/util/stat-shadow.c |  7 +++-
 11 files changed, 250 insertions(+), 92 deletions(-)

-- 
2.34.0.rc1.387.gb447b232ab-goog

