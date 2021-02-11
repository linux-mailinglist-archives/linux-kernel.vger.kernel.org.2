Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDD531837D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhBKCMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:12:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhBKCLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:11:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ADD764EC0;
        Thu, 11 Feb 2021 02:09:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lA1QU-00BAZ5-Bf; Wed, 10 Feb 2021 21:09:50 -0500
Message-ID: <20210211020950.241040866@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Feb 2021 21:09:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 12/12] selftests/ftrace: Add !event synthetic event syntax check
References: <20210211020927.829775774@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Add a check confirming that '!event' alone will remove a synthetic
event.

Link: https://lkml.kernel.org/r/1dff3f03d18542cece08c10d6323d8a8dba11e42.1612208610.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../trigger/inter-event/trigger-synthetic-event-syntax.tc     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
index 59216f3cfb12..2968cdc7df30 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
@@ -32,6 +32,10 @@ grep "myevent[[:space:]]u64 var1" synthetic_events
 # it is not possible to add same name event
 ! echo "myevent u64 var2" >> synthetic_events
 
+# make sure !synthetic event doesn't require a field
+echo "!myevent" >> synthetic_events
+echo "myevent u64 var1" >> synthetic_events
+
 # Non-append open will cleanup all events and add new one
 echo "myevent u64 var2" > synthetic_events
 
-- 
2.29.2


