Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C855F309906
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhA3Xyb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:54:31 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:23645 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232604AbhA3XvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:51:04 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-NjAPl49RP-ip_ZtI6v1AVg-1; Sat, 30 Jan 2021 18:50:11 -0500
X-MC-Unique: NjAPl49RP-ip_ZtI6v1AVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BF77801817;
        Sat, 30 Jan 2021 23:50:09 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2096F60DA0;
        Sat, 30 Jan 2021 23:50:06 +0000 (UTC)
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
Subject: [PATCH 22/24] perf tests: Add daemon signal command test
Date:   Sun, 31 Jan 2021 00:48:54 +0100
Message-Id: <20210130234856.271282-23-jolsa@kernel.org>
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

Adding test for perf daemon signal command. The test
sends a signal to configured sessions and verifies
the perf data files were generated accordingly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/shell/daemon.sh | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
index 3b6b5aa5587c..2e414f2c9251 100755
--- a/tools/perf/tests/shell/daemon.sh
+++ b/tools/perf/tests/shell/daemon.sh
@@ -348,10 +348,50 @@ EOF
 	rm -f ${config}
 }
 
+test_signal()
+{
+	echo "test daemon signal"
+
+	local config=$(mktemp /tmp/perf.daemon.config.XXX)
+	local base=$(mktemp -d /tmp/perf.daemon.base.XXX)
+
+	# prepare config
+	cat <<EOF > ${config}
+[daemon]
+base=BASE
+
+[session-test]
+run = -e cpu-clock --switch-output
+EOF
+
+	sed -i -e "s|BASE|${base}|" ${config}
+
+	# start daemon
+	daemon_start ${config} test
+
+	# send 2 signals
+	perf daemon signal --config ${config} --session test
+	perf daemon signal --config ${config}
+
+	# stop daemon
+	daemon_exit ${base} ${config}
+
+	# count is 2 perf.data for signals and 1 for perf record finished
+	count=`ls ${base}/session-test/ | grep perf.data | wc -l`
+	if [ ${count} -ne 3 ]; then
+		error=1
+		echo "FAILED: perf data no generated"
+	fi
+
+	rm -rf ${base}
+	rm -f ${config}
+}
+
 error=0
 
 test_list
 test_reconfig
 test_stop
+test_signal
 
 exit ${error}
-- 
2.29.2

