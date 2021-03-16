Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE2933D526
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhCPNqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:46:49 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:44695 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhCPNq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:46:29 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210316134626epoutp014724a4a117c50006016644b32002fb1b~s1qjTD9Aj1500915009epoutp01T
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 13:46:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210316134626epoutp014724a4a117c50006016644b32002fb1b~s1qjTD9Aj1500915009epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615902386;
        bh=kNxRw4Oo0HnM85CnPzgVCMVoCZ9laCHs2r0PF8zp1As=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oevYb+5eZg/TTMCpvENQkHyYhdIzizdwibgseBA7lgVmbesLAhP8qwi7ojnQMcrcU
         35BZn7tudreNAAT0e6w7QUgoajHp4DJD5YWuzUK1iqiD3sjM4VPoCWXkN+3jbw7DqX
         riCm/QcryhUFDhdOIPIoQrXcKIvrASkWxl/9d/sY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210316134625epcas1p2b3d23322c6cdfac22e104c983351b15e~s1qhtwrEB0830008300epcas1p2O;
        Tue, 16 Mar 2021 13:46:25 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4F0F1p6vcMz4x9Pp; Tue, 16 Mar
        2021 13:46:22 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.EC.59147.EA6B0506; Tue, 16 Mar 2021 22:46:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210316134622epcas1p488fe019ee343dd156dc077c6df9322da~s1qfI7XTV0629206292epcas1p4b;
        Tue, 16 Mar 2021 13:46:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210316134622epsmtrp2e437e36add089efbf521352fc1b5dffc~s1qfGmkvE2205822058epsmtrp2t;
        Tue, 16 Mar 2021 13:46:22 +0000 (GMT)
X-AuditID: b6c32a38-e3dff7000000e70b-09-6050b6aeb810
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.03.13470.EA6B0506; Tue, 16 Mar 2021 22:46:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.183]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210316134622epsmtip109e67ba22e6c219321c28e98ddc06c7d~s1qez4jZ83042430424epsmtip1Q;
        Tue, 16 Mar 2021 13:46:22 +0000 (GMT)
From:   Sangmoon Kim <sangmoon.kim@samsung.com>
To:     broonie@kernel.org
Cc:     0x7f454c46@gmail.com, Dave.Martin@arm.com, amit.kachhap@arm.com,
        catalin.marinas@arm.com, gshan@redhat.com, jordan.lim@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, pcc@google.com,
        rostedt@goodmis.org, sangmoon.kim@samsung.com, will@kernel.org
Subject: Re: [PATCH] arm64: traps: add tracepoints for unusal exception
 cases
Date:   Tue, 16 Mar 2021 22:37:20 +0900
Message-Id: <20210316133720.9432-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308133149.GA4656@sirena.org.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmru66bQEJBndvmFhMmPaCxWLKhx2s
        FlMfPmGzeL+sh9Giae4eRouXu7YxWdxYFmax6fE1VovLu+awWSy9fpHJ4tKBBUwW/Xeus1ns
        63jAZHHrQSOLRcsdUwd+jzXz1jB67Jx1l92jZd8tdo8Fm0o9Nq3qZPPYvKTe4/2+q2wefVtW
        MXp83iQXwBmVY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
        lpkDdL6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK
        0MDAyBSoMiEn48fLeSwF70UrZny7ydLAuE6wi5GTQ0LAROL9h0+sXYxcHEICOxgl7v49zA7h
        fGKUeHt+P5TzjVFi3ekpjDAt594+BrOFBPYySuydJAxR9IVR4tuaV2wgCTYBXYkv8y6DFYkI
        iEncntPJDFLELHCKSeLa/cfsIAlhAX+Jkw1rmUBsFgFViYl3DgLFOTh4BWwkDp4qhlgmL7F6
        wwFmEJtTwEjiwpbNbCBzJAQWckjs2r4J6iIXiTlTvzND2MISr45vYYewpSQ+v9vLBmHvY5TY
        s1IGonkKo8TyKTugiowlensuMIMsZhbQlFi/Sx8irCix8/dcsPnMAnwS7772sIKUSAjwSnS0
        CUGUqEk8fnUX6gQZif4781kgbA+JiX8vs0ECpZVRYlnfWdYJjHKzEDYsYGRcxSiWWlCcm55a
        bFhgghxlmxjBCVTLYgfj3Lcf9A4xMnEwHmKU4GBWEuE1zQtIEOJNSaysSi3Kjy8qzUktPsRo
        Cgy8icxSosn5wBSeVxJvaGpkbGxsYWJmbmZqrCTOm2TwIF5IID2xJDU7NbUgtQimj4mDU6qB
        Ke9A+aWrRQdFg96Fnj6kn7jNPGtj54zmpOunr1t6bb8bOo37xPc35zrfL4n1eKtiZLxSu3rt
        iis31lY3bd8S7clzo+J5/09Fnu6NARtn+VwRnRmTcf/bC27Newf1jBI3+PPrcDS27O5Yc+Nq
        VG+Mzr6IgqVr5cRETWaxtWtsv6UiKXPv75Y7UTE/zKeLbBF68ld5zqLJ+TwxOz/u8F4od/je
        caGQLZ43TrCLbq5ouJj8Kkvgfy5r8q6G6rLjOV4TTZnyl8s1FanG6kj8fPLrY339QtnN+tZW
        xXMuJkxL61h287bZJNGu4E7DNvWGF2n7PwX+OCLAraHD3CDnsuWd8EHG1/Wid/2rNvX1rd3u
        o8RSnJFoqMVcVJwIAISG+MUpBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSnO66bQEJBp9beS0mTHvBYjHlww5W
        i6kPn7BZvF/Ww2jRNHcPo8XLXduYLG4sC7PY9Pgaq8XlXXPYLJZev8hkcenAAiaL/jvX2Sz2
        dTxgsrj1oJHFouWOqQO/x5p5axg9ds66y+7Rsu8Wu8eCTaUem1Z1snlsXlLv8X7fVTaPvi2r
        GD0+b5IL4IzisklJzcksSy3St0vgyvjxch5LwXvRihnfbrI0MK4T7GLk5JAQMJE49/YxYxcj
        F4eQwG5GiWvLWpggEjISOy9uBrI5gGxhicOHiyFqPjFKtN1+zgJSwyagK/Fl3mVGEFtEQEzi
        9pxOZpAiZoE7TBLPPrxnB0kIC/hK7J+9jRXEZhFQlZh45yA7yFBeARuJg6eKIXbJS6zecIAZ
        xOYUMJK4sGUzG4gtJGAoMen7JZYJjHwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefn
        bmIEB7mW5g7G7as+6B1iZOJgPMQowcGsJMJrmheQIMSbklhZlVqUH19UmpNafIhRmoNFSZz3
        QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTrgBv3CuDxJNBb8LvTtK/2TI5XK3wU1qeuMLEBmf2
        blGOGYKbleqfO4Ud77W9xrGS5birdkiPU6tXi61r646+/RHJR5Qezf5Y7fhgTcw6My3T3+Em
        LK2HdaceYHxqnpC//u+m0oKQRNPylD+ekv9OrZv3symzwV85cYGz/p+vylJ1RuGl2h6aWyw/
        fKxMMC5MNHn2uTrfdtmG3YmWb/a/t9lx1J1ht+AfbskZ097cDj0wb7GsccWkve8Dbc/410ky
        +V7ZsP5/zNIqzu+NG2Y+/BIfrRPQNdP8Qv9VboWFL/5tiikUYAk98tC+3maa6r/ZB7/paZeJ
        MSh6c2j4LWf4u/SEoO9K2dyP8xbuKFNiKc5INNRiLipOBABYQkyt4QIAAA==
