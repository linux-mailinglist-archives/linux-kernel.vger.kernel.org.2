Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0231A414132
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhIVFYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:24:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:50589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231896AbhIVFYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632288142;
        bh=5hgh/U4SYPOaZ0UeQj+Ij9M+/6aYz1DP0O5BJh1rX0Q=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=R6DynJvbvk69c/KOnPOQ1K76JGiUhNY/wVKWfsbtz00PN4m0lZ62QkXR8UZOE8Ws2
         YrEIf15BtBjQlW4EHinWXH+n/+FCQQjC3QofSEpoMb7fa+temJF1cKidOShHAAygNK
         oVxqwXiSSTR6UZbpuJcSVZ2HySJjuBIUBqJbdIJk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.221]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5QF-1mgsor1dNH-00FDiW; Wed, 22
 Sep 2021 07:22:22 +0200
Message-ID: <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 22 Sep 2021 07:22:20 +0200
In-Reply-To: <20210921103621.GM3959@techsingularity.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
         <20210921103621.GM3959@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RNG5cLLtX2XEjwKA3501VUiYBjUdVAaf7VQilPiTF6v+IDYqZJw
 uzVPuWQxqRy69N2fnFrnksSyxxwfaazCaaCGQRF8YKO+0C/3Ei6o9KawA7qQuq9iiC4SoSt
 vXB+77WjwIYeTDjXipjo9jdc6ps2dUvKXhHIWIBiAaqwviPaWx87vpZ3Y3jg6vM91pZpFrn
 xetY9ImVOPX6kYBm6PPog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uXySdueNrrM=:Q2X070B4E6uKRHJOymgvym
 UDpmvct952BkTFmPy03M9nIljiAEh/i7oKMzM3Vpr6U1yldcDVXCyH9yt+fIro+ToHFRJt8Ti
 0qJwfKFKXS+BTPio+DhO8A6VQKLIKVGXIikMYSH8QkF0efJs/F+T521h1p8MDyq7pn0tSuGWu
 CjIqrQzVj1maEoDOvmUFDg/6aGJsYwfXRN4Na68eFe6Xo1f1FQpV/sjKes4rxsOCD32NogK10
 f4pvJ33f4EtP1ZBtQUdx7X+t8I/Rou3Csp0nJU3gSyPMqUiBJzMkQ77xBIfAodd4cZpWNRNAl
 EyLCce17KMJUJ48KEd2FPjr0OcvLHeHxjbevzcDW7VdOtEVLXwp0ItbJIk/1UaXtnkhtJL7kw
 tn1nQAdRECqD4k3bVaSgAv86QpKipjRm18MUbkfEwqMJ3zuqT5JXH0xfn7xq0CEb72ipjtxdD
 4KH3kiB1/ad6FXQeDbB8bKKmyb6XF/K9ubpnLykqfF2NaU/FX9VCRueemgPeVx3svlcVKCI/s
 8q6OAx5QZ1cXnUs27RSGrrO+JJcpu2J2skB7UJ4CccCZzlbmU1OBew9Jfd/AxWqLl80etP2EB
 bzFfsucdCqkhU0Q4/Iqc0tC3mMcSt2WNnWsYVuVFUz5DpLpSodgkapsHyaUX4O8bsqyr2spw5
 uH2Ib5vCUD8cMHJcSfCC+6eXklFASJbMhOWFq79wQCOxGYWV0batobwXi2p2zrGWrJSuQr27F
 VJrqv0aGi25LK7R6Bt/TlOt3AfoefkMtLTUzQ6JXE1PZjhjjMwP4/kFPtpfYV0KLBQE1tWAcf
 iRsiWUhfTu5Elnl4IOYJz17AEz63HZgSquQ9UdD2mU5dhv1h0XaY1xdDXBf6rlFP7cZQGgEGA
 +HZG46zYZ0frFpHbH2kD8Re5juPjVwd3EHZNqTDfk77ahJwGsCvg6wLItgz0bF0JpwDCKyOYU
 cj42BuXBorNxICCR2eH+b+514/deNjwHEdk0EMvixPrq9Q5ZNY8z+DstQydyGVM3BaxgSlATn
 3oDcLYKtrKkD658DCQ1jXxnZ8dt4F4Huj2agIJd2lJw3MegzdD7/kVjHn0osVO5isnWRUzqVX
 dle9w8NwmPcWmY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-09-21 at 11:36 +0100, Mel Gorman wrote:
