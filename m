Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113D53CF0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379456AbhGSXom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 19:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441968AbhGSW2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 18:28:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C984C08EBB4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:32:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y4so17929147pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0Nuc5Prp1GKdA9Dd+8nIInf5AUMXmoNYZmiAZbbVr8=;
        b=amU5ifTLKV3u+7VDGwLHwVqrj1209nx8C0TbhFyARmPe/epD/W1S/V3kE4f42TU9th
         G4JD4fn2pf2v55h3JqlclFSU7I3QK90JYpbIR/1FsqaHAlELq51NR59ulpbW86brO+VP
         ofGKFo0IqJqmOXn9/kuvOtigSUsPbbMy1p33Z484eDhF+K8k6Cszkg7ttmV/YaJCSAHg
         HdE60ApirrcjW5DW9CgKiwP4AjG9II3WFpUh1q58VLKHtxAB+51wQp5Ox4V40qTIVLL4
         7sHGohQ0iQvDm/GwKif6S2vBLwMB0UqoABSUB36PszrMUHO2mtzSpHFkBrQz/US4wZN+
         MfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=S0Nuc5Prp1GKdA9Dd+8nIInf5AUMXmoNYZmiAZbbVr8=;
        b=A6fF8csKIxAlGnIdYAz1lAQSdPBsiGgq7sLBd6+B2asmJiuMdKSe7FPG522qI0wd/J
         8/u8n2/QBg2TXFJz+jukzsTogdzCQHE47e4WGda1OKrHqkEW7H6L2Kkge8SWy+dULiDl
         y/5LwGOfzcmP72pqk8UuEDRoY8gEFoWwTIdfsGBbaUxt9P5NLxeAuFU617Md9JLJi88/
         1tI+pDOXNG0xM6s6E3kO1x1M7Sb1/lnwALk2GwC7LM9jBzB8+jQOLspYrogFqp/D33Ga
         iZW9Y16XBqLqKK+7EaxIZqAfgBAkwdG57Xtjgd/W3bjq1e03tl5d+uVv6uZpTAliEvFx
         aJfA==
X-Gm-Message-State: AOAM532B9lwcNYhDPwSkFvEXyJGSQ9/uFL+sdMrY/tXeFoVlLdqgBR4t
        /DbmG/1SwAmTYrFN+3viwl7H4SwPjuk=
X-Google-Smtp-Source: ABdhPJyg2kVPcTIJZbaxFv/NPIm76mB1QA2SM6EPCOwM4BhMTg8MZdvbXdj957olMq6bVOP1Pb7rjA==
X-Received: by 2002:a62:687:0:b029:2ef:be02:c346 with SMTP id 129-20020a6206870000b02902efbe02c346mr28522854pfg.51.1626733925069;
        Mon, 19 Jul 2021 15:32:05 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:ff4e:db29:48ff:3778])
        by smtp.gmail.com with ESMTPSA id q19sm6921569pgj.17.2021.07.19.15.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:32:04 -0700 (PDT)
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
Date:   Mon, 19 Jul 2021 15:31:50 -0700
Message-Id: <20210719223153.1618812-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
In-Reply-To: <20210719223153.1618812-1-namhyung@kernel.org>
References: <20210719223153.1618812-1-namhyung@kernel.org>
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
index 44249027507a..f280b3a38646 100644
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
2.32.0.402.g57bb445576-goog

