Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325373E22D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 07:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243018AbhHFFPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 01:15:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:50267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240658AbhHFFPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 01:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628226861;
        bh=ZBgF49qhDTP9/Mp+faU6MKUiN+GEY0KedS91I/sQFfc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=h5DsTK1arqI3PslsDmANmL6ujjzBre7G3mjFbZncuEdbdtJMn1pkEwovd8xN6wdQN
         zF5BDM+m4g/ZQ8jdbqu4NcaqtLoZ1IYHDDVUe3i5u1NxQ7aHso9qMx4ffp27cJ9okz
         h+nnhnSbsTJMXAWKvabBIshiFrGFvgi1aR9iy3tM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.94]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0XD2-1n5mED1uSq-00wVSp; Fri, 06
 Aug 2021 07:14:21 +0200
Message-ID: <a36ad3a060da4f02808b2692891afbe35292e15b.camel@gmx.de>
Subject: Re: [PATCH v4 00/35] SLUB: reduce irq disabled scope and make it RT
 compatible
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
Date:   Fri, 06 Aug 2021 07:14:18 +0200
In-Reply-To: <20210805164210.2zxpzn2sdogf4kx3@linutronix.de>
References: <20210805152000.12817-1-vbabka@suse.cz>
         <20210805164210.2zxpzn2sdogf4kx3@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wCfO6rc3QwrJyKKDeHHK/7zxi7C2dqQYpfUoN7TOX+9OYVpvAOw
 bLUkR86wa9dVjxNVhi7IZZZnnBvLDFvGol368Y5EoZglWXxOljrisCKyj/Z1UVqcYFZX71o
 y47jzXPyz85dNNn23hOQZNIVeXFUPfXTK3CsMOob8RgQliIMv/lyNCnLwSOEyWwldRhkctI
 y/GLUE8EBMl5wQgp/Gc/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ppSYBInI0Yg=:pq5jTwR7Jb9AwRlsoxS9Qn
 zg0Xksl1qWkSOQjW0u1ErU6LqXRs/XDpYhPjd9SLOUA4OgZ6w/jIu49UxlTlfYyrGHDdUWvny
 pu4bURRdUIMJS/5T4KqnDtrgrE61OE4kdbjRx7+3GHvNS/a+XaZTjQqX7RAOnfIsGIsIwt4Hr
 2G7caDs0SOQqG2ON4wmuoFNepgWvFuf0mNAOnRvaFQVeYXmi816JXz8+cTcsV097mu/t0Lp6J
 yRm6HHn6nmK1v6KTfJqTPKTb310wnT9ScqLUhjbQ+Jt9jrO18tbUsAayWJjvXSp1TRNFfJXBX
 My8jysSH6CNfjeO1feC4D0+l7hqHmrixhbnlo1iK/NhhvY1NeR8Iju5tDVcdyCa5c+Te7lUf7
 /YziC781/qh+PWqQuN+rk6+fv/hJlEP4CQWQPBAcjXaC2oPF+wLlYbg2d1oc4QghrUP3+yN9u
 9aDDbPkEf+ta/KrImvJQ5U9o9BKIoMRS+7xT48MnBeyI8de1yjTYsOnytqSwTRmcNDnwGjrFR
 RMSnw90X2O/k6/sNGLrXZGOfjwmlLAw4/nivya3jU3YvJiaVJTc/hO4Ya/TMq/gpCCS7DOipb
 lcvdTSOJKZ72nhli0CCX9VU4n7fShk/nMKV4pWGBdFJ5+/qbESlbX02twlZ8R8BV6mlwauUEI
 rs39d1hhxq8eVVb9MQXEfME2S0AkrMyvHUVltD9BWaQ4HoyHOQCSNRXdWyt0eRaIA9WxWCN7l
 YvkQi3JuBla8We5Nv5InRMiDV8lgottROIHGHBigQfBKuc8YRfwJoiOPlhtYtwr82YdCej4to
 QGwhmvHbh0YuwXcIA81XarrGnwO9qWuKZPVJc9uW4iqdJ1UiuA0g5fyLYgj5sTNV+ra353Z1C
 asFLE7CcGMFBq8zdAjBk9Aso7LCnv9pkXynSrg7pYXoPU7uOUQvlZMZJJ4caJwWALQhsLUx6j
 FXmKvCFLfDg3DINvkGiVigkglOYgmbWnoOz7kEC+RIGsXZME7rTCN0B/6vyyHQnzffWM8H7gI
 ohQ3tcPpE0GUuLG/6arJwnWslVTDzlTPVotzBWW1GN91Ph1Oq++b3cUs+fLvnEM0knorAbJK/
 klN/2DYVfDg9zAn4Vv8b/P/rHPCVLnSe6Mc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-08-05 at 18:42 +0200, Sebastian Andrzej Siewior wrote:
