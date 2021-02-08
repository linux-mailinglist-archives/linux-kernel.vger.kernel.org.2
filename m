Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E497314184
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbhBHVRp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 16:17:45 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:35793 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236681AbhBHUKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:10:53 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-wJzQmCEGO1C1bkjiSzH2Sg-1; Mon, 08 Feb 2021 15:09:56 -0500
X-MC-Unique: wJzQmCEGO1C1bkjiSzH2Sg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24E5E1005501;
        Mon,  8 Feb 2021 20:09:54 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD05C19C59;
        Mon,  8 Feb 2021 20:09:51 +0000 (UTC)
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
Subject: [PATCH 16/24] perf daemon: Use control to stop session
Date:   Mon,  8 Feb 2021 21:09:00 +0100
Message-Id: <20210208200908.1019149-17-jolsa@kernel.org>
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

Using 'stop' control command to stop perf record session.
If that fails, falling back to current SIGTERM/SIGKILL pair.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 56 ++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 17ab8f9021ca..11f9fac4cf12 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -871,11 +871,25 @@ static int setup_client_socket(struct daemon *daemon)
 static void daemon_session__kill(struct daemon_session *session,
 				 struct daemon *daemon)
 {
-	daemon_session__signal(session, SIGTERM);
-	if (daemon_session__wait(session, daemon, 10)) {
-		daemon_session__signal(session, SIGKILL);
-		daemon_session__wait(session, daemon, 10);
-	}
+	int how = 0;
+
+	do {
+		switch (how) {
+		case 0:
+			daemon_session__control(session, "stop", false);
+			break;
+		case 1:
+			daemon_session__signal(session, SIGTERM);
+			break;
+		case 2:
+			daemon_session__signal(session, SIGKILL);
+			break;
+		default:
+			break;
+		}
+		how++;
+
+	} while (daemon_session__wait(session, daemon, 10));
 }
 
 static void daemon__signal(struct daemon *daemon, int sig)
@@ -900,13 +914,35 @@ static void daemon_session__remove(struct daemon_session *session)
 	daemon_session__delete(session);
 }
 
+static void daemon__stop(struct daemon *daemon)
+{
+	struct daemon_session *session;
+
+	list_for_each_entry(session, &daemon->sessions, list)
+		daemon_session__control(session, "stop", false);
+}
+
 static void daemon__kill(struct daemon *daemon)
 {
-	daemon__signal(daemon, SIGTERM);
-	if (daemon__wait(daemon, 10)) {
-		daemon__signal(daemon, SIGKILL);
-		daemon__wait(daemon, 10);
-	}
+	int how = 0;
+
+	do {
+		switch (how) {
+		case 0:
+			daemon__stop(daemon);
+			break;
+		case 1:
+			daemon__signal(daemon, SIGTERM);
+			break;
+		case 2:
+			daemon__signal(daemon, SIGKILL);
+			break;
+		default:
+			break;
+		}
+		how++;
+
+	} while (daemon__wait(daemon, 10));
 }
 
 static void daemon__exit(struct daemon *daemon)
-- 
2.29.2

