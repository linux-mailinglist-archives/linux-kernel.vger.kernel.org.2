Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DC83B0951
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhFVPmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232324AbhFVPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624376385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/wFXoBcn9iO6fPUOkqFiUXQLnfuBmGcAVxGMEB2Nh4=;
        b=PaCyz4EhR5y3LVd//dP/Yorfd+UzBsDoiFrY1fFXRYS4a9hU0AeTdTBdE11ImS/WAGO4b6
        ZVA8l5WWeCDO8WlM/2VaANezM1ny3Zw0m4bkQwCyLYIS+HUdPy5wvouWK1PaQPp452bkXw
        VGrZa7vEBVqUVrLafyvaQFwLo78fsxA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-eahE40MfPVGzeAA_MVr2yA-1; Tue, 22 Jun 2021 11:39:44 -0400
X-MC-Unique: eahE40MfPVGzeAA_MVr2yA-1
Received: by mail-wm1-f70.google.com with SMTP id f11-20020a05600c154bb02901e0210617aaso823274wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/wFXoBcn9iO6fPUOkqFiUXQLnfuBmGcAVxGMEB2Nh4=;
        b=KzhIGNw5ye3KO+f9ty9SaY6/oA7AdcCYiJ+P+TFTYu2WYb9ZhDGfHtGCLfdfCWGbQD
         3Vw4NSWspjRIzFUQN3NqlNj9lxU4pQRDbdcGMGeF69gTyYtbfZGXd6ZtbJblws7Bu6a2
         OyEHObfRPSFs/Tg7BJ+Xe1I4WC6Di6WTPQMLCpx42Vx95KbZyq699PwLAMKPEs27XIhw
         QJ7CCwovxZVno8hsIhCXCZReNG9bUmhD78fhJZkA3lmdP3+9QWJceNz0woKKiDkECNE+
         4pUNiw4AJxvuCc8u6iXZJpUOXTaisU9pBWleX/lKCPbnN+N0HRYMH8XiQLbdQnSjwVJC
         G6Mg==
X-Gm-Message-State: AOAM5309Z30d4ZHHzeLvKrLM4/G5U3xLIDzZgiDJg7IyjNhHncpVk4Ok
        6FMNRfa0lAfQTnVxDjcErfiTi3bzaTs855TYolfZxniTCzPIHxTO30WoQ1V6NuMoJUc2Ln7vBm2
        1Ad3djgG852m8E0QQMq97jcTo
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr5205917wmh.8.1624376382872;
        Tue, 22 Jun 2021 08:39:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrLI/X468Tt11nt92sTn98VX3c4isJ2DeClv5DufyyIiUCl/I6GMUgL7hHXVw8XQrBFnAf6Q==
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr5205907wmh.8.1624376382690;
        Tue, 22 Jun 2021 08:39:42 -0700 (PDT)
Received: from krava.redhat.com ([5.171.243.0])
        by smtp.gmail.com with ESMTPSA id e3sm11647962wro.26.2021.06.22.08.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:39:42 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 10/10] perf inject: Add --buildid-mmap2 option to fix failed build ids
Date:   Tue, 22 Jun 2021 17:39:18 +0200
Message-Id: <20210622153918.688500-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622153918.688500-1-jolsa@kernel.org>
References: <20210622153918.688500-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --buildid-mmap2 option that tried to fix failed build ids
in mmap2 events.

Record data with --buildid-mmap option:

  # perf record --buildid-mmap ...
  ...
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Failed to parse 4 build ids]
  [ perf record: Captured and wrote 0.008 MB perf.data ]

Check if there's only build id fault reported:

  # perf report --header-only
  ...
  # build id mmap stats: FAULTS 4, LOST 0, NOT FIXED

There is, check the stats:

  # perf report --stat

  Aggregated stats:
           TOTAL events:        104
                    ....
         BUILD_ID fails:          4  (14.3%)

Yep, let's fix it:

  # perf inject --buildid-mmap2 -i perf.data -o perf-fixed.data

And verify:

  # perf report -i perf-fixed.data --stats

  Aggregated stats:
             TOTAL events:        104
                      ....

Good, let's see how many we fixed:

  # perf report --header-only -i perf-fixed.data
  ...
  # build id mmap stats: FAULTS 4, LOST 0, FIXED(4)

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-inject.txt |  3 ++
 tools/perf/builtin-inject.c              | 45 ++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
