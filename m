Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3A3098FF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhA3XxL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:53:11 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:54342 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232585AbhA3Xur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:47 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-9luKGOLhPxiIQote7aqnqg-1; Sat, 30 Jan 2021 18:49:52 -0500
X-MC-Unique: 9luKGOLhPxiIQote7aqnqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C044E801817;
        Sat, 30 Jan 2021 23:49:50 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 196E860DA0;
        Sat, 30 Jan 2021 23:49:44 +0000 (UTC)
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
Subject: [PATCH 16/24] perf daemon: Use control to stop session
Date:   Sun, 31 Jan 2021 00:48:48 +0100
Message-Id: <20210130234856.271282-17-jolsa@kernel.org>
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

Using 'stop' control command to stop perf record session.
If that fails, falling back to current SIGTERM/SIGKILL pair.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 56 ++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index a5a71e0a706c..92dba933027d 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -821,11 +821,25 @@ static int setup_client_socket(struct daemon *daemon)
 
 static void session__kill(struct session *session, struct daemon *daemon)
 {
-	session__signal(session, SIGTERM);
-	if (session__wait(session, daemon, 10)) {
-		session__signal(session, SIGKILL);
-		session__wait(session, daemon, 10);
-	}
+	int how = 0;
+
+	do {
+		switch (how) {
+		case 0:
+			session__control(session, "stop", false);
+			break;
+		case 1:
+			session__signal(session, SIGTERM);
+			break;
+		case 2:
+			session__signal(session, SIGKILL);
+			break;
+		default:
+			break;
+		}
+		how++;
+
+	} while (session__wait(session, daemon, 10));
 }
 
 static void daemon__signal(struct daemon *daemon, int sig)
@@ -850,13 +864,35 @@ static void session__remove(struct session *session)
 	session__free(session);
 }
 
+static void daemon__stop(struct daemon *daemon)
+{
+	struct session *session;
+
+	list_for_each_entry(session, &daemon->sessions, list)
+		session__control(session, "stop", false);
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
 
 static void __daemon__free(struct daemon *daemon)
-- 
2.29.2

