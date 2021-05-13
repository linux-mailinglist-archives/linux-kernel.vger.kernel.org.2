Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBFB37FE6B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhEMTzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:55:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:44008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232108AbhEMTzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:55:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7CFABAC36;
        Thu, 13 May 2021 19:54:04 +0000 (UTC)
Date:   Thu, 13 May 2021 12:53:57 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     a.darwish@linutronix.de, bigeasy@linutronix.de, tglx@linutronix.de,
        shung-hsi.yu@suse.com, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH v2] seqlock,lockdep: Only check for preemption_disabled
 in non-rt
Message-ID: <20210513195357.xq57b2t26hhhmdn4@offworld>
References: <20210507233951.78950-1-dave@stgolabs.net>
 <20210507234713.86097-1-dave@stgolabs.net>
 <YJuVhR9C6pUmZBOs@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YJuVhR9C6pUmZBOs@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021, Peter Zijlstra wrote:

>I'm confused, and the Changelog is useless. The code you actually
>changed is for seqcount_t, which doesn't have an associated LOCK. If

Hmm it was never my intention to touch seqcount_t, I now see the error of
my ways.

>there is a lock, the code should be changed to use the appropriate
>seqcount_LOCKNAME_t and the assertion will change into the one found in
>__seqprop_##lockname##_assert(), namely:
>
>  lockdep_assert_held(lockmember)
>
>
>But as is, seqcount_t usage relies on being non-preemptible, even for
>PREEMPT_RT, and this is a good thing. Please describe the site that goes
>boom and explain things..

So the splat is:
     WARNING: CPU: 0 PID: 15 at kernel/locking/lockdep.c:5363 lockdep_assert_preemption_disabled+0x7a/0xa0
     CPU: 0 PID: 15 Comm: kworker/0:1 Tainted: G            E      5.3.18-rt_syzkaller #1
     Workqueue: events xfrm_hash_resize
     RIP: 0010:lockdep_assert_preemption_disabled+0x7a/0xa0
     Code: 09 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 04 3c 03 7e 1c 8b 83 c8 09 00 00 85 c0 74 02 <0f> 0b 5b c3 48 c7 c7 54 39 ce 83 e8 c6 0d 43 00 eb 9f e8 bf 0d 43
     RSP: 0018:ffff888118497ca0 EFLAGS: 00010202
     RAX: 0000000000000001 RBX: ffff88811847ce40 RCX: 1ffffffff079c72a
     RDX: 1ffff1102308fb01 RSI: 0000000000000022 RDI: ffff88811847d808
     RBP: ffffffff83b9ebb0 R08: 0000000000000001 R09: ffff888118497bd8
     R10: ffff888118497c47 R11: 0000000000000001 R12: ffff88811b232200
     R13: ffff888118497dc0 R14: 0000000000000010 R15: ffff88811847ce40
      xfrm_hash_resize+0xd7/0x1490
      process_one_work+0x78e/0x16e0
      ? pwq_dec_nr_in_flight+0x2e0/0x2e0
      ? do_raw_spin_lock+0x11a/0x250
      ? _raw_spin_lock_irq+0xa/0x40
      worker_thread+0x5f5/0x1080
      ? process_one_work+0x16e0/0x16e0
      kthread+0x401/0x4f0
      ? __kthread_parkme+0x290/0x290
      ret_from_fork+0x24/0x30

I was initially chasing (and hence why the preemption check wasn't making sense):

	seqcount_mutex_init(&xfrm_policy_hash_generation, &hash_resize_mutex);

But there are actually two xfrm_hash_resize() calls (*sigh*). And the other
one, the right one, is/was indeed seqcount_t xfrm_state_hash_generation:

xfrm_hash_resize() // kworker callback, task context
     spin_lock_bh(&net->xfrm.xfrm_policy_lock); // disables softirq, preemption still enabled
     write_seqcount_begin(&xfrm_state_hash_generation);
	__seqprop_assert() <-- boom

And therefore converting it to an associated spinlock would avoid the preemption
check, which is exactly what Ahmed has already done:

bc8e0adff34 (net: xfrm: Use sequence counter with associated spinlock)
e88add19f68 (net: xfrm: Localize sequence counter per network namespace)

Sorry for the noise.

Thanks,
Davidlohr
