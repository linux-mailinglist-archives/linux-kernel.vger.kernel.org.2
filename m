Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E653C7A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 02:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhGNAhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 20:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbhGNAhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 20:37:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E746C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 17:34:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x16so312656pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 17:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JE7W+Yd8WHQzk8V5Xe0vhncZeoTcU/+HKmbQiqaEI34=;
        b=XxMsSDE9+zYoHdp1NA4CQsb4vSYGKaQWOlDVqPh0x5Q1Juu77zgX6+/wVwIJDbJ0J5
         fVttK2wuVb35pZOnksG+M/JYBmu+0c1FFKe9Tiogd9t53bzwcI9P8Zz5nvVCwK9XdiU8
         Y+RAXb+Qfyb4ov/M7Hb9uwDJbwex4paGQKm9IVvSEKT+oHSIqZ7XXMwTKU3ckOHQN4dL
         JhhMUrLxuj7SC9uKGUUcyxUv2bI+2f0QX5HXXytiCUHk6C1JHEaqCTcFNnCDTCVyDt/G
         aE3ezyoC3jSqCVfrBUyLzMYgNhplieoZU17VkNXAQYQnEqZi52LOknDXIns7vc0RQDvl
         HzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JE7W+Yd8WHQzk8V5Xe0vhncZeoTcU/+HKmbQiqaEI34=;
        b=e/HYOEazdnOn5Lg3GwctQ+tr06jdgCa5RWpTNjcPNbwvkYQ6ZpIiJ8Uk9yWaCYvJVT
         P4MsrQGbyU9eMy4cAiD54MwCJ8cyqEBojYftUnBUZouH21a0Bksl16GdvFO6GTWqqeA7
         ybMDd3Ue7bJ69qnvJYicLEMnGhZQbyqHohB36kSSgvb1avmivkqPthQ1kG0xxrXCfqOD
         Gdm0IHfSrvffcwfBUnDZOjoYGes+9SlLI0k6UYJSqcZyr7qxTINav0bvrwqOf8Et1506
         VojiosHjITSLG2Jht2AVWYgbt4HPGCFu6HpZnW7rr6pWf2/5Poip4okZwRfV5RKHXM/d
         i5cw==
X-Gm-Message-State: AOAM5312BsDyIumMJ0ec8AL84YPhs5I/0BTYfu8llqci/2z/MEZZ/1Ni
        bCNc0GJ6rtaJcTZiXq8/bVw=
X-Google-Smtp-Source: ABdhPJz6MT+lWH9xNfFUsD82ChwvfD18IQl/ePgCh2kMvHMbZ6aKvE71elBKqBZAo6yaiEi+ftXAUw==
X-Received: by 2002:a65:6191:: with SMTP id c17mr6710991pgv.153.1626222887787;
        Tue, 13 Jul 2021 17:34:47 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:9b12:1fd4:6232:5315])
        by smtp.gmail.com with ESMTPSA id x6sm285896pgq.67.2021.07.13.17.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:34:47 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/5] perf tools: Pass a fd to perf_file_header__read_pipe()
Date:   Tue, 13 Jul 2021 17:34:39 -0700
Message-Id: <20210714003442.1111502-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210714003442.1111502-1-namhyung@kernel.org>
References: <20210714003442.1111502-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it unconditionally writes to stdout for repipe.  But perf
inject can direct its output to a regular file.  Then it needs to
write the header to the file as well.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c |  1 +
 tools/perf/util/header.c    | 12 ++++++------
 tools/perf/util/header.h    |  2 +-
 tools/perf/util/session.c   |  8 ++++----
 tools/perf/util/session.h   |  4 ++--
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 3cffb12f01be..d99f4538d2fc 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -992,6 +992,7 @@ int cmd_inject(int argc, const char **argv)
 
 	data.path = inject.input_name;
 	inject.session = __perf_session__new(&data, inject.output.is_pipe,
+					     perf_data__fd(&inject.output),
 					     &inject.tool);
 	if (IS_ERR(inject.session))
 		return PTR_ERR(inject.session);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 0158d2945bab..4f1a7b6df7ee 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3865,10 +3865,10 @@ static int perf_file_section__process(struct perf_file_section *section,
 static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
 				       struct perf_header *ph,
 				       struct perf_data* data,
-				       bool repipe)
+				       bool repipe, int repipe_fd)
 {
 	struct feat_fd ff = {
-		.fd = STDOUT_FILENO,
+		.fd = repipe_fd,
 		.ph = ph,
 	};
 	ssize_t ret;
@@ -3891,13 +3891,13 @@ static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
 	return 0;
 }
 
