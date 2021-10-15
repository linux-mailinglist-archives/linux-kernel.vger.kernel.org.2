Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE7742F4D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbhJOOI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhJOOI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:08:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E483461090;
        Fri, 15 Oct 2021 14:06:48 +0000 (UTC)
Date:   Fri, 15 Oct 2021 10:06:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, acme@kernel.org, mingo@redhat.com,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH] perf/core: allow ftrace for functions in
 kernel/event/core.c
Message-ID: <20211015100647.661f2044@gandalf.local.home>
In-Reply-To: <YWmBs5fLO3F151cY@hirez.programming.kicks-ass.net>
References: <20211006210732.2826289-1-songliubraving@fb.com>
        <YWWCrYM1I1MtmCkY@hirez.programming.kicks-ass.net>
        <20211013124731.1a8a48ac@gandalf.local.home>
        <YWmBs5fLO3F151cY@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 15:27:15 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > 
> > Did you want me to pull this into my tree? My tests usually stress perf
> > along with ftrace.  
> 
> Hurmph, I just pushed it out, but sure, throw it in.

Keep it in your tree then. I'll just run it through tests locally, and see
if it spits any crumbs out.

-- Steve
