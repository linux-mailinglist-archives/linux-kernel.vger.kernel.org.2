Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FFC3417CA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCSIxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:53:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:35163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhCSIxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616144004;
        bh=591mMv6inl8TRS5dqckQVxVjtPoWMOqDSCMK2PbWsso=;
        h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
        b=MgfWB6Hc0clpE5Kmh/8GGOMuUUZqd8hnJz7BKKvlMP4/AsSmUEMH68oeJkd1T8K+6
         hWnFuOh0FFTjvYHdf5lQzv37ycPqXM6WoGY/BPjHQK07jDrCBgmPIfV8ugMaiK18mo
         0lNDyE+Gf9D/4ikrApbF8PtV6FKBQsYUrIjpFpRI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.223]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNct-1lu3St2JxP-00hsIR; Fri, 19
 Mar 2021 09:53:24 +0100
Message-ID: <e7d067e98b903fc828ca9a643e6452a51211d4f1.camel@gmx.de>
Subject: Re: [PATCH] futex: use wake_up_process() instead of wake_up_state()
From:   Mike Galbraith <efault@gmx.de>
To:     Wang Qing <wangqing@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Mar 2021 09:53:18 +0100
In-Reply-To: <b135934766964005677a8faa983919b052409a54.camel@gmx.de>
References: <1616122760-11790-1-git-send-email-wangqing@vivo.com>
         <b135934766964005677a8faa983919b052409a54.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KKweXKVUtoz/l77P+I7sbaz8sqFK6MVpDCwHd5/cDp6lGwTDbDR
 YsncnqiRJ3PRWdgoq1Bovn0y4Y2YrsHiNC1M4P6IL1drn1Pe88sygDnWgbCXbyvKG3NSLDn
 cOZhle1+b1u3MotGvDZfm6KADE0vb6qAl7dCVxRuYQiius0i3Rg9IdLQTr0I7EFTKhpZ+iW
 iHMW8ATpvER/arCW0BWCQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WoWaRjYFcug=:h5LTY4qmDL/oUNRsaDKatr
 jVvz+XIP30gfliW29uiDzmKcsheCwPCrQ+xx7eFrMS4DyWGyBtCP3SfCN5rDqYyIqumLQ6++K
 mzXITBg7J+MV76yluyYWoSRFZuqBLS0CZYpWlgTrSytHqGxpS2NPkHaRzpyIh85E2HLyW75X4
 6TifC3n6JXsJEe8Z3AP2DNUHyDoFIbXfWXf0Hz3uS9+momaLIOmra9pjaL12+Nbj3sh6sdcDK
 rCvO2KQeJ4kQrYuH6YQ2kyOYC37miqER5xk5FlzO2KytPcU22DxuLpfUab0sm9csdGQ9xFVx2
 0qG7a+NtAI7wJcya07OYmOptVNLEWk+7sQzRVZKakevo58vjFkkKHCg7XvHEF+0mF7r59PDEI
 5CefwUub6g3NXuOkxoLbetZvdckqpRFXO/yjFAai6QXp7/RJRS1D3mAHAr0gfUVLwglUv8b8y
 hIKhyqzFsWblEAQl0tfVGsjHqxy+BfcocklFMbnIvZWs9W/1TaynN/2P351DQI2bhiz3tT1Be
 0E/lAKB9WFaQCPVc2qrGaECIKaFP8t0z9O0OPZjsjlaWyJgjM1yOsjq3+VOZrg7aPU8lLVDF1
 OTCdIVidEHrSVSyxgGxAj1Q6iy5HgUo5o8hw36nTLbxjikx+zBqaQ36WVw1//cp7ZNAXqmV70
 4RvWxg5b0ECMY8LW+5lt9s9YCPZY63EscuXZpbXIzmEgsM2v72Y1jIfCXsTq7PbJTwLh41v//
 jXZyOXtgN28NNs4oPtHWosvK+LJi/gGAoyd1Q1eHXncHRGPOfIc9R+VH5GlhCVwSrTiv1iS4D
 60tbYDldk0LTqHde60pYu46zY3YdirKvhmwTwWUbxMG9ESE6U96xHdWSjC9MDUT7B1p2dUw7i
 sGXikC+8Qbxi8R1+YyMA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-03-19 at 06:21 +0100, Mike Galbraith wrote:
> On Fri, 2021-03-19 at 10:59 +0800, Wang Qing wrote:
> > Using wake_up_process() is more simpler and friendly,
> > and it is more convenient for analysis and statistics
>
> I likely needn't bother, and don't have a NAK to paste on this thing,
> but here's another copy of my NOPE for yet another gratuitous change
> with complete BS justification.

Let me try a bit softer tone.  I think you're trying to help, but
ignoring feedback is not the way to achieve that goal.  My feedback was
and remains that your change is not an improvement, it's churn, but
more importantly, that changes require technical justification, which
you did not provide.  You were subsequently handed the justification
you lacked by none other than the maintainer of the code you were
modifying.  He told you that your change could become a tiny kernel
size optimization by converting like instances all in one patch.. which
you promptly ignored, instead submitting multiple patches with zero
justification.  That is not the path to success.

>
> >
> > Signed-off-by: Wang Qing <wangqing@vivo.com>
> > ---
> >  kernel/futex.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/futex.c b/kernel/futex.c
> > index e68db77..078a1f9
> > --- a/kernel/futex.c
> > +++ b/kernel/futex.c
> > @@ -1820,7 +1820,7 @@ void requeue_pi_wake_futex(struct futex_q *q, un=
ion futex_key *key,
> >
> >  	q->lock_ptr =3D &hb->lock;
> >
> > -	wake_up_state(q->task, TASK_NORMAL);
> > +	wake_up_process(q->task);
> >  }
> >
> >  /**
>

