Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA531899D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhBKLh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:37:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:41968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbhBKLGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 06:06:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613041552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMJzRr/L4i/Dq4M8UHSKGZOZ6wJPLPyiWgD0VYdU+Bk=;
        b=YqY7bmv95n/xGzpd+Q/ZohZU1eDHEHg1lAbKJHPKWusDvnnVZx0TwMvx8zXwdleIGN4raH
        zciHp1cgtkvgn4WTAsLQm+JfhqrsehAyv/EqbYoqWeWqDqWwuX1RvQC2WjJsv0TdOqQNZC
        3B2cQkV4gGfFHWQ0lFU8s9wKi4jz2VE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43CD7AD2B;
        Thu, 11 Feb 2021 11:05:52 +0000 (UTC)
Date:   Thu, 11 Feb 2021 12:05:51 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, "J. Avila" <elavila@google.com>
Subject: Re: [PATCH] printk: avoid prb_first_valid_seq() where possible
Message-ID: <YCUPj5MK9mA65ST2@alley>
References: <20210205141728.18117-1-john.ogness@linutronix.de>
 <YCLKvCNJwabVavAP@alley>
 <874kij4w59.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kij4w59.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-02-10 19:32:10, John Ogness wrote:
> On 2021-02-09, Petr Mladek <pmladek@suse.com> wrote:
> >> @@ -1629,9 +1631,13 @@ int do_syslog(int type, char __user *buf, int len, int source)
> >>  	/* Number of chars in the log buffer */
> >>  	case SYSLOG_ACTION_SIZE_UNREAD:
> >>  		logbuf_lock_irq();
> >> -		if (syslog_seq < prb_first_valid_seq(prb)) {
> >> -			/* messages are gone, move to first one */
> >> -			syslog_seq = prb_first_valid_seq(prb);
> >> +		if (prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
> >> +			if (info.seq != syslog_seq) {
> >> +				/* messages are gone, move to first one */
> >> +				syslog_seq = info.seq;
> >> +				syslog_partial = 0;
> >> +			}
> >> +		} else {
> >>  			syslog_partial = 0;
> >
> > I am scratching my head when prb_read_valid_info(prb,
> > syslog_seq, &info, NULL)) might fail.
> 
> It can fail because the descriptor has been invalidated/recycled by
> writers and perhaps there is no valid record that has yet come after it.

I see. From some reasons I though that there should always be at
least one message in the commited state. But it is enough when
it is in reusable state. I should have double checked it.

> I recommend changing your suggestion to:
> 
> > 		if (!prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
> >			/*
> >			 * No unread messages. No need to check/reset
> >			 * syslog_partial. When a reader does read a new
> >			 * message it will notice and appropriately update
> >			 * syslog_seq and reset syslog_partial.
> >			 */

The following comment might be enough after all.

			/* No unread messages. */

My main concern was that we cleared syslog_partial and continued.
I thought that we might miss a bug this way. But it seems to
be perfectly fine. I just have to update my mental picture.

Otherwise. the fact that syslog_partial will be fixed by the next
successful call is more or less obvious if we change the code as you
propose.

Please, send an updated patch.

Best Regards,
Petr


> > 			logbuf_unlock_irq();
> > 			return 0;
> > 		}
> > 		if (info.seq != syslog_seq) {
> > 			/* messages are gone, move to first one */
> > 			syslog_seq = info.seq;
> > 			syslog_partial = 0;
> > 		}
> 
> John Ogness
