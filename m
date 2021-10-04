Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1F74204CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 03:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhJDBvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 21:51:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:47853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232113AbhJDBvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 21:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633312144;
        bh=YMsxXOi/dfMIzH2Mll91CKrgRo2FJKJGB8ID49Cuv0o=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gc8WwQnXBgTNV24dVNW98rtznztuaf+YQD7X8YujEaVTAL6Nd1fUDf0J2M7lldBAm
         ciioK4u4J3srNvGYfk9iYkN+RJjL9XRZVqW9PBu2vJMdiU5MI2fTo5ExUDZ2W+tmxg
         2UTXq2v+16zVaY5wxa1zPawckftJ/JSX2AeeL7kE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.159]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1mrMOM33rl-016fVQ; Mon, 04
 Oct 2021 03:49:03 +0200
Message-ID: <807ad42763f4b2a9f831a3ed93fe0d1b94449520.camel@gmx.de>
Subject: Re: wakeup_affine_weight() is b0rked - was Re: [PATCH 2/2]
 sched/fair: Scale wakeup granularity relative to nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 04 Oct 2021 03:49:00 +0200
In-Reply-To: <CAGsJ_4zAN-K_OrhC8wec9nyXxbP+sS_-N4djvaUYYVuYj+zbyQ@mail.gmail.com>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
         <20210921103621.GM3959@techsingularity.net>
         <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
         <02c977d239c312de5e15c77803118dcf1e11f216.camel@gmx.de>
         <CAGsJ_4xcRFcDMpuC7vrpHe=aRbDpAnRd1F64aqh2EEcNgmZxCg@mail.gmail.com>
         <4713ffb37ee8f6042626904ad33fa91b5151f0d6.camel@gmx.de>
         <CAGsJ_4zAN-K_OrhC8wec9nyXxbP+sS_-N4djvaUYYVuYj+zbyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fU0Of744qszbfVgDMxo7KTGw66h6LomOzPonpQ6w6NVHxssAnXG
 zrUnt4KD20o8/HaEa7vrh0BC8ch76aBpOyrwy3/rf4gCcfcUXGUmJSEFGeRmCAR8oI8j98s
 JFk3/ZLKHo5Rdnfq0SbxfDh2oW3aVB1yYWn+YVclHWg/FMKWZiRJSM3aRFE1hyPUJ4uSs0K
 u+/E6FhzDkFnSaw8p+AZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s/9lHDeGDSc=:rFFObjQmfBf4CEu9cs/98D
 nLT7YQSjreUPWB25H+jfsf+Lm8iAFBcHlSmIRBaP+L5opin1BNzWUwTHZg7XJQ4JVsG5pjTQ7
 t35x9YTeyPfLdknVQdgrlj6wF6x9hk/eSzvNV+qSi5JVNfXtnadueoPUeivxCwYZyV1KlX1Im
 zzMpSOpDLLbwjYAB0k1DB5GsvZ+espDiXnoD9OoHLK5iSX34lfmnjITKgdQoez9q1yQVHqkhk
 P32fagRyCYJ7ADIektbYvFTI0ybRMSI4d5MnH0VlQGhpIuTLd3Orj4lkk/intU868Z4KGtaVo
 O5WV7bA7FwDAKtlIKgaMQ0MuAV3Uzc1Z8pw/g4mBMFvfFX9M0IXkA0xiyx8/ZsA+pfHQSF63v
 l9uWNKFRYsFYySLgdDeuUNSoElboZ1cgTV4PmLLbt0UP6SIU8wPS48OH94+Ca634Y8Fe6ouRI
 DnOmdvqiFFYNIH6kYE+FJr5l6YnbStDNv2sMANw4G8XrNsLcvWM1kGvX8YcpkSpzev/Gu8ouH
 PDClpoRYGYgLqqMs0PIGf34tV43LiTqLDxdxDJWR0BzpJVsDL7mNhSRSuxqHvtozBtvfdeNfy
 t33MjiVFcsFRr2RTfMZgEsBJeOIV809D1NbG4NW+Jx3kFzWvRmHCBe5pMJPVH9zv6+NMdyaMH
 zFmZ5q0bLe2QfEIxj7W87BOAY9QhmyPF6QZxRvqV9A2H/M41dzwnydi9Zetk0BohYJ/0qS0Qg
 sRaV+HZrDMCSjUnEQLJ5VweTULgw6nlB9znDUEiJoiPC0fV2/adw3fDydYQmssvy+1vA8uvd/
 8/jv4WwKAbn+pK3aXI9UHyROjmnc6xlwZPH2Q5sFLXFVX1lJS6e7iYYI6Cz5f3VKYCxgZVVSz
 QiibrYkmxCwFjra/i2VoSyAhfEgHKo9edZDYh58ikWFJM21kBkQM62Q6IjiJ1fKJG0OX7CzIP
 GCDgpDp4h3uLiutfCq25WATVpOZhFrJ+hgo2k7FIIYVCCpJtVuqm3qaRbOEkNIVABzSW/l/Uz
 vmKBbSoLrzc+KoF3FovdUN7r4n58RMr1jXmwUbBrb5k4ox4TQ/mFxE1/x4/GtidXilVK9piOS
 l/Y+v5VB1vwMpg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-04 at 10:06 +1300, Barry Song wrote:
>
> What is the topology of your hardware?

It's an i4790 quad+smt.

> shouldn't select_idle_sibling find some other idle CPUs in CPU7's LLC
> domain? Why are you always getting CPU7?

The box is busy.  It's running a parallel kbuild as well as the
desktop, firefox and their various minions (et al.. kthreads).

> one thing bothering me is that we are using the load of a single CPU
> in wake_affine_weight(), but we are actually scanning the whole LLC
> afterwards.

The question wake_affine() is answering is one from the bad old days of
SMP, of pull the task to toasty data, or make it drag that data across
horrible hardware. LLC came into the equation much later.  With it, and
big boxen with several of them, the wake affine question became mostly
about which LLC, but not solely.  There's still L2 to consider, and
there's even a valid time to stack two communicating tasks like in the
bad old SMP days.. say when there would be a man-in-the-middle of the
conversation if wakee were to be left on its previous CPU.

	-Mike
