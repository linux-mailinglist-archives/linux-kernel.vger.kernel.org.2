Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1CA402BA7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbhIGPWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345073AbhIGPWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:22:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E015F610FE;
        Tue,  7 Sep 2021 15:21:29 +0000 (UTC)
Date:   Tue, 7 Sep 2021 11:21:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] trace: Add migrate-disabled counter to tracing
 output.
Message-ID: <20210907112128.7e670ad7@gandalf.local.home>
In-Reply-To: <20210906081343.klxtb652s5aphg4z@linutronix.de>
References: <20210806164907.xtgvrb25eb4isxhd@linutronix.de>
        <20210806135124.1279fc94@oasis.local.home>
        <20210810132625.ylssabmsrkygokuv@linutronix.de>
        <20210903194216.1392b62e@gandalf.local.home>
        <20210906081343.klxtb652s5aphg4z@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2021 10:13:43 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> I left that with that XXX on purpose so you can look and comment and say
> how to fix it. The problem I had with preempt_count was that only the
> lower nibble contains the preemption counter. So I thought you could
> easily came up with something how this can be split or taught to only
> expose the lower nibble. I didn't after a few attempts.
> My understanding is that this `preempt_count' is also used in the filter
> tracefs file so something like "preempt_count > 1" > filter would also
> match for migrate_count = 2, preempt_count = 1. You seem to be happy to
> filter in user space.

Right. It will break filtering, and I don't see a good way to handle that.

That said, I'll update the code to handle comparing fields with a mask.
I'll need to do this with the kernel as well.

I'm fine with breaking the filtering on preempt_count over having it just
fail to print it at all.

-- Steve

