Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB473F0ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhHRSCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhHRSB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:01:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38425C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:01:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id bo19so4425656edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sPlFear2VejrkKnhxlFGzsr9A3uD/UYpahcqXgaXo8o=;
        b=P+y3+x23bWM1HtOyIoVFqqBvLFvylU2c4dZo8jT17xgEjEY3UfdMkihq/46N/B8UHo
         ZqjXYIfYt8wCP25wvHdJlcjHBDVE4MAtEoAHGm2NE8neW44itevagTU9enOi9n340EAo
         GZIeeLxF4E2aJ90WyZqwzzSSsBeqYDMdRQtfZ1W0C9fYsGId/bLidDiC+HfV9hoz595G
         3A3Bv33evWYytVVeGIxs050y6va0m7rObGTmw0/LOIrn+n1Sy5OCZ+XuDmUK6LgEwAeR
         FaZz7Zwz/CX0ifgSI5zbHOdwfpOlEQOV6ciGbmHedvunjaSlENMJExgRyszhdsA97Oke
         t9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sPlFear2VejrkKnhxlFGzsr9A3uD/UYpahcqXgaXo8o=;
        b=S+LEsnch/iAF/nkTC6IVkXYoci4SYVifxxGG+EzNUyq8cfDwc5pgaDx0aiZI++B8ef
         uTfk8LgSAygU3+PT5rRxLQwtthwjYUtilpfEBqidvjUF3n5YMbfAL1dV+U4skM6w8fPA
         1x+AOkdhYvyKp8rHp4xoidSPNlH9s+qNjB+YMYtt7MiR9I+xsWNJWHL2sXfKgv+zdS8Z
         jXy/Q0BBoxyfLsoP1EU1YJWeiH9NY4KQn5pYGZvcyxCICxxwQWF8BgyYoIwjvJ2M0OqD
         o9a8Z+fQFmPvKlHQsnCsjtkzp87zr2egpe6JcaAGM1c0YViq13PghFR73oFm/oMOoK5Y
         C9zw==
X-Gm-Message-State: AOAM531ld8yUNKMwiYkm0tUPeYTS4bGYsrSE+yliW7niZ8ugjo3h4WgJ
        P+re5oqlnzBYxKlEHSluniBlZzSC7AItVZJdtvI=
X-Google-Smtp-Source: ABdhPJy/MaPpLWwrIR+L7ZD49/CGJxWb4w3/UCAWMAo+cMHPxbIVqdtO+pM7rvEQzt5s7PHRjC0UCV23NSiRv6/CGhQ=
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr11510876edd.151.1629309682826;
 Wed, 18 Aug 2021 11:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210816180909.3603-1-shy828301@gmail.com> <20210818063042.GA2310427@u2004>
In-Reply-To: <20210818063042.GA2310427@u2004>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 18 Aug 2021 11:01:10 -0700
Message-ID: <CAHbLzkpMLJtK_ZdQw=pN5TJL_B4vW=jGCJhACxOP0w4QSitUtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Oscar Salvador <osalvador@suse.de>, tdmackey@twitter.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:30 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> On Mon, Aug 16, 2021 at 11:09:08AM -0700, Yang Shi wrote:
> > In the current implementation of soft offline, if non-LRU page is met,
> > all the slab caches will be dropped to free the page then offline.  But
> > if the page is not slab page all the effort is wasted in vain.  Even
> > though it is a slab page, it is not guaranteed the page could be freed
> > at all.
> >
> > However the side effect and cost is quite high.  It does not only drop
> > the slab caches, but also may drop a significant amount of page caches
> > which are associated with inode caches.  It could make the most
> > workingset gone in order to just offline a page.  And the offline is no=
t
> > guaranteed to succeed at all, actually I really doubt the success rate
> > for real life workload.
> >
> > Furthermore the worse consequence is the system may be locked up and
> > unusable since the page cache release may incur huge amount of works
> > queued for memcg release.
> >
> > Actually we ran into such unpleasant case in our production environment=
.
> > Firstly, the workqueue of memory_failure_work_func is locked up as
> > below:
> >
> > BUG: workqueue lockup - pool cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 stu=
ck for 53s!
> > Showing busy workqueues and worker pools:
> > workqueue events: flags=3D0x0
> >   pwq 2: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D14/256 refcnt=
=3D15
> >     in-flight: 409271:memory_failure_work_func
> >     pending: kfree_rcu_work, kfree_rcu_monitor, kfree_rcu_work, rht_def=
erred_worker, rht_deferred_worker, rht_deferred_worker, rht_deferred_worker=
, kfree_rcu_work, kfree_rcu_work, kfree_rcu_work, kfree_rcu_work, drain_loc=
al_stock, kfree_rcu_work
> > workqueue mm_percpu_wq: flags=3D0x8
> >   pwq 2: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1/256 refcnt=
=3D2
> >     pending: vmstat_update
> > workqueue cgroup_destroy: flags=3D0x0
> >   pwq 2: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1/1 refcnt=3D1=
2072
> >     pending: css_release_work_fn
> >
> > There were over 12K css_release_work_fn queued, and this caused a few
> > lockups due to the contention of worker pool lock with IRQ disabled, fo=
r
> > example:
> >
> > NMI watchdog: Watchdog detected hard LOCKUP on cpu 1
> > Modules linked in: amd64_edac_mod edac_mce_amd crct10dif_pclmul crc32_p=
clmul ghash_clmulni_intel xt_DSCP iptable_mangle kvm_amd bpfilter vfat fat =
acpi_ipmi i2c_piix4 usb_storage ipmi_si k10temp i2c_core ipmi_devintf ipmi_=
msghandler acpi_cpufreq sch_fq_codel xfs libcrc32c crc32c_intel mlx5_core m=
lxfw nvme xhci_pci ptp nvme_core pps_core xhci_hcd
> > CPU: 1 PID: 205500 Comm: kworker/1:0 Tainted: G             L    5.10.3=
2-t1.el7.twitter.x86_64 #1
> > Hardware name: TYAN F5AMT /z        /S8026GM2NRE-CGN, BIOS V8.030 03/30=
/2021
> > Workqueue: events memory_failure_work_func
> > RIP: 0010:queued_spin_lock_slowpath+0x41/0x1a0
> > Code: 41 f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09=
 d0 a9 00 01 ff ff 75 1b 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 <8b> 07 84 c0 =
