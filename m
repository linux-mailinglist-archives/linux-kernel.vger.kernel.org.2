Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E494B3E2E09
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244991AbhHFP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:56:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41794 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245000AbhHFP4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:56:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B218C21F8D;
        Fri,  6 Aug 2021 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628265396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y98PhVLBzm9dgjKbFUyHIWB8M33IZsEWGkjIi3Q7n64=;
        b=HOGRZUwEMNINVb78NTrtf9OtPkBJtzljaeTgLa/60YQ7xEKo5CUvnKSigm1D59zyrQW9eu
        pKAzO4nTHDWco1vCS4zPYR1rD0zpFUe3r1/TuhdvPtc84/yyRNPgFFTo9YpIAqocBg8DdZ
        slk5Y5y/nurqPyBYSRn4uiOxsql/3iM=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 66D7AA3B8B;
        Fri,  6 Aug 2021 15:56:36 +0000 (UTC)
Date:   Fri, 6 Aug 2021 17:56:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 06/10] printk: use seqcount_latch for
 console_seq
Message-ID: <YQ1bsdh8PoLwBrnl@alley>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
 <20210803131301.5588-7-john.ogness@linutronix.de>
 <YQvWuzpAv1Tw/CoQ@alley>
 <87bl6bx68f.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl6bx68f.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-08-05 17:32:40, John Ogness wrote:
