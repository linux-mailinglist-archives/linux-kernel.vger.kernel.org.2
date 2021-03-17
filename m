Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F043033E757
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCQDCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:02:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhCQDBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:01:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0CB2AC17;
        Wed, 17 Mar 2021 03:01:49 +0000 (UTC)
Date:   Tue, 16 Mar 2021 20:01:41 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 3/4] locking/ww_mutex: Treat ww_mutex_lock() like a
 trylock
Message-ID: <20210317030141.hsfeodb7toihrvrq@offworld>
References: <20210316153119.13802-1-longman@redhat.com>
 <20210316153119.13802-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210316153119.13802-4-longman@redhat.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021, Waiman Long wrote:

>It was found that running the ww_mutex_lock-torture test produced the
>following lockdep splat almost immediately:
>
>[  103.892638] ======================================================
>[  103.892639] WARNING: possible circular locking dependency detected
>[  103.892641] 5.12.0-rc3-debug+ #2 Tainted: G S      W
>[  103.892643] ------------------------------------------------------
>[  103.892643] lock_torture_wr/3234 is trying to acquire lock:
>[  103.892646] ffffffffc0b35b10 (torture_ww_mutex_2.base){+.+.}-{3:3}, at: torture_ww_mutex_lock+0x316/0x720 [locktorture]
>[  103.892660]
>[  103.892660] but task is already holding lock:
>[  103.892661] ffffffffc0b35cd0 (torture_ww_mutex_0.base){+.+.}-{3:3}, at: torture_ww_mutex_lock+0x3e2/0x720 [locktorture]
>[  103.892669]
>[  103.892669] which lock already depends on the new lock.
>[  103.892669]
>[  103.892670]
>[  103.892670] the existing dependency chain (in reverse order) is:
>[  103.892671]
>[  103.892671] -> #2 (torture_ww_mutex_0.base){+.+.}-{3:3}:
>[  103.892675]        lock_acquire+0x1c5/0x830
>[  103.892682]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
>[  103.892687]        ww_mutex_lock+0x4b/0x180
>[  103.892690]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
>[  103.892694]        lock_torture_writer+0x142/0x3a0 [locktorture]
>[  103.892698]        kthread+0x35f/0x430
>[  103.892701]        ret_from_fork+0x1f/0x30
>[  103.892706]
>[  103.892706] -> #1 (torture_ww_mutex_1.base){+.+.}-{3:3}:
>[  103.892709]        lock_acquire+0x1c5/0x830
>[  103.892712]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
>[  103.892715]        ww_mutex_lock+0x4b/0x180
>[  103.892717]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
>[  103.892721]        lock_torture_writer+0x142/0x3a0 [locktorture]
>[  103.892725]        kthread+0x35f/0x430
>[  103.892727]        ret_from_fork+0x1f/0x30
>[  103.892730]
>[  103.892730] -> #0 (torture_ww_mutex_2.base){+.+.}-{3:3}:
>[  103.892733]        check_prevs_add+0x3fd/0x2470
>[  103.892736]        __lock_acquire+0x2602/0x3100
>[  103.892738]        lock_acquire+0x1c5/0x830
>[  103.892740]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
>[  103.892743]        ww_mutex_lock+0x4b/0x180
>[  103.892746]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
>[  103.892749]        lock_torture_writer+0x142/0x3a0 [locktorture]
>[  103.892753]        kthread+0x35f/0x430
>[  103.892755]        ret_from_fork+0x1f/0x30
>[  103.892757]
>[  103.892757] other info that might help us debug this:
>[  103.892757]
>[  103.892758] Chain exists of:
>[  103.892758]   torture_ww_mutex_2.base --> torture_ww_mutex_1.base --> torture_ww_mutex_0.base
>[  103.892758]
>[  103.892763]  Possible unsafe locking scenario:
>[  103.892763]
>[  103.892764]        CPU0                    CPU1
>[  103.892765]        ----                    ----
>[  103.892765]   lock(torture_ww_mutex_0.base);
>[  103.892767] 				      lock(torture_ww_mutex_1.base);
>[  103.892770] 				      lock(torture_ww_mutex_0.base);
>[  103.892772]   lock(torture_ww_mutex_2.base);
>[  103.892774]
>[  103.892774]  *** DEADLOCK ***
>
>Since ww_mutex is supposed to be deadlock-proof if used properly, such
>deadlock scenario should not happen. To avoid this false positive splat,
>treat ww_mutex_lock() like a trylock().
>
>After applying this patch, the locktorture test can run for a long time
>without triggering the circular locking dependency splat.
>
>Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by Davidlohr Bueso <dbueso@suse.de>
