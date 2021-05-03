Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20679372219
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 22:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhECU4V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 May 2021 16:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhECU4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 16:56:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BF4D61157;
        Mon,  3 May 2021 20:55:24 +0000 (UTC)
Date:   Mon, 3 May 2021 16:55:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     <Peter.Enderborg@sony.com>, <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <akpm@linux-foundation.org>, <peterz@infradead.org>,
        <ast@kernel.org>, <christian.brauner@ubuntu.com>,
        <dave@stgolabs.net>, <walken@google.com>, <jannh@google.com>,
        <christophe.leroy@c-s.fr>, <minchan@kernel.org>
Subject: Re: [PATCH 1/2] tracing: Add a trace for task_exit
Message-ID: <20210503165522.6f1f2fc3@gandalf.local.home>
In-Reply-To: <m1a6pbk5d3.fsf@fess.ebiederm.org>
References: <20210430142223.25500-1-peter.enderborg@sony.com>
        <20210430142223.25500-2-peter.enderborg@sony.com>
        <m14kfnzmsp.fsf@fess.ebiederm.org>
        <4bb24db4-f720-f5e7-9054-36bdeaee1d79@sony.com>
        <20210501091104.418765bd@oasis.local.home>
        <1214833117.22933.1620049830326.JavaMail.zimbra@efficios.com>
        <769a00d2-a76d-62d2-aa56-5a107dfdc53d@sony.com>
        <m1sg33lqyo.fsf@fess.ebiederm.org>
        <663fc7fa-e7fc-7d63-9de8-91b5f6fe4f06@sony.com>
        <m1a6pbk5d3.fsf@fess.ebiederm.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 May 2021 14:02:48 -0500
ebiederm@xmission.com (Eric W. Biederman) wrote:

> > However current traces is template based, and I assume it wont be
> > popular to add new fields to the template, and exit reasons is not
> > right for the other template use cases.

trace events can always add fields, it's removing them that can cause
problems (but even then, it's not that bad). The new libtracefs and
libtraceevent make it trivial for tools to get the fields from trace events
when needed.

> >
> > I still see a "new" task moving it to do_exit make trace name more
> > correct?  Or is trace_task_do_exit better?  

It is also trivial with the libraries to write a tool that can put together
everything you want. We even are working on python bindings to connect to
these libraries where you could write a python script to do this.

There is no need for a new tracepoint, especially if it makes it harder to
improve the implementation of what is being traced.

> 
> I really can't say, as I don't know much of anything about the tracing
> infrastructure.  I would assume in most cases with a tracepoint in place
> other kinds of tracing (like bpf programs) could come into play and read
> out pieces of information that are not commonly wanted.
> 
> All I really know something about is the exit code path, as I keep
> slowly trying to clean it up.  I plan on ignoring any tracepoint that
> makes that gets in the way.

As you should.

-- Steve
