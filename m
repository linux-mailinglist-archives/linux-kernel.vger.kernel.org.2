Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAA33B6306
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhF1OvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 10:51:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51356 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhF1OiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:38:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E0A53222BC;
        Mon, 28 Jun 2021 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624890948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzl5ets5eB5Dq/q2i/0wuJBZwKopr9+a77SurnLm4X8=;
        b=fZ+7fksWt1bqacMr8vJA/yaRYssQXmpXNZuOl9hzv73i5JUSBSr9x2pfQxTZv67Got1dGy
        247cjtEX1vvQaYRFiOhabUNjPChGq9+xRfRo+k0Sfysx08ivUMIAR1aeKDTVAqQ0NrlrV0
        jd0dRt7VpJlKOw8EZAN1pMkQcmoY70A=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C63DEA3B9E;
        Mon, 28 Jun 2021 14:35:48 +0000 (UTC)
Date:   Mon, 28 Jun 2021 16:35:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: syslog: close window between wait
 and read
Message-ID: <YNneRIEIa7pHahTu@alley>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
 <20210624111148.5190-7-john.ogness@linutronix.de>
 <20210625093354.12384711@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625093354.12384711@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-06-25 09:33:54, Steven Rostedt wrote:
> On Thu, 24 Jun 2021 13:17:48 +0206
> John Ogness <john.ogness@linutronix.de> wrote:
> 
> > +	 * @syslog_lock is held when entering the read loop to prevent
> > +	 * another reader from modifying @syslog_seq.
> 
> You should add to the above comment:
> 
> 	 * And the @syslog_lock is released before exiting the loop.
> 
> Because it's not normal to enter a loop locked, and have it unlocked
> when exiting the loop. And I can envision in the future, someone might
> add a break (for error) while still holding the lock.

I was double checking the code and the locking is really hard to
follow. I would if the following approach make it easier. The main
trick is that the lock is taken at the beginnig and release at
the end. It is only temporary released around a single line
when needed.

static int syslog_print(char __user *buf, int size)
{
	struct printk_info info;
	struct printk_record r;
	char *text;
	int len = 0;
	u64 seq;

	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
	if (!text)
		return -ENOMEM;

	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);

	mutex_lock(&syslog_lock);

	/*
	 * Wait for the @syslog_seq record to be vailable. @syslog_seq may
	 * change while waiting.
	 */
	do {
		seq = syslog_seq;

		mutex_unlock(&syslog_lock);
		len = wait_event_interruptible(log_wait, prb_read_valid(prb, seq, NULL));
		mutex_lock(&syslog_lock);

		if (len)
			goto out;
	} while (syslog_seq != seq);

	/*
	 * Copy records that fit into the buffer. The above cycle makes sure
	 * that the first record is always available.
	 */
	do {
		size_t n;
		size_t skip;
		unsigned long err;

		if (!prb_read_valid(prb, syslog_seq, &r))
			break;

		if (r.info->seq != syslog_seq) {
			/* message is gone, move to next valid one */
			syslog_seq = r.info->seq;
			syslog_partial = 0;
		}

		/*
		 * To keep reading/counting partial line consistent,
		 * use printk_time value as of the beginning of a line.
		 */
		if (!syslog_partial)
			syslog_time = printk_time;

		skip = syslog_partial;
		n = record_print_text(&r, true, syslog_time);
		if (n - syslog_partial <= size) {
			/* message fits into buffer, move forward */
			syslog_seq = r.info->seq + 1;
			n -= syslog_partial;
			syslog_partial = 0;
		} else if (!len){
			/* partial read(), remember position */
			n = size;
			syslog_partial += n;
		} else
			n = 0;

		if (!n)
			break;

		mutex_unlock(&syslog_lock);
		err = copy_to_user(buf, text + skip, n);
		mutex_lock(&syslog_lock);

		if (err && !len) {
			len = -EFAULT;
			break;
		}

		len += n;
		size -= n;
		buf += n;
	} while(size);
out:
	mutex_unlock(&syslog_lock);
	kfree(text);
	return len;
}

Best Regards,
Petr
