Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97AD3A513B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 01:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhFLXIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 19:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhFLXIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 19:08:44 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E991D611AD;
        Sat, 12 Jun 2021 23:06:42 +0000 (UTC)
Date:   Sat, 12 Jun 2021 19:06:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 9/9] tracing: Add timerlat tracer
Message-ID: <20210612190641.4dc6dce0@rorschach.local.home>
In-Reply-To: <6808245d-208c-c6d2-1c6e-7410df158992@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
        <b650672b9973887ef1420bc1e76b97940b6522d6.1621024265.git.bristot@redhat.com>
        <20210607213639.68aad064@gandalf.local.home>
        <fd2bdb45-e68a-995e-271e-ec181f04ecbc@redhat.com>
        <20210611160340.6970e10c@gandalf.local.home>
        <6808245d-208c-c6d2-1c6e-7410df158992@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 11:41:41 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> > I think the above may be easier to understand, especially if the trace
> > output that represents it is below.  
> 
> ok, I can try to capture a trace sample and represent it into the ASCII art
> format above.

Why capture it? Just fudge an example that fits the example ;-)

> 
> > Also, I have to ask, shouldn't the "thread noise" really start at the
> > "External clock event"?  
> 
> To go in that direction, we need to track things that delayed the IRQ execution.

[snip long explanation of the obvious (to me at least) ;-) ]

> the overhead is acceptable because of the sound analysis of the scheduling bound
> (which is rooted in a formal specification & analysis of the system).

I meant, that it needs to be documented, what the real thread noise is
but due to what is available it may not be truly accurate.

-- Steve

