Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5474D353BC5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 07:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhDEFY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 01:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbhDEFYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 01:24:46 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC6BC061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 22:24:40 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id i19so7769636qtv.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 22:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/TGChMkFQ46rLA5yA4GyAxtAf3NiUmoal4ss6ih3tCM=;
        b=ikuPUxlDd8VuAtbtMkgEpUWCO/c/ZJv6oxcWZ43rdO2/MAD3fgvxeNV0iL+zrNeuXh
         opVW8RrWOQuzG4bMN3XzZ2LYbOUDsum4IBXGG15xpXJZs66YVCF/7Wg3SpOd+venJQvG
         dbrg7mB98pprNqKpJd8kFM4A4kaEvVxJ02c+w9atTP7PZmj151O4kHwTJt9amX8O1xRt
         J/l6/RXf0RAUl8sHvzYajRnOGXOPcyVtRCKlUmDHWsZpnZGM39JpApjMqXIpEGsdj1Ca
         9le3EiHHE30GLf5sU87eNgliPKTcKDIJXSRbHX3mYxhI+sZrVyBvTVykfywEk3c92D50
         Ehmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/TGChMkFQ46rLA5yA4GyAxtAf3NiUmoal4ss6ih3tCM=;
        b=AhTHLcAAO5VAvTAMMBkAoT8TrBFPWI3h2PgUwkBlsqpELT6+QDAw+uErxUKIHF7G+9
         oFyq+6oNedsSQgUywabwjKWji8VJdskLvCFUXclRN4mlcVONlNws3e34/8vHhBi8Zx1x
         V3wgCaIpkaCVZj9mzky5/4k+fumJLYN6MjOtQ3vejd652mODpBjt9KJzCW7byLsB39/7
         3F8mHf4LOQBP3wwQiulX6768twgduDC1Kd3v61CU/yq+qInPB+lWsjaLqgHRAMNItT7q
         QHqkRscUHfdFuUX04dtQKxyeuvKDrdsQj1WwH3xKNO+JPXI3HVIUHMhcghwV4rkzpSf1
         u/GA==
X-Gm-Message-State: AOAM531sHXTsDFTo6hiFRMsjdL2OXhKL8HbqptanUNafE00kECPV3kHU
        /Kk0H2mQveeKNck6JQHb4g8=
X-Google-Smtp-Source: ABdhPJxW9iLyfivvMDPLB/T1C4Q27O1k2RS6sbsq+VnKMT6n85S3/a8EaBHLcLJGn7PiZB7wxWvzaQ==
X-Received: by 2002:ac8:6913:: with SMTP id e19mr20903441qtr.78.1617600279744;
        Sun, 04 Apr 2021 22:24:39 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id a19sm12884747qkl.126.2021.04.04.22.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 22:24:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8B89C27C0054;
        Mon,  5 Apr 2021 01:24:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 05 Apr 2021 01:24:38 -0400
X-ME-Sender: <xms:FZ9qYNNIZyd-i0EMgWp38U4dmTlk7ioBxW1NrR0okZCcgrFpp-Dvkg>
    <xme:FZ9qYP-v4fZaJ4POvecAYrDZHh5uFh2LysCfJWYZxSNPB9LbnPc30J-WY3FwXn_2P
    -PlzPzl4CbSPDW3Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejuddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfhfgggtuggj
    sehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvg
    hnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepfeduhfegieeufeeukeef
    ffehjedvhfeuveekgedthfeuleefjeefleeutddtvdegnecuffhomhgrihhnpehshiiikh
    grlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhgohhoghhlvgdrtghomhenucfkphepudef
    uddruddtjedruddrvdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithih
    qdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrih
    hlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:FZ9qYMRhqzpHSCf7u7YieswUG9xPhSo4CYQVdb54BWurJ8SYOsMt1A>
    <xmx:FZ9qYJskYlIgqYeQTJfhwMdzR5adMOlHu-f2t2FPL5doxz0o6wbEkg>
    <xmx:FZ9qYFec1KV2nMAC8fPSNeAM3FCK0bC29HeeX4GoX466_zviP2jo9A>
    <xmx:Fp9qYPs3o8Td4c6De5rJ0ZmliYutQCMv3q51Rkk1V6OU7My2dBzGcAWNdh8>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA id 75F15240054;
        Mon,  5 Apr 2021 01:24:37 -0400 (EDT)
Date:   Mon, 5 Apr 2021 13:23:30 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com>,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in get_timespec64
Message-ID: <YGqe0tRRpibv3/Bd@boqun-archlinux>
References: <0000000000000e025b05bf2a430b@google.com>
 <87mtud4wfi.ffs@nanos.tec.linutronix.de>
 <20210404214030.GB2696@paulmck-ThinkPad-P72>
 <20210405030855.GG2531743@casper.infradead.org>
 <20210405040125.GF2696@paulmck-ThinkPad-P72>
 <20210405043038.GA31091@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405043038.GA31091@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 09:30:38PM -0700, Paul E. McKenney wrote:
