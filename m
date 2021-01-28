Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587E530686A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 01:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhA1ALj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 19:11:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231158AbhA1AKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 19:10:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0491164DD4;
        Thu, 28 Jan 2021 00:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611792579;
        bh=yIpnzFhNO8N5c81rba3vMGRndNhLraXNGRD2B4tTl70=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JoF8gimer+Mt/jrIl4dXfxH+0bSuhkYTJBBVrCqI7ppCwLVoM5shYYUCJrjT1s/JI
         tNUXWBhLOrHEgu8sKcd+ZiRK3ksioiMx/74ywrLJsTRn7IOF2c1f+HVL3N2Y9Z2nAN
         ZoNXHGk8JFhRCCM6pqo6tYTtPIfPvTCvTyyAwxQMfivf/RoG3OfW9TBqeA1vLY5vzB
         WX+71wAUk1r18HPIjbB8oLwbU3wb/GdYYUuMom2jdbW+PN5HDpcBM2QgFN+0vRXCAV
         8puZKwa0zD6gpDnbXUOdGFyk8YUTEsETLlc1VEw8dp/G9oTKMgQahMLwy3d8sqNUpL
         OK2GiHwV69vCg==
Date:   Thu, 28 Jan 2021 09:09:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jianlin Lv <Jianlin.Lv@arm.com>, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/kprobe: Fix to support kretprobe events on
 unloaded modules
Message-Id: <20210128090935.719ac21fbfa2b6cfc91dea9c@kernel.org>
In-Reply-To: <20210127172950.7911317a@gandalf.local.home>
References: <161176187132.1067016.8118042342894378981.stgit@devnote2>
        <20210127172950.7911317a@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 17:29:50 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 28 Jan 2021 00:37:51 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Fix kprobe_on_func_entry() returns error code instead of false so that
> > register_kretprobe() can return an appropriate error code.
> > 
> > append_trace_kprobe() expects the kprobe registration returns -ENOENT
> > when the target symbol is not found, and it checks whether the target
> > module is unloaded or not. If the target module doesn't exist, it
> > defers to probe the target symbol until the module is loaded.
> > 
> > However, since register_kretprobe() returns -EINVAL instead of -ENOENT
> > in that case, it always fail on putting the kretprobe event on unloaded
> > modules. e.g.
> > 
> > Kprobe event:
> > /sys/kernel/debug/tracing # echo p xfs:xfs_end_io >> kprobe_events
> > [   16.515574] trace_kprobe: This probe might be able to register after target module is loaded. Continue.
> > 
> > Kretprobe event: (p -> r)
> > /sys/kernel/debug/tracing # echo r xfs:xfs_end_io >> kprobe_events
> > sh: write error: Invalid argument
> > /sys/kernel/debug/tracing # cat error_log
> > [   41.122514] trace_kprobe: error: Failed to register probe event
> >   Command: r xfs:xfs_end_io
> >              ^
> > 
> > To fix this bug, change kprobe_on_func_entry() to detect symbol lookup
> > failure and return -ENOENT in that case. Otherwise it returns -EINVAL
> > or 0 (succeeded, given address is on the entry).
> > 
> > Reported-by: Jianlin Lv <Jianlin.Lv@arm.com>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Is this something that should go to stable? And if so, can you supply a
> Fixes tag?

Yes, I thought that had not supported previously, but that's wrong.
I found below commit introduced -ENOENT check in trace_kprobe side.

Fixes: 59158ec4aef7 ("tracing/kprobes: Check the probe on unloaded module correctly")

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
