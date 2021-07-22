Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B527A3D2F97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 00:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhGVVce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 17:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231902AbhGVVcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 17:32:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16A8260EB4;
        Thu, 22 Jul 2021 22:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626991987;
        bh=K/zgg60QxsD92H9u2p0eB3H/DhqLEWBtU80nyuCM96Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FdlsIoiAeOmoonbiA7TM+OB9x5Oqyrfk1PjdOyNOk3ujdil9NMOzw7xx1AkNf+PkC
         11AR2mwAu63ujUHrEoScbK1RopgaEgOauOAivX46FxvqrQmNLqG2YXBv8asW9UI/Sy
         Dz7G4EWKVDowthOyiN52VyJ0nDNX0VHun6wQEGWSDxtpth3/cAC0r/KgS9mIW2PDCG
         e5wpWOTs9QVFGOMp5wuZQXpnY4663kvWDqjmJob4nr3XUIr53Z5l7Dgq+cFBPVmqvE
         wp1snKZJs547XrHwVvI1v0bvls6NajjRPlVBIZRby3VFn/3HBf7LsVu7pbib8l3rYR
         B5ClXoI8iMvKQ==
Message-ID: <044507ec2dc4046f53e32cffbdb6d827205b22bc.camel@kernel.org>
Subject: Re: [PATCH] tracing: Synthetic event field_pos is an index not a
 boolean
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 22 Jul 2021 17:13:05 -0500
In-Reply-To: <20210721191008.638bce34@oasis.local.home>
References: <20210721191008.638bce34@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2021-07-21 at 19:10 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Performing the following:
> 
>  ># echo 'wakeup_lat s32 pid; u64 delta; char wake_comm[]' >
> synthetic_events
>  ># echo 'hist:keys=pid:__arg__1=common_timestamp.usecs' >
> events/sched/sched_waking/trigger
>  ># echo
> 'hist:keys=next_pid:pid=next_pid,delta=common_timestamp.usecs-
> $__arg__1:onmatch(sched.sched_waking).trace(wakeup_lat,$pid,$delta,pr
> ev_comm)'\
>       > events/sched/sched_switch/trigger
>  ># echo 1 > events/synthetic/enable
> 
> Crashed the kernel:
> 
>  BUG: kernel NULL pointer dereference, address: 000000000000001b
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] PREEMPT SMP
>  CPU: 7 PID: 0 Comm: swapper/7 Not tainted 5.13.0-rc5-test+ #104
>  Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01
> v03.03 07/14/2016
>  RIP: 0010:strlen+0x0/0x20
>  Code: f6 82 80 2b 0b bc 20 74 11 0f b6 50 01 48 83 c0 01 f6 82 80 2b
> 0b bc
>   20 75 ef c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 <80> 3f 00
> 74 10
>   48 89 f8 48 83 c0 01 80 38 9 f8 c3 31
>  RSP: 0018:ffffaa75000d79d0 EFLAGS: 00010046
>  RAX: 0000000000000002 RBX: ffff9cdb55575270 RCX: 0000000000000000
>  RDX: ffff9cdb58c7a320 RSI: ffffaa75000d7b40 RDI: 000000000000001b
>  RBP: ffffaa75000d7b40 R08: ffff9cdb40a4f010 R09: ffffaa75000d7ab8
>  R10: ffff9cdb4398c700 R11: 0000000000000008 R12: ffff9cdb58c7a320
>  R13: ffff9cdb55575270 R14: ffff9cdb58c7a000 R15: 0000000000000018
>  FS:  0000000000000000(0000) GS:ffff9cdb5aa00000(0000)
> knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000000000001b CR3: 00000000c0612006 CR4: 00000000001706e0
>  Call Trace:
>   trace_event_raw_event_synth+0x90/0x1d0
>   action_trace+0x5b/0x70
>   event_hist_trigger+0x4bd/0x4e0
>   ? cpumask_next_and+0x20/0x30
>   ? update_sd_lb_stats.constprop.0+0xf6/0x840
>   ? __lock_acquire.constprop.0+0x125/0x550
>   ? find_held_lock+0x32/0x90
>   ? sched_clock_cpu+0xe/0xd0
>   ? lock_release+0x155/0x440
>   ? update_load_avg+0x8c/0x6f0
>   ? enqueue_entity+0x18a/0x920
>   ? __rb_reserve_next+0xe5/0x460
>   ? ring_buffer_lock_reserve+0x12a/0x3f0
>   event_triggers_call+0x52/0xe0
>   trace_event_buffer_commit+0x1ae/0x240
>   trace_event_raw_event_sched_switch+0x114/0x170
>   __traceiter_sched_switch+0x39/0x50
>   __schedule+0x431/0xb00
>   schedule_idle+0x28/0x40
>   do_idle+0x198/0x2e0
>   cpu_startup_entry+0x19/0x20
>   secondary_startup_64_no_verify+0xc2/0xcb
> 
> The reason is that the dynamic events array keeps track of the field
> position of the fields array, via the field_pos variable in the
> synth_field structure. Unfortunately, that field is a boolean for
> some
> reason, which means any field_pos greater than 1 will be a bug (in
> this
> case it was 2).
> 
> Cc: stable@vger.kernel.org
> Fixes: bd82631d7ccdc ("tracing: Add support for dynamic strings to
> synthetic events")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_synth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
> index 6e146b959dcd..4007fe95cf42 100644
> --- a/kernel/trace/trace_synth.h
> +++ b/kernel/trace/trace_synth.h
> @@ -14,10 +14,10 @@ struct synth_field {
>  	char *name;
>  	size_t size;
>  	unsigned int offset;
> +	unsigned int field_pos;
>  	bool is_signed;
>  	bool is_string;
>  	bool is_dynamic;
> -	bool field_pos;
>  };
>  
>  struct synth_event {

Good catch, thanks,

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


