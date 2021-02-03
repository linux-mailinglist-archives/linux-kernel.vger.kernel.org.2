Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFC030D30D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 06:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhBCF15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 00:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhBCF1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 00:27:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9528FC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 21:27:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k141so19294762ybf.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 21:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=25t9HJ50dgGjPzhSo29oITTf14RojzF/SHp+npjqrvg=;
        b=oE4nD9PdZ0xCtTnc5HAFJ0Iek19ZAIHQLV6W9CERAbkM8p2mK3xRbd1QyEy+qe/kxw
         cww0Ax7bEkooyFkmZJpNSNVnO4UCk9TmaB+2cYR4ppjHwjKS/59PhfgkpABfPioqU10w
         mZmoI8HdVKx6ez16C9bJeHwkipAw9Ha2aL9X5ZlWk9aEare4PG4lIYbucH2gZ+egizvP
         ctv/KridZ/IlW3+uxCuoclk6r2oHcS2l9LXO6klo6DrMXg8ztncDsOkSxOWEdhadBneH
         w+inb/p5Q7x4KeyigtitIa//j4KxTjP2rEfxrOisndcImzvLL/E+8wFHMf9S2rAJgwKu
         qcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=25t9HJ50dgGjPzhSo29oITTf14RojzF/SHp+npjqrvg=;
        b=Qwm5LrggMda6pegL1PZACUIuxeHc+92CcGMmrqzzTUH2en5EladNaRGoc9pNXX01KM
         Qm5IeYRNCpYH79j7wY1bT7DptYWrQ6HdILVsHGouzG/ijZeoYAzyAziYJ4elHAsT3fIX
         V4i4bz11H+FyKj6T+wcKfwqSG5Ts3RUmE/Tz4cNgKSvoFSUN8SM3aCVIqobfzbQJdPYZ
         NaN97xgtK5nzl3+EK9U8yjn4leXFSdiDZsaR8ZpvrP0oeBTnbLJHNILYAgUeHLhe2cge
         YnqiJKNOvQQUJsF2Eb4Xg6yaPWkE/C8wFc5aXy6EUslzE0IgaSr72CAvUFTNVZzjj1//
         roEg==
X-Gm-Message-State: AOAM533ovOlCcuOV33D6mhPt0NMMPpkgNqE+Ok1h75w5JNiujN9XtmZv
        oQj7Ly58DSoPbQjpc2VBAQ+hFu/BVmQD
X-Google-Smtp-Source: ABdhPJz46TFMD774K62Icekxtzqr3epxwLHSH/IbtgOMP8lmgDo3yWF96QaIDBrlKqTFVq3kCuBOz7WDL9UT
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:2de9:3170:c58a:bdf0])
 (user=irogers job=sendgmr) by 2002:a25:d681:: with SMTP id
 n123mr2099452ybg.37.1612330023813; Tue, 02 Feb 2021 21:27:03 -0800 (PST)
Date:   Tue,  2 Feb 2021 21:26:58 -0800
Message-Id: <20210203052659.2975736-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 1/2] perf trace-event-info: Rename for_each_event.
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

Avoid a naming conflict with for_each_event with similar code in
parse-events.c, rename to for_each_event_tps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/trace-event-info.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 0e5c4786f296..a65f65d0857e 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -152,7 +152,7 @@ static bool name_in_tp_list(char *sys, struct tracepoint_path *tps)
 	return false;
 }
 
-#define for_each_event(dir, dent, tps)				\
+#define for_each_event_tps(dir, dent, tps)			\
 	while ((dent = readdir(dir)))				\
 		if (dent->d_type == DT_DIR &&			\
 		    (strcmp(dent->d_name, ".")) &&		\
@@ -174,7 +174,7 @@ static int copy_event_system(const char *sys, struct tracepoint_path *tps)
 		return -errno;
 	}
 
-	for_each_event(dir, dent, tps) {
+	for_each_event_tps(dir, dent, tps) {
 		if (!name_in_tp_list(dent->d_name, tps))
 			continue;
 
@@ -196,7 +196,7 @@ static int copy_event_system(const char *sys, struct tracepoint_path *tps)
 	}
 
 	rewinddir(dir);
-	for_each_event(dir, dent, tps) {
+	for_each_event_tps(dir, dent, tps) {
 		if (!name_in_tp_list(dent->d_name, tps))
 			continue;
 
@@ -274,7 +274,7 @@ static int record_event_files(struct tracepoint_path *tps)
 		goto out;
 	}
 
-	for_each_event(dir, dent, tps) {
+	for_each_event_tps(dir, dent, tps) {
 		if (strcmp(dent->d_name, "ftrace") == 0 ||
 		    !system_in_tp_list(dent->d_name, tps))
 			continue;
@@ -289,7 +289,7 @@ static int record_event_files(struct tracepoint_path *tps)
 	}
 
 	rewinddir(dir);
-	for_each_event(dir, dent, tps) {
+	for_each_event_tps(dir, dent, tps) {
 		if (strcmp(dent->d_name, "ftrace") == 0 ||
 		    !system_in_tp_list(dent->d_name, tps))
 			continue;
-- 
2.30.0.365.g02bc693789-goog

