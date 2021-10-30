Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8170744070B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 05:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhJ3DOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 23:14:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:47147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229921AbhJ3DOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 23:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635563494;
        bh=qjTtp88hW/qAnuLq6PK4CdIotMnR4Kq8WGCR55KIXz4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=DZrZ4yWa3krIjDRRcNThLwSb/YNITw05M1M8Ou8WriM5OjgzhZVStUbjiMuQKtef+
         /k4WP6nfi9R8fGWo+UbgIGN5kH5xwV9vwKCEzDAquF1PSXR3tJqPpK2iDTn9ssKUgn
         hAtZlVYDlWP3Foep62A2Y/+fnSWlU4pYOBP5S8c8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.242]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1mqkPo3WQf-00yv1o; Sat, 30
 Oct 2021 05:11:33 +0200
Message-ID: <ab98b05314846102baec5cbb46893675f4ea5cfb.camel@gmx.de>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
From:   Mike Galbraith <efault@gmx.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 30 Oct 2021 05:11:30 +0200
In-Reply-To: <CAKfTPtB-fJ7Pd6eYPDrHB8Ts0o7SCbN7nniAD9PSoF4Pf+xB3w@mail.gmail.com>
References: <20211028094834.1312-1-mgorman@techsingularity.net>
         <20211028094834.1312-2-mgorman@techsingularity.net>
         <CAKfTPtB-fJ7Pd6eYPDrHB8Ts0o7SCbN7nniAD9PSoF4Pf+xB3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:chsK/1SSDeIrgUkxsmaKoBd9QuPwC5WEIqIDqhsih6Jde/9dlzc
 OZcys95BQjHlsi7kMnbkbE+5E69qZgxEtxg7suHs305eiuQ7bwXOCRGl1oRTIzrAnfh+vdu
 Shh6LnlUzK0kCcxHZQuzP/ZrTtBxIyZvnBmrOxGg290rnomhcSLnXe60VIuGLEb6q/tRAF+
 HmkVbQKZUW9QT0MgFgYGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:esvAs1nuxIE=:VMt1UqDNoir4ABskIv+4ij
 glZs0jUXXcK0ri7y0C0PgzSILOw+WaKiKv0hocz7yWX2LDOu4Ba/jeUsb+b4wYA6ZnSkvWlXI
 H+dgfhiwya14zsv+Y5U9UWfPSO/VkjaQnR7YNp5F8WqdK0QizZAxQMXPvMH5S6s6MaWKfDyKt
 1ln7Q5LczRsTuE/MMa/TsPioAP0Bh4JgcAeUp4pmTCRSeGvXVNai8I+tLe31rF7YrP4NI5AkI
 dqC+n//r1RGBf0mM2Fsuvzi0F+uZjefQbafcRCNMCWHNdBawyQNEIVZcgOPVLPZXm2HQo/vhy
 bIxoL0OM2rwSXOVZyYN5Oo1ptcO6B7WsTEhDeSMk30Cr6b5X7C0cjC9lE0SoxGV+aI3BFwVbw
 v8OmxHpP5ZGdPu/sKWNHPFaQg0sBhYaYH/Sx8hnjZQaDE4xpm4cArjqc1ZaAl8tQc8WQG5sWS
 rCP6Hz6LD2EFWN1AMuJfmMNWD800udqJ6B6jtUCi8JGilAUtGSRsq4WeX0stalrqgce39195p
 lSsEfXt3kUqyc91u2f5nO+tCP8XOArnexfYfBBqvo/gwocyAqkcIX7cTso4DIjy11JxKhgcOP
 tFtOCABuOB/IVuKfFswWqMTQ+Qo+rHNMGgSyzRknLi59tcb4eqZlBaJTJzKD2mhK2x3yNO/j0
 Ni7OT3QkGvTneLJsm3b7ULykqNnbNChkdwh8BGA6xt5UH7U5ufSLFFMrR+MlQ2YMdQcNmWh8n
 mJBNsbWXxJiIdQJYlFUiAQiICzSrRGiTVFxn0r9A4Ew99GCJcUSLBQq3/XbbEAZ1OzV6PNqHW
 VlTZVw0OQ+Sl0H1eefye9Tx7H91fa9Qkv4w6iKVEnFZmDXXROT7/Fs126oxDMaXnly1sJUFob
 VafMBe/fyzYI2q1ywSt4Gkr/nKCf+bBWlO8KQGk5go29T3f85tCJJ13dl45WZungYzkyBMrpG
 zPeLc709Gq7yCzzSXYUENt9lWm5tdPIlKt4Nj838H9UplYtutBaKTORnKQhR9pP/2jR+6k32K
 AXvTRphB8Q+Aox8TfWWf45xedcoNxGrbJf879ZWUxDkt76HPHMRwG5LQoHZq44Mhh9gz4ScAB
 TYwq8DnaKjl6Zo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-10-29 at 17:17 +0200, Vincent Guittot wrote:
>
> I have a hard time understanding the rationale behind these changes
> and the one below. Could you provide more details about why to
> increase p->wakee_flips here ?

The rationale behind it was me discovering wake_affine_weight() use of
weight averages causing X waking a way too big thread pool to stack the
entire herd of 21 threads onto the waker's CPU while all other CPUs in
my little i7 box had one task each.  Preventing stacking is SIS or
wake_wide(), but because I was test driving a patch I had some fairness
concerns about, box was kept busy.  I was subsequently asked about
wake_wide()'s role, and while I don't think it should have one in a
single LLC box, looked into it, found that while X is a candidate,
event thread wakees were not. I think to self, what if I loosely couple
zero flip earning wakees, do so, then allow for a bit of decay wiggle
room while after watching it do its thing in realtime.

There you have the rationale.

While it did help, it did not eliminate the aforementioned worst case
because as desktop behavior changes, decay turns off the heuristic,
stacking follows.  I profiled it with a perf that sums delay (local mod
I find useful), and found that there was no real benefit to the light
desktop test load, at which point, no longer having NUMA boxen at my
disposal where wake_wide() does have a mission, I lost interest.  Mel
was interested however, fed it to SUSE's test array, and here we are.

Executive summary: patchlet is not so lovely mitigation of an even more
not so lovely scheduler behavior. The two deserve each other ;-)

Kidding aside, way better would be wake_wide() becoming obsolete.

	-Mike
