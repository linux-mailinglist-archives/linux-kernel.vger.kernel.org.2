Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7D433E8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhCQFQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:16:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:43638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhCQFQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:16:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED00EAC17;
        Wed, 17 Mar 2021 05:16:13 +0000 (UTC)
Date:   Tue, 16 Mar 2021 22:16:05 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 4/4] locking/locktorture: Fix incorrect use of
 ww_acquire_ctx in ww_mutex test
Message-ID: <20210317051605.popetodgwbr47ha2@offworld>
References: <20210316153119.13802-1-longman@redhat.com>
 <20210316153119.13802-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210316153119.13802-5-longman@redhat.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021, Waiman Long wrote:

>The ww_acquire_ctx structure for ww_mutex needs to persist for a complete
>lock/unlock cycle. In the ww_mutex test in locktorture, however, both
>ww_acquire_init() and ww_acquire_fini() are called within the lock
>function only. This causes a lockdep splat of "WARNING: Nested lock
>was not taken" when lockdep is enabled in the kernel.
>
>To fix this problem, we need to move the ww_acquire_fini() after the
>ww_mutex_unlock() in torture_ww_mutex_unlock(). In other word, we need
>to pass state information from the lock function to the unlock function.

Right, and afaict this _is_ the way ww_acquire_fini() should be called:

  * Releases a w/w acquire context. This must be called _after_ all acquired w/w
  * mutexes have been released with ww_mutex_unlock.

>Change the writelock and writeunlock function prototypes to allow that
>and change the torture_ww_mutex_lock() and torture_ww_mutex_unlock()
>accordingly.

But wouldn't just making ctx a global variable be enough instead? That way
we don't deal with memory allocation for every lock/unlock operation (yuck).
Plus the ENOMEM would need to be handled/propagated accordingly - the code
really doesn't expect any failure from ->writelock().

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 0ab94e1f1276..606c0f6c1657 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -362,6 +362,8 @@ static DEFINE_WW_MUTEX(torture_ww_mutex_0, &torture_ww_class);
  static DEFINE_WW_MUTEX(torture_ww_mutex_1, &torture_ww_class);
  static DEFINE_WW_MUTEX(torture_ww_mutex_2, &torture_ww_class);

+static struct ww_acquire_ctx ctx;
+
  static int torture_ww_mutex_lock(void)
  __acquires(torture_ww_mutex_0)
  __acquires(torture_ww_mutex_1)
@@ -372,7 +374,6 @@ __acquires(torture_ww_mutex_2)
		struct list_head link;
		struct ww_mutex *lock;
	} locks[3], *ll, *ln;
-	struct ww_acquire_ctx ctx;

	locks[0].lock = &torture_ww_mutex_0;
	list_add(&locks[0].link, &list);
@@ -403,7 +404,6 @@ __acquires(torture_ww_mutex_2)
		list_move(&ll->link, &list);
	}

-	ww_acquire_fini(&ctx);
	return 0;
  }

@@ -415,6 +415,8 @@ __releases(torture_ww_mutex_2)
	ww_mutex_unlock(&torture_ww_mutex_0);
	ww_mutex_unlock(&torture_ww_mutex_1);
	ww_mutex_unlock(&torture_ww_mutex_2);
+
+	ww_acquire_fini(&ctx);
  }

  static struct lock_torture_ops ww_mutex_lock_ops = {
