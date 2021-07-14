Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6F3C7A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 02:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbhGNAhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 20:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbhGNAhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 20:37:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FD9C0613EF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 17:34:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t9so193843pgn.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 17:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FDm3lJYHGGaxvtivXokPORl5JWRQ690WY2gWwBN/M4s=;
        b=qesyhibu30an5buJETLm55Cy+AEcE3HgMBCdY8QypdHwbsOeErWTIKuUfCZv/BNtUU
         H1li/17O+8In5hNoMTBKzhAgAByyIhtlMSHA3V8E9A6UAl7GCjl7n/tGVHZ1UlgqPAeF
         EI53gATUYT5pSCm10mdHWUx0Jgko3SqN4W09d2JYigjzCfPM2RQsRglZRXGcCvJCROhE
         /5lTWTV02UCCNKB4Gokf1wR5n909JCoV3cQHEdvHjEI0hB9g34pFOnXhBc0BZP76JXgt
         4edXmL01/DvAvzEm8BCjNsVUkwZHNN7NV+aRLJBoX60Lr0lInyVM7NrJB+yIx3yA+JD+
         Ku6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FDm3lJYHGGaxvtivXokPORl5JWRQ690WY2gWwBN/M4s=;
        b=hRx3wvctBlJjOLc9MZBiUXP6lC5a1XHiH5nuBYKFQVJ2V+O9cixgVnaAa/YTNqu8tN
         2xus5HcjyadNb+d17NbHlt3pH3xBPF3DRkcPLNWffmIK6JXjRYj7I3d7zeeyPt1i1OV3
         I71Krlqo9QUXGIyiR4KLALLvhln8G1tmevZOmBjVyn1DWGU3cqNFEkYbDnASnFy0zYEq
         Ud3W13yZDU7SiYZX+LBhH81/9M2Fs067yO8KkEchsR+EmW6G9sOXmfTZTpvEBwqdVYWD
         TxecCprZgVmcTCx+7CSo7XWHndPCJt5eLi0ZEytGOKRK7eMDgQsPI91WFOpYgbS3aPfX
         aChA==
X-Gm-Message-State: AOAM533N4SLkyFCpQt2ztdscNEkM5lfDjVA+dksB7nLW2S0LhBB9LKGd
        4Gj6ijyUTZw9AD3mBw9r1lo=
X-Google-Smtp-Source: ABdhPJwqpyznI3YlQD6teLmYXmLgVtl/dLkFmBFhXctP8/NA5e2Mqak8pHhEI3qEbI81t++uNTtexw==
X-Received: by 2002:a63:3387:: with SMTP id z129mr6522500pgz.227.1626222889149;
        Tue, 13 Jul 2021 17:34:49 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:9b12:1fd4:6232:5315])
        by smtp.gmail.com with ESMTPSA id x6sm285896pgq.67.2021.07.13.17.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:34:48 -0700 (PDT)
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
Date:   Tue, 13 Jul 2021 17:34:40 -0700
Message-Id: <20210714003442.1111502-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210714003442.1111502-1-namhyung@kernel.org>
References: <20210714003442.1111502-1-namhyung@kernel.org>
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

