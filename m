Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B753F56A1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 05:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhHXDYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 23:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhHXDYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 23:24:42 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02F1C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 20:23:58 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1mIMvh-0001LI-6c; Mon, 23 Aug 2021 23:16:49 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id B5B2C56006F; Mon, 23 Aug 2021 23:16:48 -0400 (EDT)
Date:   Mon, 23 Aug 2021 23:16:48 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: 5.14-rc breaks iotop swap io monitoring.
Message-ID: <20210824031648.GA2725@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed that in 5.14-rc running iotop, it complains on startup
that "CONFIG_TASK_DELAY_ACCT not enabled in kernel, cannot determine
SWAPIN and IO %" and sure enough a bunch of columns show up as
'unavailable'.

My suspicion is this commit, which I've not confirmed yet as it doesn't
cleanly revert.  I'll poke at it some more in the morning, but figured
I'd bring it up sans-evidence in the hope that I'll wake up to someone
having an Ah-ha moment.

	Dave


commit c5895d3f06cbb80ccb311f1dcb37074651030cb6
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue May 4 22:43:42 2021 +0200

    sched: Simplify sched_info_on()
    
    The situation around sched_info is somewhat complicated, it is used by
    sched_stats and delayacct and, indirectly, kvm.
    
    If SCHEDSTATS=Y (but disabled by default) sched_info_on() is
    unconditionally true -- this is the case for all distro kernel configs
    I checked.
    
    If for some reason SCHEDSTATS=N, but TASK_DELAY_ACCT=Y, then
    sched_info_on() can return false when delayacct is disabled,
    presumably because there would be no other users left; except kvm is.
    
    Instead of complicating matters further by accurately accounting
    sched_stat and kvm state, simply unconditionally enable when
    SCHED_INFO=Y, matching the common distro case.
    
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
    Reviewed-by: Ingo Molnar <mingo@kernel.org>
    Acked-by: Johannes Weiner <hannes@cmpxchg.org>
    Link: https://lkml.kernel.org/r/20210505111525.121458839@infradead.org
