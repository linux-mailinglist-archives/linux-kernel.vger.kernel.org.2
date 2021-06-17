Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE73ABBFE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 20:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhFQSox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 14:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhFQSor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 14:44:47 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A134DC0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 11:42:36 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 81-20020a370e540000b02903aacdbd70b7so2786117qko.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5DjNG/5LrW+h84YK4KYw+ImmLTxQ10GkkIqN1ecfe50=;
        b=U67lanHkkfa0ltY86P0m9Lk89MeEmTbJ+2mZ9Wqd1wYOQ5MgP7PXnYgh0iY/U8haW5
         DQaO04AZkL/bvpONjjQxefNZN6I2pDT6LJ+nm4fSNjlvGETIdULShNNbcyjmu0hmVNW4
         cihAn6VL4SPwgfX3jvOHDr2hJ17hbhADYfnf0x4B7NstfALSrmPgPwo93ItstMBbg6DP
         aHzAL+owhPPtmiV8kUwXrnwMrSVSn5zB3MQBoG/W13kTXPib25bOfH8nWkuDtKn8H2XI
         vN5f/ixpv7jS2hsL0b6EV/oTaeBgoFX5HL4W5fBlH1wbI07LxZwmVseHGk8cBlx3ooYw
         CfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5DjNG/5LrW+h84YK4KYw+ImmLTxQ10GkkIqN1ecfe50=;
        b=LIWA++V2DLIeRLZjhAgtQuP23ObyYCZ5FgJ9tt6Hw10locweB0ZX5Uv7wAOYg+suiJ
         YAPIsUH0dPfU+ZH2bD9AY2pNLeZm30+fUVcJ775yiY/90dU5dPs0IZV0v+kxn+sMOLQc
         YO2aL7TQfebwCj4+cn+vMBkJ/fo7A9lPBhv36IcA9am0c2UTGrQGUkYaXVDOHB9Yd/Ms
         vT/R2bwVTteMHmnpLf1hekntmpDyoQSdiN3nFcXQA3h8F0q209XIkW//H6mfLmUaMvH7
         g34UGAPYGNry/MzdtooIkcFcactJCjSsSZEL0WSe4XDx9t7UL7UqDpJPxgbMtS2amh4C
         01qQ==
X-Gm-Message-State: AOAM530MlhqKInpu+63QzS7BksKt9PcRCqnSQm65Ol/CBj9SAgMo89px
        jjJhBvGl8Syo9t3oeRK4eJngljQmY/mm
X-Google-Smtp-Source: ABdhPJwzE0fiA+ui94SKI9ag06uXUpN6/xN+13AkJwieIj2mSxVaBw+2ipmvQVZW7nK8sWjK5SCrg5eB0O9I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ef90:beff:e92f:7ce0])
 (user=irogers job=sendgmr) by 2002:a25:43:: with SMTP id 64mr8267727yba.109.1623955355646;
 Thu, 17 Jun 2021 11:42:35 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:42:16 -0700
In-Reply-To: <20210617184216.2075588-1-irogers@google.com>
Message-Id: <20210617184216.2075588-4-irogers@google.com>
Mime-Version: 1.0
References: <20210617184216.2075588-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 4/4] perf test: Make stat bpf counters test more robust
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the test is run on a hypervisor then the cycles event may not be
counted, skip the test in this situation. Fail the test if cycles are
not counted in the subsequent bpf counter run.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 81d61b6e1208..2aed20dc2262 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -31,7 +31,15 @@ if ! perf stat --bpf-counters true > /dev/null 2>&1; then
 fi
 
 base_cycles=$(perf stat --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
+if [ "$base_cycles" == "<not" ]; then
+	echo "Skipping: cycles event not counted"
+	exit 2
+fi
 bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
+if [ "$bpf_cycles" == "<not" ]; then
+	echo "Failed: cycles not counted with --bpf-counters"
+	exit 1
+fi
 
 compare_number $base_cycles $bpf_cycles
 exit 0
-- 
2.32.0.288.g62a8d224e6-goog

