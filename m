Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432B036EB04
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbhD2M7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:59:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:50831 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237367AbhD2M7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:59:31 -0400
IronPort-SDR: fEzDFU166rlSUGajcSluThSQ/3f/I4xhV6w5RK/Nz0DD6a+6N22ju7U7tHEx8YO1Co8k1zPSk9
 jQ8IQpzIxUMQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="177107422"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="177107422"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 05:58:40 -0700
IronPort-SDR: sB6zJD0z4EczBB0ceVyWPz07qu78Xl4gxHsYlyMc1wI7uqY25MLq+ADqD3IPA2Km2QXcf99h+r
 djlpdtJKriKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="537361597"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2021 05:58:38 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] perf inject: Add facility to do in place update
Date:   Thu, 29 Apr 2021 15:58:46 +0300
Message-Id: <20210429125854.13905-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429125854.13905-1-adrian.hunter@intel.com>
References: <20210429125854.13905-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is a need to modify only timestamps, it is much simpler and
quicker to do it to the existing file rather than re-write all the
contents.

In preparation for that, add the ability to modify the input file in place.
In practice that just means making the file descriptor and mmaps writable.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-inject.c | 30 ++++++++++++++++++++++++++----
 tools/perf/util/data.c      |  3 ++-
 tools/perf/util/data.h      |  1 +
 tools/perf/util/header.c    |  5 +++++
 tools/perf/util/session.c   |  6 +++++-
 5 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ddccc0eb7390..ddfdeb85c586 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -43,6 +43,8 @@ struct perf_inject {
 	bool			have_auxtrace;
 	bool			strip;
 	bool			jit_mode;
+	bool			in_place_update;
+	bool			in_place_update_dry_run;
 	const char		*input_name;
 	struct perf_data	output;
 	u64			bytes_written;
@@ -701,7 +703,7 @@ static int __cmd_inject(struct perf_inject *inject)
 	int ret = -EINVAL;
 	struct perf_session *session = inject->session;
 	struct perf_data *data_out = &inject->output;
-	int fd = perf_data__fd(data_out);
+	int fd = inject->in_place_update ? -1 : perf_data__fd(data_out);
 	u64 output_data_offset;
 
 	signal(SIGINT, sig_handler);
@@ -759,14 +761,14 @@ static int __cmd_inject(struct perf_inject *inject)
 	if (!inject->itrace_synth_opts.set)
 		auxtrace_index__free(&session->auxtrace_index);
 
-	if (!data_out->is_pipe)
+	if (!data_out->is_pipe && !inject->in_place_update)
 		lseek(fd, output_data_offset, SEEK_SET);
 
 	ret = perf_session__process_events(session);
 	if (ret)
 		return ret;
 
-	if (!data_out->is_pipe) {
+	if (!data_out->is_pipe && !inject->in_place_update) {
 		if (inject->build_ids)
 			perf_header__set_feat(&session->header,
 					      HEADER_BUILD_ID);
@@ -900,7 +902,27 @@ int cmd_inject(int argc, const char **argv)
 		return -1;
 	}
 
-	if (perf_data__open(&inject.output)) {
+	if (inject.in_place_update) {
+		if (!strcmp(inject.input_name, "-")) {
+			pr_err("Input file name required for in-place updating\n");
+			return -1;
+		}
+		if (strcmp(inject.output.path, "-")) {
+			pr_err("Output file name must not be specified for in-place updating\n");
+			return -1;
+		}
+		if (!data.force && !inject.in_place_update_dry_run) {
+			char reply[10];
+
+			printf("The input file will be updated in place. OK? (y/n) ");
+			if (!fgets(reply, sizeof(reply), stdin) || strcmp(reply, "y\n")) {
+				pr_err("Aborted\n");
+				return -1;
+			}
+		}
+		if (!inject.in_place_update_dry_run)
+			data.in_place_update = true;
+	} else if (perf_data__open(&inject.output)) {
 		perror("failed to create output file");
 		return -1;
 	}
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index f29af4fc3d09..209fe63d4e49 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -239,11 +239,12 @@ static bool is_dir(struct perf_data *data)
 
 static int open_file_read(struct perf_data *data)
 {
+	int flags = data->in_place_update ? O_RDWR : O_RDONLY;
 	struct stat st;
 	int fd;
 	char sbuf[STRERR_BUFSIZE];
 
-	fd = open(data->file.path, O_RDONLY);
+	fd = open(data->file.path, flags);
 	if (fd < 0) {
 		int err = errno;
 
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 62a3e66fbee8..c9de82af5584 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -31,6 +31,7 @@ struct perf_data {
 	bool			 is_dir;
 	bool			 force;
 	bool			 use_stdio;
+	bool			 in_place_update;
 	enum perf_data_mode	 mode;
 
 	struct {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index aa1e42518d37..02b13c7a23be 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3814,6 +3814,11 @@ int perf_session__read_header(struct perf_session *session)
 	if (perf_file_header__read(&f_header, header, fd) < 0)
 		return -EINVAL;
 
+	if (header->needs_swap && data->in_place_update) {
+		pr_err("In-place update not supported when byte-swapping is required\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Sanity check that perf.data was written cleanly; data size is
 	 * initialized to 0 and updated only if the on_exit function is run.
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index eba3769be3f1..edd068ea8a6c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2131,6 +2131,7 @@ struct reader {
 	u64		 data_size;
 	u64		 data_offset;
 	reader_cb_t	 process;
+	bool		 in_place_update;
 };
 
 static int
@@ -2164,7 +2165,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
 
-	if (session->header.needs_swap) {
+	if (rd->in_place_update) {
+		mmap_prot  |= PROT_WRITE;
+	} else if (session->header.needs_swap) {
 		mmap_prot  |= PROT_WRITE;
 		mmap_flags = MAP_PRIVATE;
 	}
@@ -2250,6 +2253,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		.data_size	= session->header.data_size,
 		.data_offset	= session->header.data_offset,
 		.process	= process_simple,
+		.in_place_update = session->data->in_place_update,
 	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
-- 
2.17.1

