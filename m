Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D0A440735
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 06:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhJ3EPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 00:15:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:33827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhJ3EPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 00:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635567140;
        bh=HF3makqSIcPA30AKpF1cuIDv2llKO8z8FPX3+zDoAGg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=F48HUKALJpbMhHjQhxUAdR1oiyyPPKS1BVnJ4WrZFucDFK2ATYhUvJCIUoWODsUH1
         Aqn8iav7b00HzLiCuooDq7Y12DD8JfXwGdMT4h/yll2qVSSKfQ45ES2OJN3ceKPT+K
         ++T2fMXEW9Mn+vn7hcrf2wjrhv2mfHmBk6+ZcRuw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.242]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFzx-1mX4wD2gy5-00AGBn; Sat, 30
 Oct 2021 06:12:20 +0200
Message-ID: <91cb83b8e05076bd6650e3bfcda00feb890b911a.camel@gmx.de>
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
Date:   Sat, 30 Oct 2021 06:12:17 +0200
In-Reply-To: <ab98b05314846102baec5cbb46893675f4ea5cfb.camel@gmx.de>
References: <20211028094834.1312-1-mgorman@techsingularity.net>
         <20211028094834.1312-2-mgorman@techsingularity.net>
         <CAKfTPtB-fJ7Pd6eYPDrHB8Ts0o7SCbN7nniAD9PSoF4Pf+xB3w@mail.gmail.com>
         <ab98b05314846102baec5cbb46893675f4ea5cfb.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DzHGr6Uepey7Ffm11lI2Otq/x08e/xy9HDZ7v0yWlg/CoIjc969
 yq3Pzm8mZexBG84E8H4SKgyxaOMLo7x3mRWeAP5dneL64N2x0Dpom4XfK+50l6cPJsIiSYQ
 FMchDLuu0bPT7ysGujdgZ3cb8lWmVAS3U2W9u0QyXJPJTgTH1yo6MiqgiaEn+GXnRADj+XA
 GtZWWu47gGQu9/NdKU73w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wdjw1NjahP0=:moFn0IsNvdhyjfbx/QuQNt
 RCZciaZTfUcrQmwswstUlTipzdA3K3rHctNUKLCC0a254BjKi+BMoXmoHZuu0ZHJnJVxTUXLa
 6a4k0imCCNWjP+Dbmgiv0ucIchdb2m2x7Zg1SRUUKS+rHbMOV1+FDnAsYHDJniBuLk5w0DrZ4
 vfpzCIeOY+poBzeoFMBwCl/qBzrsD6ioc/DJNZbexCy6Jq1lDaoN4ZAYX1B+XlOkqKjiszl6V
 gb8QB6QpKioGEPfJPuKk2KkYpV9ukb6q0bAV6A8OXJY+xVbh2B/OjqDYOtAr3tYQ+c/WaPXaC
 vc+Zxtpf6wi5vaG76nKfvnDHTncgpLEZWtUKC8htrlNRcoC1oMqfUltKidNYirbbmDN+1OPz/
 0F9B6Hz2+KB/1ekvIshbC/hB38E192FstYW2jaKt4ZYskKTiI6ulRBQuh+eY/Vb0gA5w5VxHF
 j6ECylPo310Zukb6ho23vLHlqfeAUglSVzsoraZXm41PosX39SqHzY2n10hwPhzamVhm/r2lC
 N6LZExzAt5njlf9PfhhpMVC9Bfdx8xEIheyj3FfWWV6XjMAezPFYuPsJwnUSnnn/6taEtb3MX
 TGlZCiIa9ViU3e6e2r1g5q4pPN2/m51IiGlmbbaXPJLQeL3Gb/oKO/8IR7ffT61CvliYPnUk2
 b4RIEhCEgeImoFHq9+AnBqhQIywrLeR4RwUyA+lMu7XXdIJLD2kiPM1WF9rU2+no6ktGVArpP
 2cpEASOmL9wGdAG/HU5fHnCC9uZ08RDnShPKudp23OX9+M+yOVjQEeCSzoXaMDnSeJNVWaMJ3
 Dt+UupY0/gZyUhmSwA+kB+bLGBjJsq1FtK4wGLyMINx7utlQbQSbm9szSaxmv1w6hteWKNgdT
 dhnMqmjDCPQPMbpvL5NvLApiLGHtX97p8uhLlPUfIX4KFmKE6/E4Hf5l/pjg71l4S6xBH+s6B
 gVmwdnzZnKfxhm9hV5JtlSADc9ISf2VgQHH26/st+PVZV+TNeWpMtkPWm0+HKdI/QnhGiQeHg
 xMCm7EGfn6SJkalzyV1VRmhuPiUaHCi+HItDS8s5aGrGpBEAPjkuV6j1t79XJn4pQl3sp63Fx
 bH5QTi4sa8PTTI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-10-30 at 05:11 +0200, Mike Galbraith wrote:
>
> I profiled it with a perf that sums delay (local mod I find useful)...

Here are those numbers for completeness.  As you can see, patchlet was
fairly meaningless to the desktop load.  In fact, even though the wake
affine logic essentially favors the compute load over the heavily
threaded but light desktop load, I noticed zero difference with or
without that being allowed, nor did perf record any noteworthy latency
events, just more wait as load was kinda sorta de-treaded by being
stacked up.

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

