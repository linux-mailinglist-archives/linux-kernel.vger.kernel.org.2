Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2F234794C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhCXNP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233465AbhCXNPK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:15:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6445619B3;
        Wed, 24 Mar 2021 13:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616591709;
        bh=3JIpP2HYw5IxRD8oBaMuJQoHKlJG7St9R2h4CM87cos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTzT7pNAWHk20bOJQEG00mQbY2vMrzMKQXd1VtZ5KGcX50DuhvXoxyzjcYrQfTXvy
         XIpOc5kYGbGAGHlTBFp/jLp3o4mNXc4RRCXA167zUJEU0BP6Tj+1RHK3haCFmiawZx
         FHJ9/zAN8x2/4HEHjVNjiFTbnoNNVaEAL0RLwxiTQLEBmSYOjb51iHuABIm6Xb4bWX
         8dVxpMMIlsGUuq5QlyLU2dhlJn4CkJuryhUMs8h54vUtnAWIpT1zUTl9SSqnjJDStm
         r75HaRR9vaBoIhOoaK29WKsDjXJHlFo8u+Ml1XKyVThGUBrDcmRLt3eZV0lLNE7taA
         9MfoFvu+VeTdw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9918640647; Wed, 24 Mar 2021 10:15:07 -0300 (-03)
Date:   Wed, 24 Mar 2021 10:15:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 2/2] perf test: Add CVS summary test
Message-ID: <YFs7W7CHNO7haeb0@kernel.org>
References: <20210319070156.20394-1-yao.jin@linux.intel.com>
 <20210319070156.20394-2-yao.jin@linux.intel.com>
 <YFs5DvUwtwblghqc@kernel.org>
 <YFs6y8EW4yWpqBh+@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFs6y8EW4yWpqBh+@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 24, 2021 at 10:12:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 24, 2021 at 10:05:18AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Mar 19, 2021 at 03:01:56PM +0800, Jin Yao escreveu:
> > > The patch "perf stat: Align CSV output for summary mode" aligned
> > > CVS output and added "summary" to the first column of summary
> > > lines.
> > > 
> > > Now we check if the "summary" string is added to the CVS output.
> > > 
> > > If we set '--no-cvs-summary' option, the "summary" string would
> > > not be added, also check with this case.
> > 
> > You mixed up cvs with csv in various places, I'm fixing it up...
> 
> This, for the first patch, now fixing the second.

nah, there were some missing fixes:


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
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 2e7fec0bd8f3f3bb..d3137bc1706548d4 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -440,7 +440,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			os.nfields++;
 	}
 
-	if (!config->no_cvs_summary && config->csv_output &&
+	if (!config->no_csv_summary && config->csv_output &&
 	    config->summary && !config->interval) {
 		fprintf(config->output, "%16s%s", "summary", config->csv_sep);
 	}
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index def0cdc841330210..48e6a06233faef8e 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -128,7 +128,7 @@ struct perf_stat_config {
 	bool			 all_user;
 	bool			 percore_show_thread;
 	bool			 summary;
-	bool			 no_cvs_summary;
+	bool			 no_csv_summary;
 	bool			 metric_no_group;
 	bool			 metric_no_merge;
 	bool			 stop_read_counter;
@@ -161,7 +161,7 @@ struct perf_stat_config {
 };
 
 void perf_stat__set_big_num(int set);
-void perf_stat__set_no_cvs_summary(int set);
+void perf_stat__set_no_csv_summary(int set);
 
 void update_stats(struct stats *stats, u64 val);
 double avg_stats(struct stats *stats);
