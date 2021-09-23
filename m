Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8A5415ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbhIWJYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:24:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:39245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239965AbhIWJYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632388920;
        bh=kg2X/33R3HpULtgGMrnIJ3mpCCH8dRU6dKWBGjFCbcc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Wd6D97buHcpeM5C9OaH6mBRlnawOHWnVRmwDHzQnyinaB4DBGvZJH/I9qJLvDwOho
         /gpsDJefssoDB8bjFbSve/BVjKU+BZNqWMcF84FZFVcNos8iLldsLkwX0JgKzmROn4
         AIZnBi0Up0+2b3FrJTCyuF4XTcADdd5gOP19VfMg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.175]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0FxV-1mp8hT1RUl-00xGMP; Thu, 23
 Sep 2021 11:22:00 +0200
Message-ID: <50400427070018eff83b0782d2e26c0cc9ff4521.camel@gmx.de>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Sep 2021 11:21:58 +0200
In-Reply-To: <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
         <20210921103621.GM3959@techsingularity.net>
         <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
         <20210922132002.GX3959@techsingularity.net>
         <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
         <20210922150457.GA3959@techsingularity.net>
         <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
         <20210922173853.GB3959@techsingularity.net>
         <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
         <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de>
         <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7kfjVT+3Odk2NlZvSGf0pS+jISsoalbLGF7/wHC7Fpqfsd1V4Mv
 bfS+eTFqtOkL1CZ7al7yveBmYHRIXdZ8Cy/nFn/1Izg+80cfhRDV94kyATCHkHnJVHND9cp
 zfoj+6nWrhclPHuzInuvuMXtqU3+2ZTedDh5fSEmcMiFenHwrc4OYMQGuqTrncoQWoJIRZD
 I2eX2cElk1YXfRpk1ZIIg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vd/QnmmMMow=:bxeBdq2phMXcEO8/VKiPjG
 A8NgZKtUNkTrk25GtOepUfwDTwYRTylAyaDeb9/NfwQ/RGcHUYNxvLP48z3YVBP0SjhThTkbQ
 f2wplkLZfnSuY+5vNr33KIBNKFRLChLF3DG6qsMJDETHfCStM6Uf6YxBTo4ks4cyu3jQ8CUUX
 iJAarAVlWEx4uBew2qdgJhNUjRY44jPGhmZL63iiTPmmIAxTpmLydEIllrM7k9K8WdXQnjxdt
 AV3rooe2K3+6ItI41vfDImhkwtxPMLf0iDnwZyEIG31RjYhr9CaaVxbP0pf1ibvU3RzogttMH
 awe8knNLM9ajwixI3LR0chtJuy2S6NLskmBuJxDt2bHQ2yi51wq4tXKj/oi/3o8JQpvRCP3AO
 iw368JLnt+4nHExDsg4V4Qanz4T3MxgNqZx2CcNOISBwHua34Ab6V2/ayrxZxTDHNeDmo//se
 ppqB+sJ8sfPG+/87/dV0oCXQz2Q24n6djJY0ufFbdXlbK01OqoWQOuJqfpLjQW/LqEcnb6c8/
 slP2mqX8I4Z3AO7CCZ+5XKOzj2d5n04ieVQVf/Oa3771WWaW91hxvreKyGXiePswHQIISO4fP
 Cjdiq52yXmdr41bI3vFzDk1UhH1alcqO8t8smlllBcyv1yjsZWPk2Cb4CtKu0tf+NKRNwdujO
 gtaq/3o/xSynvzQCi7odO/OuRwGaPGxs9CWhaJCj8t5TT5T1QzrvqDSTsVFvpBRyI3V+6trjt
 0LSHCSr36VHZgVPQ2pyegM4zZSI42smbbcfOvZoTg1zWDeM6nbfkWUn3Ul16Pq1apdY57pPSg
 LOFQV1qDFi3/pzd3psmFW4q+KKRdGiwfJtTLUHG37PpH8XuDEHXIJp42N064XQdajMnlcoRbq
 KouDy7V1Zp6/lJpULoD0OQPGHYY+O0O74uWAJasI3vvpjbJZU+6R5MIK0hTf8TTrhU2PWB6iv
 otmf9bDfZ8RqKxozcVJQmL6i653EzP1rx0jtymy4eCGLxkhI6OFGir3F6LxHBFXnZWj5w4M3B
 VmAT2L/Px9pX+m0GdaaJt5VggiVZfLMroZKaWFskgUS/5UQ+l9yXUAyEddcrGKFQLtpgC3eTZ
 KIjSTucuF3CPCI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-09-23 at 10:40 +0200, Vincent Guittot wrote:
>
> a 100us value should even be enough to fix Mel's problem without
> impacting common wakeup preemption cases.

It'd be nice if it turn out to be something that simple, but color me
skeptical.  I've tried various preemption throttling schemes, and while
it was trivial to get promising results, my scheme always managed to
harm something.  Everything I ever tried, I ended up tossing.

	-Mike
