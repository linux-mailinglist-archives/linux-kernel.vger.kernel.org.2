Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7311E3BEDB2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhGGSIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhGGSIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:08:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6863C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 11:05:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 145so2982247pfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FDm3lJYHGGaxvtivXokPORl5JWRQ690WY2gWwBN/M4s=;
        b=da9j5qi3P8In4VmR+etcuhpvNo7YCMZDFsXdUJ8k1NP0MPlub1cGK+aJDSylY/CC0k
         mfyHa/dbBAes3yFt80JI04KxouAKly8B9PvOroja7EVFdeCBP+caucvkphwWwCqHyUYC
         y2nchSLljk3N178NxNUjOoeBIQalvoPxGX30ehF9OFdC4fNw2V0YXZTF9Wf4x+QE5B9C
         OUNsjTb2glEuRRxQfVMxwLocpxBFfWC9v67gkEBBhb8eFDOtv8ez60pAvOaA2JDhoPBC
         z5ZoprqR/6vLhA6FZrNkAEsPXmf/0KrkUz48kG6ykQQOw0Wrr9aJsIVL9AZUxC1+Ubbt
         TAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FDm3lJYHGGaxvtivXokPORl5JWRQ690WY2gWwBN/M4s=;
        b=naZYgsYZmJxago3M80alhHlC2pZ8QuYvWS1qfNGJQE3+T7bBvvJZTyl/mhEwdvpPNQ
         2lgj3qHzqtOJwanXI1Vpcg/6qDSSPsgiAiQ6u35lcRmIONBlnyA5TfazF/dEc0pcX7mg
         S9UowyIVsZenDhiJDWHTBvcv6CBot8i5c+cFy+YWAoN17ZKri0PB9ohkiDa1aDFbA8rv
         jzS4zdgwd3wOtQ/Z4QDqoMRdnct3o823YvhQmkcmbST2g7E9leeB9XKJl8YquzofKDPX
         izfcC6dzb+5iDmwM/aDpBCyrx8a1iS+7Gz5ESBzjnwUc1VbpgdUZ0V/rEggJbcf3ne4O
         X7xg==
X-Gm-Message-State: AOAM531p5aqcYXlf8zH1pjISNCb+m/d+nYgZkKtKI6Ljjvv0PWvMjApd
        Ke6RBYZ0Kqff9R2DLm0++XrBdLK+Xvg=
X-Google-Smtp-Source: ABdhPJw96qrlzeEJXEhSioQltVIoxvM01zRmsxHiZKyfGdSvyKYCogEhe1DRrKpGjgaZ0eAbbOjczw==
X-Received: by 2002:a65:6494:: with SMTP id e20mr27789204pgv.101.1625681144243;
        Wed, 07 Jul 2021 11:05:44 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:8e3d:643a:56fb:b045])
        by smtp.gmail.com with ESMTPSA id 1sm9379711pfm.123.2021.07.07.11.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:05:43 -0700 (PDT)
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
Subject: [PATCH 3/4] perf inject: Fix output from a pipe to a file
Date:   Wed,  7 Jul 2021 11:05:35 -0700
Message-Id: <20210707180536.72175-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210707180536.72175-1-namhyung@kernel.org>
References: <20210707180536.72175-1-namhyung@kernel.org>
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
2.32.0.93.g670b81a890-goog

