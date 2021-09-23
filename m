Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6688415F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbhIWNQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:16:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:37265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234515AbhIWNQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
        s=badeba3b8450; t=1632402854;
        bh=lU0u6JPJIXL4HNlA8zPgv8plXcK4dBpVGakj8NOVom8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=TBfVgL8052DicUYWMqujuaLTV6qdTSWCEht7c7enLKL5RdhhcZWYgvs+TfOGUqTnr
         9NAlkd+7huEfRW6hyvi/2D43nImDTmZ3s9Cyen1Xyje2ggcffc/uRl0m558vRzB1oh
         P7vqgYQxJmAWi+in8Ry6Xyawi2NotnPR+Pz2olLY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.175]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0FxV-1mpAOn2ujX-00xG6j; Thu, 23
 Sep 2021 15:14:14 +0200
Message-ID: <38b22e307f1c912e9fb22155b04d4d0064b9e63d.camel@gmx.de>
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
Date:   Thu, 23 Sep 2021 15:14:12 +0200
In-Reply-To: <CAKfTPtDHYtskM7wR0w=fDry+6JJae2_q8Lw7ETcW_gBJ+n4NBA@mail.gmail.com>
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
         <50400427070018eff83b0782d2e26c0cc9ff4521.camel@gmx.de>
         <CAKfTPtDHYtskM7wR0w=fDry+6JJae2_q8Lw7ETcW_gBJ+n4NBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OHvRlOVkMqRD9dJFokSxGNbtMxypgfw9JtZ8qjIhQCTAHb/QWxb
 QXN+MFlPkUZ308fgj9Xyz6hKfGHCUuv5fv8tCacKZjff1RRnuvosbfug/uiHiDyv+lyp1ou
 A7ImuWrtLUehImGtndDM+OpGUC82pBw1UGwfGuRqkedXAFLDOMDWt8Xx4eN07S/0sVtOXoS
 SWLpedF41xNopVDshu/MA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iLXJGYKnwVA=:192kKRCfxQ+8DtfaTNzpzm
 fCMA6J+vysiGYE5faKBqQjYvZdKe+NVNzLE+JbsOdk86ts+lXMkU0G/Jr2el+Er1AH7cPZGtL
 djHvOi2cDB4+r9eshk1Ni68ql4LvJFvApVkuJfan4+4JrHIqUwBzTDqVkQFcqkqVpRn70IhC/
 zP3j7T5A3tplzfpUowplfG3h6YAXLb/id9Axkt2+q+wIGCdNCLBSWdwqG3BhoyAzdFWpBnRuB
 /HV8DjzhBks4a2ZxoIwcNZDZ1HwbR+HIejsc12iDCJx/2WNQjTMOU90+G0LmNR6i3LcIsfHvj
 yGp5jHRa9i7siA1WBFBUbOnGnkNTKtPgTTWRANWRIe2J6GzINJTzBvJb0jmETjO4UuCjeew/i
 X8YRLxsi/SDCP88d5LB7ddi/kkm5o0+DgAqFILu0/k9iOY1N3XJ1rC0sMotOSMY5avbDmpp6w
 NJYf94wWeaOl2uwzTq2oX2gX0aTs/YhiBfDU1sdE5BD1Q9t/m7n6Nn8OSL2qxWFLxvduABgJd
 FdQ6JXDvuJeRhqC8c21A+FM3JVaeviHqoZHmzalHB8ZBRjfpI2zuoRlAo5h06Bui4FpLgXrUv
 EkcW9UqE3EjFc2DluJNQOX59s+h5CjdZTEbngBx2UavMs6Usl20HbbtVHov7KuRAKhe+asJ1M
 XWxH/qEVGO6+oi/lu6uSdvB1QdjwAknMeKzMrW7qekrea58Dw5kLS1nozziHIuXAL780qJ/37
 MpS2kxVZP6zY3Pl3YLe7YXPk07DFCslePyeRYvXsaP28eSGThQfNlok0Cfb252BPLmPO+avhP
 b7v9rEMucKB8TEbiL67CwXS+FYa1Yn3p6kubOIDSNTm02tw6Ns2tKfXTNuugHQ9z/MgvYD579
 DswFj05X3WpwkK55V+4GyyP5LzsS5dx/UGe7LZIt3obVYVjE9XUI2jGdycXQjQ0rHnCmJdmwy
 p8l2JhX+lY5rxYLAt6nhIAVlsV2YAR1Nz3Tdse5Cy+EOMmWDSld+84wXuHKpDf398X9Q03MCk
 9F8pwRBORfrKdpU6eDRZsY7fOLc9fHLwQfMd0j/JTAzDlatDxBusDbZESgjmmavzYYyopIB2S
 MsHqqBmz7Zgj9E=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-09-23 at 14:41 +0200, Vincent Guittot wrote:
> On Thu, 23 Sept 2021 at 11:22, Mike Galbraith <efault@gmx.de> wrote:
> >
> > On Thu, 2021-09-23 at 10:40 +0200, Vincent Guittot wrote:
> > >
> > > a 100us value should even be enough to fix Mel's problem without
> > > impacting common wakeup preemption cases.
> >
> > It'd be nice if it turn out to be something that simple, but color me
> > skeptical.=C2=A0 I've tried various preemption throttling schemes, and=
 while
>
> Let's see what the results will show. I tend to agree that this will
> not be enough to cover all use cases and I don't see any other way to
> cover all cases than getting some inputs from the threads about their
> latency fairness which bring us back to some kind of latency niceness
> value

What dooms the dirt simple solution is: tasks that dip lightly but
frequently are a thing ;-) Take nfs threads, tell 'em frequent
preemption ain't cool, and no matter how you diplomatically you say it,
they react in the only way they can, by sucking at their job.

	-Mike
