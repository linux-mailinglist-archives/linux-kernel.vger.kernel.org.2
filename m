Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C28370752
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 15:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhEANL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 09:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232129AbhEANL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 09:11:57 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E494B61462;
        Sat,  1 May 2021 13:11:05 +0000 (UTC)
Date:   Sat, 1 May 2021 09:11:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <Peter.Enderborg@sony.com>
Cc:     <ebiederm@xmission.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <akpm@linux-foundation.org>,
        <peterz@infradead.org>, <ast@kernel.org>,
        <christian.brauner@ubuntu.com>, <dave@stgolabs.net>,
        <walken@google.com>, <jannh@google.com>,
        <mathieu.desnoyers@efficios.com>, <christophe.leroy@c-s.fr>,
        <minchan@kernel.org>
Subject: Re: [PATCH 1/2] tracing: Add a trace for task_exit
Message-ID: <20210501091104.418765bd@oasis.local.home>
In-Reply-To: <4bb24db4-f720-f5e7-9054-36bdeaee1d79@sony.com>
References: <20210430142223.25500-1-peter.enderborg@sony.com>
        <20210430142223.25500-2-peter.enderborg@sony.com>
        <m14kfnzmsp.fsf@fess.ebiederm.org>
        <4bb24db4-f720-f5e7-9054-36bdeaee1d79@sony.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2021 09:29:41 +0000
<Peter.Enderborg@sony.com> wrote:

> On 4/30/21 7:48 PM, Eric W. Biederman wrote:
> > Peter Enderborg <peter.enderborg@sony.com> writes:
> >  
> >> This is the peer functions to task_rename and task_newtask.
> >> With this we get hole "life-cycle" of task and can easily
> >> see short livied task and their exit status.  
> > This patch is incorrect.  The location you are dealing with is not part
> > of task exit.  The location you have instrumented is part of reaping a
> > task which can come arbitrarily long after the task exits.  
> 
> That is what it aiming. When using this as tool for userspace you
> would like to know when the task is done. When it no longer
> holds any thing that might have any impact. If you think the
> exit imply something more specific I can change the name.
> 
> I thought exit was a good name, it is in in exit.c.
> 
> Will the name task_done, task_finished or task_reaped work for you?

I think "task_reaped" is probably the best name, and the most
descriptive of what happened.

-- Steve
