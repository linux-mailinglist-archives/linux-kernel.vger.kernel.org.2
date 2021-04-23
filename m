Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF25369997
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243634AbhDWS3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243458AbhDWS26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:28:58 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776A4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:28:21 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id u20so18380764qku.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHfZLB/RyL5ipuOg49U3Triv5cvSVIfnZmPRHzEKBv0=;
        b=Ws4r8GPLQXotrSrgc+mY5+XUfPsUQrqfcDME+u8UZbQxoDz3eX9vgCq+H0r9/DwAWF
         12TxMRtr0UiULkSoSA9qj+uW48t7fi7InRsyCZe2+WvZmkFGAWOQcPmNlJS4XDIAMyaw
         1RYe3H5HA9Ha3Q5b7Nkp6PYnOg5zCsZCmwjt2CRyynsNtBtnvHZgtGOcULVq7kEErJKe
         FWN2Okf8XV4cBn45q4nSCgrVEmxDmz6ieLVe4lKyJd7Jlu0N+8m6icXqCFd5kxoSqQ22
         26qy+SI1lokpNKdNYhEW6lQDDMU1EET1QoH3CkAMzdY1C4bUOO16g+Z2ai5IRolztA6q
         yjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wHfZLB/RyL5ipuOg49U3Triv5cvSVIfnZmPRHzEKBv0=;
        b=PqKGA+1axmMeikKDftMEIKD6Jo7HBJBlU5bVtWUhODATsadOvMhrLWkSBqsJ4Fn94F
         pUXZ0EZxm5mqEUoPDSSy3CPbohwCSiEYk1GT8XwxjxDCFMfGMXd0Yv5IwAtxZsw9aLv6
         jDBtzJbk/ehJnV6hef3lrWfZelhV6ir3LElzDW823aHuoL06CJscuxTYfVPD7FRQ9ZMt
         AdJW6G9Eciab/q9VwJ9J493JxxiMomkBNffMSFqzvwbRhObYdpRUKWz64otHAq/bLZMK
         efMAC+z5bGcLm36J1XMmdV52ywenbFH7ObkY5XRTGbYawcEGUZeaMzKKA06507zyv9yc
         YwNQ==
X-Gm-Message-State: AOAM5314nK2GrdAmJeXD9Qled+R2uw1zZMHCFUWfTFPkndUMg3n++nX5
        1UBBhG1bWC30FbrnLueS/EU=
X-Google-Smtp-Source: ABdhPJxc0X1767CNJQX6PCSxc2jtNuKj2G/3SUBzkE1O5dR+lLsIvIMr6r1utU/HP8+lFkXhC2GO2Q==
X-Received: by 2002:a05:620a:16a1:: with SMTP id s1mr5464356qkj.109.1619202500762;
        Fri, 23 Apr 2021 11:28:20 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id c5sm4783863qkl.7.2021.04.23.11.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 11:28:20 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 3/5] perf report: Show event sample counts in --stat output
Date:   Fri, 23 Apr 2021 11:28:11 -0700
Message-Id: <20210423182813.1472902-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210423182813.1472902-1-namhyung@kernel.org>
References: <20210423182813.1472902-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the output identical with perf report -D, it needs to show
per-event sample counts along with the aggregated stat  at the end.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index b0b9b60f74e5..be56f3efa413 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -708,9 +708,22 @@ static void report__output_resort(struct report *rep)
 	ui_progress__finish();
 }
 
+static int count_sample_event(struct perf_tool *tool __maybe_unused,
+			      union perf_event *event __maybe_unused,
+			      struct perf_sample *sample __maybe_unused,
+			      struct evsel *evsel,
+			      struct machine *machine __maybe_unused)
+{
+	struct hists *hists = evsel__hists(evsel);
+
+	hists__inc_nr_events(hists);
+	return 0;
+}
+
 static void stats_setup(struct report *rep)
 {
 	memset(&rep->tool, 0, sizeof(rep->tool));
+	rep->tool.sample = count_sample_event;
 	rep->tool.no_warn = true;
 }
 
@@ -719,6 +732,7 @@ static int stats_print(struct report *rep)
 	struct perf_session *session = rep->session;
 
 	perf_session__fprintf_nr_events(session, stdout);
+	perf_evlist__fprintf_nr_events(session->evlist, stdout);
 	return 0;
 }
 
-- 
2.31.1.498.g6c1eba8ee3d-goog

