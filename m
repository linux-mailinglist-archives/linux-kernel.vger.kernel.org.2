Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4853919EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhEZOV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234096AbhEZOVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:21:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C0F061248;
        Wed, 26 May 2021 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622038824;
        bh=o7LDYAS4HfE7cCCWNy5DV9wNf+3T7eAq6p3G+I2eXqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CebbaxlQGcwFSBpCnWx3W4lVbOuIOcCFJ5f1Q0bEQb/jry/nnCE3XmKLt+sbssbwi
         /zYZpxkEAs17uSdOeAa0J8sxuiMEL2ZHlXPLQkzYf0doTeH/OX/n03S1kqhWTpdGio
         42wwdVMzrsp5J/oiYISO+CqRwAQm8ljPFMxEw/zP2OL6Ud0E1zCpuSE4pcraaf6LRf
         YkSgJl9xo1x3BtAgQzSqmuuTgjmZ4EOHPe7UyVSdPYRrAiZjWZ0lL81U8ZEeWX/hwx
         MOijTdWDPXHe953SR21RRZpFZ/1m8oBCroZIqJxTsCNMc4idBh2aMqnt8lsgWKaKxV
         0b3QujrKXQCVQ==
Date:   Wed, 26 May 2021 23:20:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf probe: Provide more detail with relocation warning
Message-Id: <20210526232020.c1632c2285af811c7531b3cc@kernel.org>
In-Reply-To: <YK5FfaxFKUNdDBWz@kernel.org>
References: <20210525043744.193297-1-ravi.bangoria@linux.ibm.com>
        <20210525214858.33a66846ac09e499c3268a63@kernel.org>
        <05e32c82-1009-03ba-d973-8b1bc0582ce2@linux.ibm.com>
        <20210526153340.a49ba8292f201493990f210c@kernel.org>
        <YK5FfaxFKUNdDBWz@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 09:56:29 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Wed, May 26, 2021 at 03:33:40PM +0900, Masami Hiramatsu escreveu:
> > On Wed, 26 May 2021 10:23:18 +0530 Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:
> > > On 5/25/21 6:18 PM, Masami Hiramatsu wrote:
> > > > On Tue, 25 May 2021 10:07:44 +0530 Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:
> 
> > > >> When run as normal user with default sysctl kernel.kptr_restrict=0
> > > >> and kernel.perf_event_paranoid=2, perf probe fails with:
> 
> > > >>    $ ./perf probe move_page_tables
> > > >>    Relocated base symbol is not found!
> 
> > > >> The warning message is not much informative. The reason perf
> > > >> fails is because /proc/kallsyms is restricted by
> > > >> perf_event_paranoid=2 for normal user and thus perf fails to read
> > > >> relocated address of the base symbol.
> 
> > > >> Tweaking kptr_restrict and perf_event_paranoid can change the
> > > >> behavior of perf probe. Also, running as root or privileged user
> > > >> works too. Add these details in the warning message.
> 
> > > >> Plus, kmap->ref_reloc_sym might not be always set even if
> > > >> host_machine is initialized. Above is the example of the same.
> > > >> Remove that comment.
> 
> > > > Yes, those are restricted in some cases. Anyway without priviledged
> > > > (super) user, perf probe can not set the probe in ftrace.
> 
> > > > Hmm, I think it should check the effective user-id at first. If it
> > > > is not super user and the action will access tracefs and kallsyms,
> > > > it should warn at that point.
> 
> > > If kptr_restrict=2, perf probe fails with same error even for root user.
> > > That's why I thought to just change this warning message.
> 
> > Ah, yes. In that case, perf probe must not use the base symbol.
> > (like -D option)
> > OK, then, let's merge this fix.
> 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks, applied as it improves the current situation.
> 
> But as a follow up, to further improve this, we can reuse what 'perf trace' has:
> 
>   $ perf trace sleep 1
>   Error:	No permissions to read /sys/kernel/tracing/events/raw_syscalls/sys_(enter|exit)
>   Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'
>   $ sudo mount -o remount,mode=755 /sys/kernel/tracing/
>   $ perf trace sleep 1
>   Error:	Permission denied.
>   Hint:	Check /proc/sys/kernel/perf_event_paranoid setting.
>   Hint:	For your workloads it needs to be <= 1
>   Hint:	For system wide tracing it needs to be set to -1.
>   Hint:	Try: 'sudo sh -c "echo -1 > /proc/sys/kernel/perf_event_paranoid"'
>   Hint:	The current value is 2.
>   $ 

OK, let me check this.
BTW, does perf_event_paranoid affect only perf syscall (and kallsyms),
not the tracefs correct?

> I.e. go the extra step and show what the current value is and what it
> needs to be to achieve what is being attempted.
> 
> IOW combine error message with relevant documentation, to save steps.
> 
> See what 'perf top' does for an unpriv user:
> 
>   $ perf top --stdio
>   Error:
>   Access to performance monitoring and observability operations is limited.
>   Enforced MAC policy settings (SELinux) can limit access to performance
>   monitoring and observability operations. Inspect system audit records for
>   more perf_event access control information and adjusting the policy.
>   Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
>   access to performance monitoring and observability operations for processes
>   without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
>   More information can be found at 'Perf events and tool security' document:
>   https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
>   perf_event_paranoid setting is 2:
>     -1: Allow use of (almost) all events by all users
>         Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>   >= 0: Disallow raw and ftrace function tracepoint access
>   >= 1: Disallow CPU event access
>   >= 2: Disallow kernel profiling
>   To make the adjusted perf_event_paranoid setting permanent preserve it
>   in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)

Hmm, I would rather like pointing manpages...

Would we better to have perf-security.7 manpage?

Thank you,

>   $
> 
> - Arnaldo
> 
> > 
> > > 
> > > Different combinations of privilege, perf_event_paranoid, kptr_restrict:
> > > 
> > >    Normal/Root user
> > >     |   perf_event_paranoid
> > >     V    V   kptr_restrict        perf probe error
> > >    ----------------------------------------------------------------
> > >     N   -1    0     Failed to open kprobe_events: Permission denied
> > >     N    0    0     Failed to open kprobe_events: Permission denied
> > >     N    1    0     Failed to open kprobe_events: Permission denied
> > >     N    2    0     Relocated base symbol is not found!
> > >    
> > >     N   -1    1     Relocated base symbol is not found!
> > >     N    0    1     Relocated base symbol is not found!
> > >     N    1    1     Relocated base symbol is not found!
> > >     N    2    1     Relocated base symbol is not found!
> > >    
> > >     N   -1    2     Relocated base symbol is not found!
> > >     N    0    2     Relocated base symbol is not found!
> > >     N    1    2     Relocated base symbol is not found!
> > >     N    2    2     Relocated base symbol is not found!
> > >    
> > >     R   -1    0     No error.
> > >     R    0    0     No error.
> > >     R    1    0     No error.
> > >     R    2    0     No error.
> > >    
> > >     R   -1    1     No error.
> > >     R    0    1     No error.
> > >     R    1    1     No error.
> > >     R    2    1     No error.
> > >    
> > >     R   -1    2     Relocated base symbol is not found!
> > >     R    0    2     Relocated base symbol is not found!
> > >     R    1    2     Relocated base symbol is not found!
> > >     R    2    2     Relocated base symbol is not found!
> > > 
> > > Ravi
> > 
> > 
> > -- 
> > Masami Hiramatsu <mhiramat@kernel.org>
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
