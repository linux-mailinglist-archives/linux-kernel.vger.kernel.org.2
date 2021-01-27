Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36E13064ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhA0USR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:18:17 -0500
Received: from mail.efficios.com ([167.114.26.124]:45632 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhA0USM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:18:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 516C330F689;
        Wed, 27 Jan 2021 15:17:31 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ogrbrk7BnphO; Wed, 27 Jan 2021 15:17:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E766730F688;
        Wed, 27 Jan 2021 15:17:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E766730F688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1611778651;
        bh=+leZRXJdFr73v2wOBMPKaEsdpmRX+7ymYMomuvOlwdI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=IeNEAhg+M5816C9EU+v8G9hDseQPIuc4eVjah/comqv8YzZ++66gHXsS0kst8ETjd
         9ailI6oBzeG7/k5Pix92jaVTVKUKkWgxwM3/DxDs5j4JPtRvJzTR7Z7Zc4fNNR5m93
         f6+NERd04A8i2PQ04PtTqvPp4o3HJKtG+9xsQKzG7+TEZdYD1oSmcjHQet2sLknKQa
         cpNHdK2BC9BRDslOk0V8AHUhyF8PUYh1Ta4FwGAx+f5wzdgb7YV+d+2AzadCPnE8Nz
         YU31cbFWcwabC4W9DSw940/9drSecjIoetLjxu/7CPwFi4NsPY6eDbQIjBYmFmf6H+
         vE0twynEIBoug==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KbrgJXCyXWIL; Wed, 27 Jan 2021 15:17:30 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id CC9CA30F619;
        Wed, 27 Jan 2021 15:17:30 -0500 (EST)
Date:   Wed, 27 Jan 2021 15:17:30 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>
Cc:     paulmck <paulmck@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matt Mullins <mmullins@mmlx.us>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1522990896.370.1611778650694.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210127141617.047d5b78@gandalf.local.home>
References: <20210127123951.14f8d321@gandalf.local.home> <2075610164.123.1611770446483.JavaMail.zimbra@efficios.com> <20210127130714.4ec189d5@gandalf.local.home> <119550773.160.1611771202224.JavaMail.zimbra@efficios.com> <20210127141617.047d5b78@gandalf.local.home>
Subject: Re: [PATCH v4] tracepoint: Do not fail unregistering a probe due to
 memory failure
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF84 (Linux)/8.8.15_GA_3996)
Thread-Topic: tracepoint: Do not fail unregistering a probe due to memory failure
Thread-Index: M6fyWD3C0j5LokOsjUEU/bzk7xoN4Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 27, 2021, at 2:16 PM, rostedt rostedt@goodmis.org wrote:

> On Wed, 27 Jan 2021 13:13:22 -0500 (EST)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> > Thanks for bringing that up.
>> 
>> Requiring an RCU synchronize on element removal is quite intrusive, and can
>> be problematic if tracepoint removal is called from e.g. preempt-off context.
> 
> But how often do you remove more than one callback from the same
> tracepoint? Or should I say, from a lot of tracepoints?
> 
> This will only synchronize for the following case:
> 
> Add three callbacks to a single tracepoint.
> Remove the first one.
>    <rcu callback to update the counters>
> Remove the second one
>   <triggers a synchronization if the counters have not been finished
>    updating>
> Remove the third one.
>   <no synchronization needed, because it's being freed>
> 
> And we may be able to make this work in batch too.
> 
> More to come, but I really like this approach over the others because it
> does not increase the size of the kernel for a failure that should never
> happen in practice.

My concern with introducing a scheme based on synchronize_rcu to handle out-of-memory
scenarios is not about how frequently synchronize_rcu will be called, but
about the added complexity this adds to the tracepoints insertion/removal.
This has chances to explode in unlikely scenarios, which will become harder to test
for. This will also introduce constraints on which kernel context can perform
tracepoint removal.

I notice that the error report which leads to this v4 is against v2 of the patch [1],
which has known issues. I wonder whether there are any such issues with v3, which is
using a function stub ? [2]

The main concern I had about v3 of the patch was that the prototype of the
stub (void argument list) does not match the prototype of the called function. As
discussed in [2], there are other scenarios where the kernel expects this to work,
based on the expectation that all architectures supported by the Linux kernel have
a calling convention where the caller performs the clean-up.

So I would prefer the approach taken in v3 rather than adding the kind of complexity
introduced in v4. Ideally we should document, near the stub function, that this
expects the calling convention to have the caller perform the clean-up (cdecl family),
and that the returned type (void) of the function always match. It's only the arguments
which may differ.

There is still one thing that I'm not 100% sure about. It's related to this comment
from Kees Cook [3], hinting that in a CFI build the function prototype of the call
site and the function need to match. So do we need extra annotation of the stub function
to make this work in a CFI build ?

Thanks,

Mathieu

[1] https://lore.kernel.org/bpf/20201117211836.54acaef2@oasis.local.home/
[2] https://lore.kernel.org/bpf/20201118093405.7a6d2290@gandalf.local.home/
[3] https://lore.kernel.org/bpf/202011171330.94C6BA7E93@keescook/
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
