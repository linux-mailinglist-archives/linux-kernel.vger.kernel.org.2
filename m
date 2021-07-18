Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C653CC815
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 09:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhGRHpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 03:45:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52600 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhGRHpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 03:45:18 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7596922623;
        Sun, 18 Jul 2021 07:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626594139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MFgZm8r9p9xLPJ2nnX1oYo1nIlbmFhaGZvcR8KOfakQ=;
        b=ZycUc2WV3x2zNsIhKlaL1b0qD+bwQ6ZRahXon19oTOOGlb0rvwnw4dvtsYl/TOxLePnHOy
        cahACcsQt8bLG0BQs/nF3vsaItMGw9CghRY8iVzCOR9DjAu6NBUaFLCUUX4+aYjrs/bnNP
        kysgHbepCZkpzVnrghmJRQkRfyMlA/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626594139;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MFgZm8r9p9xLPJ2nnX1oYo1nIlbmFhaGZvcR8KOfakQ=;
        b=4B7JdJ37kMLZeHmM+KFtSgRO69hvRkoqRVI94mP1uBXaWpp5YM+gNv/L9rfDqGjwq8OA4T
        xztLJ8qKvUTc9tDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 227BA13AD2;
        Sun, 18 Jul 2021 07:42:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3jLoBlvb82AFDQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Sun, 18 Jul 2021 07:42:19 +0000
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
To:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
References: <20210609113903.1421-1-vbabka@suse.cz>
 <20210702182944.lqa7o2a25to6czju@linutronix.de>
 <891dc24e38106f8542f4c72831d52dc1a1863ae8.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ef4903e2-c2ce-9a64-68b0-c7ee483eb582@suse.cz>
Date:   Sun, 18 Jul 2021 09:41:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <891dc24e38106f8542f4c72831d52dc1a1863ae8.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/21 9:24 AM, Mike Galbraith wrote:
> On Fri, 2021-07-02 at 20:29 +0200, Sebastian Andrzej Siewior wrote:
>> I replaced my slub changes with slub-local-lock-v2r3.
>> I haven't seen any complains from lockdep or so which is good. Then I
>> did this with RT enabled (and no debug):
> 
> Below is some raw hackbench data from my little i4790 desktop box.  It
> says we'll definitely still want list_lock to be raw.

Hi Mike, thanks a lot for the testing, sorry for late reply.

