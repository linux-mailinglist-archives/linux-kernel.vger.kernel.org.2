Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5123C959E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 03:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhGOBgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 21:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbhGOBgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:36:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82769C061762
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:33:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o11-20020a056902110bb029055b266be219so5394733ybu.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1xMjO4kgd9GThnwLrzWb6z2olJzN511MeRsxBTktrzk=;
        b=pRHGVkQD82aM2yJLyYhoIsWE+JyJ2wImCtJzcHe4/zJiRulZVfj42YGWY58XGlIXdV
         5LYqcPYKAL5K2+GrKgD0g9zb+LCgiC2+WD1efwrmxYxAl6xpJEO7qHTQnkMk2rSbOp2c
         kwivQbYIiyFTMMF8c5LxseFw2ku7iCZeEXz2yNFGLhmo/R1LHHDn7cEe+Nr4VbCCEQn7
         ZtY0VB/quv6SH8ELwa+HWCCudGga4JtSXzH0BXu0QIhcyKTi0DrM6F1DSnAyp2Zi2G0V
         36HW9ohU2uMy8l/Q3o/wFm5VZ+SI2DhIbcbteEf5P9yR3PUiTi6AjPx/3Jqi1KojtC9h
         P7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1xMjO4kgd9GThnwLrzWb6z2olJzN511MeRsxBTktrzk=;
        b=m8N7+Nkf45U5DXoxeAH4/8O3baumsg2N9lqWleb3XX0hFGlXw2jpLLN75jFDLAb9R+
         y9KxWHylgoVMyMhzPI+6fdHoK675Ct05I4HW6jmBvBAsblTd96Y7rVRCjpYUOJXWhHDd
         7LZg4FmmDbSpfuFbt8swh4QUnRAJGZ0zhveb9w8TfuhkQdRGv1RpzRi0VyLNkDHo8V97
         u7csNQ+SZI1ihinjeU5Zke2Epxd4rYu9GnuXsk3zL1xjfl9mJ9Rlh0sDxE8S8ZxffitM
         z1q7AlKDZRURF9zPEW/Wt3Ym7ElU74lONANDFWznH6GaE9rcdAtd+Corbucp5ZAivYui
         BEng==
X-Gm-Message-State: AOAM5334TbVKD06J3/4la60+Pc9cK1R/wbA5Qah+WsWvgnaYEs0zb19T
        baKNP2FktsBrbomTH8ZA6SrjY1cbsPv0
X-Google-Smtp-Source: ABdhPJyOLYEmVqY779oa560cGqUl3Entvz5QJopYEhEmjtBsyZCK85zVwW3Pn4IcYC6QO5vVsWKtIP6J/5m+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a5b:4d2:: with SMTP id u18mr1321425ybp.158.1626312838591;
 Wed, 14 Jul 2021 18:33:58 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:38 -0700
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
Message-Id: <20210715013343.2286699-3-irogers@google.com>
Mime-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 2/7] perf doc: Fix doc.dep
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The doc.dep dependencies for the Makefile fail to build as
build-docdep.perl is missing. Add this file from git.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/build-docdep.perl | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100755 tools/perf/Documentation/build-docdep.perl

diff --git a/tools/perf/Documentation/build-docdep.perl b/tools/perf/Documentation/build-docdep.perl
new file mode 100755
index 000000000000..ba4205e0302a
--- /dev/null
+++ b/tools/perf/Documentation/build-docdep.perl
@@ -0,0 +1,46 @@
+#!/usr/bin/perl
+
+my %include = ();
+my %included = ();
+
+for my $text (<*.txt>) {
+    open I, '<', $text || die "cannot read: $text";
+    while (<I>) {
+	if (/^include::/) {
+	    chomp;
+	    s/^include::\s*//;
+	    s/\[\]//;
+	    $include{$text}{$_} = 1;
+	    $included{$_} = 1;
+	}
+    }
+    close I;
+}
+
+# Do we care about chained includes???
+my $changed = 1;
+while ($changed) {
+    $changed = 0;
+    while (my ($text, $included) = each %include) {
+	for my $i (keys %$included) {
+	    # $text has include::$i; if $i includes $j
+	    # $text indirectly includes $j.
+	    if (exists $include{$i}) {
+		for my $j (keys %{$include{$i}}) {
+		    if (!exists $include{$text}{$j}) {
+			$include{$text}{$j} = 1;
+			$included{$j} = 1;
+			$changed = 1;
+		    }
+		}
+	    }
+	}
+    }
+}
+
+while (my ($text, $included) = each %include) {
+    if (! exists $included{$text} &&
+	(my $base = $text) =~ s/\.txt$//) {
+	print "$base.html $base.xml : ", join(" ", keys %$included), "\n";
+    }
+}
-- 
2.32.0.402.g57bb445576-goog

