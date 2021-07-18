Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0903CC900
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 14:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhGRMNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 08:13:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:44629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232845AbhGRMNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 08:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626610187;
        bh=cuqyPzrx7IAW5c7lY3bsuKCM76Nm9JRNbAQCn9di5QA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=UBB1LCMega6vU4v0MXFc6E3FD4j/lTM22onIBtg0BGL5Tai0wRCaOZTMpjRQC0pO3
         x3YjXRjiD6jzrbSyQk+30IyqUpurzGCzncTwPnNKE8L3r0kJkoxxS+ir5KVOjewFzm
         aeeHylUnfv2kUM0KDZMmNbZSIrCm3SFQn+7nZ4IM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fmq-1l7vUY32zo-01242S; Sun, 18
 Jul 2021 14:09:46 +0200
Message-ID: <6c9d110538d431ce3f14577815a94be491eaa719.camel@gmx.de>
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
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
Date:   Sun, 18 Jul 2021 14:09:44 +0200
In-Reply-To: <64eda4de845c8d98e0dcb7f6fa3177037120e317.camel@gmx.de>
References: <20210609113903.1421-1-vbabka@suse.cz>
         <20210702182944.lqa7o2a25to6czju@linutronix.de>
         <891dc24e38106f8542f4c72831d52dc1a1863ae8.camel@gmx.de>
         <ef4903e2-c2ce-9a64-68b0-c7ee483eb582@suse.cz>
         <64eda4de845c8d98e0dcb7f6fa3177037120e317.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5ECMWE5n8wQibvnqzkfpFwBBauoJJ23F8wK36voR7s7nCr0SlBZ
 ds+42/nYfwP5juSTwWGCaVqCY4K0x3Swgy/4X7VWClPACmPBAVcSnhWDu8hVO/rJD7W5JkV
 qliocb8coV0/+LVqT6K278L7n38zB5WbcFeNdYRrSaSaah3fv4LkArgXmcZo/yJUxuf9rmy
 gos6/assHMrKKqTg98Qiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EZGkQIaZYb8=:r3yG/CuEiIzWxNmVS5kSOb
 q+zrhApLYx0sSpLhC+C7Q2x2jxsSWlAi/etupKU9cLwepQwPmUdJ+fVT14L6bjfowZratdx7N
 NJA4MbE/oXPmzPyAxjq4MY949YvYlf1E3lSyGF+xZmX8tVfNQRBeoPaqglRKejDQ5Do9/er6O
 u1Roy4QLh1dLDk0ysqZADOs+ueHjYkzGUqAE6DgbnQxLBCRtpXEf49nC0YLrD2SF2AMxNl3Qn
 tA0KtlvF2Pk6NlLR1mUwsdIDk1dFzoysHGX6JSOd1U3Y0sKaz6TGCqTHkRF7DzH0bYbO67NYn
 17Cln1+/ZTHpWXi7hqJd6mRnDvWIwyFGkHx8WG9ps4cLcPg68BJylwG4KEiAULk7cOgU/8Vzn
 RkffxdajTQoRcufsSfssfrCuBkV8eF+KJb733oxO0lAosrF0A9TPtaJO7wR73rLwL8QrySkPi
 JjV3rb22qMutg/U1xKYXpNXBg0xpRCw7HQuXvrAB3Lyx0yWuvvab9x3UrZ1zt8LOM4S2Gcp9D
 2CEQgVvGJ5Ab/KGlAkqWY4KLN2hm8TLwZa1GMzAZitD5fYTj/LrN5IM9KKCa37HqeSwBvqgKt
 Sg1Z/e82EfOfxqqrqbptu2Sv/4Y5eBzInFnT/bI/qfH+/xcXi3GTwEViIWtUr7EFtfA6jlhgh
 30dZIX1Od9nMKSSa38AKdAPezwnB+rno0h2NKEM2ACQtXAweRIpMN3/WmoPhqRkY4W5M4lnGC
 vsLHhmzDvDM6wwbDxpBbNbzL/FTMSyBf6QDvTwlEOdMgoyE76Ir3zHq+omdjAJdEyAfmLDG90
 PNpkCwCxXPh5TOIFm1vvadpynuD/rWFpmTuSHNxCyL+rpTbqIlJds2UouTSNiC7S0lWFY0PAi
 /0mYddBEHz59liL4TPFyG1kO0CnuaKHM2ejjjlo163Aqpx9GGFYi4QZR7MfE2FFj3QTkDrkwB
 BwKW2jv250Hyesz2luDrC8Z4ntq09uao77GjhM8+PckwzNUbl6LtC8aPz/dvDDRPrcRX215Hg
 YjWhENFdzs8z/0qpFn8n6mbqjDKsEL6zlqgFLp6NPo4I1hxiG21fG+APKswPe0BOHjn+MlaOL
 L7qQk8Lr/LWvE/PXx7V7J67PLLKz7bHSRb1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-07-18 at 10:29 +0200, Mike Galbraith wrote:
> On Sun, 2021-07-18 at 09:41 +0200, Vlastimil Babka wrote:
> > On 7/3/21 9:24 AM, Mike Galbraith wrote:
> > > On Fri, 2021-07-02 at 20:29 +0200, Sebastian Andrzej Siewior
> > > wrote:
> > > > I replaced my slub changes with slub-local-lock-v2r3.
> > > > I haven't seen any complains from lockdep or so which is good.
> > > > Then I
> > > > did this with RT enabled (and no debug):
> > >
> > > Below is some raw hackbench data from my little i4790 desktop
> > > box.  It
> > > says we'll definitely still want list_lock to be raw.
> >
> > Hi Mike, thanks a lot for the testing, sorry for late reply.
> >
> > Did you try, instead of raw list_lock, not applying the last, local
> > lock patch, as I suggested in reply to bigeasy?
>
> No, but I suppose I can give that a go.

The kernel has of course moved forward, so measure 'em again, but
starting before replacing 5.12-rt patches with slub-local-lock-v2r3.

box is old i4790 desktop
perf stat -r10 hackbench -s4096 -l500
full warmup, record, repeat twice for elapsed

Config has only SLUB+SLUB_DEBUG, as originally measured.

5.14.0.g79e92006-tip-rt (5.12-rt, 5.13-rt didn't exist when first measured=
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

