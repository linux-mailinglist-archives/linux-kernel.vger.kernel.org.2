Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECDB42FFD3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 05:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbhJPDFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 23:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239702AbhJPDFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 23:05:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D4961266;
        Sat, 16 Oct 2021 03:02:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mbZyH-006ZUT-2Q; Fri, 15 Oct 2021 23:02:53 -0400
Message-ID: <20211016030252.876545284@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 15 Oct 2021 23:02:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 6/7] selftests/ftrace: Update test for more eprobe removal process
References: <20211016030222.926060517@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The removal of eprobes was broken and missed in testing. Add various ways
to remove eprobes that are considered acceptable to the testing process to
catch when/if they break again.

Link: https://lkml.kernel.org/r/20211013205533.836644549@goodmis.org

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../test.d/dynevent/add_remove_eprobe.tc      | 54 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
index 5f5b2ba3e557..60c02b482be8 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
@@ -11,8 +11,8 @@ SYSTEM="syscalls"
 EVENT="sys_enter_openat"
 FIELD="filename"
 EPROBE="eprobe_open"
-
-echo "e:$EPROBE $SYSTEM/$EVENT file=+0(\$filename):ustring" >> dynamic_events
+OPTIONS="file=+0(\$filename):ustring"
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
 
 grep -q "$EPROBE" dynamic_events
 test -d events/eprobes/$EPROBE
@@ -37,4 +37,54 @@ echo "-:$EPROBE" >> dynamic_events
 ! grep -q "$EPROBE" dynamic_events
 ! test -d events/eprobes/$EPROBE
 
+# test various ways to remove the probe (already tested with just event name)
+
+# With group name
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+grep -q "$EPROBE" dynamic_events
+test -d events/eprobes/$EPROBE
+echo "-:eprobes/$EPROBE" >> dynamic_events
+! grep -q "$EPROBE" dynamic_events
+! test -d events/eprobes/$EPROBE
+
+# With group name and system/event
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+grep -q "$EPROBE" dynamic_events
+test -d events/eprobes/$EPROBE
+echo "-:eprobes/$EPROBE $SYSTEM/$EVENT" >> dynamic_events
+! grep -q "$EPROBE" dynamic_events
+! test -d events/eprobes/$EPROBE
+
+# With just event name and system/event
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+grep -q "$EPROBE" dynamic_events
+test -d events/eprobes/$EPROBE
+echo "-:$EPROBE $SYSTEM/$EVENT" >> dynamic_events
+! grep -q "$EPROBE" dynamic_events
+! test -d events/eprobes/$EPROBE
+
+# With just event name and system/event and options
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+grep -q "$EPROBE" dynamic_events
+test -d events/eprobes/$EPROBE
+echo "-:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+! grep -q "$EPROBE" dynamic_events
+! test -d events/eprobes/$EPROBE
+
+# With group name and system/event and options
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+grep -q "$EPROBE" dynamic_events
+test -d events/eprobes/$EPROBE
+echo "-:eprobes/$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+! grep -q "$EPROBE" dynamic_events
+! test -d events/eprobes/$EPROBE
+
+# Finally make sure what is in the dynamic_events file clears it too
+echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+LINE=`sed -e '/$EPROBE/s/^e/-/' < dynamic_events`
+test -d events/eprobes/$EPROBE
+echo "-:eprobes/$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
+! grep -q "$EPROBE" dynamic_events
+! test -d events/eprobes/$EPROBE
+
 clear_trace
-- 
2.32.0