75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> > RSP: 0018:ffff9b2ac278f900 EFLAGS: 00000002
> > RAX: 0000000000480101 RBX: ffff8ce98ce71800 RCX: 0000000000000084
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8ce98ce6a140
> > RBP: 00000000000284c8 R08: ffffd7248dcb6808 R09: 0000000000000000
> > R10: 0000000000000003 R11: ffff9b2ac278f9b0 R12: 0000000000000001
> > R13: ffff8cb44dab9c00 R14: ffffffffbd1ce6a0 R15: ffff8cacaa37f068
> > FS:  0000000000000000(0000) GS:ffff8ce98ce40000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fcf6e8cb000 CR3: 0000000a0c60a000 CR4: 0000000000350ee0
> > Call Trace:
> >  __queue_work+0xd6/0x3c0
> >  queue_work_on+0x1c/0x30
> >  uncharge_batch+0x10e/0x110
> >  mem_cgroup_uncharge_list+0x6d/0x80
> >  release_pages+0x37f/0x3f0
> >  __pagevec_release+0x1c/0x50
> >  __invalidate_mapping_pages+0x348/0x380
> >  ? xfs_alloc_buftarg+0xa4/0x120 [xfs]
> >  inode_lru_isolate+0x10a/0x160
> >  ? iput+0x1d0/0x1d0
> >  __list_lru_walk_one+0x7b/0x170
> >  ? iput+0x1d0/0x1d0
> >  list_lru_walk_one+0x4a/0x60
> >  prune_icache_sb+0x37/0x50
> >  super_cache_scan+0x123/0x1a0
> >  do_shrink_slab+0x10c/0x2c0
> >  shrink_slab+0x1f1/0x290
> >  drop_slab_node+0x4d/0x70
> >  soft_offline_page+0x1ac/0x5b0
> >  ? dev_mce_log+0xee/0x110
> >  ? notifier_call_chain+0x39/0x90
> >  memory_failure_work_func+0x6a/0x90
> >  process_one_work+0x19e/0x340
> >  ? process_one_work+0x340/0x340
> >  worker_thread+0x30/0x360
> >  ? process_one_work+0x340/0x340
> >  kthread+0x116/0x130
> >
> > The lockup made the machine is quite unusable.  And it also made the
> > most workingset gone, the reclaimabled slab caches were reduced from 12=
G
> > to 300MB, the page caches were decreased from 17G to 4G.
> >
> > But the most disappointing thing is all the effort doesn't make the pag=
e
> > offline, it just returns:
> >
> > soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()
> >
> > It seems the aggressive behavior for non-LRU page didn't pay back, so i=
t
> > doesn't make too much sense to keep it considering the terrible side
> > effect.
> >
> > Reported-by: David Mackey <tdmackey@twitter.com>
> > Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Thank you. I agree with the idea of dropping drop_slab_node() in shake_pa=
ge(),
> hoping that range-based slab shrinker will be implemented in the future.
>
> This patch conflicts with the patch
> https://lore.kernel.org/linux-mm/20210817053703.2267588-1-naoya.horiguchi=
@linux.dev/T/#u
> which adds another shake_page(), so could you add the following hunk in y=
our patch?
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 64f8ac969544..7dd2ca665866 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1198,7 +1198,7 @@ static int get_any_page(struct page *p, unsigned lo=
ng flags)
>                          * page, retry.
>                          */
>                         if (pass++ < 3) {
> -                               shake_page(p, 1);
> +                               shake_page(p);
>                                 goto try_again;
>                         }
>                         goto out;

BTW, a question about the return value with the above patch, will
reply in that thread.

>
>
> Thanks,
> Naoya Horiguchi