X-CMS-MailID: 20210316134622epcas1p488fe019ee343dd156dc077c6df9322da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210316134622epcas1p488fe019ee343dd156dc077c6df9322da
References: <20210308133149.GA4656@sirena.org.uk>
        <CGME20210316134622epcas1p488fe019ee343dd156dc077c6df9322da@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Monday, March 8, 2021 10:32 PM
> Subject: Re: [PATCH] arm64: traps: add tracepoints for unusal exception cases
> 
> On Fri, Mar 05, 2021 at 09:36:30PM +0900, Sangmoon Kim wrote:
> 
> > When kernel panic occurs, a kernel module can use either the
> > panic_notifier or die_notifier to obtain the debugging information.
> 
> > However, in case of these exceptions like do_undefinstr(), regs and
> > esr data are not passed on. Although a module might be able to find
> > those data in the console messages, parsing text messages is very
> > expensive behavior for a module especially on mobile devices.
> 
> > These bare tracepoints allow a module to probe regs and esr information
> > for debugging purpose. _tp suffix comes from bare tracepoints of
> > sched/core.c
> 
> This use case sounds a lot like what the enterprise and Android people
> do via pstore - it seems like it would be better for this to integrate
> via the interfaces that other systems are using for similar purposes and
> then ensure that whatever information is useful is getting passed
> through in a format that makes sense.  That'd be more structured and
> more readily usable by a wider range of systems than something that's
> more of a building block, going via the trace infrastructure seems like
> a bit of an indirection.
> 
> > @@ -832,6 +846,7 @@ void __noreturn arm64_serror_panic(struct pt_regs *regs, u32 esr)
> >  	if (regs)
> >  		__show_regs(regs);
> >
> > +	trace_traps_serror_panic_tp(regs, esr);
> >  	nmi_panic(regs, "Asynchronous SError Interrupt");
> 
> One of the concerns people have with adding tracepoints is that they can
> end up defining ABI so if we *are* going to add any then we need to
> think carefully about how they're defined.  As things currently stand
> they'll pass in the full pt_regs struct which includes not only what's
> defined by the hardware but also additional software defined information
> we store along with it like the stackframe which would be even more of a
> problem if it ends up getting used by someone in a way that ends up as
> ABI.  These are defined as bare tracehooks which does mitigate against
> things ending up getting used in ways that cause problems but people are
> still going to worry about things ending up getting relied on one way or
> another.
> 
> That said it's not clear to me that this will record anything beyond the
> pointer directly in the trace buffer so the value might not be useful
> for terribly long, that itself feels like it might not be as robust an
> interface as it should be.

Dear Mark,

Thank you for your review. I learned a lot about the concerns when using
tracepoint.

Thanks,
Sangmoon

