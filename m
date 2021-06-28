Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E9F3B65AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhF1PdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235677AbhF1PHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:07:00 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A6461457;
        Mon, 28 Jun 2021 14:52:42 +0000 (UTC)
Date:   Mon, 28 Jun 2021 10:52:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: syslog: close window between wait
 and read
Message-ID: <20210628105240.4fc1be2e@oasis.local.home>
In-Reply-To: <YNneRIEIa7pHahTu@alley>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
        <20210624111148.5190-7-john.ogness@linutronix.de>
        <20210625093354.12384711@oasis.local.home>
        <YNneRIEIa7pHahTu@alley>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 16:35:48 +0200
Petr Mladek <pmladek@suse.com> wrote:

> I was double checking the code and the locking is really hard to
> follow. I would if the following approach make it easier. The main
> trick is that the lock is taken at the beginnig and release at
> the end. It is only temporary released around a single line
> when needed.
> 
> static int syslog_print(char __user *buf, int size)
> {
> 	struct printk_info info;
> 	struct printk_record r;
> 	char *text;
> 	int len = 0;
> 	u64 seq;
> 
> 	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
> 	if (!text)
> 		return -ENOMEM;
> 
> 	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
> 
> 	mutex_lock(&syslog_lock);
> 
> 	/*
> 	 * Wait for the @syslog_seq record to be vailable. @syslog_seq may
> 	 * change while waiting.
> 	 */
> 	do {
> 		seq = syslog_seq;
> 
> 		mutex_unlock(&syslog_lock);
> 		len = wait_event_interruptible(log_wait, prb_read_valid(prb, seq, NULL));
> 		mutex_lock(&syslog_lock);
> 
> 		if (len)
> 			goto out;
> 	} while (syslog_seq != seq);
> 
> 	/*
> 	 * Copy records that fit into the buffer. The above cycle makes sure
> 	 * that the first record is always available.
> 	 */
> 	do {
> 		size_t n;
> 		size_t skip;
> 		unsigned long err;
> 
> 		if (!prb_read_valid(prb, syslog_seq, &r))
> 			break;
> 
> 		if (r.info->seq != syslog_seq) {
> 			/* message is gone, move to next valid one */
> 			syslog_seq = r.info->seq;
> 			syslog_partial = 0;
> 		}
> 
> 		/*
> 		 * To keep reading/counting partial line consistent,
> 		 * use printk_time value as of the beginning of a line.
> 		 */
> 		if (!syslog_partial)
> 			syslog_time = printk_time;
> 
> 		skip = syslog_partial;
> 		n = record_print_text(&r, true, syslog_time);
> 		if (n - syslog_partial <= size) {
> 			/* message fits into buffer, move forward */
> 			syslog_seq = r.info->seq + 1;
> 			n -= syslog_partial;
> 			syslog_partial = 0;
> 		} else if (!len){
> 			/* partial read(), remember position */
> 			n = size;
> 			syslog_partial += n;
> 		} else
> 			n = 0;
> 
> 		if (!n)
> 			break;
> 
> 		mutex_unlock(&syslog_lock);
> 		err = copy_to_user(buf, text + skip, n);
> 		mutex_lock(&syslog_lock);
> 
> 		if (err && !len) {
> 			len = -EFAULT;
> 			break;
> 		}
> 
> 		len += n;
> 		size -= n;
> 		buf += n;
> 	} while(size);
> out:
> 	mutex_unlock(&syslog_lock);
> 	kfree(text);
> 	return len;
> }

That's a much more common approach to locking, that may not be as
efficient, but is much easier to keep straight, and less error prone.

-- Steve
