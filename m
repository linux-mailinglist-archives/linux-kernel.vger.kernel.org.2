Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD9F34B134
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhCZVUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34507 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230176AbhCZVUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616793615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=mrVQo9srzsM96kqBT98BwwTsIevF8ZDTRT8P9kqAt0A=;
        b=LRfJ/XPR5a2TbDqUQcuJ5y6qrcWHIIS3omEumQo+RAXhEDmlXyHzmPXrHOW3IBkyzeC5hv
        PxBqJ4RZCnFOSktCUvUgJo76GLr+JBKFFp1+iXYsVxfxxGyioVTrB0J/mSr4K9yFLvHQ3r
        k/93CHg/OGl/GM1iOl/hLH0UreTChfw=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-JCbrVUpYNjaDi1BA-6-vCg-1; Fri, 26 Mar 2021 17:20:13 -0400
X-MC-Unique: JCbrVUpYNjaDi1BA-6-vCg-1
Received: by mail-io1-f69.google.com with SMTP id d4so7146073ioc.16
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 14:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=mrVQo9srzsM96kqBT98BwwTsIevF8ZDTRT8P9kqAt0A=;
        b=HxC1e8TgZXx9fy3+oGGyM+NHJD/hy62AKgCRoK3mLk/eGTyHnWUWysnjbZn2U1JfyR
         zaLsevtS13M/wfrvPcNEx+RzIa0VYNiZAmQrAzX7NoHxPkjT+WLpQtOtJEV4iM/jKPx1
         jNhwebbpiv1QOchsLiwrxNmgjMFiRfWZuAM9rn9s89vO8DaeJr6xLSyMlp2Ztepv+X5Z
         wexHGkcZ+ZLVKto+nH0kYDC+swDoRxkZd6OaU2Ym+IeaK7F/3T1ibcbnVpzfw/sTptls
         Y5GTyVgQCJGv/yKrVvw0XdRSg1Ou9I97WyU6BIqhg+iimU+/ckEogtELFrhS7LN2x1lJ
         3vlg==
X-Gm-Message-State: AOAM5334c98iZnFe3yPQZyhwk4Ec3jvcvm/siQkH+UtNUAIFKPlNIUFt
        XRD/2A4qxVPwqRZgleWuOSb1NAXze1A2BLHhByf1zImqXWZWcNIiOQ7B45PA+sJM2yrKbyf7hky
        IeuTq6UulcMM4zZR5AgqJ87cnGZ2P/I9b5I3URl/gZ57GhOyI9ewOhstS52MPyS7bm8/ZBE9xuT
        sV
X-Received: by 2002:a92:c748:: with SMTP id y8mr10263124ilp.37.1616793611858;
        Fri, 26 Mar 2021 14:20:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh0auR89PT3pe3sPldKiA2hObE6Q9SRgzWnNthkGztWq39sDwCpcLYDaxsOGg2kTTvzevcdQ==
X-Received: by 2002:a92:c748:: with SMTP id y8mr10263112ilp.37.1616793611604;
        Fri, 26 Mar 2021 14:20:11 -0700 (PDT)
Received: from halaneylaptop ([136.33.227.6])
        by smtp.gmail.com with ESMTPSA id x3sm534298ilg.2.2021.03.26.14.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 14:20:11 -0700 (PDT)
Date:   Fri, 26 Mar 2021 16:20:09 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [RT v5.12-rc3-rt3] __call_rcu with KASAN causes invalid sleeping
 function call
Message-ID: <20210326212009.dvmga3e7axms3atk@halaneylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I booted the RT kernel (v5.12-rc3-rt3) with KASAN enabled for the first
time today and noticed this:

