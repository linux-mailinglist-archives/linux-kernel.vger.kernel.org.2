Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE303BA3EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhGBScU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 14:32:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48010 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhGBScT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 14:32:19 -0400
Date:   Fri, 2 Jul 2021 20:29:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625250586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1LP04KpdM/Xii9XazRoYT55qF7Zs2WWSaf0X5rgB/YI=;
        b=OWg8L2E+Rd3pYI642Oye8e4r4BiJocV794SpGvwipz4GoE4GhuCuDzsOixQ7CJ6BV3ZDs2
        bpu/1AO6xtEgGmdT9iv7fnormWD61hMjlk30r3DhwkdHB8ezKkfZKKsSsHhnAJuYvI+j/E
        ow/w0VmGaj2ao3TBK6EFLtjmcuQ6saJTMRm48PwFU/9NQOZXqSH0VX+xJLGd7+jTZz3kkW
        KHAWzlvOk/O0bFqUEONCZLYJ0ezlBKrAldqmxo7uXVHnEDz0Yh5IvPUYSN+VyIght8Skwu
        FvNhMxmfDuGbj1pP8iyfeSXg/ru8n00gwkzFmAO7u95FPla17KJzjNoRjhF5aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625250586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1LP04KpdM/Xii9XazRoYT55qF7Zs2WWSaf0X5rgB/YI=;
        b=6lw7AkFPWzvD6KtRY6f6Uwn1CU3N72ZwVjan69VBAARy2e3VZTII4arXD/qZXbGBUm9J6x
        2tHMV49sbM05F1Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
Message-ID: <20210702182944.lqa7o2a25to6czju@linutronix.de>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I replaced my slub changes with slub-local-lock-v2r3.
I haven't seen any complains from lockdep or so which is good. Then I
did this with RT enabled (and no debug):

- A "time make -j32" run of allmodconfig on /dev/shm.
  Old:
| real    20m6,217s
| user    568m22,553s
| sys     48m33,126s

  New:
| real    20m9,049s
| user    569m32,096s
| sys     48m47,670s

  These 3 seconds here are probably in the noise range.

- perf_5.10 stat -r 10 hackbench -g200 -s 4096 -l500
Old:
|         464.967,20 msec task-clock                #   27,220 CPUs utilized            ( +-  0,16% )
|          7.683.944      context-switches          #    0,017 M/sec                    ( +-  0,86% )
|            931.380      cpu-migrations            #    0,002 M/sec                    ( +-  4,94% )
|            219.569      page-faults               #    0,472 K/sec                    ( +-  0,39% )
|  1.104.727.599.918      cycles                    #    2,376 GHz                      ( +-  0,18% )
|    941.428.898.087      stalled-cycles-frontend   #   85,22% frontend cycles idle     ( +-  0,24% )
|    729.016.546.572      stalled-cycles-backend    #   65,99% backend cycles idle      ( +-  0,32% )
|    340.133.571.519      instructions              #    0,31  insn per cycle
|                                                   #    2,77  stalled cycles per insn  ( +-  0,12% )
|     73.746.821.314      branches                  #  158,607 M/sec                    ( +-  0,13% )
|        377.838.006      branch-misses             #    0,51% of all branches          ( +-  1,01% )
| 
|            17,0820 +- 0,0202 seconds time elapsed  ( +-  0,12% )

New:
|         422.865,71 msec task-clock                #    4,782 CPUs utilized            ( +-  0,34% )
|         14.594.238      context-switches          #    0,035 M/sec                    ( +-  0,43% )
|          3.737.926      cpu-migrations            #    0,009 M/sec                    ( +-  0,46% )
|            218.474      page-faults               #    0,517 K/sec                    ( +-  0,74% )
|    940.715.812.020      cycles                    #    2,225 GHz                      ( +-  0,34% )
|    716.593.827.820      stalled-cycles-frontend   #   76,18% frontend cycles idle     ( +-  0,39% )
|    550.730.862.839      stalled-cycles-backend    #   58,54% backend cycles idle      ( +-  0,43% )
|    417.274.588.907      instructions              #    0,44  insn per cycle
|                                                   #    1,72  stalled cycles per insn  ( +-  0,17% )
|     92.814.150.290      branches                  #  219,488 M/sec                    ( +-  0,17% )
|        822.102.170      branch-misses             #    0,89% of all branches          ( +-  0,41% )
| 
|             88,427 +- 0,618 seconds time elapsed  ( +-  0,70% )

So this is outside of the noise range.
I'm not sure where this is coming from. My guess would be higher lock
contention within the memory allocator.
  
> The remaining patches to upstream from the RT tree are small ones related to
> KConfig. The patch that restricts PREEMPT_RT to SLUB (not SLAB or SLOB) makes
> sense. The patch that disables CONFIG_SLUB_CPU_PARTIAL with PREEMPT_RT could
> perhaps be re-evaluated as the series also addresses some latency issues with
> percpu partial slabs.

With that series the PARTIAL slab can be indeed enabled. I have (had) a
half done series where I had PARTIAL enabled and noticed a slight
increase in latency so made it "default y on !RT". It wasn't dramatic
but appeared to be outside of noise.

Sebastian