> On Tue, Sep 21, 2021 at 05:52:32AM +0200, Mike Galbraith wrote:
>
>
> > Preemption does rapidly run into diminishing return as load climbs for
> > a lot of loads, but as you know, it's a rather sticky wicket because
> > even when over-committed, preventing light control threads from slicin=
g
> > through (what can be a load's own work crew of) hogs can seriously
> > injure performance.
> >
>
> Turning this into a classic Rob Peter To Pay Paul problem. We don't know
> if there is a light control thread that needs to run or not that affects
> overall performance. It all depends on whether that control thread needs
> to make progress for the overall workload or whether there are a mix of
> workloads resulting in overloading.

WRT overload, and our good buddies Peter and Paul :) I added...
	if (gran >=3D sysctl_sched_latency >> 1)
		trace_printk("runnable:%d preempt disabled\n",cfs_rq->nr_running);
...to watch, and met the below when I.. logged in.

homer:..debug/tracing # tail -20 trace
               X-2229    [002] d..5.    60.690322: wakeup_gran: runnable:9=
 preempt disabled
               X-2229    [002] d..5.    60.690325: wakeup_gran: runnable:1=
0 preempt disabled
               X-2229    [002] d..5.    60.690330: wakeup_gran: runnable:1=
1 preempt disabled
               X-2229    [002] d..5.    60.690363: wakeup_gran: runnable:1=
3 preempt disabled
               X-2229    [002] d..5.    60.690377: wakeup_gran: runnable:1=
4 preempt disabled
               X-2229    [002] d..5.    60.690390: wakeup_gran: runnable:1=
5 preempt disabled
               X-2229    [002] d..5.    60.690404: wakeup_gran: runnable:1=
6 preempt disabled
               X-2229    [002] d..5.    60.690425: wakeup_gran: runnable:9=
 preempt disabled
       ksmserver-2694    [003] d..3.    60.690432: wakeup_gran: runnable:6=
 preempt disabled
       ksmserver-2694    [003] d..3.    60.690436: wakeup_gran: runnable:7=
 preempt disabled
               X-2229    [002] d..5.    60.690451: wakeup_gran: runnable:6=
 preempt disabled
               X-2229    [002] d..5.    60.690465: wakeup_gran: runnable:7=
 preempt disabled
            kmix-2736    [000] d..3.    60.690491: wakeup_gran: runnable:6=
 preempt disabled
               X-2229    [004] d..5.    92.889635: wakeup_gran: runnable:6=
 preempt disabled
               X-2229    [004] d..5.    92.889675: wakeup_gran: runnable:6=
 preempt disabled
               X-2229    [004] d..5.    92.889863: wakeup_gran: runnable:6=
 preempt disabled
               X-2229    [004] d..5.    92.889944: wakeup_gran: runnable:6=
 preempt disabled
               X-2229    [004] d..5.    92.889957: wakeup_gran: runnable:7=
 preempt disabled
               X-2229    [004] d..5.    92.889968: wakeup_gran: runnable:8=
 preempt disabled
  QXcbEventQueue-2740    [000] d..4.    92.890025: wakeup_gran: runnable:6=
 preempt disabled
homer:..debug/tracing

Watching 'while sleep 1; do clear;tail trace; done' with nothing but a
kbuild running is like watching top.  There's enough stacking during
routine use of my desktop box that it runs into the tick granularity
wall pretty much continuously, so 'overload' may want redefining.

	-Mike
