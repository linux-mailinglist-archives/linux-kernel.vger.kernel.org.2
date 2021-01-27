Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50B3063E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhA0TRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:17:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231367AbhA0TRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:17:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6AE64DC1;
        Wed, 27 Jan 2021 19:16:19 +0000 (UTC)
Date:   Wed, 27 Jan 2021 14:16:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH v4] tracepoint: Do not fail unregistering a probe due to
 memory failure
Message-ID: <20210127141617.047d5b78@gandalf.local.home>
In-Reply-To: <119550773.160.1611771202224.JavaMail.zimbra@efficios.com>
References: <20210127123951.14f8d321@gandalf.local.home>
        <2075610164.123.1611770446483.JavaMail.zimbra@efficios.com>
        <20210127130714.4ec189d5@gandalf.local.home>
        <119550773.160.1611771202224.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 13:13:22 -0500 (EST)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > Thanks for bringing that up.  
> 
> Requiring an RCU synchronize on element removal is quite intrusive, and can
> be problematic if tracepoint removal is called from e.g. preempt-off context.

But how often do you remove more than one callback from the same
tracepoint? Or should I say, from a lot of tracepoints?

This will only synchronize for the following case:

 Add three callbacks to a single tracepoint.
 Remove the first one.
    <rcu callback to update the counters>
 Remove the second one
   <triggers a synchronization if the counters have not been finished
    updating>
 Remove the third one.
   <no synchronization needed, because it's being freed>

And we may be able to make this work in batch too.

More to come, but I really like this approach over the others because it
does not increase the size of the kernel for a failure that should never
happen in practice.

-- Steve
