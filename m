Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F31E3DB7A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 13:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbhG3LIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 07:08:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50778 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbhG3LIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 07:08:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8651221FF;
        Fri, 30 Jul 2021 11:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627643320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0GCLZk8me0mqnrvY5RsB3WmpgnQwWsOmJ1mrttu8VmU=;
        b=gwqfBLaFwsRoFJyinjfeD5kSQv+2OdUGn7wbcyKOBbCb0QjY0yb9mNIp8kcYMOrP6aNaCQ
        SUztSEkud1gzLAVF1AKAAYfjjEwY+uzmqwBWRJuhzq1B9YWQtOh4jLr9ImUEijqMASX8U4
        nSwsAqILQ9GhtyRcu1mAQm/+iNI9sMM=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BD2C0A3B8B;
        Fri, 30 Jul 2021 11:08:40 +0000 (UTC)
Date:   Fri, 30 Jul 2021 13:08:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/nmi_backtrace: Serialize even messages about idle
 CPUs
Message-ID: <YQPdt5tDmI1wtE2s@alley>
References: <20210727080939.27193-1-pmladek@suse.com>
 <87r1fjiwsn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1fjiwsn.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-07-27 17:53:04, John Ogness wrote:
> On 2021-07-27, Petr Mladek <pmladek@suse.com> wrote:
> > The commit 55d6af1d66885059ffc2a ("lib/nmi_backtrace: explicitly serialize
> > banner and regs") serialized backtraces from more CPUs using the re-entrant
> > printk_printk_cpu lock. It was a preparation step for removing the obsolete
> > nmi_safe buffers.
> >
> > The single-line messages about idle CPUs were not serialized against other
> > CPUs and might appear in the middle of backtrace from another CPU,
> > for example:
> >
> > [56394.590068] NMI backtrace for cpu 2
> > [56394.590069] CPU: 2 PID: 444 Comm: systemd-journal Not tainted 5.14.0-rc1-default+ #268
> > [56394.590071] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> > [56394.590072] RIP: 0010:lock_is_held_type+0x0/0x120
> > [56394.590071] NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0xb/0x10
> > [56394.590076] Code: a2 38 ff 0f 0b 8b 44 24 04 eb bd 48 8d ...
> > [56394.590077] RSP: 0018:ffffab02c07c7e68 EFLAGS: 00000246
> > [56394.590079] RAX: 0000000000000000 RBX: ffff9a7bc0ec8a40 RCX: ffffffffaab8eb40
> >
> > It might cause confusion what CPU the following lines belongs to and
> > whether the backtraces are really serialized.
> 
> I originally implemented this, but later decided against it because it
> causes idle CPUs to begin busy-waiting in NMI context in order to log a
> single line saying they are idle. If the user is aware that there is
> only 1 line for the idle message, then the user knows that it isn't
> causing a problem for reading the stack trace.
> 
> When triggering many such dumps on systems with many CPUs where this
> patch is applied, it seemed like I was making the whole system work
> awfully hard for something that should be trivial.

I understand the concern. I am not super happy with it as well.

> Considering that dump_stack() and show_regs() should be fast and we are
> only dumping to the lockless buffer, it is probably OK to be doing all
> the busy-waiting. Once atomic consoles are introduced, it will have
> quite an impact here, but atomic consoles are mostly only active on
> system crash, so I think that would be OK as well.

Also the single line is printed only on idle CPUs. They have nothing
else to do anyway ;-)

I have pushed the patch into printk/linux.git, branch
rework/printk_safe-removal.

We could always revert it when there are some problems with it.

Best Regards,
Petr
