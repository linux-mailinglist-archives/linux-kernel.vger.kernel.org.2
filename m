Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552943B094F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhFVPmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232286AbhFVPl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624376381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/k6JHWhmjZJbOSP+z4S9aloGNHBLWUVWp/g3fFFYBc=;
        b=YXHp0G4HyblKZAcg+HAbaFhOPJG58pju+2lwpzVGSwE1UPA9qpoRbJsFkNHXMm3GNsidff
        upR4T6NH+bIab7NMj9bR8ff9/hrP2B7skb7AMnyHojBqQJ5PgJvdMHTVAhkVMVl7AoQoXm
        wg2DXtVYStVCz8O8jsmCE8gyXFOidng=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-xc5jVErgOgm3eHtKJ36eUw-1; Tue, 22 Jun 2021 11:39:40 -0400
X-MC-Unique: xc5jVErgOgm3eHtKJ36eUw-1
Received: by mail-wr1-f72.google.com with SMTP id b3-20020a05600018a3b029011a84f85e1cso5764535wri.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/k6JHWhmjZJbOSP+z4S9aloGNHBLWUVWp/g3fFFYBc=;
        b=mTm4wT1ArJTiQy9ymB/6UG6wfnLkdfFBPZO5pOU1UikrtucRLZfK+AfVoW3AAreyvf
         KQBvi5a38/mgHLTi3QhByhygBzljg91Yx1jU+skJauaz/9edf2ENBZX80U61y7HccRn1
         /F3FlQm+fX4hFPhuGrvWiKNmFjdYF5y1E2I2AX/oCY0eo8cHoxrWcRY+Q1SPH00FNjiD
         ytBSqY6vpjqAXi34xDNDVe4Vph9gU78bMwkWUD3NjcqsBUPt4nhwPVzTUl9tGsanfZDs
         R/jX0pU/9mCzxOT0ejg8lv09KELRxB12rgiL3KnM0JQDz4WqqB/j1OPyqi80m2vD9W4e
         crvQ==
X-Gm-Message-State: AOAM5333ZLcXmlMueLGv2h7+/sLFsHLWjDiSClUddJ7NZrRBHp/ohb7B
        ItkPXAhZQ1lbVGd0W37UnSZ0I4kQXzg1leNCCtXBybrZKeviId5bp7btzPGbPd3qk2NARrekBpC
        e6KjtdUvSwIqkJEDV229FWCIg
X-Received: by 2002:a5d:4b44:: with SMTP id w4mr5538094wrs.78.1624376378535;
        Tue, 22 Jun 2021 08:39:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaDvUNqT5rG/gZkA8EFu/u0KNKRQjlSyQmWxBrLGpcryWH3mMpMvC/WYWPbq/RV/DNHPoKcg==
X-Received: by 2002:a5d:4b44:: with SMTP id w4mr5538076wrs.78.1624376378394;
        Tue, 22 Jun 2021 08:39:38 -0700 (PDT)
Received: from krava.redhat.com ([5.171.243.0])
        by smtp.gmail.com with ESMTPSA id e3sm11647962wro.26.2021.06.22.08.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:39:38 -0700 (PDT)
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
Subject: [PATCH 08/10] perf record: Add new HEADER_BUILD_ID_MMAP feature
Date:   Tue, 22 Jun 2021 17:39:16 +0200
Message-Id: <20210622153918.688500-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622153918.688500-1-jolsa@kernel.org>
References: <20210622153918.688500-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new HEADER_BUILD_ID_MMAP feature to store faulst/lost/fixed
counts for --buildid-mmap setup. We skip post processing for build_id,
so we need to store session stats.

The feature data has following format:

	struct {
	       u32 version;
	       u64 faults;
	       u64 lost;
	       u64 fixed;
	};

The version is set to 1.
The faults has the value of faulted build id retrievals for the session.
The lost has the value of faulted lost events for the session.
The fixed has the value of fixed build ids by post-processing.

The perf report --header-only display for when fixes is 0:

  # build id mmap stats: FAULTS 4, LOST 0, NOT FIXED

