Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8CB30630D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhA0SOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:14:06 -0500
Received: from mail.efficios.com ([167.114.26.124]:38944 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhA0SOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:14:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C1AEC30E6DC;
        Wed, 27 Jan 2021 13:13:22 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1IF3V4a3VIbs; Wed, 27 Jan 2021 13:13:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6CE8E30E6DB;
        Wed, 27 Jan 2021 13:13:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6CE8E30E6DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1611771202;
        bh=cYfn5HWOSlweY8sj1X5lxa5xwWuynkhOBEJQzLrcG2M=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=VREkt7F7BsamC+jmtJebqOyrE7Qmtn+KrHjsdzPA79RbveU7iMi1rsUdP/hfhC4PD
         /uJNtPfvwvI7//HFgBoPgn3GOKoXf6KJwfG6lxqrLxh5Mp1C0sa1gpx1nujBS1cmR4
         b4YT4t0ikNmWrmzlQjov5ydXUmLQsNOL1huGmBeuVF+A5fUh9zyu9/Pd7cu4XlDGhZ
         f77nQV5bQ4rNQb5QGdwnHyiV73mrcrkQMeMsMmz//O/GVDcj2jPm+8R448SvaJYXPt
         nq/XtYJExKVscSKrIFlvXW94CZdJODelGY9b65+LWcU8I7jeTDQpf0M8E2e3kOtTFS
         +nNBc8Tgf3sMQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Q6RD3oUhZwkq; Wed, 27 Jan 2021 13:13:22 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 5818630E64C;
        Wed, 27 Jan 2021 13:13:22 -0500 (EST)
Date:   Wed, 27 Jan 2021 13:13:22 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
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
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <119550773.160.1611771202224.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210127130714.4ec189d5@gandalf.local.home>
References: <20210127123951.14f8d321@gandalf.local.home> <2075610164.123.1611770446483.JavaMail.zimbra@efficios.com> <20210127130714.4ec189d5@gandalf.local.home>
Subject: Re: [PATCH v4] tracepoint: Do not fail unregistering a probe due to
 memory failure
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF84 (Linux)/8.8.15_GA_3996)
Thread-Topic: tracepoint: Do not fail unregistering a probe due to memory failure
Thread-Index: zLlq1m0MGZqB0LAry6fv8XrShj1Nsw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 27, 2021, at 1:07 PM, rostedt rostedt@goodmis.org wrote:

> On Wed, 27 Jan 2021 13:00:46 -0500 (EST)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> > Instead of allocating a new array for removing a tracepoint, allocate twice
>> > the needed size when adding tracepoints to the array. On removing, use the
>> > second half of the allocated array. This removes the need to allocate memory
>> > for removing a tracepoint, as the allocation for removals will already have
>> > been done.
>> 
>> I don't see how this can work reliably. AFAIU, with RCU, approaches
>> requiring a pre-allocation of twice the size and swapping to the alternate
>> memory area on removal falls apart whenever you remove 2 or more elements
>> back-to-back without waiting for a grace period.
> 
> Good point ;-)
> 
>> 
>> How is this handled by your scheme ?
> 
> I believe we can detect this case using the "prio" part of extra element,
> and force a rcu sync if there's back to back removals on the same
> tracepoint. That case does not happen often, so I'm hoping nobody will
> notice the slowdown with these syncs. I'll take a look at this.
> 
> Thanks for bringing that up.

Requiring an RCU synchronize on element removal is quite intrusive, and can
be problematic if tracepoint removal is called from e.g. preempt-off context.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
