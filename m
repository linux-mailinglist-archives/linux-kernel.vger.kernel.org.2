Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FB237C84B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbhELQHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 12:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235670AbhELP2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:28:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F72C6142D;
        Wed, 12 May 2021 15:14:41 +0000 (UTC)
Date:   Wed, 12 May 2021 11:14:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: Correct calling tracepoints
Message-ID: <20210512111439.5f80f707@gandalf.local.home>
In-Reply-To: <YJvgreWRNgkloeuh@hirez.programming.kicks-ass.net>
References: <20210512120937.90211-1-leo.yan@linaro.org>
        <YJvL+IvlTtoNv2c7@hirez.programming.kicks-ass.net>
        <20210512093202.5fca1259@gandalf.local.home>
        <YJvgreWRNgkloeuh@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 16:05:33 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Thing is, if you look at the list copy:
> 
>   https://lore.kernel.org/lkml/20200821085348.782688941@infradead.org/
> 
> things were okay. I suspect there was a conflict at some point and
> resolution got it backwards because the hunks are so similar and I never
> noticed :/

Was this a git merge issue or a quilt merge issue ?

-- Steve
