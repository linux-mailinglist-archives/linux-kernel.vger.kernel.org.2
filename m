Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44883CF0C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379824AbhGSXqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 19:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442039AbhGSWdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 18:33:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34225C08EC26
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:32:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a127so17925454pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=syPwIwbWlprfb5Gh/Ulv2ZSrap5K83pP7HkgDMtPAu0=;
        b=awCQ88jw7gmtBD8uT3/z2wZF6npN/EWOOI6S6wG6b/HcVNyQARzF7qRCUJh0f6TdYf
         xXLRXqgRnh1yOKIpvQz/NL3QURJjKjoOIJKTJq6L8gJJM2pvHjkVZY+qVc42WGaVcX24
         noH8VZh7eSfbXxH8kGrYu5/G8b4JLX7epm3dQ2/eKK35zEXdsU6uX0wJQAwGYODfD7iG
         7F1TQfNPAxDSjJAUwbLPEk04Ey2GNGlgPlJJ636NcY1cnf0ruLqL3UeDQ2lslg7zrNl0
         9wtdIZs4DYSRXcFzQhwc7yXNjIZsXZCNcULqzJSaJLQYyO2szDtQZq9E0oPbZTInbEqn
         m4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=syPwIwbWlprfb5Gh/Ulv2ZSrap5K83pP7HkgDMtPAu0=;
        b=hbl55iAW4LIUyLJbhPqV4hE9IcOghk/pB8r6FvuMLy3jP5LGrSeeYpBdN74KY9vmGN
         ltnoCgLLNMkTgm1jpC/KvW+6rr2u65Gcx4Js3mmXfNbB3QOtugT7HYNnlNxDPvLUbLrk
         y4yWItuUL5Tf4yijtW2KAPQXUABi4jVnDOsFHPzn4wIuciodqXEfwrjK1nmdid0oWbRO
         KKKhS4UameYKemk7t3IcaDZZJ5JnREQf+Rhr0BoXIS+IwHpxjflgoFGRHBXUzuQh4tbw
         ylxCq40hCuEuWS+UTEWMhIGFdfeR/50EAMMoeGweLPRWALN0UYr5tLxfR5tG6zQrlJ0b
         9uPw==
X-Gm-Message-State: AOAM532BHjDkSjwvmCPowXkn0LBicHFhsnQAZH8J1bTG/BtYZVPGf0hv
        SIbO1QtOLw5/vsPwOaF2u4E=
X-Google-Smtp-Source: ABdhPJz1S9Vu6eeftkQmt1H8RPjwDcjgKCexKUHfMT4R34a1uQadsmKHRTQePDO9XSPZKyNBxuJkPw==
X-Received: by 2002:a63:4e51:: with SMTP id o17mr17178001pgl.126.1626733926726;
        Mon, 19 Jul 2021 15:32:06 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:ff4e:db29:48ff:3778])
        by smtp.gmail.com with ESMTPSA id q19sm6921569pgj.17.2021.07.19.15.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:32:06 -0700 (PDT)
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
Subject: [PATCH 3/5] perf inject: Fix output from a pipe to a file
Date:   Mon, 19 Jul 2021 15:31:51 -0700
Message-Id: <20210719223153.1618812-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
In-Reply-To: <20210719223153.1618812-1-namhyung@kernel.org>
References: <20210719223153.1618812-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes it needs to save the perf inject data to a file for
debugging.  But normally it assumes the same format for input and
output, so the end result cannot be used due to a broken format.

  # perf record -a -o - sleep 1 | perf inject -b -o my.data

  # perf report -i my.data --stdio
  0x208 [0]: failed to process type: 0 [Invalid argument]
  Error:
  failed to process sample
  # To display the perf.data header info, please use --header/--header-only options.
  #

In this case, it thought the data has a regular file header since the
output is not a pipe.  But actually it doesn't have one and has a pipe
file header.  At the end of the session, it tries to rewrite the
regular file header with updated features and it overwrites the data
just follows the pipe header.

Fix it by checking either the input and the output is a pipe.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index d99f4538d2fc..7c126597d3f5 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -46,6 +46,7 @@ struct perf_inject {
 	bool			jit_mode;
 	bool			in_place_update;
 	bool			in_place_update_dry_run;
+	bool			is_pipe;
 	const char		*input_name;
 	struct perf_data	output;
 	u64			bytes_written;
@@ -126,7 +127,7 @@ static int perf_event__repipe_attr(struct perf_tool *tool,
 	if (ret)
 		return ret;
 
-	if (!inject->output.is_pipe)
+	if (!inject->is_pipe)
 		return 0;
 
 	return perf_event__repipe_synth(tool, event);
@@ -825,14 +826,14 @@ static int __cmd_inject(struct perf_inject *inject)
 	if (!inject->itrace_synth_opts.set)
 		auxtrace_index__free(&session->auxtrace_index);
 
-	if (!data_out->is_pipe && !inject->in_place_update)
+	if (!inject->is_pipe && !inject->in_place_update)
 		lseek(fd, output_data_offset, SEEK_SET);
 
 	ret = perf_session__process_events(session);
 	if (ret)
 		return ret;
 
-	if (!data_out->is_pipe && !inject->in_place_update) {
+	if (!inject->is_pipe && !inject->in_place_update) {
 		if (inject->build_ids)
 			perf_header__set_feat(&session->header,
 					      HEADER_BUILD_ID);
@@ -991,7 +992,10 @@ int cmd_inject(int argc, const char **argv)
 	}
 
 	data.path = inject.input_name;
-	inject.session = __perf_session__new(&data, inject.output.is_pipe,
+	if (!strcmp(inject.input_name, "-") || inject.output.is_pipe)
+		inject.is_pipe = true;
+
+	inject.session = __perf_session__new(&data, inject.is_pipe,
 					     perf_data__fd(&inject.output),
 					     &inject.tool);
 	if (IS_ERR(inject.session))
-- 
2.32.0.402.g57bb445576-goog

