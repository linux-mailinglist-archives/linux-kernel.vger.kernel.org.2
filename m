Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD5D424B68
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbhJGA5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231279AbhJGA5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:57:34 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA19610CE;
        Thu,  7 Oct 2021 00:55:41 +0000 (UTC)
Date:   Wed, 6 Oct 2021 20:55:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rjohnson@digitalocean.com, Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/2] tracing: show size of requested buffer
Message-ID: <20211006205540.14ea13e0@rorschach.local.home>
In-Reply-To: <robbat2-20211006T224617-864445788Z@orbis-terrarum.net>
References: <20210831043723.13481-1-robbat2@gentoo.org>
        <20211006182652.6c11ce1b@gandalf.local.home>
        <robbat2-20211006T224617-864445788Z@orbis-terrarum.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2021 22:48:35 +0000
"Robin H. Johnson" <robbat2@gentoo.org> wrote:

> On Wed, Oct 06, 2021 at 06:26:52PM -0400, Steven Rostedt wrote:
> > On Mon, 30 Aug 2021 21:37:22 -0700
> > "Robin H. Johnson" <robbat2@gentoo.org> wrote:
> > 
> > Sorry for the late reply, I was on holiday when this was sent, and I'm just
> > getting to looking at this email now (as my OoO email should have suggested ;-)
> > 
> > Anyway, this needs to be reviewed by the Perf maintainers (Cc'd)
> > 
> > (Lore link for patch 2: 
> >   https://lore.kernel.org/all/20210831043723.13481-2-robbat2@gentoo.org/ )  
> 
> You already CC'd them on Sept 7th, no response yet.

Oh good, that means I'm not the one that dropped the ball on this ;-)

> 
> Does MAINTAINERS need an update for kernel/trace/trace_event_perf.c?
> It points to Ingo & yourself for that directory, and not to the Perf
> maintainers.

Well, it is maintained by both of us. I usually just ask them to review
before taking it, but if there's no response from them by the end of
the week, I'll add it to my "for-next" queue.

-- Steve

