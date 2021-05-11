Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A77D379F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhEKGK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229840AbhEKGK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620713391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=iCqlWXsYzQ4M50g/8LZgXjNs7GwMMEWU8lAHhEw1x0I=;
        b=fxnrSE85q1DFrLiM0VIz9XemJEf2rHHk1I1Jckwf2zJ9BcnHMBg4l0QOCLyJ5NN4SlwoD+
        k65lcYr9EcFABfvLNpAQBcpsshjCuCcebPcr6x5YLJj+QES/kRQZW+rGVGxyI60F/STRKP
        RLuoMJ4zCuy7e0Wdjdi+5CuRdL0JeJQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-eAfJlhXFMBO7BWksRNcTVg-1; Tue, 11 May 2021 02:09:47 -0400
X-MC-Unique: eAfJlhXFMBO7BWksRNcTVg-1
Received: by mail-ed1-f71.google.com with SMTP id q18-20020a0564025192b02903888712212fso10316980edd.19
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 23:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iCqlWXsYzQ4M50g/8LZgXjNs7GwMMEWU8lAHhEw1x0I=;
        b=oVbEvJwzUU8zVC4vlC3qkomRGu1b4731kzOAy3GmmCP2OQxxAge6piMU9GhI3k04Gd
         ukPdMatzjDxbneGvCk3Nels8L8vQGMibayItxcSNJcVlgwsA3XTxu8Lpfj0Wt3+iNRNw
         cS4upfp+tIvHyV1Se5d402F8819GV2I6mpyEUEPyL5GC9pjbMQ46MadocP1kYfORvzd6
         aN76hbK3jfCE+2vWbYQUvdXuyCERcbxfn/4aiQ6foEPofjxvECmuUnbhPzAUWVWtlQML
         zsF6KEeXbqs8U9V6C+IGdF4SYwJvkHToCYZ3h/0I7EaH2JOdvQieQq8xik0jz38ObJCA
         Hcow==
X-Gm-Message-State: AOAM53085sUjP0N1wWLW7SKdrT4CqCJJl2Vtio7eus1IyupD2L/jeUSu
        0eMikyBr6mRsUeD7mIu17mKUKNCU1ToMH1AbxNlxKWtfVQ4INkd+OTSnhKi3kQpNMEu1mH4R15m
        T70qTUge6XUp+qX144bi4iZIP
X-Received: by 2002:a05:6402:177c:: with SMTP id da28mr33312011edb.135.1620713385499;
        Mon, 10 May 2021 23:09:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRZlDgHMwqPw6Hh/70Be2C5J22YJG9jLtexJBcsEd/38SWL5S6OQfC3T7Je+jRAjd8TxM+MQ==
X-Received: by 2002:a05:6402:177c:: with SMTP id da28mr33311991edb.135.1620713385294;
        Mon, 10 May 2021 23:09:45 -0700 (PDT)
Received: from localhost.localdomain ([151.29.103.229])
        by smtp.gmail.com with ESMTPSA id h23sm10808283ejx.90.2021.05.10.23.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 23:09:44 -0700 (PDT)
Date:   Tue, 11 May 2021 08:09:42 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sassmann@redhat.com
Subject: [RT] Question about i40e threaded irq
Message-ID: <YJofplWBz8dT7xiw@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following has been reported on RT.

