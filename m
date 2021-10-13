Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F19D42C6B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJMQti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhJMQth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:49:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D9A360E54;
        Wed, 13 Oct 2021 16:47:33 +0000 (UTC)
Date:   Wed, 13 Oct 2021 12:47:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, acme@kernel.org, mingo@redhat.com,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH] perf/core: allow ftrace for functions in
 kernel/event/core.c
Message-ID: <20211013124731.1a8a48ac@gandalf.local.home>
In-Reply-To: <YWWCrYM1I1MtmCkY@hirez.programming.kicks-ass.net>
References: <20211006210732.2826289-1-songliubraving@fb.com>
        <YWWCrYM1I1MtmCkY@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 14:42:21 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 06, 2021 at 02:07:32PM -0700, Song Liu wrote:
> > It is useful to trace functions in kernel/event/core.c. Allow ftrace for
> > them by removing $(CC_FLAGS_FTRACE) from Makefile.
> > 
> > ---
> > We had some discussions about this last year [1]. Seems that enabling
> > ftrace in kernel/events won't really cause fatal recursion in the tests.
> > Shall we give it another try?  
> 
> I suppose we can give it a go..

Did you want me to pull this into my tree? My tests usually stress perf
along with ftrace.

-- Steve
