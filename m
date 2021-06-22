Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518AA3AFC16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 06:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhFVEkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 00:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhFVEkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 00:40:47 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16DDC0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:38:31 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id a2-20020ad441c20000b0290251bb08ce61so15265749qvq.19
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U/VtG6VE7zWrQke1C0jwUjUCh7PXfPilKdm/dVNjIos=;
        b=At3tjYzW+aFSYw1myhNWAaTNB303C9Gm+HrWCsXGtvwdOF+hwsoltElrV4tjYfmgOM
         0gTBEpF7oDWJQcIe37wsRjQUjH4WWgL4IYb2f/ACmGxHqKryZ4NcBQ+drJ0JA+ma3qj2
         W/a9SGjM+pKhArZaBKMaNNlZGp5gtNmKimXy61DDreny5u2kxK4qe0GQKyWTMd11TxFs
         k2hUOYSNu4DvOpOaFT+dvKs5oIeQIwQfvZ8u1WtNcyXKyCV+JnHwyEtTaF2nA2E0VO3e
         q1IUmQpxWhroj04rLGkjYqMS6pouxTxKBsR5AeoWO6qTyMeAedoKMNVn6MbrSXLBETBK
         iqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U/VtG6VE7zWrQke1C0jwUjUCh7PXfPilKdm/dVNjIos=;
        b=ASUSVQb9eSHNk8biaB76JoNUQavB84PkutoKF/5lgmFgWF7W9p8U+yZz0rg4VlR34x
         KezrN+KR072+FRpzcUJrw115K/PndSqqFRsix9EnQbvpXX8t89qrpUbya5FKimuNAD5Z
         Gupnzl26q3DpOWHuxIrVEsOhpVL1K4UPnfztkPyuf6L8Sqb3p/aJMV24Q9T5Vn1K1zHH
         8GJ3AlN4Nnrwrin3NIubnjrzON9gDIRzfv4KnZtKgsqAVkMVN9EzUfOwPu++iUTgakGR
         xvzdqZGrWIe/OiZ0xvMbFeFj6EOxeodbKPnzIgQX1Qje4HXyoAHX+ewlC8KJBMD3v/Or
         vQug==
X-Gm-Message-State: AOAM533kAlMQ4JM00F78MzlKVWcND4jt8ORs2uFRLY4/3EM/myAb5eqO
        tEpFTygVi58baXXGdIULyuSb01tGgbM8
X-Google-Smtp-Source: ABdhPJwduWsDu9nOn1wAVXUjgY9FmcJZlcoDsxFPK8CSVp1KqI55NfxIZsHalFp418moW6fMV41Bk7dDPhxf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ffd6:b7f5:87ee:7be2])
 (user=irogers job=sendgmr) by 2002:a25:c045:: with SMTP id
 c66mr2293005ybf.296.1624336710873; Mon, 21 Jun 2021 21:38:30 -0700 (PDT)
Date:   Mon, 21 Jun 2021 21:38:11 -0700
In-Reply-To: <20210622043811.3108564-1-irogers@google.com>
Message-Id: <20210622043811.3108564-4-irogers@google.com>
Mime-Version: 1.0
References: <20210622043811.3108564-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 4/4] libtraceevent: Increase libtraceevent logging when verbose
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-users@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Claire Jensen <cjense@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libtraceevent has added more levels of debug printout and with changes
like:
https://lore.kernel.org/linux-trace-devel/20210507095022.1079364-3-tz.stoyanov@gmail.com
previously generated output like "registering plugin" is no longer
displayed. This change makes it so that if perf's verbose debug output
is enabled then the debug and info libtraceevent messages can be
displayed.
The code is conditionally enabled based on the libtraceevent version as
discussed in the RFC:
https://lore.kernel.org/lkml/20210610060643.595673-1-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debug.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 2c06abf6dcd2..7e085d7cd8a9 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -24,6 +24,9 @@
 #include "util/parse-sublevel-options.h"
 
 #include <linux/ctype.h>
+#include <traceevent/event-parse.h>
+
+#define MAKE_LIBTRACEEVENT_VERSION(a, b, c) ((a)*255*255+(b)*255+(c))
 
 int verbose;
 int debug_peo_args;
@@ -228,6 +231,15 @@ int perf_debug_option(const char *str)
 	/* Allow only verbose value in range (0, 10), otherwise set 0. */
 	verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
 
+#if MAKE_LIBTRACEEVENT_VERSION(1, 3, 0) <= LIBTRACEEVENT_VERSION
+	if (verbose == 1)
+		tep_set_loglevel(TEP_LOG_INFO);
+	else if (verbose == 2)
+		tep_set_loglevel(TEP_LOG_DEBUG);
+	else if (verbose >= 3)
+		tep_set_loglevel(TEP_LOG_ALL);
+#endif
+
 	return 0;
 }
 
-- 
2.32.0.288.g62a8d224e6-goog

