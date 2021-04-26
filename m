Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CF936BAED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 23:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhDZVEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 17:04:46 -0400
Received: from mail.efficios.com ([167.114.26.124]:54596 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhDZVEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:04:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 48122336A25;
        Mon, 26 Apr 2021 17:04:02 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TT8qq_pO4H4R; Mon, 26 Apr 2021 17:04:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B18E23365CB;
        Mon, 26 Apr 2021 17:04:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B18E23365CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1619471040;
        bh=PJMFRcdlYlSTotth+bS33v5PRFTjXdp5c2MQmYDL5qg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=PHgIIfXcgvUSY6fosk3/hP8KpDzcivD0zJTF4NXcOIP63f82+yelYvYben9Wflmim
         5Df/9oeZ590NCpuj0PRMTXBP9SIPw0aIOgHDh1hBtzkKhw8q2QL1uKAERerixOVsrj
         d9/TaqYWrEh/2DmvH6BvIhiBgIevNXMaHJT8aiEXZksb/XBE/DM8fnaoOZGFhxGWPk
         O2dwwSb9aS+Ppp8tjrI4JGfg6jFOTdtdQzS/ZVDrv/9BivnxwFcS/QSvQwgI0Q2+Za
         6F/Clf6o8mBrc/Jju8aFPHiysx3eQ9SdE/vZ6WpMCjtaxbyeXKIwUGdZ0Co9KU/1Zi
         BPu9ZotGR00Uw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HEWi4wfzbFc2; Mon, 26 Apr 2021 17:04:00 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 9FE31336772;
        Mon, 26 Apr 2021 17:04:00 -0400 (EDT)
Date:   Mon, 26 Apr 2021 17:04:00 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <626936290.15030.1619471040515.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210426154539.GA5166@redhat.com>
References: <20210426154539.GA5166@redhat.com>
Subject: Re: [PATCH RESEND] ptrace: make ptrace() fail if the tracee changed
 its pid unexpectedly
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: ptrace: make ptrace() fail if the tracee changed its pid unexpectedly
Thread-Index: DJ2l2EB58ssqB3CFC2OC8lQgmrnIXA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 26, 2021, at 11:45 AM, Oleg Nesterov oleg@redhat.com wrote:

> Suppose we have 2 threads, the group-leader L and a sub-theread T,
> both parked in ptrace_stop(). Debugger tries to resume both threads
> and does
> 
>	ptrace(PTRACE_CONT, T);
>	ptrace(PTRACE_CONT, L);
> 
> If the sub-thread T execs in between, the 2nd PTRACE_CONT doesn not
> resume the old leader L, it resumes the post-exec thread T which was
> actually now stopped in PTHREAD_EVENT_EXEC. In this case the
> PTHREAD_EVENT_EXEC event is lost, and the tracer can't know that the
> tracee changed its pid.
> 
> This patch makes ptrace() fail in this case until debugger does wait()
> and consumes PTHREAD_EVENT_EXEC which reports old_pid. This affects all
> ptrace requests except the "asynchronous" PTRACE_INTERRUPT/KILL.
> 
> The patch doesn't add the new PTRACE_ option to not complicate the API,
> and I _hope_ this won't cause any noticeable regression:
> 
>	- If debugger uses PTRACE_O_TRACEEXEC and the thread did an exec
>	  and the tracer does a ptrace request without having consumed
>	  the exec event, it's 100% sure that the thread the ptracer
>	  thinks it is targeting does not exist anymore, or isn't the
>	  same as the one it thinks it is targeting.
> 
>	- To some degree this patch adds nothing new. In the scenario
>	  above ptrace(L) can fail with -ESRCH if it is called after the
>	  execing sub-thread wakes the leader up and before it "steals"
>	  the leader's pid.

Hi Oleg,

Is this something that should also target stable kernels ? AFAIU this change
won't break debuggers more that they are already in this scenario. Or maybe
it makes them fail in more obvious ways ?

Thanks,

Mathieu
 
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
