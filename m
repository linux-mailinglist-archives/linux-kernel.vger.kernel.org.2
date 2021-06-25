Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213B33B448D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhFYNgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231693AbhFYNgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:36:17 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB31760FE9;
        Fri, 25 Jun 2021 13:33:55 +0000 (UTC)
Date:   Fri, 25 Jun 2021 09:33:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: syslog: close window between wait
 and read
Message-ID: <20210625093354.12384711@oasis.local.home>
In-Reply-To: <20210624111148.5190-7-john.ogness@linutronix.de>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
        <20210624111148.5190-7-john.ogness@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 13:17:48 +0206
John Ogness <john.ogness@linutronix.de> wrote:

> +	 * @syslog_lock is held when entering the read loop to prevent
> +	 * another reader from modifying @syslog_seq.

You should add to the above comment:

	 * And the @syslog_lock is released before exiting the loop.

Because it's not normal to enter a loop locked, and have it unlocked
when exiting the loop. And I can envision in the future, someone might
add a break (for error) while still holding the lock.

-- Steve

> +	 */
> +
> +	for (;;) {
>  		size_t n;
>  		size_t skip;
>  
> -		mutex_lock(&syslog_lock);
>  		if (!prb_read_valid(prb, syslog_seq, &r)) {
>  			mutex_unlock(&syslog_lock);
>  			break;
> @@ -1542,8 +1570,13 @@ static int syslog_print(char __user *buf, int size)
>  		len += n;
>  		size -= n;
>  		buf += n;
> -	}
>  
> +		if (!size)
> +			break;
> +
> +		mutex_lock(&syslog_lock);
> +	}
