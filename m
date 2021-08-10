Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2183E009A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 13:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhHDL5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 07:57:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhHDL5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:57:15 -0400
Date:   Wed, 4 Aug 2021 13:57:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628078222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DtIoVz/ATx5dkmXfEK0DBmHpZVvInaS+hJm52/QJudg=;
        b=VTG4zQ0J2fj69kmMUovaWjpPKWq75k5BaK3Tq3nDwVdD0C7HTMoQ4NsYN4NliALwmqru3R
        4p1ZAf1EZtwWNiXIbpVn7HnXrUSNu2whNG3TPp/uXjeB+J1tUdZGoZfpoC8NNV6g648/wx
        ihq/eRNsw/Hhalf5xTjlJ1Q102RvmoTfxHtSeY02OF3XVLqKqkrM/G+Clx/yo6EIGhIbet
        FaHdFk/kt4nLmLwJKTukcFTT6RdRkZlksa9evFaOJKZfhNqMOBjXA5hJq0afxY5LTX9gRk
        Q033+HhZyONMNG4f2AbwjjGzMSuifc2D7mndytODdfa/ANaDhRscD5ZaUR96qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628078222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DtIoVz/ATx5dkmXfEK0DBmHpZVvInaS+hJm52/QJudg=;
        b=sfvmGmndPW14p4s1KCuxZ2v8k7EBmpPq69ILz/oF2yGOUpDZFe0dtLOueMLcvOjCSnNkn9
        flcfWRwpHMQQeoBg==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH v2 00/21] libtracefs: Introducing tracefs_sql() to create
 synthetice events with an SQL line
Message-ID: <YQqAjBCtd8MnhV1v@lx-t490>
References: <20210803042347.679499-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803042347.679499-1-rostedt@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Tue, Aug 03, 2021 , Steven Rostedt wrote:
>
> Major update since v1:
>
>    It was brought to my attention that the man page did not state that the
>    SQL syntax required JOIN .. ON in the statement. That is, they were not
>    optional. I decided to fix that. But not by updating the man page, but by
>    actually making JOIN .. ON optional. If you leave that out, the synthetic
>    event will not be completely created, but it will have enough to create
>    a histogram. See the bottom (HISTOGRAMS) for more info!
>
...
>
> HISTOGRAMS
>
> Simple SQL statements without the JOIN ON may also be used, which will
> create a histogram instead. When doing this, the struct tracefs_hist
> descriptor can be retrieved from the returned synthetic event descriptor via
> the tracefs_synth_get_start_hist(3).
>

Thanks a lot! Actually, I meant going even one step further ;)

I was imagining something like the following:

$ trace-cmd sql-shell		# OR

$ perf tracefs-sql-shell

  Welcome to tracefs SQL shell...

  > SELECT PNAME(common_pid),msr,val
    FROM write_msr
    WHERE msr=72 OR msr=2096

  .-------------------------------------------.
  | PNAME(common_pid)   |  msr  |    val      |
  |---------------------|------ |-------------|
  | qemu-system-x86     | 0x48  | 0           |
  | qemu-system-x86     | 0x48  | 0           |
  | qemu-system-x86     | 0x48  | 0           |
  | kworker/u16:2       | 0x830 | 0x1000008fb |
  | ....                | ....  | .....       |
  +-------------------------------------------+

  > SELECT MAX(end.TIMESTAMP_USECS - start.TIMESTAMP_USECS) AS MaxSystemLatency_us,
      PNAME(common_pid)
    FROM sched_waking AS start JOIN sched_switch AS end
    ON start.pid = stop.next_pid

  .-------------------------------------------.
  | MaxSystemLatency_us | PNAME(common_pid)   |
  |---------------------|---------------------|
  | 350                 | cyclictest          |
  +-------------------------------------------+

  > SELECT (end.TIMESTAMP_USECS - start.TIMESTAMP_USECS) AS latency,
      PNAME(common_pid), PRIO(common_pid)
    FROM sched_waking AS start JOIN sched_switch AS end
    ON start.pid = stop.next_pid
    ORDER BY latency DESC
    LIMIT 5

  .----------------------------------------------------------.
  | Latency | PNAME(common_pid)           | PRIO(common_pid) |
  |---------|-----------------------------|------------------|
  | 829     | cyclictest                  | SCHED_FIFO:98    |
  | 400     | cyclictest                  | SCHED_FIFO:98    |
  | 192     | pulseaudio-rt               | SCHED_RR:48      |
  | 30      | firefox                     | SCHED_OTHER:0:0  |
  | 10      | kworker/0:0H-events_highpri | SCHED_OTHER:0:-20|
  +----------------------------------------------------------+

  > SELECT (end.TIMESTAMP_USECS - start.TIMESTAMP_USECS) as MaxIRQLatency_us
    FROM irq_disable as start JOIN irq_enable as end
    ON start.common_pid = end.common_pid,
       start.parent_offs == end.parent_offs
    ORDER BY max_irq_disable
    LIMIT 1

  .------------------.
  | MaxIRQLatency_us |
  |------------------|
  | 37               |
  +------------------+

And so on....

The idea was that since the community already picked SQL as a
higher-level tracing language, why hard-code the SQL language with
synthetic events and histograms?

The language can alredy offer something *way more generic*, out of the
box, while still covering the desired special cases.

We can support the standard SQL aggregate functions (e.g., MAX(), MIN(),
SUM(), COUNT(), DISTINCT(), AVG(), etc.) + some kernel-specific
functions (e.g., PROCESS_NAME(), PROCESS_PRIO(), USECS(), etc.) + the
standard SQL keyworkds like ORDER BY, LIMIT, DESC, ASC, etc. This would
offer some nice friendly competition to BPF tracing, while still being a
(relatively) simple *query-only* language.

I'm not sure if you would be OK with this, but I thought a proposal
won't hurt :)

I can also write some patches on top of this series if you are OK with
the principle in general.

Kind regards,

--
Ahmed S. Darwish
Linutronix GmbH
