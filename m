Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF37306792
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhA0XNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:13:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234488AbhA0XGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:06:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56ABA64DD2;
        Wed, 27 Jan 2021 22:29:52 +0000 (UTC)
Date:   Wed, 27 Jan 2021 17:29:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jianlin Lv <Jianlin.Lv@arm.com>, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/kprobe: Fix to support kretprobe events on
 unloaded modules
Message-ID: <20210127172950.7911317a@gandalf.local.home>
In-Reply-To: <161176187132.1067016.8118042342894378981.stgit@devnote2>
References: <161176187132.1067016.8118042342894378981.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021 00:37:51 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fix kprobe_on_func_entry() returns error code instead of false so that
> register_kretprobe() can return an appropriate error code.
> 
> append_trace_kprobe() expects the kprobe registration returns -ENOENT
> when the target symbol is not found, and it checks whether the target
> module is unloaded or not. If the target module doesn't exist, it
> defers to probe the target symbol until the module is loaded.
> 
> However, since register_kretprobe() returns -EINVAL instead of -ENOENT
> in that case, it always fail on putting the kretprobe event on unloaded
> modules. e.g.
> 
> Kprobe event:
> /sys/kernel/debug/tracing # echo p xfs:xfs_end_io >> kprobe_events
> [   16.515574] trace_kprobe: This probe might be able to register after target module is loaded. Continue.
> 
> Kretprobe event: (p -> r)
> /sys/kernel/debug/tracing # echo r xfs:xfs_end_io >> kprobe_events
> sh: write error: Invalid argument
> /sys/kernel/debug/tracing # cat error_log
> [   41.122514] trace_kprobe: error: Failed to register probe event
>   Command: r xfs:xfs_end_io
>              ^
> 
> To fix this bug, change kprobe_on_func_entry() to detect symbol lookup
> failure and return -ENOENT in that case. Otherwise it returns -EINVAL
> or 0 (succeeded, given address is on the entry).
> 
> Reported-by: Jianlin Lv <Jianlin.Lv@arm.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Is this something that should go to stable? And if so, can you supply a
Fixes tag?

Thanks Masami,

-- Steve
