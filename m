Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E798D314186
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhBHVR4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 16:17:56 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:42245 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234033AbhBHUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:10:57 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-3f2eNTMtOriJU0u0r5FPPw-1; Mon, 08 Feb 2021 15:10:01 -0500
X-MC-Unique: 3f2eNTMtOriJU0u0r5FPPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78B5E192D786;
        Mon,  8 Feb 2021 20:09:59 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D22619C59;
        Mon,  8 Feb 2021 20:09:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH 18/24] perf daemon: Add examples to man page
Date:   Mon,  8 Feb 2021 21:09:02 +0100
Message-Id: <20210208200908.1019149-19-jolsa@kernel.org>
In-Reply-To: <20210208200908.1019149-1-jolsa@kernel.org>
References: <20210208200908.1019149-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding usage examples to the man page.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-daemon.txt | 98 ++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
index 90b20bea6356..f558f8e4bc9b 100644
--- a/tools/perf/Documentation/perf-daemon.txt
+++ b/tools/perf/Documentation/perf-daemon.txt
@@ -41,6 +41,10 @@ for time and size.
 Each session is started with control setup (with perf record --control
 options).
 
+Sessions are configured through config file, see CONFIG FILE section
+with EXAMPLES.
+
+
 OPTIONS
 -------
 -v::
@@ -105,6 +109,100 @@ session-<NAME>.run:
 Each perf record session is run in daemon.base/<NAME> directory.
 
 
+EXAMPLES
+--------
+Example with 2 record sessions:
+
+  # cat ~/.perfconfig
+  [daemon]
+  base=/opt/perfdata
+
+  [session-cycles]
+  run = -m 10M -e cycles --overwrite --switch-output -a
+
+  [session-sched]
+  run = -m 20M -e sched:* --overwrite --switch-output -a
+
+
+Starting the daemon:
+
+  # perf daemon start
+
+
+Check sessions:
+
+  # perf daemon
+  [603349:daemon] base: /opt/perfdata
+  [603350:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
+  [603351:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
+
+First line is daemon process info with configured daemon base.
+
+
+Check sessions with more info:
+
+  # perf daemon -v
+  [603349:daemon] base: /opt/perfdata
+    output:  /opt/perfdata/output
+    lock:    /opt/perfdata/lock
+    up:      1 minutes
+  [603350:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
+    base:    /opt/perfdata/session-cycles
+    output:  /opt/perfdata/session-cycles/output
+    control: /opt/perfdata/session-cycles/control
+    ack:     /opt/perfdata/session-cycles/ack
+    up:      1 minutes
+  [603351:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
+    base:    /opt/perfdata/session-sched
+    output:  /opt/perfdata/session-sched/output
+    control: /opt/perfdata/session-sched/control
+    ack:     /opt/perfdata/session-sched/ack
+    up:      1 minutes
+
+The 'base' path is daemon/session base.
+The 'lock' file is daemon's lock file guarding that no other
+daemon is running on top of the base.
+The 'output' file is perf record output for specific session.
+The 'control' and 'ack' files are perf control files.
+The 'up' number shows minutes daemon/session is running.
+
+
+Make sure control session is online:
+
+  # perf daemon ping
+  OK   cycles
+  OK   sched
+
+
+Send USR2 signal to session 'cycles' to generate perf.data file:
+
+  # perf daemon signal --session cycles
+  signal 12 sent to session 'cycles [603452]'
+
+  # tail -2  /opt/perfdata/session-cycles/output
+  [ perf record: dump data: Woken up 1 times ]
+  [ perf record: Dump perf.data.2020123017013149 ]
+
+
+Send USR2 signal to all sessions:
+
+  # perf daemon signal
+  signal 12 sent to session 'cycles [603452]'
+  signal 12 sent to session 'sched [603453]'
+
+  # tail -2  /opt/perfdata/session-cycles/output
+  [ perf record: dump data: Woken up 1 times ]
+  [ perf record: Dump perf.data.2020123017024689 ]
+  # tail -2  /opt/perfdata/session-sched/output
+  [ perf record: dump data: Woken up 1 times ]
+  [ perf record: Dump perf.data.2020123017024713 ]
+
+
+Stop daemon:
+
+  # perf daemon stop
+
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-config[1]
-- 
2.29.2

