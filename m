Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50D734CDC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhC2KOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:14:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:59176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231987AbhC2KOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:14:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617012844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nzUJoQum8qHlbfmya0Ob9QbYNOqWwVyrLmOEsi0nE3g=;
        b=lkpwIrS+yjDOhmuwF1gIduN6u1vG31dkV2fogjxVhx41NJPIFTWYqHiXsx7/MMyuiV9Er3
        h/9nQFD/gBkoY9O6nclfRTg9zClBuHq6F692fKr7hnhqbd8ivXd1a2gFlapQCl+UHvQJsX
        ZS5h/igLj2wNUxebOp6d+G1LT1tSwLw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4531AB3DF;
        Mon, 29 Mar 2021 10:14:04 +0000 (UTC)
Date:   Mon, 29 Mar 2021 12:14:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] workqueue/watchdog: Make unbound workqueues aware of
Message-ID: <YGGoa/AAk86FmYgn@alley>
References: <1616585643-26720-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616585643-26720-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-03-24 19:34:02, Wang Qing wrote:
> There are two workqueue-specific watchdog timestamps:
> 
>     + @wq_watchdog_touched_cpu (per-CPU) updated by
>       touch_softlockup_watchdog()
> 
>     + @wq_watchdog_touched (global) updated by
>       touch_all_softlockup_watchdogs()
> 
> watchdog_timer_fn() checks only the global @wq_watchdog_touched for
> unbound workqueues. As a result, unbound workqueues are not aware
> of touch_softlockup_watchdog(). The watchdog might report a stall
> even when the unbound workqueues are blocked by a known slow code.
> 
> Solution:
> touch_softlockup_watchdog() must touch also the global @wq_watchdog_touched 
> timestamp.
> 
> The global timestamp can not longer be used for bound workqueues
> because it is updated on all CPUs. Instead, bound workqueues
> have to check only @wq_watchdog_touched_cpu and these timestamp
> has to be updated for all CPUs in touch_all_softlockup_watchdogs().
> 
> Beware:
> The change might cause the opposite problem. An unbound workqueue
> might get blocked on CPU A because of a real softlockup. The workqueue
> watchdog would miss it when the timestamp got touched on CPU B.
> 
> It is acceptable because softlockups are detected by softlockup
> watchdog. The workqueue watchdog is there to detect stalls where
> a work never finishes, for example, because of dependencies of works
> queued into the same workqueue.
> 
> V3:
> - Modify the commit message clearly according to Petr's suggestion.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

The patch fixes a real problem:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