>
> There was throughput regression in RT compared to previous releases
> (without this series). The regression was (based on my testing) only
> visible in hackbench and was addressed by adding adaptiv spinning to
> RT-mutex. With that we almost back to what we had before :)

Numbers on my box say a throughput regression remains (silly fork bomb
scenario.. yawn), which can be recouped by either turning on all
SL[AU]B features or converting the list_lock to a raw lock.  They also
seem to be saying that if you turned on PREEMPT_RT because you care
about RT performance first and foremost (gee), you'll do neither of
those, because either will eliminate an RT performance progression.

	-Mike

numbers...

box is old i4790 desktop
perf stat -r10 hackbench -s4096 -l500
full warmup, record, repeat twice for elapsed

SLUB+SLUB_DEBUG only

begin previously reported numbers
5.14.0.g79e92006-tip-rt (5.12-rt based as before, 5.13-rt didn't yet exist=
)
          7,984.52 msec task-clock                #    7.565 CPUs utilized=
            ( +-  0.66% )
           353,566      context-switches          #   44.281 K/sec        =
            ( +-  2.77% )
            37,685      cpu-migrations            #    4.720 K/sec        =
            ( +-  6.37% )
            12,939      page-faults               #    1.620 K/sec        =
            ( +-  0.67% )
    29,901,079,227      cycles                    #    3.745 GHz          =
            ( +-  0.71% )
    14,550,797,818      instructions              #    0.49  insn per cycl=
e           ( +-  0.47% )
     3,056,685,643      branches                  #  382.826 M/sec        =
            ( +-  0.51% )
         9,598,083      branch-misses             #    0.31% of all branch=
es          ( +-  2.11% )

           1.05542 +- 0.00409 seconds time elapsed  ( +-  0.39% )
           1.05990 +- 0.00244 seconds time elapsed  ( +-  0.23% ) (repeat)
           1.05367 +- 0.00303 seconds time elapsed  ( +-  0.29% ) (repeat)

5.14.0.g79e92006-tip-rt +slub-local-lock-v2r3 -0034-mm-slub-convert-kmem_c=
pu_slab-protection-to-local_lock.patch
          6,899.35 msec task-clock                #    5.637 CPUs utilized=
            ( +-  0.53% )
           420,304      context-switches          #   60.919 K/sec        =
            ( +-  2.83% )
           187,130      cpu-migrations            #   27.123 K/sec        =
            ( +-  1.81% )
            13,206      page-faults               #    1.914 K/sec        =
            ( +-  0.96% )
    25,110,362,933      cycles                    #    3.640 GHz          =
            ( +-  0.49% )
    15,853,643,635      instructions              #    0.63  insn per cycl=
e           ( +-  0.64% )
     3,366,261,524      branches                  #  487.910 M/sec        =
            ( +-  0.70% )
        14,839,618      branch-misses             #    0.44% of all branch=
es          ( +-  2.01% )

           1.22390 +- 0.00744 seconds time elapsed  ( +-  0.61% )
           1.21813 +- 0.00907 seconds time elapsed  ( +-  0.74% ) (repeat)
           1.22097 +- 0.00952 seconds time elapsed  ( +-  0.78% ) (repeat)

repeat of above with raw list_lock
          8,072.62 msec task-clock                #    7.605 CPUs utilized=
            ( +-  0.49% )
           359,514      context-switches          #   44.535 K/sec        =
            ( +-  4.95% )
            35,285      cpu-migrations            #    4.371 K/sec        =
            ( +-  5.82% )
            13,503      page-faults               #    1.673 K/sec        =
            ( +-  0.96% )
    30,247,989,681      cycles                    #    3.747 GHz          =
            ( +-  0.52% )
    14,580,011,391      instructions              #    0.48  insn per cycl=
e           ( +-  0.81% )
     3,063,743,405      branches                  #  379.523 M/sec        =
            ( +-  0.85% )
         8,907,160      branch-misses             #    0.29% of all branch=
es          ( +-  3.99% )

           1.06150 +- 0.00427 seconds time elapsed  ( +-  0.40% )
           1.05041 +- 0.00176 seconds time elapsed  ( +-  0.17% ) (repeat)
           1.06086 +- 0.00237 seconds time elapsed  ( +-  0.22% ) (repeat)

