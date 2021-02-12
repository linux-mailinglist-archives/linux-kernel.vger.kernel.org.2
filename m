Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F57131993C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBLEiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhBLEis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:38:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991D9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 20:38:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 127so8455142ybc.19
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 20:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=5wM3QmaBSjsPMVOPBa5ekJ9mtLxgwKxj2USgf1qZous=;
        b=j0ezXLsyoeZR+fx0DkY0/Y68tG9puzu/N7D/BqodlMcdaEMAvJrYZUEKxqhbv3luXX
         uN5wAgO9a84ehGjZJu1hhEkz7O3nDYnbEFXNyi0T+EMaQH8Q7hKjf0KOQoFga4P28mmG
         BkMZwgC1eYPKowEA8SEqMcHojiDjYa9F5tumBypDO++l8pJSJ5lP2XEjjsFAVkPlZqpe
         5qSQykItz2B/UrKPeEQr+zonY3Lv3j7LjaSaCC+NU2/vLX+10+zYNtvin0/NWVuB9nr+
         BjFVUCa4eeejDLOSqm/r7HrSW5Ojfmxm5/9aS0URbBO7uGUsDns8pXUUYoKKNdQXcj1p
         QvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=5wM3QmaBSjsPMVOPBa5ekJ9mtLxgwKxj2USgf1qZous=;
        b=VSWWjky7wdzsMJln1NEX0rmr1lSsnjC8jCVuQ97PFaerN0KjvFxTT+JHKKHUAL6Ofj
         gsBHoAoqNKI/r5MBt0TEHNkw0aj+sHEXElbzc+xXFiN8tNhP5JWIPfJ2dWHTx4zE2jW+
         fSA4b7+yc+6fVbE8z8S5FP7ytAPyJbC3hGSBQwNw7L2vXW8mYPSnki+D8J3vX1vh+H/5
         fmEVjc35mtCIy6UXh+4Q3RKg/KNybgtQ2PrNjiusB/8ZBOpqTeZoCVItLOaukQpk0/8O
         CF2J9CNnumeDBEIKLs/PTCF+oQ9jrN+JZsfX6nXXMuUd/8kJU2yvn9Tkj8wdtHxYxhGt
         ap2Q==
X-Gm-Message-State: AOAM533NXAgKRF5QHqnrs1PJ4qgAXFHk0n2wJokFJHtjCqjIZ8uZ695S
        i+mgdOSNKUEB0fAvyGal+yDkM79RJnkn
X-Google-Smtp-Source: ABdhPJxaeyGkfUwuOC0yJXdHAFeLBzdKkUWGmRClrty0qaerZC4HcpiV9qHDRybUxfq1ZZJ0odikg6O4abBH
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:cdf1:7c25:80b2:5961])
 (user=irogers job=sendgmr) by 2002:a25:bbc2:: with SMTP id
 c2mr1576997ybk.311.1613104687710; Thu, 11 Feb 2021 20:38:07 -0800 (PST)
Date:   Thu, 11 Feb 2021 20:38:03 -0800
Message-Id: <20210212043803.365993-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] perf libperf: Remove unused xyarray.c
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrated to libperf in:
commit 4b247fa7314c ("libperf: Adopt xyarray class from perf")

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/xyarray.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)
 delete mode 100644 tools/perf/util/xyarray.c

diff --git a/tools/perf/util/xyarray.c b/tools/perf/util/xyarray.c
deleted file mode 100644
index 86889ebc3514..000000000000
--- a/tools/perf/util/xyarray.c
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "xyarray.h"
-#include <stdlib.h>
-#include <string.h>
-#include <linux/zalloc.h>
-
-struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size)
-{
-	size_t row_size = ylen * entry_size;
-	struct xyarray *xy = zalloc(sizeof(*xy) + xlen * row_size);
-
-	if (xy != NULL) {
-		xy->entry_size = entry_size;
-		xy->row_size   = row_size;
-		xy->entries    = xlen * ylen;
-		xy->max_x      = xlen;
-		xy->max_y      = ylen;
-	}
-
-	return xy;
-}
-
-void xyarray__reset(struct xyarray *xy)
-{
-	size_t n = xy->entries * xy->entry_size;
-
-	memset(xy->contents, 0, n);
-}
-
-void xyarray__delete(struct xyarray *xy)
-{
-	free(xy);
-}
-- 
2.30.0.478.g8a0d178c01-goog

