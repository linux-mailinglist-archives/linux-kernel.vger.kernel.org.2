Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADA83E2CFC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 16:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbhHFOy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 10:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233915AbhHFOyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 10:54:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 378D861052;
        Fri,  6 Aug 2021 14:54:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mC1Ed-003ETb-Pe; Fri, 06 Aug 2021 10:54:07 -0400
Message-ID: <20210806145259.240934834@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 06 Aug 2021 10:52:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [for-linus][PATCH 0/3] tracing: Fix tracepoint and static call race condition`
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix tracepoint race between static_call and callback data

As callbacks to a tracepoint are paired with the data that is passed in when
the callback is registered to the tracepoint, it must have that data passed
to the callback when the tracepoint is triggered, else bad things will
happen. To keep the two together, they are both assigned to a tracepoint
structure and added to an array. The tracepoint call site will dereference
the structure (via RCU) and call the callback in that structure along with
the data in that structure. This keeps the callback and data tightly
coupled.

Because of the overhead that retpolines have on tracepoint callbacks, if
there's only one callback attached to a tracepoint (a common case), then it
is called via a static call (code modified to do a direct call instead of an
indirect call). But to implement this, the data had to be decoupled from the
callback, as now the callback is implemented via a direct call from the
static call and not an indirect call from the dereferenced structure.

Note, the static call only calls a callback used when there's a single
callback attached to the tracepoint. If more than one callback is attached
to the same tracepoint, then the static call will call an iterator
function that goes back to dereferencing the structure keeping the callback
and its data tightly coupled again.

Issues can arise when going from 0 callbacks to one, as the static call is
assigned to the callback, and it must take care that the data passed to it
is loaded before the static call calls the callback. Going from 1 to 2
callbacks is not an issue, as long as the static call is updated to the
iterator before the tracepoint structure array is updated via RCU. Going
from 2 to more or back down to 2 is not an issue as the iterator can handle
all theses cases. But going from 2 to 1, care must be taken as the static
call is now calling a callback and the data that is loaded must be the data
for that callback.

Care was taken to ensure the callback and data would be in-sync, but after
a bug was reported, it became clear that not enough was done to make sure
that was the case. These changes address this.

The first change is to compare the old and new data instead of the old and
new callback, as it's the data that can corrupt the callback, even if the
callback is the same (something getting freed).

The next change is to convert these transitions into states, to make it
easier to know when a synchronization is needed, and to perform those
synchronizations. The problem with this patch is that it slows down
disabling all events from under a second, to making it take over 10 seconds
to do the same work. But that is addressed in the final patch.

The final patch uses the RCU state functions to keep track of the RCU state
between the transitions, and only needs to perform the synchronization if an
RCU synchronization hasn't been done already. This brings the performance of
disabling all events back to its original value. That's because no
synchronization is required between disabling tracepoints. It is only
required when enabling a tracepoint after its been disabled. If an RCU
synchronization happens after the tracepoint is disabled, and before it is
re-enabled, there's no need to do the synchronization again.

Both the second and third patch have subtle complexities that they are
separated into two patches. But because the second patch causes such a
regression in performance, the third patch adds a "Fixes" tag to the second
patch, such that the two must be backported together and not just the second
patch.

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 79497d2cb5619c45a5e259d27280ead1060b776b


Mathieu Desnoyers (3):
      tracepoint: static call: Compare data on transition from 2->1 callees
      tracepoint: Fix static call function vs data state mismatch
      tracepoint: Use rcu get state and cond sync for static call updates

----
 kernel/tracepoint.c | 155 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 135 insertions(+), 20 deletions(-)
