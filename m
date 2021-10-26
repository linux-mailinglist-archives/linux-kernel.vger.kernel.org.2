Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE443AFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhJZKTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:19:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:50263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235249AbhJZKSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635243342;
        bh=7nOg+WbWudfsXn69esM+imng/AQVqbUy9nVxWfrynf8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=LXzsjYkpR7QH6UVC4vGClfdtQHSd8sC3ThirGcT/qGdTQDZz2d10gryPCEQkEhPtM
         GcphTJCc6t+MIbJ/ITq/a2hgodSMGFODcwc9bqISOm4oaROqw7Mk64JmsxPmTo7NBJ
         DgCPfHrewp/W5sM46umjyOvY8XEnII6OgMhRoGkc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.217]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1nFCbY346X-00cwDY; Tue, 26
 Oct 2021 12:15:41 +0200
Message-ID: <4105fd08f84c60698b38efcb4d22e999de187d6e.camel@gmx.de>
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
Date:   Tue, 26 Oct 2021 12:15:31 +0200
In-Reply-To: <20211026081817.GM3959@techsingularity.net>
References: <20211021145603.5313-1-mgorman@techsingularity.net>
         <20211021145603.5313-2-mgorman@techsingularity.net>
         <37d8c167df66a1ead16b699115548ca376494c0c.camel@gmx.de>
         <20211022110534.GJ3959@techsingularity.net>
         <496d495b290ac69fed75d02ab5915a7871243321.camel@gmx.de>
         <20211026081817.GM3959@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c8DccyGYhkrA3FbIEsBnF1sTb32UrEw6yXVgc2GprQXFXpLm7py
 QNOtrumXwQGYL7W0IMR9xK4NxPqyblxZmgw+c3ltB8EbtWxQjjvC8DIcwLe3movalBc2pHB
 cMHDLQ02zQYVQnZamPt6xobnX+uHEd7AEhF9peyP2LzuDiJsEXXPDCXWcBFh81QgTRi6Y/Y
 WhTEilRc9AEi/b0WiUzeg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6dAJDhKzGKA=:gjxR4ys5r0gYZvwoW02U7e
 nr8KjIlBNf6qyuS1tU8w9xEhhVHUqAswGFb1Qg2fPUOFOO1X/0+X1xKRzGXmQFhIpAsywqVNS
 +IHs6MPZk5ihUc93znVsxEr87/iVxvvbIElRpoPd+U8+3PBDdcKcr5xGfCiXXS7W0SmiRysZd
 ftqcvKayuJo3MLNdL3m3aMDaOcwEKiuEu+T/TBctVXLr30UZG8O1Iu/nKu/fllpHJQamtB4OV
 idi+28bDy9nlC84sD5mcUapIduP7jjnfzlX3GQOeioQ8ovSehrRv1uNEr/BSQXAXqhtHlXUQW
 HnyPknoCu/7ZwkguxPKuxFAtVgAc/eAUTiiPMHqoc96a2cOXTujgonKmnw8JjRWSDzicNq6Wz
 d9q9T1f5qPFChTEddqOmhXxu3J1VTypl+uDqN3nQA88/+zdq8yXUwrCQkRBOIOwx47GrhXB4o
 YOnO9zhg6LfmnmX5Zsy2fSpmvU6G6ybiBEKcFkv4F5mvDzUXuIVSrUM534HdgWadHkUDoRcYF
 KsxhTQtE3qr90XCva0ZyxweMAHjaGftsgNTeoAD5QI6dgdPAOfkJlA+dLOmBcGmoXEZSgKTq6
 KKwhTmAFAS7Sc6w9to4cYR8u3gFZTTxt8byV3E6KX8jdAtkYnSzKOpKhhaCs7NAMB9f5YpzUJ
 McHZT6l8gYzwcgcPf9dp2M8okaHzp/PMotO7ptdxgcqswiJdrtgHcJ4y0fYQPvS8ya+SirpDJ
 FW6+NowQpSs52/RiZ1Ae5OPCtmF/jvSSFHhclYik9r3UdoBuXauOJNdmDcHONDsfYPIed05Vz
 +qN29XqNToyXys+ntNfAUEznsgGQI08VNKT9WCMHyGx1wYaoh7ywCQ1mDf1loRuLcUuQaKe9D
 crzKtDUE1TnpCkGQi3cGMkcIwyIAZSmfDD9MaI72j59v5a/ljqCMDl4slq370Q/y8TzznlupC
 D6LUu/fqIeuh8iZkcTZCk5fDFJZDwD81D3v7okk346yIs6mm7jWdKIm1aAyvKPsDCVeh7X5Ev
 WCqUSHDZfv8D4ExRZEbVVVyRC+kWDGNvLL6NEQBVUiMSXGqlYMBGqF2ocypgCRcR6qKZguXLT
 PqXHJVemengGOw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-26 at 09:18 +0100, Mel Gorman wrote:
> On Mon, Oct 25, 2021 at 08:35:52AM +0200, Mike Galbraith wrote:
>
> >
> > My desktop trace session said distribution improved a bit, but there
> > was no meaningful latency or throughput improvement, making for a
> > pretty clear "nope" to the above question.
>
> Another interpretation is that it's simply neutral and does no harm.

Yes, patchlet not completely countermanding PELT is a good sign. Had it
continuously fired and countermanded PELT entirely, that would mean
either that it was busted, or that the desktop load is so damn over-
threaded as to be continuously waking more damn threads than can
possibly have any benefit whatsoever.  Neither of those having happened
happening is a good thing.  While I really dislike PELT's evil side,
it's other face is rather attractive... rob

> > It benefiting NUMA box
> > hackbench is a valid indicator, but one that is IMO too disconnected
> > from the real world to carry much weight.
> >
>
> I think if it's not shown to be harmful to a realistic workload but help=
s
> an overloaded example then it should be ok. While excessive overload is
> rare in a realistic workload, it does happen. There are a few workloads
> I've seen bugs for that were triggered when an excessive number of worke=
r
> threads get spawned and compete for CPU access which in turns leads more
> worker threads get spawned. There are application workarounds for this
> corner case but it still triggers bugs.
>

