Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049FA345D90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCWMBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:01:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:42144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230289AbhCWMBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:01:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616500876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eVaO/6su5YYdXq23LoZme4279o571SC3c8oBt0pYyUo=;
        b=KvnwGgWIbobBFmDgXIAKsYuFFW4s1EUIIbQNxqDL6yu5yYSRSmPSBf7mHInV/uo7m7MmSC
        I5yjS0QE3dYBcze20dmmgI1WXC74TJ+7VBFEkYiOUSAFQy53D0nXUcZIvWrLsl6CdzWXTe
        f1EBer19myslGPi/I4ofHTms6l5bUFs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80B1DAD6D;
        Tue, 23 Mar 2021 12:01:16 +0000 (UTC)
Date:   Tue, 23 Mar 2021 13:01:13 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v1 3/3] printk: convert @syslog_lock to spin_lock
Message-ID: <YFnYiQX99oVv3JpU@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316233326.10778-4-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-03-17 00:33:26, John Ogness wrote:
> @syslog_log was a raw_spin_lock to simplify the transition of

s/syslog_log/syslog_lock/

Same problem is also below.

> removing @logbuf_lock and the safe buffers. With that transition
> complete, @syslog_log can become a spin_lock.

I know that we already talked about this. But I want to be sure
that this patch makes sense.

It will actually not change the behavior because we always
take the lock with interrupts disabled.

We disable the interrupts because register_console() is called
in IRQ context on parisc in handle_interruption() when it is
going to panic (code == 1 => will call parisc_terminate()).

Disabling IRQ will not help in parisc_terminate(). This code
path is non-maskable and never returns. The deadlock might be
prevented only by trylock.

trylock on syslog_lock is only small problem. Much bigger is
is a deadlock on console_lock. Fixing this is beyond this
patchset.

Summary:

    + disabling IRQ does not help for parisc

    + register_console() is not irq safe in general because
      of the sleeping console_lock.


I would personally prefer to remove both "raw" and "irq"
in this patch and just document the problem with parisc
in the commit message.

IMHO, it does not make sense to keep _irq when it neither
helps nor makes sense.

Best Regards,
Petr
