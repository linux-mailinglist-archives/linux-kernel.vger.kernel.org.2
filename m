Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3817309908
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhA3XzB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:55:01 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:60666 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232547AbhA3XvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:51:03 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-_gdllPZ7MoKqnCSWntYZnQ-1; Sat, 30 Jan 2021 18:50:08 -0500
X-MC-Unique: _gdllPZ7MoKqnCSWntYZnQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFD39107ACE3;
        Sat, 30 Jan 2021 23:50:06 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A0226F974;
        Sat, 30 Jan 2021 23:50:02 +0000 (UTC)
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
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH 21/24] perf tests: Add daemon stop command test
Date:   Sun, 31 Jan 2021 00:48:53 +0100
Message-Id: <20210130234856.271282-22-jolsa@kernel.org>
In-Reply-To: <20210130234856.271282-1-jolsa@kernel.org>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding test for perf daemon stop command. The test
stops the daemon and verifies all the configured
sessions are properly terminated.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/shell/daemon.sh | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
index 90a6e8caddfb..3b6b5aa5587c 100755
--- a/tools/perf/tests/shell/daemon.sh
+++ b/tools/perf/tests/shell/daemon.sh
@@ -295,9 +295,63 @@ EOF
 	rm -f ${config_new}
 	rm -f ${config_empty}
 }
+
+test_stop()
+{
+	echo "test daemon stop"
+
+	local config=$(mktemp /tmp/perf.daemon.config.XXX)
+	local base=$(mktemp -d /tmp/perf.daemon.base.XXX)
+
+	# prepare config
+	cat <<EOF > ${config}
+[daemon]
+base=BASE
+
+[session-size]
+run = -e cpu-clock
+
+[session-time]
+run = -e task-clock
+EOF
+
+	sed -i -e "s|BASE|${base}|" ${config}
+
+	# start daemon
+	daemon_start ${config} size
+
+	local pid_size=`perf daemon --config ${config} -x: | head -2 | tail -1 | awk 'BEGIN { FS = ":" } ; { print $1 }'`
+	local pid_time=`perf daemon --config ${config} -x: | head -3 | tail -1 | awk 'BEGIN { FS = ":" } ; { print $1 }'`
+
+	# check that sessions are running
+	if [ ! -d "/proc/${pid_size}" ]; then
+		echo "FAILED: session size not up"
+	fi
+
+	if [ ! -d "/proc/${pid_time}" ]; then
+		echo "FAILED: session time not up"
+	fi
+
+	# stop daemon
+	daemon_exit ${base} ${config}
+
+	# check that sessions are gone
+	if [ -d "/proc/${pid_size}" ]; then
+		echo "FAILED: session size still up"
+	fi
+
+	if [ -d "/proc/${pid_time}" ]; then
+		echo "FAILED: session time still up"
+	fi
+
+	rm -rf ${base}
+	rm -f ${config}
+}
+
 error=0
 
 test_list
 test_reconfig
+test_stop
 
 exit ${error}
-- 
2.29.2

