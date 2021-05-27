Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4341E39356B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 20:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbhE0SaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 14:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhE0SaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 14:30:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68822C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 11:28:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g24so991178pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FiEgVpGNsmHKxwUOtPhkZMDPSunCouCq6EvlrS/uVrs=;
        b=cy1xLVN4KchRPx6opt9BIflOBHMjClNyG2hG8DEZ4YY4x+QGLyq4lap/qL/JZBBcH9
         hbb1Z1HkN+CLfbuT2ObHwhymgB84XQRJnxlkLR549vtMq2guiyjjmxH0w4yq9EhRDsZK
         ft4ycgupk/bVuxh34DFV9IDm/DKkjQzSXtc8i0hFqToRLQOPR8OrekrqChgjUvLG1RBV
         tyXDErbyVknQ1T7RSMgeo+/4J7AORejtAoW9uePn07CkoDOoD+rd5BIttUoTRKGuXG1R
         B2k3eA22REMbza3Sm4gjOjjZX9ZPhFaVoygKXk4xTLOdPlaXZ1PJXWmvbOOUPFFkOMiz
         nRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FiEgVpGNsmHKxwUOtPhkZMDPSunCouCq6EvlrS/uVrs=;
        b=hKl+K2UteXX9R5BXbl+PnJYFOi8OVQFq3y5syO3OI0ZMX2mqMYFMl7jamZ7kL/wF8n
         CIQ0nmGLc+6O2WxpeTGKo+ItcjyBZzIMowu1qHYp7Tj7xaUIwF/VP2gcouVWWIGNvQZF
         aDddVdx4Xbn9Q/IsF5WY69ss4RnwTwNhTdeufL+/b7blZpx4Mt5rFXii1g8LHzc6jNes
         z1WRkF6kvhcmvzA3NhyB/cjwJpIKGpIoyzPgq3gCSzLnia38VfofU0IAzyL/9Jbsromc
         aHSx7LH1YAMFluFtMZCiGnbFiXeorJGulVbBILgL3/bfCXdSXXqzaY2jsZ34gqIpJttB
         /yMA==
X-Gm-Message-State: AOAM530zl1c0yPyG7quYDD/NcURThhgau8l/2kWmWGpgoJMMly03AX86
        /6ta9cHngptGOn90OkIDCT8=
X-Google-Smtp-Source: ABdhPJzEyS1Eb213tYMrL3JjrjC4FIkv2cDIs/sGS0mFuBXxZ1bJF3Ian3/U5MHHqmoiYusAWOYCJA==
X-Received: by 2002:a17:90a:ec05:: with SMTP id l5mr11081124pjy.141.1622140118802;
        Thu, 27 May 2021 11:28:38 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([2607:fb90:46b:f42d:2b99:c4fc:b92:335e])
        by smtp.gmail.com with ESMTPSA id w189sm2378462pfb.46.2021.05.27.11.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 11:28:38 -0700 (PDT)
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
Subject: [PATCH] perf tools: Move probing cgroup sampling support
Date:   Thu, 27 May 2021 11:28:35 -0700
Message-Id: <20210527182835.1634339-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that checking cgroup sampling support using the missing
features doesn't work on old kernels.  Because it added both
attr.cgroup bit and PERF_SAMPLE_CGROUP bit, it needs to check
whichever comes first (usually the actual event, not dummy).

But it only checks the attr.cgroup bit which is set only in the dummy
event so cannot detect failtures due the sample bits.  Also we don't
ignore the missing feature and retry, it'd be better checking it with
the API probing logic.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c      |  6 ++++++
 tools/perf/util/evsel.c          |  6 +-----
 tools/perf/util/evsel.h          |  1 -
 tools/perf/util/perf_api_probe.c | 10 ++++++++++
 tools/perf/util/perf_api_probe.h |  1 +
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bc3dd379eb67..71efe6573ee7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2733,6 +2733,12 @@ int cmd_record(int argc, const char **argv)
 		rec->no_buildid = true;
 	}
 
+	if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
+		pr_err("Kernel has no cgroup sampling support.\n");
+		err = -EINVAL;
+		goto out_opts;
+	}
+
 	if (rec->opts.kcore)
 		rec->data.is_dir = true;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4a3cd1b5bb33..2462584d0ee5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1217,7 +1217,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		attr->namespaces  = track;
 
 	if (opts->record_cgroup) {
-		attr->cgroup = track && !perf_missing_features.cgroup;
+		attr->cgroup = track;
 		evsel__set_sample_bit(evsel, CGROUP);
 	}
 
@@ -1933,10 +1933,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		perf_missing_features.data_page_size = true;
 		pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support, bailing out\n");
 		goto out_close;
-	} else if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
-		perf_missing_features.cgroup = true;
-		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
-		goto out_close;
         } else if (!perf_missing_features.branch_hw_idx &&
 	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)) {
 		perf_missing_features.branch_hw_idx = true;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 75cf5dbfe208..fecf13c0e4da 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -168,7 +168,6 @@ struct perf_missing_features {
 	bool bpf;
 	bool aux_output;
 	bool branch_hw_idx;
-	bool cgroup;
 	bool data_page_size;
 	bool code_page_size;
 	bool weight_struct;
diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 829af17a0867..020411682a3c 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -103,6 +103,11 @@ static void perf_probe_build_id(struct evsel *evsel)
 	evsel->core.attr.build_id = 1;
 }
 
+static void perf_probe_cgroup(struct evsel *evsel)
+{
+	evsel->core.attr.cgroup = 1;
+}
+
 bool perf_can_sample_identifier(void)
 {
 	return perf_probe_api(perf_probe_sample_identifier);
@@ -182,3 +187,8 @@ bool perf_can_record_build_id(void)
 {
 	return perf_probe_api(perf_probe_build_id);
 }
+
+bool perf_can_record_cgroup(void)
+{
+	return perf_probe_api(perf_probe_cgroup);
+}
diff --git a/tools/perf/util/perf_api_probe.h b/tools/perf/util/perf_api_probe.h
index f12ca55f509a..b104168efb15 100644
--- a/tools/perf/util/perf_api_probe.h
+++ b/tools/perf/util/perf_api_probe.h
@@ -12,5 +12,6 @@ bool perf_can_record_switch_events(void);
 bool perf_can_record_text_poke_events(void);
 bool perf_can_sample_identifier(void);
 bool perf_can_record_build_id(void);
+bool perf_can_record_cgroup(void);
 
 #endif // __PERF_API_PROBE_H
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

