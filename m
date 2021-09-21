Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D2A412E51
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 07:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhIUFwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 01:52:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:45923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhIUFwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 01:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632203412;
        bh=+ziCyTMtmaAHMGXAw5lJ58Wa1DnJRuM4E8YVHPJWQrg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=bGw//5DpQ++5ncY7F6gcWioNdbXvF8WG+ftqzLDDpGluU8otAhL/U3OmvR1UuYy7b
         H2F2Yr340l6g5RwKokz+2vN+IWDrQDkBoM0g5blKyNG2zftGH1QPSRApTnkIJJb1oy
         LdluEkfYWhSdg9u6S1fOshXM0pya+lDezBSnJwsc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.33]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKu0-1mHSsW0caO-00SgsT; Tue, 21
 Sep 2021 07:50:12 +0200
Message-ID: <7e9545b069f19f0e5c57c53d4633c508009e796c.camel@gmx.de>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 21 Sep 2021 07:50:07 +0200
In-Reply-To: <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fje87h5xhcsoNQ7Rhsy6hvIBvsrt3yDLYM8APiXO5YnP8Bm/pYC
 rHeHJh63Rw7mS84P3ZVD4UFgfgtGYu9ixVXs66V7mQXqDQb8IQRGR9E2HRRekPIjK1o28Wr
 UAFL7GFXXCa2qsGuKshcCi+WtsXhc/sfglFaJEapTrZQyQhN2/bt+OmumtB+MUOcDIe9VMQ
 cFicszLsZfAxjufds1Z+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bM2y5YUkeQI=:2qj2aTa4ldBMq91aG8v6aJ
 JbRdKKLtddBDI+0Vu9R+yVrZCCgTGCX+80DG2zLqv0SOJm4o4DfXpOXIQrxQhvNYhn36Z0fVJ
 4NmC9U/L+B68RKDjky5Fmw3oDih0Bybil5IPIHIGIpq5xlkTz6DWwFawldgZRpkR6b9DjyUxi
 I6h20gv8yIC7x7i13RrWy/zVgcRyeHczRz5xJskNTyd6mY7m7So+Px3hKTOvJa64tUD5dQDUV
 O82/z8kjhL84SoCF71s/RzkNbdVQ+TIVWJrDmZDlXEB1ZSxeNIurLf/HRZMDcOVkbS2dTpu5F
 FfwhBLX844E4hnuk6sIRQjWN9LFGFU8GCOnUAWiMi2wrPBB9uQe4P3JbQjc3ZO5NEbQnx6jlA
 ukV0zms4OwV8AGnq7hCF0170E1KZAJ8sKnrcRayfNMiZ0jag1DPrF8h4CMq/MTSkScSyHCqPb
 Wi9dS/KF3nvxsa5jyMvVztf54wa7YN+9CI3kx4LDLa+axDdXUVeW+3eXLg7+K5UpvdlbLHueg
 MkUik8eV3heGZdMFUTrgeSN4VEcwDPQHRsZHV4v6EnlCR9+6i6sitpq25HoyN2QW2nkvR7XaD
 H8ihO+LVCI847mSzUgJ9gjLpPUI0F61O3r4kpXE0tGXHAk75yju6eUaLzy7gmHWuajgbv+GfD
 uOV69W9gBKxkCPuf1FRk55tvKYOYPoBdrbdGo7/RaaZwqBTjTywdV8rPzzzN/HD3+udSAbx1v
 hnVDe4dtCXyvWzrMgwa66v65LTi3aa4WJWg80tKfk9/zHCs0D4uY/Ruc/I1eNfJyKVueYjGR5
 rGPv1qemFd6hhwDPeXLcS3ivruN8+WPt7AjpL4wEiK1bZMZHgjHf05UinH45gQtSiggUv/D3c
 BN+7LOiC1MXIf40M7kFIckjLocFc1Vf/hzu962tnEeENr7YcoImiF1n9k8RDVCIPtSXin264j
 9uNJKYkt6k5a4YP+s7jmsERiwqFEJk0IKjGYWT7BSHL72WHKkDzMhb2gKMYAKroEOtSeLugmm
 HcQxNCGaKYGnsnzphZfx+KSjrWZvkobKifOsb1IqlyFXVJKRfuRRRumOhrVeZM7B3eeQgOhMP
 AGE74lorCRJAFA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-09-21 at 05:52 +0200, Mike Galbraith wrote:
> On Mon, 2021-09-20 at 15:26 +0100, Mel Gorman wrote:
>
>
> The scaled up tweakables on my little quad desktop box:
> sched_nr_latency =3D 8
> sched_wakeup_granularity =3D 4ms
> sched_latency =3D 24ms
>
> Due to the FAIR_SLEEPERS feature, a task can only receive a max of
> sched_latency/2 sleep credit, ie the delta between waking sleeper and
> current is clipped to a max of 12 virtual ms, so the instant our
> preempt threshold reaches 12.000ms, by human booboo or now 3 runnable
> tasks with this change, wakeup preemption is completely disabled, or?

I just dug up a now ancient artifact testcase allegedly distilled from
a real application's control thread sometime back in the dark ages, and
granularity >=3D latency/2 still does turn off wakeup preemption.

	-Mike
