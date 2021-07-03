Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555BD3BA7A8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 09:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhGCH1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 03:27:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:42457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhGCH1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 03:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625297082;
        bh=aAQht86ygjqzuUvu+yg4HOD6z+4TpARHV7wzK6R1Ke4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=b+4eZ6j7ELesHiF8GeAkr4cbAkd/0KTDWMr0Olwv0rEUNxGNKqK1KMFXU1ZjYiLre
         4bJQNE5pxF56nJhqLq2dt22vckTWVNJfWjcpCsaUpchNAGybvQRNztt4dFgWoHiPEA
         2PbPk5Ev2pxDslG5kOr0kknrE5pSmdTOaGm678cc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.218]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ykW-1m5cQJ3r5a-0063dD; Sat, 03
 Jul 2021 09:24:42 +0200
Message-ID: <891dc24e38106f8542f4c72831d52dc1a1863ae8.camel@gmx.de>
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
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
Date:   Sat, 03 Jul 2021 09:24:39 +0200
In-Reply-To: <20210702182944.lqa7o2a25to6czju@linutronix.de>
References: <20210609113903.1421-1-vbabka@suse.cz>
         <20210702182944.lqa7o2a25to6czju@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SZzxfTcLtL+Mr+NwejC8HfJ/MB82VSIgomyfpE4RRBVvyTJNpeG
 EhldT0r9Vj1PHOdB8nVVfIf47hK6R1Ji0RMZ2KhtV4pLP9dKXz41K2uIhw94dBT0J2YA1Lr
 x1xHykTCIE1rV/B9u2wqVq1A/1GxdhhyuTn/Jc5sqAscEvu438a5W8z1TlCPTkBM5+TJWzU
 NAnQgZx7qM/AZQQ1o3xGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qCDe++ReYVY=:6vL+gWo8krqioqMCDD11lG
 RuIDkyTuapKwkUC/uhwdiZy2jOMWsXoNyAzfLaJZy0wCmpazaDOnW+U/ODj8b/xjXwLjHNM1T
 NyUvwVBg4C9iJmVEiofg76dWGg50hJy6gug6oVEg6/wvUC7GIrQqIxNHdYnkW4fdnlZM1TgNB
 65hbVyebEN3ob92W2vR1J8rgucBSOlMqAQyWjgi76XZ1hTNBbKkj9Favt2LtK/J6ECnOfrmkL
 01UOZOW/coQ5a1rczkpWfdGTsqyHaOqPRWxZ+qK4fWW9norSMykgA5+gPk3M3c/SzlPkVuszT
 3fZCA+2qO5mbXwUIPORqxN12yxzICK7AabamTIUg6ucJ1mXOv9y3IyrVf9n+5+azrPIyyNqYd
 Jsp3LyBZ14Zsu2Fkwmzu2YPYUvEeQD79jK858wTQk895D3L7WS1Q2QkaIsP9WlLJ/xT/1fWYs
 bCjN9xAX/y+o2ID2WJiMRARrKtmzWPAPq4OtyGq95tpMdmNncTOhIFgL+HskbRx+Mk34pFXLl
 R3Kwd7pGLs7Jo3CbPTKn01zcuSkSlUcDBeE4vdEsdvrqqU0ARCpbk/q+2lL0UT0F/GDPJhsJd
 g5eDEedgCqF3yiaaR2ei0Rqm8mXhZ0WSn8WDDZnERS935gau6XAWdckiwgWo3YzfIJlb7B0f5
 4qcqQRTBJtoJKYrX8LWcB6WS2DI4imbql/Z1VMIXnEQysAquqTl4I4NIFfLTQOV2l0jiwbp8i
 DpptVKwaQsG14h2JQFz6gVhUGJZRCirGx1qqqn9vayGoj/Yevd355vsHZxlmZ0RHflJEOxOG5
 QefmaNrEyuzejyvUHSrYftvXOzoC03XPPEylclUTG8oX+XFIhA3AIk/mavZsTxRoGmjQwCMkG
 o3szo7vKJWkwR/z8c0rDFwhdG9z7AGLnr/YPpOX/126w/qK5UMTYYwE+AyS15i+j3tmkE55WA
 rrhdBDfV5tyFyjrB6RLBufmQkS7jJD7UCmb7W9V4Qg9SAmmDKKg+0ooH/StYr8erOVb1OIe4q
 hoNjF7swVzh0Id/Ig8+NcKWcIfxAC4dilbGobHGLGe3WJ4kABdSjxo49oGVklPfBBxNr+pZ3j
 Lsyb/zHBPFsg7Ifk7g9cHDLwn6j1cyGx8ML
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-07-02 at 20:29 +0200, Sebastian Andrzej Siewior wrote:
> I replaced my slub changes with slub-local-lock-v2r3.
> I haven't seen any complains from lockdep or so which is good. Then I
> did this with RT enabled (and no debug):

Below is some raw hackbench data from my little i4790 desktop box.  It
says we'll definitely still want list_lock to be raw.

It also appears to be saying that there's something RT specific to
stare at in addition to the list_lock business, but add a pinch of salt
to that due to the config of the virgin(ish) tip tree being much
lighter than the enterprise(ish) config of the tip-rt tree.

perf stat -r10 hackbench -s4096 -l500
full warmup, record, repeat twice for elapsed