> On Sun, Apr 04, 2021 at 09:01:25PM -0700, Paul E. McKenney wrote:
> > On Mon, Apr 05, 2021 at 04:08:55AM +0100, Matthew Wilcox wrote:
> > > On Sun, Apr 04, 2021 at 02:40:30PM -0700, Paul E. McKenney wrote:
> > > > On Sun, Apr 04, 2021 at 10:38:41PM +0200, Thomas Gleixner wrote:
> > > > > On Sun, Apr 04 2021 at 12:05, syzbot wrote:
> > > > > 
> > > > > Cc + ...
> > > > 
> > > > And a couple more...
> > > > 
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    5e46d1b7 reiserfs: update reiserfs_xattrs_initialized() co..
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1125f831d00000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=78ef1d159159890
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=88e4f02896967fe1ab0d
> > > > > >
> > > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com
> > > > > >
> > > > > > =============================
> > > > > > WARNING: suspicious RCU usage
> > > > > > 5.12.0-rc5-syzkaller #0 Not tainted
> > > > > > -----------------------------
> > > > > > kernel/sched/core.c:8294 Illegal context switch in RCU-sched read-side critical section!
> > > > > >
> > > > > > other info that might help us debug this:
> > > > > >
> > > > > >
> > > > > > rcu_scheduler_active = 2, debug_locks = 0
> > > > > > 3 locks held by syz-executor.4/8418:
> > > > > >  #0: 
> > > > > > ffff8880751d2b28
> > > > > >  (
> > > > > > &p->pi_lock
> > > > > > ){-.-.}-{2:2}
> > > > > > , at: try_to_wake_up+0x98/0x14a0 kernel/sched/core.c:3345
> > > > > >  #1: 
> > > > > > ffff8880b9d35258
> > > > > >  (
> > > > > > &rq->lock
> > > > > > ){-.-.}-{2:2}
> > > > > > , at: rq_lock kernel/sched/sched.h:1321 [inline]
> > > > > > , at: ttwu_queue kernel/sched/core.c:3184 [inline]
> > > > > > , at: try_to_wake_up+0x5e6/0x14a0 kernel/sched/core.c:3464
> > > > > >  #2: ffff8880b9d1f948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_change+0x142/0x220 kernel/sched/psi.c:807
> > > > 
> > > > This looks similar to syzbot+dde0cc33951735441301@syzkaller.appspotmail.com
> > > > in that rcu_sleep_check() sees an RCU lock held, but the later call to
> > > > lockdep_print_held_locks() does not.  Did something change recently that
> > > > could let the ->lockdep_depth counter get out of sync with the actual
> > > > number of locks held?
> > > 
> > > Dmitri had a different theory here:
> > > 
> > > https://groups.google.com/g/syzkaller-bugs/c/FmYvfZCZzqA/m/nc2CXUgsAgAJ
> > 
> > There is always room for more than one bug.  ;-)
> > 
> > He says "one-off false positives".  I was afraid of that...
> 
> And both the examples I have been copied on today are consistent with
> debug_locks getting zeroed (e.g., via a call to __debug_locks_off())
> in the midst of a call to rcu_sleep_check().  But I would expect to see
> a panic or another splat if that were to happen.
> 
> Dmitry's example did have an additional splat, but I would expect the
> RCU-related one to come second.  Again, there is always room for more
> than one bug.
> 
> On the other hand, there are a lot more callers to debug_locks_off()
> than there were last I looked into this.  And both of these splats
> are consistent with an interrupt in the middle of rcu_sleep_check(),
> and that interrupt's handler invoking debug_locks_off(), but without
> printing anything to the console.  Does that sequence of events ring a
> bell for anyone?
> 
> If this is the new normal, I could make RCU_LOCKDEP_WARN() recheck
> debug_lockdep_rcu_enabled() after evaluating the condition, but with
> a memory barrier immediately before the recheck.  But I am not at all
> excited by doing this on speculation.  Especially given that doing
> so might be covering up some other bug.
> 

Just check the original console log and find:

[  356.696686][ T8418] =============================
[  356.696692][ T8418] WARNING: suspicious RCU usage
[  356.700193][T14782] ====================================
[  356.704548][ T8418] 5.12.0-rc5-syzkaller #0 Not tainted
[  356.729981][ T8418] -----------------------------
[  356.732473][T14782] WARNING: iou-sqp-14780/14782 still has locks held!

, so there are two warnnings here, one is from lockdep_rcu_suspisous()
and the other is from print_held_locks_bug(). I think this is what
happened:

in RCU_LOCKDEP_WARN():

	if (debug_lockdep_rcu_enabled() // this is true and at this time debug_locks = 1
	<interrupted>
	// lockdep detects a lock bug, set debug_locks = 0
	<swicth back>
	    && !__warned // true
	    && (c))      // "c" is a lock_is_held(), which will always returns true if debug_locks == 0!

the cause of the problem is that RCU_LOCKDEP_WARN() in fact read
debug_locks twice and get different values.

But if you change the ordering of two reads, probably can avoid the
problem:
	
First read:
	lock_is_held(); // true if 1) lock is really held or 2) lockdep is off

Second read:
	debug_lockdep_rcu_enabled(); // if lockdep is not off, we know
				     // that the first read got correct
				     // value, otherwise we just ignore
				     // the first read, because either
				     // there is a bug reported between
				     // two reads, or lockdep is already
				     // off when the first read happens.

So maybe something below:

Regards,
Boqun

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bd04f722714f..d11bee5d9347 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -315,7 +315,7 @@ static inline int rcu_read_lock_any_held(void)
 #define RCU_LOCKDEP_WARN(c, s)						\
 	do {								\
 		static bool __section(".data.unlikely") __warned;	\
-		if (debug_lockdep_rcu_enabled() && !__warned && (c)) {	\
+		if ((c) && debug_lockdep_rcu_enabled() && !__warned) {	\
 			__warned = true;				\
 			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
 		}							\

> 							Thanx, Paul
