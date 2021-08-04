Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C98B3DF988
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 04:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhHDCD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 22:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233916AbhHDCDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 22:03:54 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 504C760F58;
        Wed,  4 Aug 2021 02:03:42 +0000 (UTC)
Date:   Tue, 3 Aug 2021 22:03:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hui Su <suhui@zeku.com>
Cc:     me@kloenk.de, masahiroy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/tracing: fix the bug that can't parse
 raw_trace_func
Message-ID: <20210803220340.27771569@rorschach.local.home>
In-Reply-To: <20210611022107.608787-1-suhui@zeku.com>
References: <20210611022107.608787-1-suhui@zeku.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 10:21:07 +0800
Hui Su <suhui@zeku.com> wrote:

> Since commit 77271ce4b2c0 ("tracing: Add irq, preempt-count and need resched info
> to default trace output"), the default trace output format has been changed to:
>           <idle>-0       [009] d.h. 22420.068695: _raw_spin_lock_irqsave <-hrtimer_interrupt
>           <idle>-0       [000] ..s. 22420.068695: _nohz_idle_balance <-run_rebalance_domains
>           <idle>-0       [011] d.h. 22420.068695: account_process_tick <-update_process_times
> 
> origin trace output format:(before v3.2.0)
>      # tracer: nop
>      #
>      #           TASK-PID    CPU#    TIMESTAMP  FUNCTION
>      #              | |       |          |         |
>           migration/0-6     [000]    50.025810: rcu_note_context_switch <-__schedule
>           migration/0-6     [000]    50.025812: trace_rcu_utilization <-rcu_note_context_switch
>           migration/0-6     [000]    50.025813: rcu_sched_qs <-rcu_note_context_switch
>           migration/0-6     [000]    50.025815: rcu_preempt_qs <-rcu_note_context_switch
>           migration/0-6     [000]    50.025817: trace_rcu_utilization <-rcu_note_context_switch
>           migration/0-6     [000]    50.025818: debug_lockdep_rcu_enabled <-__schedule
>           migration/0-6     [000]    50.025820: debug_lockdep_rcu_enabled <-__schedule
> 
> The draw_functrace.py(introduced in v2.6.28) can't parse the new version format trace_func,
> So we need modify draw_functrace.py to adapt the new version trace output format.
> 
> Signed-off-by: Hui Su <suhui@zeku.com>

Hi Hui.

Sorry, I missed this patch. I'll add it to my queue and mark it for
stable.

-- Steve


> ---
>  scripts/tracing/draw_functrace.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
> index 74f8aadfd4cb..7011fbe003ff 100755
> --- a/scripts/tracing/draw_functrace.py
> +++ b/scripts/tracing/draw_functrace.py
> @@ -17,7 +17,7 @@ Usage:
>  	$ cat /sys/kernel/debug/tracing/trace_pipe > ~/raw_trace_func
>  	Wait some times but not too much, the script is a bit slow.
>  	Break the pipe (Ctrl + Z)
> -	$ scripts/draw_functrace.py < raw_trace_func > draw_functrace
> +	$ scripts/tracing/draw_functrace.py < ~/raw_trace_func > draw_functrace
>  	Then you have your drawn trace in draw_functrace
>  """
>  
> @@ -103,10 +103,10 @@ def parseLine(line):
>  	line = line.strip()
>  	if line.startswith("#"):
>  		raise CommentLineException
> -	m = re.match("[^]]+?\\] +([0-9.]+): (\\w+) <-(\\w+)", line)
> +	m = re.match("[^]]+?\\] +([a-z.]+) +([0-9.]+): (\\w+) <-(\\w+)", line)
>  	if m is None:
>  		raise BrokenLineException
> -	return (m.group(1), m.group(2), m.group(3))
> +	return (m.group(2), m.group(3), m.group(4))
>  
>  
>  def main():

