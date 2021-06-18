Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228993AD055
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhFRQ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 12:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231898AbhFRQ1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:27:53 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 033CD61260;
        Fri, 18 Jun 2021 16:25:42 +0000 (UTC)
Date:   Fri, 18 Jun 2021 12:25:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH next v4 1/2] lib/dump_stack: move cpu lock to printk.c
Message-ID: <20210618122541.49fbd114@oasis.local.home>
In-Reply-To: <YMyyCwMt549micJE@alley>
References: <20210617095051.4808-1-john.ogness@linutronix.de>
        <20210617095051.4808-2-john.ogness@linutronix.de>
        <20210617093243.795b4853@gandalf.local.home>
        <YMyyCwMt549micJE@alley>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 16:47:39 +0200
Petr Mladek <pmladek@suse.com> wrote:

> Good point! Just to be sure. Do you see the messed output with plain
> kernel? Or do you need the extra patches (from Peter Zijlstra) that
> redirect normal printk() to early_printk()?

I sometimes use this with Peter's patches, which also do basically the
same thing.

> 
> My understanding is that early_printk() is used only for very early
> boot message in plain kernel. And that there is not much concurrency
> at that time.

It will continue if you use ",keep" option. And that is something I
have done without Peter's patches, but then they become illegible when
there's a bug if more than one CPU triggers.

> 
> That said. I always wanted to upstream Peter's patchset. But I never
> found time to clean it up.

That would be great too!

-- Steve

