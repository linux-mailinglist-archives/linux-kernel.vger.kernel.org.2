Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282EF3BEDB1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhGGSIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhGGSI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:08:26 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241F6C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 11:05:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y17so3088671pgf.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hbic428QCVRcNM0pEatsih2P7pffaAskUqlK5VVUd4E=;
        b=FJsHuzgVQ6ezYqRTT0yQXsPEXC6YSygPINpYnwDfVzWwkwZbLSuUkgNmuk5kZOYDSv
         7E/vtnv/WRhhm1WV0F9vd+gW6nG9rK9M1R1wsHD+f+VTUbPdRfELmQ1NNDGfwilD1eb4
         BUJw/9t9eedyxIvvJzX3Q3JoKy4QBTt2XHqzl0y4ScJH9Ac24/qrGAb4I4aGYonxtFOa
         O0LBhnw9MbxFmk1YyGNviVIo51faXiziwGztVC1iOpXVzHZLag1tQqGaFYjQ5IPVCgoJ
         /Ifb6uv6W1CYflByKGW5IzVf52cU+2QoAASkCXm2TdYL321+Q8GEMxPW5HJtBRRis3c0
         BrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Hbic428QCVRcNM0pEatsih2P7pffaAskUqlK5VVUd4E=;
        b=ht7EVEoV3gd5wgG6WyJAF+lIY17rH8b56CfKkkviEsHqZM8c6sTqfmn4SOu10jVrlv
         riioecEw6qz9kA1nf7/qHD6w1ay1epywYgcrwuECnnFHPz3uCIDEI6NXkUiuftrnNcuX
         x/gaZaiRtSVs4xUHbyBgjwANWcHP3uAPeq3xGcuc06Lhr8JSmI7p2VycVTxmiC3ekgME
         XAQ6dacmVjulas5+FOkBX8NIXcysWWTLhYp2eJjT/yrYgXQFbt3kPNcCgUKZxSocuFno
         cmWepYoLvNx24o55Wc4Ps+AmvrgV8gbKlAiTY7JTOJ1tplqbAabov/PnTlBV+efhDeAQ
         9dmw==
X-Gm-Message-State: AOAM5326kV3j9FbMQVM/Xc8Twyvt5enEBwOQBI9HWdHyQPEidr7it09A
        jluOOw6x4vhgDZd9QzofE/I=
X-Google-Smtp-Source: ABdhPJysmXGnmLpxq1kFKTsDpg2yz9vwqG77+BCha/LWl9/2qs7w/WAAonThZrnlPigZLXm6KVZkVA==
X-Received: by 2002:a65:564f:: with SMTP id m15mr27241268pgs.346.1625681145745;
        Wed, 07 Jul 2021 11:05:45 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:8e3d:643a:56fb:b045])
        by smtp.gmail.com with ESMTPSA id 1sm9379711pfm.123.2021.07.07.11.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:05:45 -0700 (PDT)
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
Subject: [PATCH 4/4] perf inject: Fix output from a file to a pipe
Date:   Wed,  7 Jul 2021 11:05:36 -0700
Message-Id: <20210707180536.72175-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210707180536.72175-1-namhyung@kernel.org>
References: <20210707180536.72175-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the input is a regular file but the output is a pipe, it should
write a pipe header.  But just repiping would write a portion of the
existing header which is different in 'size' value.  So we need to
prevent it and write a new pipe header along with other information
like event attributes and features.

This can handle something like this:

  # perf record -a -B sleep 1

  # perf inject -b -i perf.data | perf report -i -

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 57 +++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 7c126597d3f5..50ed158c8076 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -918,6 +918,7 @@ int cmd_inject(int argc, const char **argv)
 		.use_stdio = true,
 	};
 	int ret;
+	bool repipe = true;
 
 	struct option options[] = {
 		OPT_BOOLEAN('b', "build-ids", &inject.build_ids,
@@ -992,10 +993,18 @@ int cmd_inject(int argc, const char **argv)
 	}
 
 	data.path = inject.input_name;
-	if (!strcmp(inject.input_name, "-") || inject.output.is_pipe)
+	if (!strcmp(inject.input_name, "-") || inject.output.is_pipe) {
 		inject.is_pipe = true;
+		/*
+		 * Do not repipe header when input is a regular file
+		 * since either it can rewrite the header at the end
+		 * or write a new pipe header.
+		 */
+		if (strcmp(inject.input_name, "-"))
+			repipe = false;
+	}
 
-	inject.session = __perf_session__new(&data, inject.is_pipe,
+	inject.session = __perf_session__new(&data, repipe,
 					     perf_data__fd(&inject.output),
 					     &inject.tool);
 	if (IS_ERR(inject.session))
@@ -1004,6 +1013,50 @@ int cmd_inject(int argc, const char **argv)
 	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed.\n");
 
+	if (!data.is_pipe && inject.output.is_pipe) {
+		ret = perf_header__write_pipe(perf_data__fd(&inject.output));
+		if (ret < 0) {
+			pr_err("Couldn't write a new pipe header.\n");
+			goto out_delete;
+		}
+
+		ret = perf_event__synthesize_attrs(&inject.tool,
+						   inject.session->evlist,
+						   perf_event__repipe);
+		if (ret < 0) {
+			pr_err("Couldn't inject synthesized attrs.\n");
+			goto out_delete;
+		}
+
+		ret = perf_event__synthesize_features(&inject.tool,
+						      inject.session,
+						      inject.session->evlist,
+						      perf_event__repipe);
+		if (ret < 0) {
+			pr_err("Couldn't inject synthesized features.\n");
+			goto out_delete;
+		}
+
+		if (have_tracepoints(&inject.session->evlist->core.entries)) {
+			/*
+			 * FIXME err <= 0 here actually means that
+			 * there were no tracepoints so its not really
+			 * an error, just that we don't need to
+			 * synthesize anything.  We really have to
+			 * return this more properly and also
+			 * propagate errors that now are calling die()
+			 */
+			ret = perf_event__synthesize_tracing_data(&inject.tool,
+						perf_data__fd(&inject.output),
+						inject.session->evlist,
+						perf_event__repipe);
+			if (ret <= 0) {
+				pr_err("Couldn't inject tracing data.\n");
+				goto out_delete;
+			}
+		}
+	}
+
 	if (inject.build_ids && !inject.build_id_all) {
 		/*
 		 * to make sure the mmap records are ordered correctly
-- 
2.32.0.93.g670b81a890-goog

