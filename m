Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDDC44BF0E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhKJKxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:53:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35416 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJKxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:53:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A2F1221B13;
        Wed, 10 Nov 2021 10:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636541442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HO47rCdGhejVyJEgjF3SBkyM6/8hcrmcNNntgOspooM=;
        b=qMYeTxwU4cq63Q3OW+UKg5QF2lysxwlTmwJqWixHqqENUO4b7wMGaNPHKAxr4Wj7BAW3fz
        jJOWsgoGaDc+mFW5E8ZcK4HByJMKjHuGclCKi/pVQQUsYSc6CIvMleBaN9zM7reHFRcL7z
        6HvQY8mRhBmazXg5zzWpszlEwRpeD3I=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2F76DA3B83;
        Wed, 10 Nov 2021 10:50:42 +0000 (UTC)
Date:   Wed, 10 Nov 2021 11:50:38 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Ben Segall <bsegall@google.com>,
        Colin Cross <ccross@android.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: printk deadlock due to double lock attempt on current CPU's
 runqueue
Message-ID: <YYuj/rT+EO3K0LsK@alley>
References: <YYrU2PdmdNkulWSM@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYrU2PdmdNkulWSM@sultan-box.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-11-09 12:06:48, Sultan Alsawaf wrote:
> Hi,
> 
> I encountered a printk deadlock on 5.13 which appears to still affect the latest
> kernel. The deadlock occurs due to printk being used while having the current
> CPU's runqueue locked, and the underlying framebuffer console attempting to lock
> the same runqueue when printk tries to flush the log buffer.
> 
> I'm not sure what the *correct* solution is here (don't use printk while having
> a runqueue locked? don't use schedule_work() from the fbcon path? tell printk
> to use one of its lock-less backends?), so I've cc'd all the relevant folks.

At the moment, printk_deferred() could be used here. It defers the
console handling via irq_work().

There is no deferred variant for WARN() at the moment. The following
might work:

#define WARN_DEFERRED(condition, format...) ({		\
	unsigned long flags;				\
							\
	printk_safe_enter_irqsave(flags);		\
	WARN(condition, format...)			\
	printk_safe_exit_irqrestore(flags);		\
})

, where printk_safe_enter_irqsave()/printk_safe_exit_irqrestore(flags)
  are currently used only internally by printk() code and defined
  in the local kernel/printk/internal.h


Be ware that using the deferred variants is a whack a mole approach.
There are many printk() callers that might be called indirectly
and eventually cause deadlocks.

As already said, the plan is to upstream -rt solution and offload
the console work into kthreads. But it goes slowly. We want to
make it a clean way and prevent regressions as much as possible.

Best Regards,
Petr
