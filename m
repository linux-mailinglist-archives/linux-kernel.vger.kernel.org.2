Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC3833B49D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhCONcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231411AbhCONb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:31:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B04C264EED;
        Mon, 15 Mar 2021 13:31:55 +0000 (UTC)
Date:   Mon, 15 Mar 2021 09:31:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [GIT pull] locking/urgent for v5.12-rc3
Message-ID: <20210315093153.2f1dd3be@gandalf.local.home>
In-Reply-To: <YE9OOx0za7ZH3AXe@hirez.programming.kicks-ass.net>
References: <161573639668.27979.17827928369874291298.tglx@nanos>
        <CAHk-=wjuD2cCptSJmmHBp2c9chTPnZcSi+0vA+QJ8JNjYTJKCw@mail.gmail.com>
        <YE8b6dgsEG4OU0ay@hirez.programming.kicks-ass.net>
        <YE9AkgbqL+eVO6p1@hirez.programming.kicks-ass.net>
        <YE9EVNG4/5UMJvFp@hirez.programming.kicks-ass.net>
        <YE9OOx0za7ZH3AXe@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 13:08:27 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> So, anybody any opinion on if we ought to do this?

Looks fine to me.

-- Steve