index 91108fe3ad5f..172d6942ca68 100644
--- a/tools/perf/Documentation/perf-inject.txt
+++ b/tools/perf/Documentation/perf-inject.txt
@@ -30,6 +30,9 @@ OPTIONS
 --buildid-all:
 	Inject build-ids of all DSOs into the output stream
 
+--buildid-mmap2:
+	Resolve failed buildids in MMAP2 events.
+
 -v::
 --verbose::
 	Be more verbose.
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 5d6f583e2cd3..5c6c37c581ca 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -40,6 +40,7 @@ struct perf_inject {
 	struct perf_session	*session;
 	bool			build_ids;
 	bool			build_id_all;
+	bool			build_id_mmap2;
 	bool			sched_stat;
 	bool			have_auxtrace;
 	bool			strip;
@@ -389,13 +390,43 @@ static int perf_event__repipe_buildid_mmap(struct perf_tool *tool,
 	return perf_event__repipe(tool, event, sample, machine);
 }
 
+static bool mmap2_fix_buildid(union perf_event *event, struct build_id *bid)
+{
+	struct perf_record_mmap2 *mmap2 = &event->mmap2;
+
+	/*
+	 * Filter maps that should have build id, but do not carry one.
+	 */
+	if (!is_buildid_memory(mmap2->filename) ||
+	    mmap2->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
+		return false;
+
+	return filename__read_build_id(mmap2->filename, bid) > 0 ? true : false;
+}
+
 static int perf_event__repipe_mmap2(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct perf_sample *sample,
 				   struct machine *machine)
 {
+	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
+	union perf_event *tmp = NULL;
+	struct build_id bid;
 	int err;
 
+	if (inject->build_id_mmap2 && mmap2_fix_buildid(event, &bid)) {
+		tmp = memdup(event, event->header.size);
+		if (!tmp)
+			return -ENOMEM;
+		memcpy(tmp->mmap2.build_id, bid.data, sizeof(bid.data));
+		tmp->header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
+		tmp->mmap2.build_id_size = (u8) bid.size;
+		tmp->mmap2.__reserved_1 = 0;
+		tmp->mmap2.__reserved_2 = 0;
+		event = tmp;
+		inject->session->header.env.build_id_mmap.fixed++;
+	}
+
 	err = perf_event__process_mmap2(tool, event, sample, machine);
 	perf_event__repipe(tool, event, sample, machine);
 
@@ -411,6 +442,7 @@ static int perf_event__repipe_mmap2(struct perf_tool *tool,
 		dso__put(dso);
 	}
 
+	free(tmp);
 	return err;
 }
 
@@ -764,7 +796,8 @@ static int __cmd_inject(struct perf_inject *inject)
 	signal(SIGINT, sig_handler);
 
 	if (inject->build_ids || inject->sched_stat ||
-	    inject->itrace_synth_opts.set || inject->build_id_all) {
+	    inject->itrace_synth_opts.set || inject->build_id_all ||
+	    inject->build_id_mmap2) {
 		inject->tool.mmap	  = perf_event__repipe_mmap;
 		inject->tool.mmap2	  = perf_event__repipe_mmap2;
 		inject->tool.fork	  = perf_event__repipe_fork;
@@ -916,13 +949,15 @@ int cmd_inject(int argc, const char **argv)
 		.mode = PERF_DATA_MODE_READ,
 		.use_stdio = true,
 	};
-	int ret;
+	int ret = -1;
 
 	struct option options[] = {
 		OPT_BOOLEAN('b', "build-ids", &inject.build_ids,
 			    "Inject build-ids into the output stream"),
 		OPT_BOOLEAN(0, "buildid-all", &inject.build_id_all,
 			    "Inject build-ids of all DSOs into the output stream"),
+		OPT_BOOLEAN(0, "buildid-mmap2", &inject.build_id_mmap2,
+			    "Resolve failed buildids in MMAP2 events"),
 		OPT_STRING('i', "input", &inject.input_name, "file",
 			   "input file name"),
 		OPT_STRING('o', "output", &inject.output.path, "file",
@@ -995,6 +1030,12 @@ int cmd_inject(int argc, const char **argv)
 	if (IS_ERR(inject.session))
 		return PTR_ERR(inject.session);
 
+	if (inject.build_id_mmap2 &&
+	    !perf_header__has_feat(&inject.session->header, HEADER_BUILD_ID_MMAP)) {
+		pr_err("The data does not have HEADER_BUILD_ID_MMAP, exiting..\n");
+		goto out_delete;
+	}
+
 	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed.\n");
 
-- 
2.31.1

