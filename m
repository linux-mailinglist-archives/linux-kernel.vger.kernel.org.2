Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92BD3D7A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbhG0PrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:47:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52240 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbhG0PrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:47:05 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627400824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H51/ZMeUA6zob6PAMZW3rybS6Qc5B+5JqVVSJ4UAVf0=;
        b=bJ5MjfbMALMw7FCxm5YowjNggn76UJj28M4xw6Qo0rDyxK7BzaEAsn2pAEIW/UiF5E69K4
        MSvmwiaHkAn0NFOyZWfNnkrkuH06jp4hUq8eeI6W5pyj/GKOJpRcILQQHVSYdCO9CxduaH
        SdCjpSQZA7dNgZNwbaZI8vmugr8h5xjtOGOs8sqH5GnSzvwkdQmXg1CBwHsCuFmaId98R6
        jjx2jhfKqd4Wycm4l+NxdIQEApMz/eQB9Lg75bpBud+a+DWqid6zh2zh1FUuHRXN5qAMdA
        u/yNb7lp8XAwR9IT5pxmP2g4v2vkBceO0IWErztzuTaBfKPM923gq1Aiq+1A2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627400824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H51/ZMeUA6zob6PAMZW3rybS6Qc5B+5JqVVSJ4UAVf0=;
        b=/S3LjABpVWj4DP84AjSomx06YKOk/MUBldyezeByvu0w+xxFk7gaF+YVUTGoxekMqc4xkk
        R+L7EKZx1RSWnvCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] lib/nmi_backtrace: Serialize even messages about idle CPUs
In-Reply-To: <20210727080939.27193-1-pmladek@suse.com>
References: <20210727080939.27193-1-pmladek@suse.com>
Date:   Tue, 27 Jul 2021 17:53:04 +0206
Message-ID: <87r1fjiwsn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-27, Petr Mladek <pmladek@suse.com> wrote:
> The commit 55d6af1d66885059ffc2a ("lib/nmi_backtrace: explicitly serialize
> banner and regs") serialized backtraces from more CPUs using the re-entrant
> printk_printk_cpu lock. It was a preparation step for removing the obsolete
> nmi_safe buffers.
>
> The single-line messages about idle CPUs were not serialized against other
> CPUs and might appear in the middle of backtrace from another CPU,
> for example:
>
> [56394.590068] NMI backtrace for cpu 2
> [56394.590069] CPU: 2 PID: 444 Comm: systemd-journal Not tainted 5.14.0-rc1-default+ #268
> [56394.590071] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [56394.590072] RIP: 0010:lock_is_held_type+0x0/0x120
> [56394.590071] NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0xb/0x10
> [56394.590076] Code: a2 38 ff 0f 0b 8b 44 24 04 eb bd 48 8d ...
> [56394.590077] RSP: 0018:ffffab02c07c7e68 EFLAGS: 00000246
> [56394.590079] RAX: 0000000000000000 RBX: ffff9a7bc0ec8a40 RCX: ffffffffaab8eb40
>
> It might cause confusion what CPU the following lines belongs to and
> whether the backtraces are really serialized.

I originally implemented this, but later decided against it because it
causes idle CPUs to begin busy-waiting in NMI context in order to log a
single line saying they are idle. If the user is aware that there is
only 1 line for the idle message, then the user knows that it isn't
causing a problem for reading the stack trace.

When triggering many such dumps on systems with many CPUs where this
patch is applied, it seemed like I was making the whole system work
awfully hard for something that should be trivial.

Considering that dump_stack() and show_regs() should be fast and we are
only dumping to the lockless buffer, it is probably OK to be doing all
the busy-waiting. Once atomic consoles are introduced, it will have
quite an impact here, but atomic consoles are mostly only active on
system crash, so I think that would be OK as well.

Feel free to add:

Reviewed-by: John Ogness <john.ogness@linutronix.de>
