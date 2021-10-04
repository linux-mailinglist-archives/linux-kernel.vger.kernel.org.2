Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C8C42056A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 06:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhJDEg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 00:36:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:49943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbhJDEg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 00:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633322069;
        bh=mfbOeHh48bvNKKVNLVixvoLyDk726M8pdwxjjJcaT4k=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=l2xc1PIHX/UGOU6ek+dBIUE8oQuLT9AUboOSMdsk1NTiWaOpfVQOwpNeDIio1Iy/H
         1ywfltToPRcv9VC1NGsmxQ1HutFeFwEcm0sVy90uFFDO3v6YvCnJoiV50xTFyG2Wt3
         wuKZoX4rngmZhUcJmTBMBDlcrD/jFOQfENgeUkF4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.159]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59GA-1mYLbt05zg-001C2y; Mon, 04
 Oct 2021 06:34:29 +0200
Message-ID: <f1b421f956fa044b4efa7f5fef015725b27223cf.camel@gmx.de>
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
Date:   Mon, 04 Oct 2021 06:34:26 +0200
In-Reply-To: <CAGsJ_4xcRFcDMpuC7vrpHe=aRbDpAnRd1F64aqh2EEcNgmZxCg@mail.gmail.com>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
         <20210921103621.GM3959@techsingularity.net>
         <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
         <02c977d239c312de5e15c77803118dcf1e11f216.camel@gmx.de>
         <CAGsJ_4xcRFcDMpuC7vrpHe=aRbDpAnRd1F64aqh2EEcNgmZxCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bv1+/j0w6Rmu8lrkrj9iswEsvfmxTGOuiZlSdT1VcUD7swVzql5
 f4wh5MikpHPYlnvbOo2DtYa7VcEf9bg54xxgx7NKicqzNHXJCLcPOwSFUiYnPzezCfoGgGW
 VXzUWr5PuqaXZPFDKCBXs8ev7W/Otb+QDUbhHFE9OJYpkL8/viCCx57WZaUKYJWxo1RH92e
 vOKqbkMMOQZV/2MoeEhCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TF5WtaWF8MQ=:upNBkGFiUZMTt03XZNu0pV
 +XY58JKUOIrkqV7dfwfDsWd5RdRrrnWkOujmmZ1IRDA6B44e8KMYPadf+gfrRemHgqDhsQ75W
 XH27Zx04PhJkPYdiCEMMMcHvBI6XI1qdtKzLc8i2mwRscYpdaUx0kOwEw9+SycSpHVGuwbZ+1
 K7aGZM1J/accn4xRYp8qybpoqORsM7uwcxuk1n3picrZEUr47B3nbi+X2AfxBe7atkL4hjgAd
 /aa0nTrtQ0po6WK88bPwTyH13wnHAnoe4Vy/tHLVd5vnd+2FIpT3JKeXs++YhlfcnmYGQoBLB
 Tk5NPyO+O25PT7zlGq7ckZUEuzPw0k6mTjC3e63gDRR4FZJULyEmpuXuGN7IMot41wNSP3CHq
 etYFl1/bTE5J711COyx4j37E2L0EH2XmLguMt6AKsw8LsQgTRYzQMx9bg8+5/6oN6mQx9TG7x
 6R04x//xhPiKZ8mllcHIaYfB/GT9PBYkTTJLvmE/CNceE/Xhw6mx8MOuQWaS+cr7OsEMHxsoe
 2rpOTIu6kuH2kaCA41TB3i1ImVVe5MnhX2B9LA+87/zDEm9r3JPrko8jVPrKSJ/XMscmuTydZ
 vq2Mvt8WB68TONBkPT0imiwY6XqK7zRYEUQaUmJw3eAHtvSaeZO05q7K7cLqFJF294p+byBca
 xdLZFevzueVtUmI2szAftDkNJsFrdc0OUe1k59/Av2uhEUskf+eTFiFoKLWf3TonJckZVghLD
 Sxzx7Mvf4v+rmY6Oj6eYEGfetK5bswqP7UE2QYUfe9YGN4G3sMyS8Om1QxbLfy5I5MO+alS3O
 SqX4T4bG/J3sv7qyd9YezOMpY3b3AD00lqAG6+YU5GM2hNI5cEhoouIM/k94UKDxEtLSRTOfs
 F7DuXnvrMJbIJLag/eveIDCSXa4kJdt01Ne6vKKrwVAZenfpuM7Bpp+FASyrYt0Z0hTXdfc5/
 6DKj0qH0EB4pwhvy4dmhntSSvESbgDmrfLI/nJ5XsHdoKCNe+qkm6ATAeW8nOVQ9DXXLcG9Ry
 3tcpbp7+10S9H0IIiivjXs9/lU43Y4tzBzE8Ld/nGveZ5saKMbZi5krtF0z5GUs1VjlYA8f3J
 yrRwPnkcLk70cU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-10-03 at 20:34 +1300, Barry Song wrote:
>
> I am wondering if this should be the responsibility of wake_wide()?

Those event threads we stacked so high (which are kde minions btw),
don't generally accrue _any_ wakee_flips, so when X wakes a slew of the
things, wake_wide()'s heuristic rejects the lot.

So yeah, the blame game for this issue is a target rich environment.
Shoot either of 'em (or both), and you'll hit the bad guy.

	-Mike