> On 2021-08-05, Petr Mladek <pmladek@suse.com> wrote:
> > On Tue 2021-08-03 15:18:57, John Ogness wrote:
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index d07d98c1e846..f8f46d9fba9b 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -2912,18 +2920,19 @@ void console_unblank(void)
> >>   */
> >>  void console_flush_on_panic(enum con_flush_mode mode)
> >>  {
> >> -	/*
> >> -	 * If someone else is holding the console lock, trylock will fail
> >> -	 * and may_schedule may be set.  Ignore and proceed to unlock so
> >> -	 * that messages are flushed out.  As this can be called from any
> >> -	 * context and we don't want to get preempted while flushing,
> >> -	 * ensure may_schedule is cleared.
> >> -	 */
> >> -	console_trylock();
> >> -	console_may_schedule = 0;
> >> -
> >> -	if (mode == CONSOLE_REPLAY_ALL)
> >> -		console_seq = prb_first_valid_seq(prb);
> >> +	if (console_trylock()) {
> >> +		if (mode == CONSOLE_REPLAY_ALL)
> >> +			latched_seq_write(&console_seq, prb_first_valid_seq(prb));
> >
> > I am scratching my head about this. Of course, latched_seq_write() does
> > not guarantee the result when the console lock it taken by another process.
> > But console_lock(), called below, will call latched_seq_write()
> > anyway.
> >
> > Also CONSOLE_REPLAY_ALL is used by panic_print_sys_info().
> > It is called the following way:
> >
> > void panic(const char *fmt, ...)
> > {
> > [...]
> > 	debug_locks_off();
> > 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> >
> > 	panic_print_sys_info();
> > [...]
> > }
> >
> > On one hand, console_flush_on_panic(CONSOLE_FLUSH_PENDING) will
> > most likely take over the console lock even when it was taken
> > by another CPU before. And the 2nd console_flush_on_panic()
> > called from panic_print_sys_info() will not even notice.
> >
> > On the other hand, CONSOLE_REPLAY_ALL would not even try to
> > reply the log when the console log was not available.
> >
> > The risk of broken console_seq is neglible. console_unlock()
> > should be safe even with invalid console_seq.
> >
> > My opinion:
> >
> > I suggest to keep the original logic and maybe add some comment:
> >
> > void console_flush_on_panic(enum con_flush_mode mode)
> > {
> > 	/*
> > 	 * If someone else is holding the console lock, trylock will fail
> > 	 * and may_schedule may be set.  Ignore and proceed to unlock so
> > 	 * that messages are flushed out.  As this can be called from any
> > 	 * context and we don't want to get preempted while flushing,
> > 	 * ensure may_schedule is cleared.
> > 	 */
> > 	console_trylock();
> > 	console_may_schedule = 0;
> >
> > 	/*
> > 	 * latched_seq_write() does not guarantee consistent values
> > 	 * when console_trylock() failed. But this is the best effort.
> > 	 * console_unlock() will update anyway console_seq. prb_read_valid()
> > 	 * handles even invalid sequence numbers.
> > 	 */
> > 	if (mode == CONSOLE_REPLAY_ALL)
> > 		latched_seq_write(&console_seq, prb_first_valid_seq(prb));
> >
> > 	console_unlock();
> > }
> 
> I see now that CONSOLE_REPLAY_ALL is not handled correctly. And in the
> follow-up patch "printk: introduce kernel sync mode" the situation gets
> worse. I am trying to find ways to handle things without blindly
> ignoring locks and hoping for the best.
> 
> I need to re-evaluate how to correctly support this feature.

A solution might be to implement a generic cycle that would use
the right latched_seq and buffers. Something like:

enum console_mode {
	CONSOLE_MODE_NORMAL = 0,
	CONSOLE_MODE_ATOMIC,
	CONSOLE_MODE_ATOMIC_NMI,
	CONSOLE_MODE_REPLAY_ALL,
	CONSOLE_MODE_LAST
};

struct console_mode_info
{
	static char text[CONSOLE_LOG_MAX];
	static char ext_text[CONSOLE_EXT_LOG_MAX];
	static struct latched_seq seq;
};

struct console_mode_info[CONSOLE_MODE_LAST];

void set_console_seq(u64 seq, enum console_mode mode)
{
	latched_seq_write(&console_mode_info[mode].seq), seq);
}

u64 get_console_seq(enum console_mode mode)
{
	/* Atomic console calls might be nested. Return the highest value. */
	if (mode == CONSOLE_MODE_ATOMIC ||
	    mode == CONSOLE_MODE_ATOMIC_NMI) {
		u64 seq, seq_nmi;

		seq = latched_seq_read_nolock(&console_mode_info[CONSOLE_MODE_ATTOMIC].seq);
		seq_nmi = latched_seq_read_nolock(&console_mode_info[CONSOLE_MODE_ATTOMIC_NMI].seq));

		if (seq_nmi > seq)
			seq = seq_nmi;

		/*
		 * Return what has already been proceed by normal consoles
		 * when the atomic consoles have not been used yet.
		 */
		if (seq > 0)
			return seq;
		return latched_seq_read_nolock(&console_mode_info[CONSOLE_MODE_NORMAL].seq);
	}

	return latched_seq_read_nolock(&console_mode_info[mode].seq;
}

/*
 * Generic cycle for flushing messages to the console.
 *
 * Return: the next to be proceed sequence number;
 */
void console_write_pending_messages(enum console_mode mode);
{
	struct printk_info info;
	struct printk_record r;
	u64 seq;

	prb_rec_init_rd(&r, &info, console_mode_info[mode].text,
			    sizeof(console_mode_info[mode].text));

	for (;;) {
		/*
		 * Stop normal console when atomic consoles got
		 * activated in a panic mode.
		 */
		if (ctx == CONSOLE_MODE_NORMAL && atomic_console_used)
			break;

		seq = get_console_seq(mode);
		if (!prb_read_valid(prb, seq, &r))
			return;

		if (suppress_message_printing(r.info->level)) {
			set_console_seq(seq + 1, mode);
			continue;
		}

		len = console_format_msg(r);
		call_console_drivers(...);
		set_console_seq(seq + 1, mode);
	}
}

void console_unlock(void)

{
	bool retry;
	int seq;

again:
	/* Prevent infinite loop when normal consoles were stopped */
	if (atomic_console_used) {
		up_console_sem();
		return;
	}

	console_write_pending_messages(CONSOLE_MODE_NORMAL);
	up_console_sem();

	/*
	 * Make sure that someone handles messages added in the small
	 * race window before console_sem was released.
	 */
	retry = prb_read_valid(prb, get_console_seq(CONSOLE_MODE_NORMAL), NULL);
	if (retry && console_trylock())
		goto again;
}

void atomic_console_write_pending()
{
	unsinged long flags;

	raw_printk_cpu_lock_irqsave(flags);

	atomic_console_used = true;
	if (in_nmi)
		console_write_pending_messages(CONSOLE_MODE_ATOMIC_NMI);
	else
		console_write_pending_messages(CONSOLE_MODE_ATOMIC);
	}

	raw_printk_cpu_unlock_irqrestore(flags);
}

void replay_all_messages()
{
	set_console_seq(CONSOLE_MODE_REPLAY_ALL, rb_first_valid_seq(prb));
	console_write_pending_messages(CONSOLE_MODE_REPLAY_ALL);
}



Problems:

   a) The same line might be printed by more contexts.
   b) per-console kthreads?


Ad a) I am not sure if we could prevent duplicated lines when
      the nested IRQ/NMI writes the same message that is just
      being written by the outer context. But it should be
      an acceptable corner case.

Ad b) Everything will get much more complicated with per-console
      kthreads. We will need counters and buffers for each console
      and each context.


This is what I was able to come up before leaving for vacation. I am
not sure if it is the best design/naming and it if it has a chance
to work.

But it looks like a way how to re-use the same code in all modes.
It might help to see what is the same and what is special about each
mode.


I would prefer to see something like this instead of the completely
different code paths for atomic consoles that are proposed by 7th
patch of this patchset.

Best Regards,
Petr