5.14.0.g79e92006-rt3-tip-rt +slub-local-lock-v2r3 full set
          7,598.44 msec task-clock                #    5.813 CPUs utilized=
            ( +-  0.85% )
           488,161      context-switches          #   64.245 K/sec        =
            ( +-  4.29% )
           196,866      cpu-migrations            #   25.909 K/sec        =
            ( +-  1.49% )
            13,042      page-faults               #    1.716 K/sec        =
            ( +-  0.73% )
    27,695,116,746      cycles                    #    3.645 GHz          =
            ( +-  0.79% )
    18,423,934,168      instructions              #    0.67  insn per cycl=
e           ( +-  0.88% )
     3,969,540,695      branches                  #  522.415 M/sec        =
            ( +-  0.92% )
        15,493,482      branch-misses             #    0.39% of all branch=
es          ( +-  2.15% )

           1.30709 +- 0.00890 seconds time elapsed  ( +-  0.68% )
           1.3205 +- 0.0134 seconds time elapsed  ( +-  1.02% ) (repeat)
           1.3083 +- 0.0132 seconds time elapsed  ( +-  1.01% ) (repeat)
end previously reported numbers

5.14.0.gf6a71a5-rt6-tip-rt (same config, full slub set.. obviously)
          7,707.63 msec task-clock                #    5.880 CPUs utilized=
            ( +-  1.46% )
           562,533      context-switches          #   72.984 K/sec        =
            ( +-  7.46% )
           208,475      cpu-migrations            #   27.048 K/sec        =
            ( +-  2.26% )
            13,022      page-faults               #    1.689 K/sec        =
            ( +-  0.80% )
    28,025,004,779      cycles                    #    3.636 GHz          =
            ( +-  1.34% )
    18,487,135,489      instructions              #    0.66  insn per cycl=
e           ( +-  1.58% )
     3,997,110,493      branches                  #  518.591 M/sec        =
            ( +-  1.65% )
        16,078,322      branch-misses             #    0.40% of all branch=
es          ( +-  4.23% )

            1.3108 +- 0.0135 seconds time elapsed  ( +-  1.03% )
            1.2997 +- 0.0138 seconds time elapsed  ( +-  1.06% ) (repeat)
            1.3009 +- 0.0166 seconds time elapsed  ( +-  1.28% ) (repeat)

5.14.0.gf6a71a5-rt6-tip-rt +list_lock=3Draw_spinlock_t
          8,252.59 msec task-clock                #    7.584 CPUs utilized=
            ( +-  0.27% )
           400,991      context-switches          #   48.590 K/sec        =
            ( +-  6.15% )
            35,979      cpu-migrations            #    4.360 K/sec        =
            ( +-  5.63% )
            13,261      page-faults               #    1.607 K/sec        =
            ( +-  0.73% )
    30,910,310,737      cycles                    #    3.746 GHz          =
            ( +-  0.31% )
    16,522,383,240      instructions              #    0.53  insn per cycl=
e           ( +-  0.92% )
     3,535,219,839      branches                  #  428.377 M/sec        =
            ( +-  0.96% )
        10,115,967      branch-misses             #    0.29% of all branch=
es          ( +-  4.32% )

           1.08817 +- 0.00238 seconds time elapsed  ( +-  0.22% )
           1.08583 +- 0.00243 seconds time elapsed  ( +-  0.22% ) (repeat)
           1.09003 +- 0.00164 seconds time elapsed  ( +-  0.15% ) (repeat)

5.14.0.g251a152-rt6-master-rt (+SLAB_MERGE_DEFAULT,SLUB_CPU_PARTIAL,SLAB_F=
REELIST_RANDOM/HARDENED)
          8,170.48 msec task-clock                #    7.390 CPUs utilized=
            ( +-  0.43% )
           449,994      context-switches          #   55.076 K/sec        =
            ( +-  4.20% )
            55,912      cpu-migrations            #    6.843 K/sec        =
            ( +-  4.28% )
            13,144      page-faults               #    1.609 K/sec        =
            ( +-  0.53% )
    30,484,114,812      cycles                    #    3.731 GHz          =
            ( +-  0.44% )
    17,554,521,787      instructions              #    0.58  insn per cycl=
e           ( +-  0.76% )
     3,751,725,852      branches                  #  459.181 M/sec        =
            ( +-  0.81% )
        13,421,985      branch-misses             #    0.36% of all branch=
es          ( +-  2.40% )

           1.10563 +- 0.00382 seconds time elapsed  ( +-  0.35% )
           1.1098 +- 0.0147 seconds time elapsed  ( +-  1.32% ) (repeat)
           1.11308 +- 0.00883 seconds time elapsed  ( +-  0.79% ) (repeat)

