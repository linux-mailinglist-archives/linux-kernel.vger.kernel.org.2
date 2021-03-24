Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF9934794A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhCXNNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233465AbhCXNMr (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:12:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40C7961A0C;
        Wed, 24 Mar 2021 13:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616591566;
        bh=OKs1mD2qebIMJb13DJKJIHreCaRQdOzExwSlbZBjb1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XN1hk9SsmnUD4Hp0fO8t9nyqpHmjXujFW7nS+NaHWuRMWPv+ij9FaKf1ISYxQuiuU
         aRJppYBOkbafZKjw2qDn7cXpnSZd5saAhX1tDP+6Au/7kILtre/XxEB1ZwWJyO0HJq
         bamq0UNVS0FcT4yHek7cnRDZM4QeOjCFt8Ysv+7g5niOw/Z2gmcSPo0byZHr6/NKEf
         9VlYZszUMZoL3HcyYqCmBPWs6gDZDdQh8eArwMFSzMOtUFUTWGWF16+G9iJ1BYrRPu
         kXXNtVlbrqJegbXxt/7eaWzsRd/lbIeZNQdOEu7QAVql+XIu1VRw5a3T9nW7Oatcy1
         6S4Ifinxqe41w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D954D40647; Wed, 24 Mar 2021 10:12:43 -0300 (-03)
Date:   Wed, 24 Mar 2021 10:12:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 2/2] perf test: Add CVS summary test
Message-ID: <YFs6y8EW4yWpqBh+@kernel.org>
References: <20210319070156.20394-1-yao.jin@linux.intel.com>
 <20210319070156.20394-2-yao.jin@linux.intel.com>
 <YFs5DvUwtwblghqc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFs5DvUwtwblghqc@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 24, 2021 at 10:05:18AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Mar 19, 2021 at 03:01:56PM +0800, Jin Yao escreveu:
> > The patch "perf stat: Align CSV output for summary mode" aligned
> > CVS output and added "summary" to the first column of summary
> > lines.
> > 
> > Now we check if the "summary" string is added to the CVS output.
> > 
> > If we set '--no-cvs-summary' option, the "summary" string would
> > not be added, also check with this case.
> 
> You mixed up cvs with csv in various places, I'm fixing it up...

This, for the first patch, now fixing the second.


diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index e81a45cadd4a0bdb..6ec5960b08c3de21 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -482,14 +482,14 @@ convenient for post processing.
 --summary::
 Print summary for interval mode (-I).
 
---no-cvs-summary::
+--no-csv-summary::
 Don't print 'summary' at the first column for CVS summary output.
 This option must be used with -x and --summary.
 
 This option can be enabled in perf config by setting the variable
-'stat.no-cvs-summary'.
+'stat.no-csv-summary'.
 
-$ perf config stat.no-cvs-summary=true
+$ perf config stat.no-csv-summary=true
 
 EXAMPLES
 --------
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6daa090129a65c78..2a2c15cac80a3bee 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1093,9 +1093,9 @@ void perf_stat__set_big_num(int set)
 	stat_config.big_num = (set != 0);
 }
 
-void perf_stat__set_no_cvs_summary(int set)
+void perf_stat__set_no_csv_summary(int set)
 {
-	stat_config.no_cvs_summary = (set != 0);
+	stat_config.no_csv_summary = (set != 0);
 }
 
 static int stat__set_big_num(const struct option *opt __maybe_unused,
@@ -1254,8 +1254,8 @@ static struct option stat_options[] = {
 		    "threads of same physical core"),
 	OPT_BOOLEAN(0, "summary", &stat_config.summary,
 		       "print summary for interval mode"),
-	OPT_BOOLEAN(0, "no-cvs-summary", &stat_config.no_cvs_summary,
-		       "don't print 'summary' for CVS summary output"),
+	OPT_BOOLEAN(0, "no-csv-summary", &stat_config.no_csv_summary,
+		       "don't print 'summary' for CSV summary output"),
 	OPT_BOOLEAN(0, "quiet", &stat_config.quiet,
 			"don't print output (useful with record)"),
 #ifdef HAVE_LIBPFM
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index df78f11f6fb50a0b..6bcb5ef221f8c1be 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -457,8 +457,8 @@ static int perf_stat_config(const char *var, const char *value)
 	if (!strcmp(var, "stat.big-num"))
 		perf_stat__set_big_num(perf_config_bool(var, value));
 
-	if (!strcmp(var, "stat.no-cvs-summary"))
-		perf_stat__set_no_cvs_summary(perf_config_bool(var, value));
+	if (!strcmp(var, "stat.no-csv-summary"))
+		perf_stat__set_no_csv_summary(perf_config_bool(var, value));
 
 	/* Add other config variables here. */
 	return 0;
