Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8FD403FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351800AbhIHTVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350394AbhIHTV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:21:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C200D61167;
        Wed,  8 Sep 2021 19:20:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mO36x-0014ci-GW; Wed, 08 Sep 2021 15:19:55 -0400
Message-ID: <20210908191955.344003340@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Sep 2021 15:19:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 12/12] selftests/ftrace: Exclude "(fault)" in testing add/remove eprobe
 events
References: <20210908191851.381347939@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The original test for adding and removing eprobes used synthetic events
and retrieved the filename from the open system call at the end of the
system call. This would allow it to always be loaded into the page tables
when accessed.

Masami suggested that the test was too complex for just testing add and
remove, so it was changed to test just adding and removing an event probe
on top of the start of the open system call event. Now it is possible that
the filename will not be loaded into memory at the time the eprobe is
triggered, and will result in "(fault)" being displayed in the event. This
causes the test to fail.

Account for "(fault)" also being one of the values of the filename field
of the event probe.

Link: https://lkml.kernel.org/r/20210907230429.5783d519@rorschach.local.home

Fixes: 079db70794ec5 ("selftests/ftrace: Add test case to test adding and removing of event probe")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
index 25a3da4eaa44..5f5b2ba3e557 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
@@ -22,7 +22,7 @@ ls
 echo 0 > events/eprobes/$EPROBE/enable
 
 content=`grep '^ *ls-' trace | grep 'file='`
-nocontent=`grep '^ *ls-' trace | grep 'file=' | grep -v -e '"/' -e '"."'` || true
+nocontent=`grep '^ *ls-' trace | grep 'file=' | grep -v -e '"/' -e '"."' -e '(fault)' ` || true
 
 if [ -z "$content" ]; then
 	exit_fail
-- 
2.32.0