Did you try, instead of raw list_lock, not applying the last, local lock
patch, as I suggested in reply to bigeasy? I think the impact at
reducing the RT-specific overhead would be larger (than raw list_lock),
the result should still be RT compatible, and it would also deal with
the bugs you found there... (which I'll look into).

Thanks,
Vlastimil

> It also appears to be saying that there's something RT specific to
> stare at in addition to the list_lock business, but add a pinch of salt
> to that due to the config of the virgin(ish) tip tree being much
> lighter than the enterprise(ish) config of the tip-rt tree.
> 
> perf stat -r10 hackbench -s4096 -l500
> full warmup, record, repeat twice for elapsed
> 
> 5.13.0.g60ab3ed-tip-rt
>           8,898.51 msec task-clock                #    7.525 CPUs utilized            ( +-  0.33% )
>            368,922      context-switches          #    0.041 M/sec                    ( +-  5.20% )
>             42,281      cpu-migrations            #    0.005 M/sec                    ( +-  5.28% )
>             13,180      page-faults               #    0.001 M/sec                    ( +-  0.70% )
>     33,343,378,867      cycles                    #    3.747 GHz                      ( +-  0.30% )
>     21,656,783,887      instructions              #    0.65  insn per cycle           ( +-  0.67% )
>      4,408,569,663      branches                  #  495.428 M/sec                    ( +-  0.73% )
>         12,040,125      branch-misses             #    0.27% of all branches          ( +-  2.93% )
> 
>            1.18260 +- 0.00473 seconds time elapsed  ( +-  0.40% )
>            1.19018 +- 0.00441 seconds time elapsed  ( +-  0.37% ) (repeat)
>            1.18260 +- 0.00473 seconds time elapsed  ( +-  0.40% ) (repeat)
> 
> 5.13.0.g60ab3ed-tip-rt +slub-local-lock-v2r3 list_lock=raw_spinlock_t
>           9,642.00 msec task-clock                #    7.521 CPUs utilized            ( +-  0.46% )
>            462,091      context-switches          #    0.048 M/sec                    ( +-  4.79% )
>             44,411      cpu-migrations            #    0.005 M/sec                    ( +-  4.34% )
>             12,980      page-faults               #    0.001 M/sec                    ( +-  0.43% )
>     36,098,859,429      cycles                    #    3.744 GHz                      ( +-  0.44% )
>     25,462,853,462      instructions              #    0.71  insn per cycle           ( +-  0.50% )
>      5,260,898,360      branches                  #  545.623 M/sec                    ( +-  0.52% )
>         16,088,686      branch-misses             #    0.31% of all branches          ( +-  2.02% )
> 
>            1.28207 +- 0.00568 seconds time elapsed  ( +-  0.44% )
>            1.28744 +- 0.00713 seconds time elapsed  ( +-  0.55% ) (repeat)
>            1.28085 +- 0.00850 seconds time elapsed  ( +-  0.66% ) (repeat)
> 
> 5.13.0.g60ab3ed-tip-rt +slub-local-lock-v2r3 list_lock=spinlock_t
>          10,004.89 msec task-clock                #    6.029 CPUs utilized            ( +-  1.37% )
>            654,311      context-switches          #    0.065 M/sec                    ( +-  5.16% )
>            211,070      cpu-migrations            #    0.021 M/sec                    ( +-  1.38% )
>             13,262      page-faults               #    0.001 M/sec                    ( +-  0.79% )
>     36,585,914,931      cycles                    #    3.657 GHz                      ( +-  1.35% )
>     27,682,240,511      instructions              #    0.76  insn per cycle           ( +-  1.06% )
>      5,766,064,432      branches                  #  576.325 M/sec                    ( +-  1.11% )
>         24,269,069      branch-misses             #    0.42% of all branches          ( +-  2.03% )
> 
>             1.6595 +- 0.0116 seconds time elapsed  ( +-  0.70% )
>             1.6270 +- 0.0180 seconds time elapsed  ( +-  1.11% ) (repeat)
>             1.6213 +- 0.0150 seconds time elapsed  ( +-  0.93% ) (repeat)
> 
> virgin(ish) tip
> 5.13.0.g60ab3ed-tip
>           7,320.67 msec task-clock                #    7.792 CPUs utilized            ( +-  0.31% )
>            221,215      context-switches          #    0.030 M/sec                    ( +-  3.97% )
>             16,234      cpu-migrations            #    0.002 M/sec                    ( +-  4.07% )
>             13,233      page-faults               #    0.002 M/sec                    ( +-  0.91% )
>     27,592,205,252      cycles                    #    3.769 GHz                      ( +-  0.32% )
>      8,309,495,040      instructions              #    0.30  insn per cycle           ( +-  0.37% )
>      1,555,210,607      branches                  #  212.441 M/sec                    ( +-  0.42% )
>          5,484,209      branch-misses             #    0.35% of all branches          ( +-  2.13% )
> 
>            0.93949 +- 0.00423 seconds time elapsed  ( +-  0.45% )
>            0.94608 +- 0.00384 seconds time elapsed  ( +-  0.41% ) (repeat)
>            0.94422 +- 0.00410 seconds time elapsed  ( +-  0.43% )
> 
> 5.13.0.g60ab3ed-tip +slub-local-lock-v2r3
>           7,343.57 msec task-clock                #    7.776 CPUs utilized            ( +-  0.44% )
>            223,044      context-switches          #    0.030 M/sec                    ( +-  3.02% )
>             16,057      cpu-migrations            #    0.002 M/sec                    ( +-  4.03% )
>             13,164      page-faults               #    0.002 M/sec                    ( +-  0.97% )
>     27,684,906,017      cycles                    #    3.770 GHz                      ( +-  0.45% )
>      8,323,273,871      instructions              #    0.30  insn per cycle           ( +-  0.28% )
>      1,556,106,680      branches                  #  211.901 M/sec                    ( +-  0.31% )
>          5,463,468      branch-misses             #    0.35% of all branches          ( +-  1.33% )
> 
>            0.94440 +- 0.00352 seconds time elapsed  ( +-  0.37% )
>            0.94830 +- 0.00228 seconds time elapsed  ( +-  0.24% ) (repeat)
>            0.93813 +- 0.00440 seconds time elapsed  ( +-  0.47% ) (repeat)
> 

