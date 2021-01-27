Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5725D306301
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343799AbhA0SIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:08:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235334AbhA0SH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:07:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7168964DA8;
        Wed, 27 Jan 2021 18:07:16 +0000 (UTC)
Date:   Wed, 27 Jan 2021 13:07:14 -0500
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
Message-ID: <20210127130714.4ec189d5@gandalf.local.home>
In-Reply-To: <2075610164.123.1611770446483.JavaMail.zimbra@efficios.com>
References: <20210127123951.14f8d321@gandalf.local.home>
        <2075610164.123.1611770446483.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 13:00:46 -0500 (EST)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > Instead of allocating a new array for removing a tracepoint, allocate twice
> > the needed size when adding tracepoints to the array. On removing, use the
> > second half of the allocated array. This removes the need to allocate memory
> > for removing a tracepoint, as the allocation for removals will already have
> > been done.  
> 
> I don't see how this can work reliably. AFAIU, with RCU, approaches
> requiring a pre-allocation of twice the size and swapping to the alternate
> memory area on removal falls apart whenever you remove 2 or more elements
> back-to-back without waiting for a grace period.

Good point ;-)

> 
> How is this handled by your scheme ?

I believe we can detect this case using the "prio" part of extra element,
and force a rcu sync if there's back to back removals on the same
tracepoint. That case does not happen often, so I'm hoping nobody will
notice the slowdown with these syncs. I'll take a look at this.

Thanks for bringing that up.

-- Steve

