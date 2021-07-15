Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD3D3CAD65
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbhGOUA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244114AbhGOT5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:57:03 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 632E6613D0;
        Thu, 15 Jul 2021 19:54:07 +0000 (UTC)
Date:   Thu, 15 Jul 2021 15:54:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH] tracing: Do no reference char * as a string in
 histograms
Message-ID: <20210715155400.28f0dfd0@oasis.local.home>
In-Reply-To: <17b88fc429ddd354cff468849bc16de25086df2d.camel@kernel.org>
References: <20210715000206.025df9d2@rorschach.local.home>
        <17b88fc429ddd354cff468849bc16de25086df2d.camel@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 12:04:13 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Not sure what the correct fix is at this point, but it would seem that
> if the original intent was honored, the histogram code should still be
> allowed to use them.

Note, it can in a patch I plan on sending in the next merge window that
Tzvetomir and I are working on. We succeeded in getting the "eprobe"
working which allows you to do much more with event fields than the
current histogram code does.

Otherwise, I need a way to get the pointer and not a string. As I
discovered, the string may not have any content in it, and you can't
fault within a tracepoint, and you are left with just passing in
"(fault)", or something. Which is not useful at all!

What we have as a working prototype is this:

 # cd /sys/kernel/tracing
 # echo 'e:myopen syscalls.sys_enter_openat file=$filename:ustring' > kprobe_events
 # trace-cmd start -e myopen -F ~/bin/openat
 # cat trace
          openat-1928    [000] ...2  1540.638692: myopen: (0) file="/etc/ld.so.cache"
          openat-1928    [000] ...2  1540.638692: myopen: (0) file="/lib64/libc.so.6"
          openat-1928    [000] ...2  1540.638694: myopen: (0) file=(fault)


And if we were to enforce this on a histogram, all we will see is
"fault" because the filename is first referenced inside the system call
and at the beginning of the call, it is not mapped in, and we can not
map it in inside a tracepoint. You are left with just putting in some
stub string (which kprobes uses "(fault)").

But, because now filename is a pointer, that the histograms can pass
around, it is much more useful, as I can use this to pass the filename
pointer to the exit of the system call!

 # echo 'hist:keys=common_pid:f=filename' > events/syscalls/sys_enter_openat/trigger
 # echo 'openret unsigned long file; long ret' > synthetic_events
 # echo 'hist:keys=common_pid:file=$f:onmatch(syscalls.sys_enter_openat).trace(openret,$file,ret)' > events/syscalls/sys_exit_openat/trigger
 # echo 'e:myopen synthetic.openret file=$file:ustring ret=$ret:s64' > kprobe_events
 # trace-cmd start -e myopen -F ~/bin/openat
 # cat trace
          openat-1994    [002] ...3  2052.403323: myopen: (0) file="/etc/ld.so.cache" ret=3
          openat-1994    [002] ...3  2052.403350: myopen: (0) file="/lib64/libc.so.6" ret=3
          openat-1994    [002] ...3  2052.403555: myopen: (0) file="/etc/passwd" ret=3

Now, not only can we see the filename, because we passed the pointer
from the sys_enter to the sys_exit, we also can show the return of the
system call.

This allows for a much more flexibility than the histograms by
themselves have. If you want the file names via pointers, you can then
create these event_probes and use them in the histograms as well. Which
gives you the full flexibility of kprobes but on the fields of events.

Note, without this patch, because the histograms thinks 'char *' is a
string, you can't pass the pointer, but only the string. Hence, you
only get "(fault)", which is pretty darn useless.

This is another rationale for why I want this patch.

FYI, the above is cut and paste from working code, but it still needs a
bit of clean up before we post it.

-- Steve
