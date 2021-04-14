Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C6435F4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351210AbhDNNRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233167AbhDNNRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:17:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30EE761220;
        Wed, 14 Apr 2021 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618406200;
        bh=odidKAiA512P4ANs2PRs0Au5dvY1BlcBlOgh91/Z5kA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlha5C74RXhORwcG/LRPdopOsKZCe/10/H1Fb/pbnVUQEnKwZguIcTJyB/mSyLeus
         fKLOi1rVsJ7ETpEltx7Jo7D40fg1+Q/MDMXHzuecxDGfEah5hrQOiT0je1THFA3QQt
         LpGL9/mt6c8VqMaQexfOfHBCGcOOKdGKBPh5vrKegQ6uXNWGO5SjMmn47qz8tdFUfQ
         Y5G+u4fEnepOFCYmYaE2NSeJrXspwN/mQdALd1FH+XOL+OB296ycbxXFtMKC93Ob5j
         vIWom9JOsFB94Ku423Wj4r4C0lezUd5tOBpysesHnIhrPnEx3NPfhn3olG4/ZxgFNp
         dNVMLirboo86A==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/2] perf evlist: Add a method to return the list of evsels as a string
Date:   Wed, 14 Apr 2021 10:16:27 -0300
Message-Id: <20210414131628.2064862-2-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210414131628.2064862-1-acme@kernel.org>
References: <20210414131628.2064862-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add a 'scnprintf' method to obtain the list of evsels in a evlist as a
string, excluding the "dummy" event used for things like receiving
metadata events (PERF_RECORD_FORK, MMAP, etc) when synthesizing
preexisting threads.

Will be used to improve the error message for workload failure in 'perf
record.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 19 +++++++++++++++++++
 tools/perf/util/evlist.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f1c79ecf81073f74..d29a8a118973c71c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2138,3 +2138,22 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 	}
 	return NULL;
 }
+
+int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf)
+{
+	struct evsel *evsel;
+	int printed = 0;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_dummy_event(evsel))
+			continue;
+		if (size > (strlen(evsel__name(evsel)) + (printed ? 2 : 1))) {
+			printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "," : "", evsel__name(evsel));
+		} else {
+			printed += scnprintf(bf + printed, size - printed, "%s...", printed ? "," : "");
+			break;
+		}
+	}
+
+	return printed;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index b695ffaae519a5d0..a8b97b50cceb7e43 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -365,4 +365,6 @@ int evlist__ctlfd_ack(struct evlist *evlist);
 #define EVLIST_DISABLED_MSG "Events disabled\n"
 
 struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
+
+int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
 #endif /* __PERF_EVLIST_H */
-- 
2.26.2