-static int perf_header__read_pipe(struct perf_session *session)
+static int perf_header__read_pipe(struct perf_session *session, int repipe_fd)
 {
 	struct perf_header *header = &session->header;
 	struct perf_pipe_file_header f_header;
 
 	if (perf_file_header__read_pipe(&f_header, header, session->data,
-					session->repipe) < 0) {
+					session->repipe, repipe_fd) < 0) {
 		pr_debug("incompatible file format\n");
 		return -EINVAL;
 	}
@@ -3995,7 +3995,7 @@ static int evlist__prepare_tracepoint_events(struct evlist *evlist, struct tep_h
 	return 0;
 }
 
-int perf_session__read_header(struct perf_session *session)
+int perf_session__read_header(struct perf_session *session, int repipe_fd)
 {
 	struct perf_data *data = session->data;
 	struct perf_header *header = &session->header;
@@ -4016,7 +4016,7 @@ int perf_session__read_header(struct perf_session *session)
 	 * We can read 'pipe' data event from regular file,
 	 * check for the pipe header regardless of source.
 	 */
-	err = perf_header__read_pipe(session);
+	err = perf_header__read_pipe(session, repipe_fd);
 	if (!err || perf_data__is_pipe(data)) {
 		data->is_pipe = true;
 		return err;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index ae6b1cf19a7d..c9e3265832d9 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -115,7 +115,7 @@ struct perf_session;
 struct perf_tool;
 union perf_event;
 
-int perf_session__read_header(struct perf_session *session);
+int perf_session__read_header(struct perf_session *session, int repipe_fd);
 int perf_session__write_header(struct perf_session *session,
 			       struct evlist *evlist,
 			       int fd, bool at_exit);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f76b18e3c061..a40dd37ac71e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -102,11 +102,11 @@ static int perf_session__deliver_event(struct perf_session *session,
 				       struct perf_tool *tool,
 				       u64 file_offset);
 
-static int perf_session__open(struct perf_session *session)
+static int perf_session__open(struct perf_session *session, int repipe_fd)
 {
 	struct perf_data *data = session->data;
 
-	if (perf_session__read_header(session) < 0) {
+	if (perf_session__read_header(session, repipe_fd) < 0) {
 		pr_err("incompatible file format (rerun with -v to learn more)\n");
 		return -1;
 	}
@@ -186,7 +186,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 }
 
 struct perf_session *__perf_session__new(struct perf_data *data,
-					 bool repipe,
+					 bool repipe, int repipe_fd,
 					 struct perf_tool *tool)
 {
 	int ret = -ENOMEM;
@@ -211,7 +211,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 		session->data = data;
 
 		if (perf_data__is_read(data)) {
-			ret = perf_session__open(session);
+			ret = perf_session__open(session, repipe_fd);
 			if (ret < 0)
 				goto out_delete;
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 9d19d2a918c6..5d8bd14a0a39 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -55,13 +55,13 @@ struct decomp {
 struct perf_tool;
 
 struct perf_session *__perf_session__new(struct perf_data *data,
-					 bool repipe,
+					 bool repipe, int repipe_fd,
 					 struct perf_tool *tool);
 
 static inline struct perf_session *perf_session__new(struct perf_data *data,
 						     struct perf_tool *tool)
 {
-	return __perf_session__new(data, false, tool);
+	return __perf_session__new(data, false, -1, tool);
 }
 
 void perf_session__delete(struct perf_session *session);
-- 
2.32.0.93.g670b81a890-goog