If fixed is defined:

  # build id mmap stats: FAULTS 4, LOST 0, FIXED(4)

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../Documentation/perf.data-file-format.txt   | 19 +++++
 tools/perf/builtin-record.c                   |  7 ++
 tools/perf/util/env.h                         |  6 ++
 tools/perf/util/header.c                      | 80 +++++++++++++++++++
 tools/perf/util/header.h                      |  1 +
 5 files changed, 113 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index e6ff8c898ada..223fea2ba662 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -438,6 +438,25 @@ struct {
 	other bits are reserved and should ignored for now
 	HEADER_FEAT_BITS	= 256,
 
+	HEADER_BUILD_ID_MMAP = 32,
+
+	It contains stats values for session with --buildid-mmap option.
+
+struct {
+	u32 version;
+	u64 faults;
+	u64 lost;
+	u64 fixed;
+};
+
+	The version is set to 1.
+	The faults has the value of faulted build id retrievals for the session.
+	The lost has the value of faulted lost events for the session.
+	The fixed has the value of fixed build ids by post-processing.
+
+	other bits are reserved and should ignored for now
+	HEADER_FEAT_BITS	= 256,
+
 Attributes
 
 This is an array of perf_event_attrs, each attr_size bytes long, which defines
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bf3958ce18e3..cae1a38a9e2a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1221,6 +1221,9 @@ static void record__init_features(struct record *rec)
 	if (!rec->opts.use_clockid)
 		perf_header__clear_feat(&session->header, HEADER_CLOCK_DATA);
 
+	if (!rec->buildid_mmap)
+		perf_header__clear_feat(&session->header, HEADER_BUILD_ID_MMAP);
+
 	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
 	if (!record__comp_enabled(rec))
 		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
@@ -1296,6 +1299,7 @@ evlist__read_session_stats(struct evlist *evlist, struct session_stats *st)
 
 static void read_session_stats(struct record *rec)
 {
+	struct perf_session *session = rec->session;
 	struct session_stats st;
 
 	if (evlist__read_session_stats(rec->evlist, &st))
@@ -1310,6 +1314,9 @@ static void read_session_stats(struct record *rec)
 		fprintf(stderr,	"[ perf record: Lost %lu chunks]\n",
 			st.lost);
 	}
+
+	session->header.env.build_id_mmap.faults = st.build_id_faults;
+	session->header.env.build_id_mmap.lost = st.lost;
 }
 
 static void
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 6824a7423a2d..8d45c774ad75 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -128,6 +128,12 @@ struct perf_env {
 		 */
 		bool	enabled;
 	} clock;
+
+	struct {
+		u64	faults;
+		u64	lost;
+		u64	fixed;
+	} build_id_mmap;
 };
 
 enum perf_compress_type {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 0158d2945bab..ac4f62170107 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1528,6 +1528,39 @@ static int write_hybrid_cpu_pmu_caps(struct feat_fd *ff,
 	return 0;
 }
 
+static int write_build_id_mmap(struct feat_fd *ff,
+			       struct evlist *evlist __maybe_unused)
+{
+	u64 data64;
+	u32 data32;
+	int ret;
+
+	/* version */
+	data32 = 1;
+
+	ret = do_write(ff, &data32, sizeof(data32));
+	if (ret < 0)
+		return ret;
+
+	/* faults */
+	data64 = ff->ph->env.build_id_mmap.faults;
+
+	ret = do_write(ff, &data64, sizeof(data64));
+	if (ret < 0)
+		return ret;
+
+	/* lost */
+	data64 = ff->ph->env.build_id_mmap.lost;
+
+	ret = do_write(ff, &data64, sizeof(data64));
+	if (ret < 0)
+		return ret;
+
+	/* fixed */
+	data64 = ff->ph->env.build_id_mmap.fixed;
+	return do_write(ff, &data64, sizeof(data64));
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -2048,6 +2081,19 @@ static void print_hybrid_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
 	}
 }
 
+static void print_build_id_mmap(struct feat_fd *ff, FILE *fp)
+{
+	fprintf(fp, "# build id mmap stats: FAULTS %" PRIu64 ", LOST %" PRIu64 ",%s FIXED",
+		ff->ph->env.build_id_mmap.faults,
+		ff->ph->env.build_id_mmap.lost,
+		ff->ph->env.build_id_mmap.fixed ? "" : " NOT");
+
+	if (ff->ph->env.build_id_mmap.fixed)
+		fprintf(fp, "(%" PRIu64 ")", ff->ph->env.build_id_mmap.fixed);
+
+	fprintf(fp, "\n");
+}
+
 static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
 {
 	const char *delimiter = "# pmu mappings: ";
@@ -3265,6 +3311,39 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
 	return ret;
 }
 
+static int process_build_id_mmap(struct feat_fd *ff,
+				 void *data __maybe_unused)
+{
+	u32 data32;
+	u64 data64;
+
+	/* version */
+	if (do_read_u32(ff, &data32))
+		return -1;
+
+	if (data32 != 1)
+		return -1;
+
+	/* faults */
+	if (do_read_u64(ff, &data64))
+		return -1;
+
+	ff->ph->env.build_id_mmap.faults = data64;
+
+	/* lost */
+	if (do_read_u64(ff, &data64))
+		return -1;
+
+	ff->ph->env.build_id_mmap.lost = data64;
+
+	/* fixed */
+	if (do_read_u64(ff, &data64))
+		return -1;
+
+	ff->ph->env.build_id_mmap.fixed = data64;
+	return 0;
+}
+
 #define FEAT_OPR(n, func, __full_only) \
 	[HEADER_##n] = {					\
 		.name	    = __stringify(n),			\
@@ -3328,6 +3407,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
 	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
 	FEAT_OPR(HYBRID_CPU_PMU_CAPS,	hybrid_cpu_pmu_caps,	false),
+	FEAT_OPR(BUILD_ID_MMAP,		build_id_mmap,		false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index ae6b1cf19a7d..a9fe37bb03cc 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -47,6 +47,7 @@ enum {
 	HEADER_CLOCK_DATA,
 	HEADER_HYBRID_TOPOLOGY,
 	HEADER_HYBRID_CPU_PMU_CAPS,
+	HEADER_BUILD_ID_MMAP,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.31.1

