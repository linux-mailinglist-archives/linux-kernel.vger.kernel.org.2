Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D54376237
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhEGIjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhEGIjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:39:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B668FC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8iWwj0c2S4fs9qTVYrOAhonBn4hHg/AIb29EFxEvgU8=; b=fJkaMMQZeBVYr5RtkyX7/AblOO
        pAni7osUVlCkkgOpG8a2uA5cif/P+ho0kaCLsS37BdKWU+/H2yIDYTU/VnY6JZ/nUTs1bEtOhI3y8
        Zv6f3obnAR5PcUDLYvnbww3OuSsyr56vfGsqTCM+8mtSxANbAKaOxYoEwOFKr61TvBGieLOunNwjl
        xqYRGe10ofVaMy/YOSQzfGPUhU7KUGmQG8py7CtdnHnxIIvTgjSNLf+cgpT5RKYn5n1iK+nmZX3TB
        f838PHrpbDm1PRy+b016d3am15BBAIgcciCnHGIqiwt2YOt3kgoqWlwx7s0pdQEsd9qgH4ugkTgvL
        se+baTkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1levzi-006W5W-C5; Fri, 07 May 2021 08:37:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EB6D4300103;
        Fri,  7 May 2021 10:37:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C88DF2028F038; Fri,  7 May 2021 10:37:56 +0200 (CEST)
Date:   Fri, 7 May 2021 10:37:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     syzbot <syzbot+37fc8b84ffa2279d636d@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, christian@brauner.io, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com, pcc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in get_signal
Message-ID: <YJT8ZPM5YGzX8Jtk@hirez.programming.kicks-ass.net>
References: <0000000000006540d705c1b013b5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006540d705c1b013b5@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 02:34:27PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=123a56a5d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
> dashboard link: https://syzkaller.appspot.com/bug?extid=37fc8b84ffa2279d636d
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+37fc8b84ffa2279d636d@syzkaller.appspotmail.com
> 
> =============================
> WARNING: suspicious RCU usage
> 5.12.0-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/core.c:8304 Illegal context switch in RCU-sched read-side critical section!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 0
> no locks held by syz-executor.4/10430.

Looks like this is a concurrent fail?, if !debug_locks (as per the above)
then RCU_LOCKDEP_WARN() should not trigger.
