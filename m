Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1348030B0D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhBATwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:52:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232531AbhBATtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:49:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C75B464EC2;
        Mon,  1 Feb 2021 19:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612208900;
        bh=gH3gZnJcbhFMZv3fvfCEI1xXHxSEVQJc23/KMH3PdSU=;
        h=From:To:Cc:Subject:Date:From;
        b=AssQlhzdBHfJayIwrF0GdoMbaiecqhsgGXUH5426dLTn6xFR+tSNJA+Zg6JcEVIxL
         Ntqh20Gsz5Rbo8+yn/Ynwr0MG0cLB1ZLsfnF+0AUCaDf87d6xdjmLME4UWEALzXUJX
         ur5rJ5kIXqE3+1cIEw1YtmUmHPpMrdE2L7d+mTcsQnCr8XgnxTeLZCVa4DwtLIC4Qz
         W44IajweorW2Xh66jk33AdGLtG9g4Oe6BXXMMrSWwav1vE3FH5D5IAiZ6nAUtJLSoY
         QQmqMJ7oydGLh7QC0/Q4LPrF7mX9eZC0EVYj6a1FLGNXXizW3KitBBJ37/IcLIgDjA
         idsihaYNBqoLQ==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/6] tracing: More synthetic event error fixes
Date:   Mon,  1 Feb 2021 13:48:10 -0600
Message-Id: <cover.1612208610.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v7 of the synthetic event error fix patchset.  This version
addresses the comments from v6:

  - moved check_command() from '[PATCH v6 3/6] tracing: Update synth
    command errors' to '[PATCH v6 2/6] tracing: Rework synthetic event
    command parsing'.

  - in __create_synth_event(), moved mutex_lock(&event_mutex) after
    is_good_name() check and changed related error handling.

  - simplified check_command() a bit by calling argv_free() sooner as
    suggested by Steve.

  - added Steve's comment about check_field_version() into that
    function and added additional comments to the caller.

Tom


v6 text:

Hi,

This is v6 of the synthetic event error fix patchset.  This version
removes the semicolon-adding pass and instead adds an inner loop as
suggested by Masami.  A different mechanism adding per-version field
checks was also added in place of the previous whole-string audit.

Also, moved the parse_synth_field() error message back into patch 2/6
(tracing: Rework synthetic event command parsing) and fixed the
problem with the !name problem as also noted by Masami, and added a
new patch (selftests/ftrace: Add '!event' synthetic event syntax
check) to check for that and prevent future changes from breaking it
again.

Tom


v5 text:

Hi,

This is v5 of the sythetic event error fix patchset.  This version is
the same as v4 but with a few variable-initialization fixes flagged by
Dan Carpenter and the kernel test robot.

Tom

v4 text:

Hi,

This is v4 of the sythetic event error fix patchset.  As suggested by
Steve, I added a new pass that adds semicolons to 'old' commands that
may be missing them, in order to maintain backward compatibility.  All
commands are handled by the new and improved parsing code, but
commands missing the semicolons have them added before processing and
are therefore still valid.  At some point in the future, as new
features are added and we can require any command containing them to
require semicolons, this pass can be completely skipped by detecting
those features in the currently empty audit_old_buffer() hook.

Also, as a result, the patch adding semicolons to the selftests is no
longer necessary (selftests/ftrace: Add synthetic event field
separators) and has been dropped in this series.

Tom


v3 text:

Hi,

This is v3 of the sythetic event error fix patchset.  As suggested by
Masami, I split the 'tracing/dynevent: Delegate parsing to create
function' into two - one containing just the interface changes and the
second with the synthetic event parsing changes the first enabled.

I also replaced a couple argv_split() with strpbrk() as suggested by
Masami, along with removing the no-longer-used consume lines and
another line that tested ECANCELED that was no longer needed.

Also, removed a test case that was no longer needed since the commands
are now stripped of whitespace first.

Thanks, Masami, for the suggestions.

Tom

v2 text:

This is v2 of the previous sythetic event error fix patchset.

This version drops the original ([PATCH 1/4] tracing: Make
trace_*_run_command() more flexible) and (tracing: Use new
trace_run_command() options) patches and replaces them with Masami's
patch (tracing/dynevent: Delegate parsing to create function) [1].
The new version adds in all the synthetic event changes needed to
compile and use the new interface.

A new patch was also added (selftests/ftrace: Add synthetic event
field separators) that fixes more invalid synthetic event syntax I
found while testing.

I also added some more new checks to the synthetic event sytax error
testcase.

As before, I didn't see any problems running the entire ftrace
testsuite or the test modules that also use the things that were
touched here.

[1] https://lore.kernel.org/lkml/20201019001504.70dc3ec608277ed22060d2f7@kernel.org/

Thanks,

Tom


v1 text:

Hi,

This patchset addresses the synthetic event error anomalies reported
by Masami in the last patchset [1].

It turns out that most of the problems boil down to clunky separator
parsing; adding a couple new abilities to trace_run_command() and then
adapting the existing users seemed to me the best way to fix these
things, and also gets rid of some code.

Also, to make things easier for error display, I changed these to
preserve the original command string and pass it through the callback
instead of rebuilding it for error display.

I added some new error strings and removed unused ones as well, and
added a bunch of new test cases to the synthetic parser error test
case.

I didn't see any problems running the entire ftrace testsuite or the
test modules that also use the things that were touched here.

Thanks,

Tom

[1] https://lore.kernel.org/lkml/20201014110636.139df7be275d40a23b523b84@kernel.org/

The following changes since commit f6a694665f132cbf6e2222dd2f173dc35330a8aa:

  tracing: Offload eval map updates to a work queue (2020-12-15 09:29:14 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-fixes-v7

Masami Hiramatsu (1):
  tracing/dynevent: Delegate parsing to create function

Tom Zanussi (5):
  tracing: Rework synthetic event command parsing
  tracing: Update synth command errors
  tracing: Add a backward-compatibility check for synthetic event
    creation
  selftests/ftrace: Update synthetic event syntax errors
  selftests/ftrace: Add '!event' synthetic event syntax check

 kernel/trace/trace.c                          |  23 +-
 kernel/trace/trace.h                          |   3 +-
 kernel/trace/trace_dynevent.c                 |  35 +-
 kernel/trace/trace_dynevent.h                 |   4 +-
 kernel/trace/trace_events_synth.c             | 320 +++++++++++++-----
 kernel/trace/trace_kprobe.c                   |  33 +-
 kernel/trace/trace_probe.c                    |  17 +
 kernel/trace/trace_probe.h                    |   1 +
 kernel/trace/trace_uprobe.c                   |  17 +-
 .../trigger-synthetic-event-syntax.tc         |   4 +
 .../trigger-synthetic_event_syntax_errors.tc  |  35 +-
 11 files changed, 333 insertions(+), 159 deletions(-)

-- 
2.17.1

