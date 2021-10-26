Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B1143B05A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhJZKo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:44:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:39529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234610AbhJZKo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635244899;
        bh=14D6tPu6/w2h5fXF3oe5B5m7qR91fUuAunOnONVlQy4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=kKGSHttxWvucd27+sltFv4pMJ/ljfSIUQOHt6jiE1Oo6LeiZwqiVdq527BZFXtRQo
         DggAUQaZjAaU1W8t0VdCo+DLIvbtEHojAt68vVcB/zKvRemr28vhp7BweXotzFLLs6
         KVTHyoZmqt4Qnput4qlobnHiMk+Ufyg4N49BgKYk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.49.114]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1mjWyJ0l0q-014GmI; Tue, 26
 Oct 2021 12:41:39 +0200
Message-ID: <b53de0da7c863ec4c883a92b2526a0f9132a24cb.camel@gmx.de>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
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
Date:   Tue, 26 Oct 2021 12:41:36 +0200
In-Reply-To: <4105fd08f84c60698b38efcb4d22e999de187d6e.camel@gmx.de>
References: <20211021145603.5313-1-mgorman@techsingularity.net>
         <20211021145603.5313-2-mgorman@techsingularity.net>
         <37d8c167df66a1ead16b699115548ca376494c0c.camel@gmx.de>
         <20211022110534.GJ3959@techsingularity.net>
         <496d495b290ac69fed75d02ab5915a7871243321.camel@gmx.de>
         <20211026081817.GM3959@techsingularity.net>
         <4105fd08f84c60698b38efcb4d22e999de187d6e.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+EcfWhzAuOffxc6Ta5wfgEYmzyUCWgibKWaOXJdc5oTpafHOjl9
 jAQISlBQIxQmwqrHutWFzPUCwMFlZvnqjyHc5HXtWe20OaqksRihJPV851M48a639Cw4XCV
 Et5kcataonB30hMlVYgPkJyoRGaKMYunc5EUQ1t2bV/1BuCavuYGyHT2Q1I0ivYy4fMpt0i
 T4xbZevnp+h/MOfa8gg9w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MNrjrNhalXE=:Vtfr79cBl1bZxmqayMgOZU
 eSNkzRjRqonACYfq5Id9s/3IM2NYE/6Hz4iUp0bgGNf2BRMiv6TM8QaBrzeZqee9PkdhIrssV
 iM90RAP7Sl1lj9qME0tbWOjjaZr/FlmUSrf6/aaQR7+svo4ro2HmxTzLmGaE4M8D+iPOy90jH
 bmmEul09tRm1/6/SpjUmgz6vPA3PVtQ86I6quGKToafzZqrhs5eW8iN0cr0HW274bkmIMzre9
 yVllH8RH8pKzwkGoRhWPfkbqexRsvuf6FLS/1S/++z/wNzhX6YIJ8RG3ua1eEWnw2KiyUpKNM
 VKS4tYYwQv+MO0nlvoyNOEynW9iKbwniubMAnQwJoi5pY6kkSc8HVyVbh27//3w+14sIYQ1Qc
 u2uGYIg4On9H5unhyhh3nYibTUc1r03tU5bxLOt0Sc1pypxnO2E3KQ/M8SJC9oOz2mb68VnsZ
 UyWAKaA0bpZ7x5HG6mn7dUquTnY5O0KrjJD3d1eHfNw0G6Y3sOMQsiCkvL2cTAyB8zH3Tm7tk
 vCYMqq8nMbPCHCM4sooBMH6CW1BC91IE7gLurL+XUL1zz5JoNxG/3/VNagUCq7g4NIAZN7YgN
 d5Rzkrr3KL1rpfR8iJE27PILzzO0cnSRKuMviEjPemm4tXjAmkTiISpZ8pxj/eJgJ6sPeKAMl
 7uzEHO3Dn9/YELpQ+d+F+PyY5r21AQeOhGqwfJTWMZoZb1fEdFqKdLRGqkqcEpfNrRLRV2BNl
 i4Zq4vRYjtsFp7Tn+wGWdHpuWk6UAFRH5k1xbV+MiXhM1eE+11baKx+8zydH+ivqqGs8DEP+9
 7fNpU1Vrljv48a0cJPM3xjBbjKNUQ0x1H6YR8tDCS055u9lYodBo0R+/cbw2sE9aFvuMN6itw
 e1v4YzNfW6wd05OeDO+Nxs2ptOmhEvJB57/ZveIo7hyX7lUshCOd68fz7X+JaYa8ZaGFaRG9n
 /FBf1fph85Ewq4MGfHfkErPsf9/O1nvA4oBuyefmlYuY0agSUKavUcU1iKTXo10y62Cbcu5iO
 UFSQI0rLWdlNNlz+/MBsElvCxie1AUYH7qojuQa8Exy/EXlbEDkLp1Wd1d0fRxeMoTscnJs2/
 0TP+P7PW3ipDoc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-26 at 12:15 +0200, Mike Galbraith wrote:
>
...

Well now, that interruption didn't go as planned. The briefer edit
would have been preferred, but you get the drift, so moving on...

> > > It benefiting NUMA box
> > > hackbench is a valid indicator, but one that is IMO too disconnected
> > > from the real world to carry much weight.
> > >
> >
> > I think if it's not shown to be harmful to a realistic workload but he=
lps
> > an overloaded example then it should be ok. While excessive overload i=
s
> > rare in a realistic workload, it does happen. There are a few workload=
s
> > I've seen bugs for that were triggered when an excessive number of wor=
ker
> > threads get spawned and compete for CPU access which in turns leads mo=
re
> > worker threads get spawned. There are application workarounds for this
> > corner case but it still triggers bugs.
>

wake_wide()'s proper test environment is NUMA, not a desktop box, so
patchlet has yet to meet a real world load that qualifies as such.
That it could detect the test load doing nutty stuff like waking a
thread pool three times the size of the box is all well and good, but
not the point.

$.02 WRT poor abused hackbench: if it happens to benefit that's fine,
but I don't think it should ever be considered change validation.  It's
a useful tool, but the common massive overload use is just nuts IMO.

	-Mike