5.13.0.g60ab3ed-tip-rt
          8,898.51 msec task-clock                #    7.525 CPUs utilized            ( +-  0.33% )
           368,922      context-switches          #    0.041 M/sec                    ( +-  5.20% )
            42,281      cpu-migrations            #    0.005 M/sec                    ( +-  5.28% )
            13,180      page-faults               #    0.001 M/sec                    ( +-  0.70% )
    33,343,378,867      cycles                    #    3.747 GHz                      ( +-  0.30% )
    21,656,783,887      instructions              #    0.65  insn per cycle           ( +-  0.67% )
     4,408,569,663      branches                  #  495.428 M/sec                    ( +-  0.73% )
        12,040,125      branch-misses             #    0.27% of all branches          ( +-  2.93% )

           1.18260 +- 0.00473 seconds time elapsed  ( +-  0.40% )
           1.19018 +- 0.00441 seconds time elapsed  ( +-  0.37% ) (repeat)
           1.18260 +- 0.00473 seconds time elapsed  ( +-  0.40% ) (repeat)

5.13.0.g60ab3ed-tip-rt +slub-local-lock-v2r3 list_lock=raw_spinlock_t
          9,642.00 msec task-clock                #    7.521 CPUs utilized            ( +-  0.46% )
           462,091      context-switches          #    0.048 M/sec                    ( +-  4.79% )
            44,411      cpu-migrations            #    0.005 M/sec                    ( +-  4.34% )
            12,980      page-faults               #    0.001 M/sec                    ( +-  0.43% )
    36,098,859,429      cycles                    #    3.744 GHz                      ( +-  0.44% )
    25,462,853,462      instructions              #    0.71  insn per cycle           ( +-  0.50% )
     5,260,898,360      branches                  #  545.623 M/sec                    ( +-  0.52% )
        16,088,686      branch-misses             #    0.31% of all branches          ( +-  2.02% )

           1.28207 +- 0.00568 seconds time elapsed  ( +-  0.44% )
           1.28744 +- 0.00713 seconds time elapsed  ( +-  0.55% ) (repeat)
           1.28085 +- 0.00850 seconds time elapsed  ( +-  0.66% ) (repeat)

5.13.0.g60ab3ed-tip-rt +slub-local-lock-v2r3 list_lock=spinlock_t
         10,004.89 msec task-clock                #    6.029 CPUs utilized            ( +-  1.37% )
           654,311      context-switches          #    0.065 M/sec                    ( +-  5.16% )
           211,070      cpu-migrations            #    0.021 M/sec                    ( +-  1.38% )
            13,262      page-faults               #    0.001 M/sec                    ( +-  0.79% )
    36,585,914,931      cycles                    #    3.657 GHz                      ( +-  1.35% )
    27,682,240,511      instructions              #    0.76  insn per cycle           ( +-  1.06% )
     5,766,064,432      branches                  #  576.325 M/sec                    ( +-  1.11% )
        24,269,069      branch-misses             #    0.42% of all branches          ( +-  2.03% )

            1.6595 +- 0.0116 seconds time elapsed  ( +-  0.70% )
            1.6270 +- 0.0180 seconds time elapsed  ( +-  1.11% ) (repeat)
            1.6213 +- 0.0150 seconds time elapsed  ( +-  0.93% ) (repeat)

virgin(ish) tip
5.13.0.g60ab3ed-tip
          7,320.67 msec task-clock                #    7.792 CPUs utilized            ( +-  0.31% )
           221,215      context-switches          #    0.030 M/sec                    ( +-  3.97% )
            16,234      cpu-migrations            #    0.002 M/sec                    ( +-  4.07% )
            13,233      page-faults               #    0.002 M/sec                    ( +-  0.91% )
    27,592,205,252      cycles                    #    3.769 GHz                      ( +-  0.32% )
     8,309,495,040      instructions              #    0.30  insn per cycle           ( +-  0.37% )
     1,555,210,607      branches                  #  212.441 M/sec                    ( +-  0.42% )
         5,484,209      branch-misses             #    0.35% of all branches          ( +-  2.13% )

           0.93949 +- 0.00423 seconds time elapsed  ( +-  0.45% )
           0.94608 +- 0.00384 seconds time elapsed  ( +-  0.41% ) (repeat)
           0.94422 +- 0.00410 seconds time elapsed  ( +-  0.43% )

5.13.0.g60ab3ed-tip +slub-local-lock-v2r3
          7,343.57 msec task-clock                #    7.776 CPUs utilized            ( +-  0.44% )
           223,044      context-switches          #    0.030 M/sec                    ( +-  3.02% )
            16,057      cpu-migrations            #    0.002 M/sec                    ( +-  4.03% )
            13,164      page-faults               #    0.002 M/sec                    ( +-  0.97% )
    27,684,906,017      cycles                    #    3.770 GHz                      ( +-  0.45% )
     8,323,273,871      instructions              #    0.30  insn per cycle           ( +-  0.28% )
     1,556,106,680      branches                  #  211.901 M/sec                    ( +-  0.31% )
         5,463,468      branch-misses             #    0.35% of all branches          ( +-  1.33% )

           0.94440 +- 0.00352 seconds time elapsed  ( +-  0.37% )
           0.94830 +- 0.00228 seconds time elapsed  ( +-  0.24% ) (repeat)
           0.93813 +- 0.00440 seconds time elapsed  ( +-  0.47% ) (repeat)

