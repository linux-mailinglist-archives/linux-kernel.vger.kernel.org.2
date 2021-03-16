Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF85833E035
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 22:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhCPVQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 17:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232771AbhCPVQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 17:16:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3ED6064F92;
        Tue, 16 Mar 2021 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615929364;
        bh=yQudHi035Cf+JUPx0Oc8k0CG2YnBs9uidWwo8QotRks=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=As3g/V7N7CapZLqKLeA9GTfE4D0HtnceNjHOlFjMBCxvPeyQ8jZ6yJ5IsaZH2tYzI
         7W+iu2C8jEeFz2AQ26Lm3lmEyaQuvs/li2AIwNJpt7pbqw/O1LhwyvJCRKNih8KdF3
         WF+FdqHnBWb8DWwFUtMRumi2QaFJfiLpfi3vupWCeSQOwoK1d+T4IuPt4P9D6liak+
         xcqbuoPi0jJF0/TYwsLACBmRzyJLAkbqGkWR7z/RQqudxvlARljEtnKexxNvGemWVf
         RhIrK3AnuuWmvAZRB/4xGj17YKq026iBZQ0GmmkaHVAU0AqxVAqkG9rczo1ecKsKcZ
         pLlAbK5WSqtzg==
Message-ID: <bc865f7bb546cdd2c59443ff6f7411e02f313cd7.camel@kernel.org>
Subject: Re: [PATCH 0/7 v2] tracing: Have ring_buffer_event_time_stamp()
 work for all events
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yordan Karadzhov <y.karadz@gmail.com>
Date:   Tue, 16 Mar 2021 16:16:03 -0500
In-Reply-To: <20210316164100.546961804@goodmis.org>
References: <20210316164100.546961804@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, 2021-03-16 at 12:41 -0400, Steven Rostedt wrote:
> Yordan has been working on a patch set that will not repeat functions
> in the function tracer but instead show a single event that states
> that
> the previous function repeated X amount of times. I recommended that
> this should also show the time of the last function that repeated.
> To save on space, Yordan suggested to use a 32 bit delta instead of
> a full 64 bit timestamp of the last event. But to create this delta,
> we need a way to extract the time of the repeat event and use that
> to calculate the delta of the last function event.
> 
> But currently the ring_buffer_event_time_stamp() only works if all
> events
> has an absolute time stamp attached to it. That would be counter
> productive
> to make all functions record the full time stamp because we wanted to
> use a 32 bit counter instead of a 64 bit counter for the rare repeat
> event!
> 
> This patch series makes ring_buffer_event_time_stamp() work for all
> non committed events (after reserve and before it is committed).
> The trick is that the per CPU descriptor of the buffer holds the time
> stamp used for the event being processed. It has a nesting of 5
> levels
> to deal with interrupts that add events. Extracting the time for the
> event
> can only be done for the current event being processed and not yet
> committed.
> 
> To achieve this, the buffer that the event is on needs to be passed
> to
> the ring_buffer_event_time_stamp(). That caused a bit of churn for
> the histogram code, because that buffer wasn't available at the time
> the ring_buffer_event_time_stamp() was called. Although the
> hist_field
> contained a pointer to the trace_array that holds the ring buffer,
> if tracing was disabled, then a temporary buffer was used instead,
> and that temporary buffer would need to be passed to the
> ring_buffer_event_time_stamp(). That buffer is exposed to the trace
> event
> logic, but was not passed down into the trigger code. That had to be
> done to take advantage of the new code.
> 
> The second to last patch adds verifier logic (although commented out)
> that was used to debug the issue when a temporary buffer was in use.
> It proved to be very valuable and is kept in, in case this needs to
> be
> debugged again.
> 
> Finally the last patch is for use with Yordan's work, and is needed
> because
> when filtering is enabled, the event being processed may not even be
> on the buffer, and the tracing_event_time_stamp() checks for that and
> will just use the current time stamp if the event is not reserved
> yet.
> This could be used also for the histogram code, but wanted to hold
> off
> on that.
> 
> Changes since v1:
> 
>  - Applied change of last patch to pass buffer not trace_array
>  - Fixed prototype of stack_track_data_snapshot() when snapshot not
> configured
> 
> Steven Rostedt (VMware) (7):
>       ring-buffer: Separate out internal use of
> ring_buffer_event_time_stamp()
>       ring-buffer: Add a event_stamp to cpu_buffer for each level of
> nesting
>       tracing: Pass buffer of event to trigger operations
>       ring-buffer: Allow ring_buffer_event_time_stamp() to return
> time stamp of all events
>       tracing: Use a no_filter_buffering_ref to stop using the filter
> buffer
>       ring-buffer: Add verifier for using
> ring_buffer_event_time_stamp()
>       tracing: Add tracing_event_time_stamp() API
> 
> ----
>  include/linux/ring_buffer.h         |   3 +-
>  include/linux/trace_events.h        |   5 +-
>  kernel/trace/ring_buffer.c          | 138
> ++++++++++++++++++++++++++++++------
>  kernel/trace/trace.c                |  38 +++++-----
>  kernel/trace/trace.h                |   9 +--
>  kernel/trace/trace_events_hist.c    | 100 +++++++++++++++++---------
>  kernel/trace/trace_events_trigger.c |  45 +++++++-----
>  7 files changed, 239 insertions(+), 99 deletions(-)

This all looks fine to me.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


