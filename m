Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A49E342FCA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCTWKu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 20 Mar 2021 18:10:50 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:42832 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229865AbhCTWK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:10:28 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-BETszJS_NFShJTUn66-nmg-1; Sat, 20 Mar 2021 18:10:21 -0400
X-MC-Unique: BETszJS_NFShJTUn66-nmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDC5557081;
        Sat, 20 Mar 2021 22:10:19 +0000 (UTC)
Received: from krava.cust.in.nbox.cz (unknown [10.40.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A35E65DAA5;
        Sat, 20 Mar 2021 22:10:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/2] perf daemon: Return from kill functions
Date:   Sat, 20 Mar 2021 23:10:13 +0100
Message-Id: <20210320221013.1619613-2-jolsa@kernel.org>
In-Reply-To: <20210320221013.1619613-1-jolsa@kernel.org>
References: <20210320221013.1619613-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should return correctly and warn in both daemon_session__kill
and daemon__kill functions after we tried everything to kill
sessions. Current code will keep on looping and wait.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 4697493842f5..7c4a9d424a64 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -908,7 +908,9 @@ static void daemon_session__kill(struct daemon_session *session,
 			daemon_session__signal(session, SIGKILL);
 			break;
 		default:
-			break;
+			pr_err("failed to wait for session %s\n",
+			       session->name);
+			return;
 		}
 		how++;
 
@@ -961,7 +963,8 @@ static void daemon__kill(struct daemon *daemon)
 			daemon__signal(daemon, SIGKILL);
 			break;
 		default:
-			break;
+			pr_err("failed to wait for sessions\n");
+			return;
 		}
 		how++;
 
-- 
2.30.2