[    2.670635] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:951
[    2.670638] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 19, name: pgdatinit0
[    2.670649] 8 locks held by pgdatinit0/19:
[    2.670651]  #0: ffffffffb6e0a1e0 (tasklist_lock){+.+.}-{0:0}, at: release_task+0x110/0x480
[    2.670666]  #1: ffffffffb7364d80 (rcu_read_lock){....}-{1:2}, at: rt_write_lock+0x292/0x3a0
[    2.670683]  #2: ffff888100364860 (&sighand->siglock){+.+.}-{0:0}, at: __exit_signal+0x11d/0x1180
[    2.670690]  #3: ffffffffb7364d80 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0x5/0xb0
[    2.670696]  #4: ffff888100395e10 (&(&sig->stats_lock)->lock){+.+.}-{0:0}, at: __exit_signal+0x276/0x1180
[    2.670701]  #5: ffffffffb7364d80 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0x5/0xb0
[    2.670707]  #6: ffff888100395d38 (&____s->seqcount#3){+.+.}-{0:0}, at: release_task+0x1d6/0x480
[    2.670713]  #7: ffffffffb77516c0 (depot_lock){+.+.}-{2:2}, at: stack_depot_save+0x1b9/0x440
[    2.670736] irq event stamp: 31790
[    2.670738] hardirqs last  enabled at (31789): [<ffffffffb5a58cbd>] _raw_spin_unlock_irqrestore+0x2d/0xe0
[    2.670741] hardirqs last disabled at (31790): [<ffffffffb3dc5d86>] __call_rcu+0x436/0x880
[    2.670746] softirqs last  enabled at (0): [<ffffffffb3be1737>] copy_process+0x1357/0x4f90
[    2.670751] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    2.670763] CPU: 0 PID: 19 Comm: pgdatinit0 Not tainted 5.12.0-rc3-rt3 #1
[    2.670766] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[    2.670768] Call Trace:
[    2.670790]  ? unwind_next_frame+0x11e/0x1ce0
[    2.670800]  dump_stack+0x93/0xc2
[    2.670826]  ___might_sleep.cold+0x1b2/0x1f1
[    2.670838]  rt_spin_lock+0x3b/0xb0
[    2.670838]  ? stack_depot_save+0x1b9/0x440
[    2.670838]  stack_depot_save+0x1b9/0x440
[    2.670838]  kasan_save_stack+0x32/0x40
[    2.670838]  ? kasan_save_stack+0x1b/0x40
[    2.670838]  ? kasan_record_aux_stack+0xa5/0xb0
[    2.670838]  ? __call_rcu+0x117/0x880
[    2.670838]  ? __exit_signal+0xafb/0x1180
[    2.670838]  ? release_task+0x1d6/0x480
[    2.670838]  ? exit_notify+0x303/0x750
[    2.670838]  ? do_exit+0x678/0xcf0
[    2.670838]  ? kthread+0x364/0x4f0
[    2.670838]  ? ret_from_fork+0x22/0x30
[    2.670838]  ? mark_held_locks+0xa5/0xe0
[    2.670838]  ? lockdep_hardirqs_on_prepare.part.0+0x18a/0x370
[    2.670838]  ? _raw_spin_unlock_irqrestore+0x2d/0xe0
[    2.670838]  ? lockdep_hardirqs_on+0x77/0x100
[    2.670838]  ? _raw_spin_unlock_irqrestore+0x38/0xe0
[    2.670838]  ? debug_object_active_state+0x273/0x370
[    2.670838]  ? debug_object_activate+0x380/0x460
[    2.670838]  ? alloc_object+0x960/0x960
[    2.670838]  ? lockdep_hardirqs_on+0x77/0x100
[    2.670838]  ? _raw_spin_unlock_irqrestore+0x38/0xe0
[    2.670838]  ? __call_rcu+0x436/0x880
[    2.670838]  ? lockdep_hardirqs_off+0x90/0xd0
[    2.670838]  kasan_record_aux_stack+0xa5/0xb0
[    2.670838]  __call_rcu+0x117/0x880
[    2.670838]  ? put_pid+0x10/0x10
[    2.670838]  ? rt_spin_unlock+0x31/0x80
[    2.670838]  ? rcu_implicit_dynticks_qs+0xab0/0xab0
[    2.670838]  ? free_pid+0x19c/0x260
[    2.670838]  __exit_signal+0xafb/0x1180
[    2.670838]  ? trace_sched_process_exit+0x1b0/0x1b0
[    2.670838]  ? rcu_is_watching+0xf1/0x160
[    2.670838]  ? rt_write_lock+0x306/0x3a0
[    2.670838]  ? release_task+0x23/0x480
[    2.670838]  release_task+0x1d6/0x480
[    2.670838]  exit_notify+0x303/0x750
[    2.670838]  ? cgroup_exit+0x306/0x830
[    2.670838]  ? forget_original_parent+0xb80/0xb80
[    2.670838]  ? perf_event_exit_task+0x1b3/0x2d0
[    2.670838]  ? rcu_read_lock_sched_held+0x3f/0x70
[    2.670838]  do_exit+0x678/0xcf0
[    2.670838]  ? exit_mm+0x5b0/0x5b0
[    2.670838]  ? __kthread_parkme+0xc9/0x280
[    2.670838]  ? setup_nr_node_ids+0x2a/0x2a
[    2.670838]  kthread+0x364/0x4f0
[    2.670838]  ? __kthread_parkme+0x280/0x280
[    2.670838]  ret_from_fork+0x22/0x30

Please let me know if you want any more info.

Thanks,
Andrew

