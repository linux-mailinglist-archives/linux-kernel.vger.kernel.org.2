Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C9939DD70
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhFGNQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhFGNQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:16:26 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C62276108D;
        Mon,  7 Jun 2021 13:14:34 +0000 (UTC)
Date:   Mon, 7 Jun 2021 09:14:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Ingo Molnar <mingo@redhat.com>, kernel@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Export tracing_start() and tracing_stop()
Message-ID: <20210607091432.667ff0ba@oasis.local.home>
In-Reply-To: <YL3X7yRr1+yW/PHU@infradead.org>
References: <20210602080118.21627-1-vincent.whitchurch@axis.com>
        <YL3X7yRr1+yW/PHU@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 09:25:19 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jun 02, 2021 at 10:01:18AM +0200, Vincent Whitchurch wrote:
> > tracing_stop() is very useful during hands-on debugging for getting the
> > trace to stop exactly when the problem is detected.  Export this to
> > modules.
> > 
> > Personally, I haven't yet found the need to use tracing_start() from
> > code since I usually start tracing via tracefs, but export that too for
> > symmetry since it may have its uses together with tracing_stop().  
> 
> NAK, no exports for unused symbols.

Normally I would NAK this NAK because this is not normal functionality
that modules could use. It's for debugging, similar to trace_printk(),
and there should be no used symbols in any modules. This is something
for debugging purposes only and should never be in shipped kernels.

That said though, tracing_stop() is probably not what is wanted
(unless its for a suspend to ram thing). According to the above
description, the author really wants to use "tracing_off()" and not
"tracing_stop()" as tracing_off() is faster and can be turned back on
in user-space with the "tracing_on" file in tracefs, where as,
tracing_stop() can not be. tracing_stop() needs a tracing_start() to
get it going again.

And tracing_off() is already EXPORT_SYMBOL_GPL() (as it is commonly
used for debugging of modules). Again, it shouldn't have any in-kernel
users in modules, because, like I stated above, it's similar to
trace_printk() which should be removed before pushing to Linus.

I'll NAK this patch for a different reason. Use tracing_off() instead.

-- Steve
