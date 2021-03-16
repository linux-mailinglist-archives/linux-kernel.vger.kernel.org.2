Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FB933D339
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCPLjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:39:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:48336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237389AbhCPLjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:39:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615894746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJJKGQtPc6ZLjVevEUohjEbwmjLdQiOKvhEFooAITDY=;
        b=Pzr/YGcT1IddQeb4YN0YZMfNGB/gkkamJV5hzGqida9hs4Lo4YJ2G087wyywzki8CtCPmQ
        yVFIDPwSoxC0d0aVVevvpOBiYHWjUz2voy4IqZyDhZa3xrDhRfmfO7V5YJ11ASgHZhnb7M
        KvhVnB+A3tBNEwWfq1bG9kSrvmRt7Vw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08A06AC1D;
        Tue, 16 Mar 2021 11:39:06 +0000 (UTC)
Date:   Tue, 16 Mar 2021 12:39:05 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YFCY2VIlpYc6cANM@alley>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <YEtNKMF3KH1kUDxY@alley>
 <YEtyUM07gsqR6ltG@chrisdown.name>
 <YE8wvGHhbV4nAGGI@alley>
 <YE9RK89jLbLQcSEq@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE9RK89jLbLQcSEq@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-03-15 12:20:59, Chris Down wrote:
> Petr Mladek writes:
> > > I don't feel strongly that this is more clear though, so maybe you
> > > mean something else?
> > 
> > I was pretty tired when reviewing the patch. It was not easy for me
> > to create the mental model of the code. I felt that some other names
> > would have made it easier.
> > 
> > Also the tricky pi_next() implementation did not help much. It looks
> > like you changed the code many times to get it working and did not
> > clean it at the end.
> 
> No worries. I'm not totally clear on what you're asking for though: do you
> meant that you'd like the SEQ_START_TOKEN logic to only be present for
> pi_start, or to pull out the logic currently in pi_next into another
> function and call it from both, or?
> 
> In my mind, pi_start is really just a special case of pi_next, so the code
> flow makes sense to me. I'm happy to change it to whatever you like, but
> it's not immediately obvious to me what that is :-)

Good question! I have missed that pi_start() can be called also with non-zero
pos when seeking.

OK, pi_start() has to handle pos == 0 special way, so let's handle it
there. Call pi_next() only when pos != 0.

The following code should do the job. I took this from my previous reply.
It is already based on the other suggested changes:

static struct pi_entry *pi_get_entry(struct module *mod, int idx)
{
	struct pi_entry *entries;
	int num_entries;

	if (mod) {
		entries = mod->entries;
		num_entries = num->num_entries;
	} else {
		entries = vmlinux_entries;
		num_entries = vmlinux_num_entries;
	}

	if (idx >= num_entries)
		return NULL;

	return entries[idx];
}

static void *pi_next(struct seq_file *s, void *v, loff_t *pos)
{
	const struct module *mod = (struct module*)s->file->f_inode->i_private;
	struct pi_entry *entry;

	entry = pi_get_entry(mod, *pos);
	*(pos)++;

	return entry;
}

static void *pi_start(struct seq_file *s, loff_t *pos)
{
	/*
	 * Make show() print the header line. Do not update *pos
	 * because pi_next() still has to return entry on the index zero.
	 */
	if (*pos == 0)
		return SEQ_START_TOKEN;

	return pi_next(s, NULL, pos);
}

Best Regards,
Petr