[ 2007.106483] list_add corruption. next->prev should be prev (ffff8d86a0aadd00), but was ffff8d86a0aadec8. (next=ffff8d86a0aadd00).
[ 2007.118155] ------------[ cut here ]------------
[ 2007.118156] kernel BUG at lib/list_debug.c:25!
[ 2007.118160] invalid opcode: 0000 [#1] PREEMPT_RT SMP NOPTI
[ 2007.118162] CPU: 36 PID: 4651 Comm: irq/429-i40e-en Kdump: loaded Tainted: G          I  #1
[ 2007.118163] Hardware name: Dell Inc. PowerEdge R740xd/04FC42, BIOS 2.6.4 04/09/2020
[ 2007.118168] RIP: 0010:__list_add_valid.cold.0+0x12/0x28
[ 2007.118169] Code: 85 5d 00 00 00 48 8b 50 08 48 39 f2 0f 85 42 00 00 00 b8 01 00 00 00 c3 48 89 d1 48 c7 c7 20 1e 6e ad 48 89 c2 e8 e0 11 cd ff <0f> 0b 48 89 c1 4c 89 c6 48 c7 c7 78 1e 6e ad e8 cc 11 cd ff 0f 0b
[ 2007.118170] RSP: 0018:ffffa598d9b0be68 EFLAGS: 00010246
[ 2007.118171] RAX: 0000000000000075 RBX: ffff8d86a0aadd00 RCX: 0000000000000001
[ 2007.118171] RDX: 0000000000000000 RSI: ffffffffad6cf723 RDI: 00000000ffffffff
[ 2007.118172] RBP: ffff8d8694112010 R08: 0000000000000000 R09: 0000000000000a36
[ 2007.118173] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8d86a0aadd00
[ 2007.118173] R13: ffffffffac71f240 R14: ffff8d869d3758a0 R15: ffff8d993af88000
[ 2007.118174] FS:  0000000000000000(0000) GS:ffff8d86a0a80000(0000) knlGS:0000000000000000
[ 2007.118174] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2007.118175] CR2: 00007fa2d29211a0 CR3: 00000011d8c0e002 CR4: 00000000007606e0
[ 2007.118175] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2007.118176] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2007.118176] PKRU: 55555554
[ 2007.118176] Call Trace:
[ 2007.118180]  __napi_schedule_irqoff+0x34/0x60
[ 2007.118191]  i40e_msix_clean_rings+0x3f/0x50 [i40e]
[ 2007.118195]  irq_forced_thread_fn+0x30/0x80
[ 2007.118196]  irq_thread+0xdd/0x180
[ 2007.118198]  ? wake_threads_waitq+0x30/0x30
[ 2007.118198]  ? irq_thread_check_affinity+0x20/0x20
[ 2007.118202]  kthread+0x112/0x130
[ 2007.118203]  ? kthread_flush_work_fn+0x10/0x10
[ 2007.118207]  ret_from_fork+0x1f/0x40

The following tracing bits have been then collected, which seem
relevant.

irq/532--4667   36....2 13343.788389: softirq_raise:        vec=3 [action=NET_RX]
irq/532--4667   36....2 13343.788391: kernel_stack:         <stack trace>
=> trace_event_raw_event_softirq (ffffffff83eb6f77)
=> __raise_softirq_irqoff (ffffffff83eb7acd)
=> i40e_msix_clean_rings (ffffffffc03fe6ef)
=> irq_forced_thread_fn (ffffffff83f1f2a0)
=> irq_thread (ffffffff83f1f58d)
=> kthread (ffffffff83ed5f42)
=> ret_from_fork (ffffffff8480023f)

irq/529--4664   36d.h.2 13343.788402: softirq_raise:        vec=3 [action=NET_RX]
irq/529--4664   36d.h.2 13343.788404: kernel_stack:         <stack trace>
=> trace_event_raw_event_softirq (ffffffff83eb6f77)
=> __raise_softirq_irqoff (ffffffff83eb7acd)
=> rps_trigger_softirq (ffffffff8452fa49)
=> flush_smp_call_function_queue (ffffffff83f591c3)
=> smp_call_function_single_interrupt (ffffffff8480294b)
=> call_function_single_interrupt (ffffffff84801c3f)
=> __list_add_valid (ffffffff8424b050)
=> __napi_schedule_irqoff (ffffffff8452fa94)
=> i40e_msix_clean_rings (ffffffffc03fe6ef)
=> irq_forced_thread_fn (ffffffff83f1f2a0)
=> irq_thread (ffffffff83f1f58d)
=> kthread (ffffffff83ed5f42)
=> ret_from_fork (ffffffff8480023f)

My understanding is that rps_trigger_softirq() sneaked in while
i40e_msix_clean_rings() threaded irq was running and, since the latter is
using napi_schedule_irqoff(), the softnet_data poll_list got eventually
corrupted.

Now, doing s/napi_schedule_irqoff/napi_schedule/ in the i40e driver seem
to cure the problem. I'm not sure that there isn't a more general
solution, though. Is it expected that napi_schedule_irqoff users in RT
know what they are doing or do we want/need to fix this in a more
general way?

Thanks!

Juri

