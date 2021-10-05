Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82CD422104
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhJEIop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:44:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:43867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhJEIon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633423332;
        bh=8vloTmutBIqcWlksH5esiytG0nlB3zdmM0rN/4QHZpo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ar3M5d2gUZDbWLyd1lGbMo7aOrwVEEINzMDbLvJnG6U85Q8c+uKHWPRtS7QO/TQqL
         WMGbSh3FJ6AIn7oIo8sV+5kPYqo8bGCwwjoSbmsIdju1OZMeyS9SIoC4oxCqbb66pu
         D6SlDkfhOwFRZYGbJ4yw0QOrxgCN5j0N3qp+lB7I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.74]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulmF-1mqIq03vnP-00rnkT; Tue, 05
 Oct 2021 10:42:12 +0200
Message-ID: <ba1195a9843add64b38fce9ceb186c0c21ef5783.camel@gmx.de>
Subject: Re: wakeup_affine_weight() is b0rked - was Re: [PATCH 2/2]
 sched/fair: Scale wakeup granularity relative to nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Barry Song <21cnbao@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 05 Oct 2021 10:42:07 +0200
In-Reply-To: <20211005074719.GP3959@techsingularity.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
         <20210921103621.GM3959@techsingularity.net>
         <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
         <02c977d239c312de5e15c77803118dcf1e11f216.camel@gmx.de>
         <CAGsJ_4xcRFcDMpuC7vrpHe=aRbDpAnRd1F64aqh2EEcNgmZxCg@mail.gmail.com>
         <f1b421f956fa044b4efa7f5fef015725b27223cf.camel@gmx.de>
         <4f571c5c759b9d356d1bb4114fb169181194a780.camel@gmx.de>
         <20211005074719.GP3959@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BYOEhFKj5Pc/3Qc/U3noD5es72ht/FLWnDkRbltiJ1s+IUifPS7
 sPoIR5ESZxf4m0uXQXYtMm3iMrMbVkECqRBn5OSpyVaHJH7tLm/6YmiSikxBURyPQLX8D6R
 EYunBgFUTmgsXBPruut4ndT7ra7yEXvGVr9HuokBpxE2HSChHYu4vmvvCEUR0onoJj5+DXC
 Aa51bgz00P5cnuvKE2yHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:K2jJnMg12QQ=:pa+21JsPRfpWQS5dGzbBvt
 QgiP9Ioq+7w34kd6XbAUvjfJG1IYtQvCt8VK9Mcuiga6Vq0Fr4D1PN2HSUOu5Yk6brur9uArK
 R9irJYiKMPnMf0b8bH/2JIGA4f/Vkct+Iir/V+EsiV+LcAJFbpY/mKSZFzndEqGaaEUHXk4Y6
 DRWU1WWLQ/sSR4lvRlxoMjAI9okEO919zNhdn4xhSFdyIFQXNONFF7Nh1JZxEd/ZYfkXR6iMk
 aVx7Lo32mr7Lxl1TnJoLF9IL0xyOc87XuiuxVjsb6QRqrNlAbthwtMI3eM8tju7aGmcTV9GN2
 bBjHMdNOHU0CxYkX/YJYeFqlfbWxS4SRcPRFeEzhyBpcU1LISOrguCUBWZkaNm+Kq1XQRudqU
 z9qZ8LugQ1KVr/hsiwRVOPt4oHF9x5WF47zer8n09/uL3kxDtED2qgzXFCUYDwjosHbvUYJOl
 G8F8HsObBCxm5AEwX6qdxoQ1w7yZN3k1dr1giMqqQhZwC8BjBi3UjsC1zMr9PpZBXhQh16CVI
 dbUfMhOjP+/BNQdveNVeCkLhpDbKpOLet/uC+Z+4yi1Tu/R4E14LRV7u8KZOgr6FqfE5U58vj
 oNaS5iJ4Nsf/GNcla9atoeCPhQQCFUdKs2+pghTcAnO1/jONI8eZymBcBf8XkCei2/DjISEao
 8g/CqFvWrernB1sx8ACmYDppLmj6GoXL+SER5Gv2dJFiqT4mBC0KapOXmYRHmM3PT07AA3KH/
 FDL6v/p2Fh2uHUf8gO37xrxvdsFX/sbHdGmFyV4YcOB1Uy6kp7bdr33CQqckO9p0VTfmW8r9f
 pkPbFen2FkXLzgDOLrO7dAflufK7emidvduLkvfFD9fkBVdc6I5Gx4qeFbOqOA2Qd93IlkOo0
 /jay5xu8X+mKefHdx7/uqv/GZITHnTK3X2//gyMY6D/zbh9dnGNkn10EUkKsVAf0wzQDRVAPf
 zV0uXnvNwPdBYuw2pojtXJZ5BNvUERHApLKm7bMFoS7XiW1qKeFtUPrdDzEcKimEqpXONSv/x
 QVjKEq+l13CBav3+uv3urwqp49YZr9Or2NdRBRERhNapjq4op/ctteBOyplPMpEPmHy7h9WXU
 pgBjeo05wdpgjM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-05 at 08:47 +0100, Mel Gorman wrote:
> On Mon, Oct 04, 2021 at 11:06:30AM +0200, Mike Galbraith wrote:
> >
> > The mallet below convinced wake_wide() that X waking event threads is
> > something it most definitely should care about.=C2=A0 It's not perfect=
, can
> > get caught with its pants down, because behavior changes a LOT, but I
> > at least have to work at it a bit to stack tasks to the ceiling.
> >
> > With make -j8 running along with firefox with two tabs, one containing
> > youtube's suggestions of stuff you probably don't want to watch, the
> > other a running clip, if I have the idle tab in focus, and don't drive
> > mouse around, flips decay enough for wake_wide() to lose interest, but
> > just wiggle the mouse, and it starts waking wide. Focus on the running
> > clip, and it continuously wakes wide. =C2=A0
> >
> > Hacky, but way better behavior.. at this particular testcase.. in this
> > particular box.. at least once :)
> >
>
> Only three machines managed to complete tests overnight. For most
> workloads test, it was neutral or slight improvements. For
> multi-kernbench__netperf-tcp-rr-multipair (kernel compile +
> netperf-tcp-rr combined), there was little to no change.
>
> For the heavy overloaded cases (hackbench again), it was variable. Worst
> improvement was a gain of 1-3%. Best improvement (single socket skylake
> with 8 logical CPUs SMT enabled) was 1%-18% depending on the group
> count.

I wrote up a changelog to remind future me why I bent it up, but I'm
not going to submit it. I'll leave the twiddling to folks who can be
more responsive to possible (spelled probable;) regression reports than
I can be.

	-Mike

