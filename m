Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E763437649
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 14:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhJVMDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 08:03:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:45367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230155AbhJVMD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634904042;
        bh=CV0bzqAO8xhY3j1WtbeSZ+D5Dn8OhUt0AEt1/gMj7+U=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=G6XJ6weTRoS/MvonxLAV4cyBsej5LR0tCDtcT8u9+E+G/0PDBCBzJprrr4b0TUdCT
         NaOg6kYR97HEmtAd1RVBRXbCqj5mL4uiVl31/IOLDoM9Yl8M1fzjgZqzZScTUTWDD1
         t00TQcbSfB5s+eyfeh5ntcIVUhP0pMyPnQdju4CU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.113]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUrx-1mtWEa3Z9t-00xtRH; Fri, 22
 Oct 2021 14:00:41 +0200
Message-ID: <2fd273f7284c78b65927b2b2572a66985cee0199.camel@gmx.de>
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
Date:   Fri, 22 Oct 2021 14:00:38 +0200
In-Reply-To: <20211022110534.GJ3959@techsingularity.net>
References: <20211021145603.5313-1-mgorman@techsingularity.net>
         <20211021145603.5313-2-mgorman@techsingularity.net>
         <37d8c167df66a1ead16b699115548ca376494c0c.camel@gmx.de>
         <20211022110534.GJ3959@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lz2y05m0t9AO/lc7DM+cX8VtslQiwOxSUt32F3LvNV1JGJRZI/t
 Ib/HxfG11By5l8GBM3FNgywxdZlngcszMfhuPdGQxWFiEa7M84RhciWp0Q5l8dOkTKVgpb9
 40rZymR42Qek2ClqO+LcBCd76llDIg5ETDksBGjscpvx2soAapSrLPzzgK2KZeSpx+LwzWy
 mZynS62cmseDCKo3j9izA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XgErVOZclIw=:q3TMD6jxCCH+zC+R0+Y9hj
 +Uhmv/LwxP9sJE6OfCFEQXd8uhdprmXSNkFwidCM/uB76ezodckodZJO1b5So907IEiJe/uUk
 /knVw57kW3hUqyOYCiC7nBcO5FNQjEh8NCLQaqk7ZVY7CBoIKiUdjNflNN84o2sQK6+5/cWo2
 4yHnpQs2YWl/j5+Kpv82zrCajNvLmya4Bhj+Ds49ZHzgFzzoJqhRHmJFI2Z4SZ/hyBZH3swMW
 ILvAt/rCe/uxQsoJnnUO/4GMnCFwJet7vfUsdnyLQrz5qXKDm2BsJNpIVBwJKFbnc8XvFSoUT
 yJHtGg1S3/O91rlMFkOwmJOdlaRwt7Gcv/MdKCzhaTRiZZ56BiOvc4/pn9sHX2iVNDwMqY9Ve
 Wy7Tl2YBkx7B8q58mzOVwM4W+fzqY0DMK+GntgplyOVjFLjwwb60cGNjT6nw8QyGlYrK4/Ikk
 ngvPA20dluYuTTLPGzkYlrVv4ftKCPPiI/mD66z2QkrwXrvCwPmpDbb9BsvHYxaw1PBkcPKP0
 rBmy7gUX58CRlIZoNJQh8clv5LOITPescc3fkRdRTBJ/7VDFJ/KNwsGyMBws/3bDqhGX5p/pW
 /iuMtUCiYDdbfYddiKMj13TY0kLwP6tiDbgY8iWGxyJqJpihSD/Yv4mx+jMWEr2aNhAnTVFAR
 /qJeuB8YSGdwyo6cK5YYhYY9Fa18/ukXprqmJrEPEOX4yqUEaglgFRjQMqn94dQhJ2HdYF0gp
 DuWgmNIN4vLfDZFnB6r1rOjukX8vcOeTX+j82xch+7vA48bzOwPC6v4ELCxDhem8ecK62QPd6
 se/SAbpuPXnVw2Ur3EJXiv6lXyhiDDIHsRyXmSta9qbLpR/NRaXoCGuMl6AJ/HhzGthhJHyRT
 dKyAIthXruDEiBy4zfCc+VRl+amOmR2IYeMhhftQCBrbnlS4xPpQog/nAWgDg29wSjMIe0zHy
 XdSRwnMMH0YTXfNN31YB9z5nG65GEn0WgizJzo1ipdKJTonCne0RB+2ibZM0zxAHknynW8xiC
 +1tW+sgot7SXqjs26gVV4OeDG9IdMhWNFou0Rbh6iTD9GeNiXstHt8kdnABEp4O/h4WsBaFvF
 8Rd4oIijh0qSik=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-10-22 at 12:05 +0100, Mel Gorman wrote:
> On Fri, Oct 22, 2021 at 12:26:08PM +0200, Mike Galbraith wrote:
>
> >
> > Hm.=C2=A0 If patchlet repeatably impacts buddy pairs one way or the ot=
her,
> > it should probably be tossed out the nearest window.
> >
>
> I don't see how buddy pairing would be impacted although there is likely
> differences in the degree tasks get preempted due to pulling tasks.

Hohum, numbers get to say whatever (weirdness) they want to I suppose.

btw, below are some desktop impact numbers I had collected.

box =3D i7-4790 quad+smt
desktop vs massive_intr 8 9999 (8 x 8ms run/1ms sleep, for 9999 secs.. eff=
ectively forever)
perf sched record -a -- su mikeg -c 'firefox https://www.youtube.com/watch=
?v=3Daqz-KE-bpKQ'& sleep 300 && killall perf firefox
                     runtime              runtime               sum delay =
     sum delay        sum delay       switches      desktop
patch/features       total          util  massive_intr   util   total     =
     massive_intr     desktop        total/massive  util
virgin/stock         2267347.921 ms 94.4% 1932675.152 ms 80.5%  158611.016=
 ms  133309.938 ms    25301.078 ms  594780/441157   13.9%
virgin/-wa_weight    2236871.408 ms 93.2% 1881464.401 ms 78.3%  255785.391=
 ms  243958.616 ms    11826.775 ms 1525470/1424083  14.8%
                          -1.34%    -1.2%                -2.2%            =
                        -13.474 s                   +0.9%
wake_wide/stock      2254335.961 ms 93.9% 1917834.157 ms 79.9%  164766.194=
 ms  141974.540 ms    22791.654 ms  720711/599064   14.0%

While patchlet mitigated the stacking somewhat, it wasn't meaningful to
my test load (BigBuckBunny for the 10001th time).  PELT clearly stacks
up the desktop pretty damn badly, but gets away with it.. in this case.

OTOH, killing stacking graveyard dead via NO_WA_WEIGHT would have
certainly dinged up cache quite a bit for the compute load had it been
something other than a synthetic CPU burner, so there's a brownie point
for PELT in the mix to go along with its stacking demerit.

Given there was zero perceptible difference, the only thing patchlet
really did was to give me a warm fuzzy knowing it was in there fighting
the good fight against obscene *looking* stacking (with potential).

	-Mike