5.14.0.gf6a71a5-rt6-tip-rt +SLAB_MERGE_DEFAULT,SLUB_CPU_PARTIAL,SLAB_FREEL=
IST_RANDOM/HARDENED
          8,026.39 msec task-clock                #    7.320 CPUs utilized=
            ( +-  0.70% )
           496,579      context-switches          #   61.868 K/sec        =
            ( +-  6.78% )
            65,022      cpu-migrations            #    8.101 K/sec        =
            ( +-  8.29% )
            13,161      page-faults               #    1.640 K/sec        =
            ( +-  0.51% )
    29,870,954,733      cycles                    #    3.722 GHz          =
            ( +-  0.67% )
    17,617,522,235      instructions              #    0.59  insn per cycl=
e           ( +-  1.36% )
     3,760,346,459      branches                  #  468.498 M/sec        =
            ( +-  1.45% )
        12,863,520      branch-misses             #    0.34% of all branch=
es          ( +-  4.45% )

            1.0965 +- 0.0103 seconds time elapsed  ( +-  0.94% )
            1.08149 +- 0.00362 seconds time elapsed  ( +-  0.33% ) (repeat=
)
            1.10027 +- 0.00916 seconds time elapsed  ( +-  0.83% )

yup, perf delta =3D=3D config delta, lets have a peek at jitter

cyclictest -Smqp99& perf stat -r100 hackbench -s4096 -l500 && killall cycl=
ictest

5.14.0.gf6a71a5-rt6-tip-rt
SLUB+SLUB_DEBUG
T: 1 ( 5903) P:99 I:1500 C:  92330 Min:      1 Act:    2 Avg:    6 Max:   =
   19
T: 2 ( 5904) P:99 I:2000 C:  69247 Min:      1 Act:    2 Avg:    6 Max:   =
   21
T: 3 ( 5905) P:99 I:2500 C:  55395 Min:      1 Act:    3 Avg:    6 Max:   =
   22
T: 4 ( 5906) P:99 I:3000 C:  46163 Min:      1 Act:    4 Avg:    7 Max:   =
   22
T: 5 ( 5907) P:99 I:3500 C:  39568 Min:      1 Act:    3 Avg:    6 Max:   =
   23
T: 6 ( 5909) P:99 I:4000 C:  34621 Min:      1 Act:    2 Avg:    7 Max:   =
   22
T: 7 ( 5910) P:99 I:4500 C:  30774 Min:      1 Act:    3 Avg:    7 Max:   =
   18

SLUB+SLUB_DEBUG+list_lock=3Draw_spinlock_t
T: 1 ( 4044) P:99 I:1500 C:  73340 Min:      1 Act:    3 Avg:   10 Max:   =
   28
T: 2 ( 4045) P:99 I:2000 C:  55004 Min:      1 Act:    4 Avg:   10 Max:   =
   33
T: 3 ( 4046) P:99 I:2500 C:  44002 Min:      1 Act:    2 Avg:   10 Max:   =
   26
T: 4 ( 4047) P:99 I:3000 C:  36668 Min:      1 Act:    3 Avg:   10 Max:   =
   24
T: 5 ( 4048) P:99 I:3500 C:  31429 Min:      1 Act:    3 Avg:   10 Max:   =
   27
T: 6 ( 4049) P:99 I:4000 C:  27500 Min:      1 Act:    3 Avg:   11 Max:   =
   30
T: 7 ( 4050) P:99 I:4500 C:  24444 Min:      1 Act:    4 Avg:   11 Max:   =
   25

SLUB+SLUB_DEBUG+SLAB_MERGE_DEFAULT,SLUB_CPU_PARTIAL,SLAB_FREELIST_RANDOM/H=
ARDENED
T: 1 ( 4036) P:99 I:1500 C:  74039 Min:      1 Act:    3 Avg:    9 Max:   =
   31
T: 2 ( 4037) P:99 I:2000 C:  55528 Min:      1 Act:    3 Avg:   10 Max:   =
   29
T: 3 ( 4038) P:99 I:2500 C:  44422 Min:      1 Act:    2 Avg:   10 Max:   =
   31
T: 4 ( 4039) P:99 I:3000 C:  37017 Min:      1 Act:    2 Avg:    9 Max:   =
   23
T: 5 ( 4040) P:99 I:3500 C:  31729 Min:      1 Act:    3 Avg:   10 Max:   =
   29
T: 6 ( 4041) P:99 I:4000 C:  27762 Min:      1 Act:    2 Avg:    8 Max:   =
   26
T: 7 ( 4042) P:99 I:4500 C:  24677 Min:      1 Act:    3 Avg:    9 Max:   =
   27

conclusion: gee, pi both works and ain't free - ditto add more stuff=3Dcyc=
les :)




