Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A5035EA08
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 02:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348885AbhDNAeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 20:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348878AbhDNAeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 20:34:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F7461249;
        Wed, 14 Apr 2021 00:34:00 +0000 (UTC)
Date:   Tue, 13 Apr 2021 20:33:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Subject: Re: [PATCH v3 1/5] tracing: Define new ftrace event "func_repeats"
Message-ID: <20210413203359.322b902e@gandalf.local.home>
In-Reply-To: <20210413151736.36ec77eb@gandalf.local.home>
References: <20210409181031.26772-1-y.karadz@gmail.com>
        <20210409181031.26772-2-y.karadz@gmail.com>
        <20210413151736.36ec77eb@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 15:17:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Running this with trace-cmd record, this displays:
> 
>           <idle>-0     [001]   261.848848: function:                            next_zone
>           <idle>-0     [001]   261.848849: func_repeats:          next_zone <-need_update       (repeats:3  delta_ts: -189)
> 
> Which is confusing in a number of ways.
> 
> 1. It would be better to have it be the actual timestamp of the last repeat.
>    But that can be done in a trace-cmd plugin (like the function trace has).
> 
> 2. It should be "delta_ns:" because it is not -189 from the timestamp, as
>    the above time stamp is truncated to microseconds and this is not
>    obvious to the user.

After playing with this some more, I take back #2. As we don't know what
units the time stamp is actually in. As it is best to simply show the time
stamp of the last event where it matches the other time stamps (which we
can do, as I demonstrated in other emails), I think the best answer is to
leave the default ambiguous as simply "delta:". That way if it's not
processed, all you see is "delta: -189" and if people don't know what that
means, they'll either ignore it, or look up its meaning. I think both
"delta_ts" and "delta_ns" can be misleading if what is displayed does not
match the raw time stamps.

-- Steve
