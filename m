Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB57414B56
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhIVOGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:06:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:54357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232243AbhIVOGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632319443;
        bh=QXxMnw7c3K8mqHEHkt346GWvYyLLAFsOS9FsO225YlY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=kkYf/NdJ+bHR56JdFNrkWnVF3uwHGgj7SIw4we/LMuojiTs62CEjVgYn7ufLD9sOZ
         Eg9TKDK9gldVNPKycqIfszdTKVVRYSHUbfSZgkqcPTTYWVRvWo9nJHwFC2PLGFNcFq
         PoWSB/E5oHGt5It0xcwEcJVUdK2JtyNnhpxZUVmU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.221]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY68d-1mNI581f7l-00YPZV; Wed, 22
 Sep 2021 16:04:03 +0200
Message-ID: <97ee06c66fe0d900e3e0c4145ef9d33457ab3c65.camel@gmx.de>
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
Date:   Wed, 22 Sep 2021 16:04:01 +0200
In-Reply-To: <20210922132002.GX3959@techsingularity.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
         <20210921103621.GM3959@techsingularity.net>
         <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
         <20210922132002.GX3959@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NPu4D8EDfgxK0K29QwqVVbD1vYgUGgUdwF4OeFYDwOyeVD0DpUA
 ZWHnw1zI6eU7fEIVpjtH56d9frAvSjoep2hocCUK1W05/xv7Hnh6YHuRQT3Z3yXR9h+dNl8
 4bIa9sziKU3x5/XRGuMQuXGhxSakOC71Kw5/J/VKHlFDfa7xQcdMjFoN8GtxokOte5si+n0
 wXa1KwchmEAOnvJtEoOhQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nWdUyeGIOW0=:SnSXouPUVMPK8wsRbbYj5q
 lknBnDrI5GZ1caCgwn2UIOd81+9i9Gh34DCKZIS7zoWWucV6fo+tTCeXHsqB/6QvXvphdkQoP
 ThsZCcbicqS2eAJwl53rjv3pNZi9hFnpMmTvzB7e5IcU9hdWK67Ddps2JnP7HTEGs1sSecETY
 gzzxSnlg3P6lYtgjEHTmlTyMuJlQLRgfjSOPmj4mW9DVwV3GXgyGDz/NWj6jqgMYe3vO+Yu+s
 TmPPN8JQ2oyXPZ7K011h5Dm2hCw/htQr9XzhDh4kkrpJfft9xpXuwWhbe4lSopoMWoVliRONQ
 HHCLIoHxqyBGYyemSYAaiYfw/vfZbNwshO2ghr2pz2XJdQ/1gIKXyb+gejFJ3+VDjTUIFR23F
 RKtasJ7FAoUts+aRYGtbTeOgRuHeoLDOoM8qS4xmqzbO9eGKc5lQMQXcEXp/y0hMJT2z25cdC
 5MkX9g9pgFti7rHQXs+zQ6gpdFyffMVyzTDuOQ7Ud0Dui+2EVzTJVcW80FPiNu8Lm5n7t/sFg
 rtTdJR+LoHGZAw/6dCM/YPx8hm5yYAi7qW2hWlgCfgeV6x78V1dpb7rO6kteR8p525ARtcoPx
 sSZeN47EHdXY7JuhVOwwkEr3Vpx4kPlNmQFNsAWIn4KUyUMyM8vX5Yf7i/FEp4FNNNFB6bJL0
 mUa99V9qqhNBhn1bqFuUmeiWw5svgb9a54P8+F4Xi3502zF8TJisNZQGX/rTmAkzbHT6zl/Kr
 ZyHmFI625Icl8TgceMjnwrM0KErX68wSrD6XvsyJIuEj5UZO3SOCqXxd1AnsbjtfoAzSNGWkl
 7dX1JjARI1qGxVoBAPHyWEYK6pMIJJEcw4pTrOkVzC0OOBhLAxI5oBqx/Y6SCDsLvD0KnOEFF
 89btoe6j4D4ph2L8e6ivjnS3Cunir1s2227UVci3YTmy4mUWWi1rFtSAEwxuhnlq/cWkQejYp
 w4K3b1LZ8GfEbIoSorvhLdIPbURuT+LzTV32F0na8XGwIZDjW2woV9JKVIryE4qYxdKv9ISwZ
 +C3OeZ3jfQLhwVocq4kM23/s0RLTziMnCKIv9j8eJPeLtUx5DxTyXDRQ2MnSeuqEH1J8jwqht
 WqRO5Dz61g3EQQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-22 at 14:20 +0100, Mel Gorman wrote:
> On Wed, Sep 22, 2021 at 07:22:20AM +0200, Mike Galbraith wrote:
> >
> > Watching 'while sleep 1; do clear;tail trace; done' with nothing but a
> > kbuild running is like watching top.=C2=A0 There's enough stacking dur=
ing
> > routine use of my desktop box that it runs into the tick granularity
> > wall pretty much continuously, so 'overload' may want redefining.
> >
>
> Ok, that's pretty convincing. You didn't mention if there were
> interactivity glitches but it's possible.

No, I didn't notice a thing.  That's not surprising given the amount of
scheduling going on.  The stack depth surprised me a bit though.

X-2230    [005] d..5.  2162.123029: wakeup_gran: runnable:6 wakee:QXcbEven=
tQueue:2695 CPU5
X-2230    [005] d..5.  2162.123035: wakeup_gran: runnable:7 wakee:QXcbEven=
tQueue:2656 CPU5
X-2230    [005] d..5.  2162.123046: wakeup_gran: runnable:8 wakee:QXcbEven=
tQueue:5876 CPU5
X-2230    [005] d..5.  2162.123049: wakeup_gran: runnable:9 wakee:QXcbEven=
tQueue:5355 CPU5
X-2230    [005] d..5.  2162.123083: wakeup_gran: runnable:10 wakee:QXcbEve=
ntQueue:2723 CPU5
X-2230    [005] d..5.  2162.123097: wakeup_gran: runnable:11 wakee:QXcbEve=
ntQueue:2630 CPU5
X-2230    [005] d..5.  2162.123208: wakeup_gran: runnable:12 wakee:QXcbEve=
ntQueue:2760 CPU5

That CPU# on the end is task_cpu(). Lord knows why X wakes all those,
but with no SD_BALANCE_WAKE, a busy box and all those having last lived
on waker's CPU, the resulting construct.. probably doesn't very closely
resemble what the programmer had in mind when threading.

	-Mike
