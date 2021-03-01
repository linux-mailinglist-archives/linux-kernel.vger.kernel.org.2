Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D55327E3C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhCAM0L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Mar 2021 07:26:11 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:40014 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232916AbhCAM0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:26:09 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-104ZsfRXMPm6wNdxme02Bw-1; Mon, 01 Mar 2021 07:25:15 -0500
X-MC-Unique: 104ZsfRXMPm6wNdxme02Bw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD6FDDF8AD;
        Mon,  1 Mar 2021 12:25:13 +0000 (UTC)
Received: from krava.cust.in.nbox.cz (unknown [10.40.192.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 501465C232;
        Mon,  1 Mar 2021 12:25:11 +0000 (UTC)
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
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/2] perf daemon: Fix control fifo permissions
Date:   Mon,  1 Mar 2021 13:25:09 +0100
Message-Id: <20210301122510.64402-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper mode for mkfifo calls to get read and
write permissions for user. We can't use O_RDWR
in here, changing to standard permission value.

Fixes: 6a6d1804a190 ("perf daemon: Set control fifo for session")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 617feaf020f6..8f0ed2e59280 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -373,12 +373,12 @@ static int daemon_session__run(struct daemon_session *session,
 	dup2(fd, 2);
 	close(fd);
 
-	if (mkfifo(SESSION_CONTROL, O_RDWR) && errno != EEXIST) {
+	if (mkfifo(SESSION_CONTROL, 0600) && errno != EEXIST) {
 		perror("failed: create control fifo");
 		return -1;
 	}
 
-	if (mkfifo(SESSION_ACK, O_RDWR) && errno != EEXIST) {
+	if (mkfifo(SESSION_ACK, 0600) && errno != EEXIST) {
 		perror("failed: create ack fifo");
 		return -1;
 	}
-- 
2.29.2

