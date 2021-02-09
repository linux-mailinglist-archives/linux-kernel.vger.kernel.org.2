Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2843153E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhBIQ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:29:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:55611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232654AbhBIQ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612888037;
        bh=ujlffkUDXmUgQi8rp1OEYKxYppbwFLYUhSFQeRlz5Cg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=YRcVcbMHIulyIytTH//iUV7y346J8FSKU+idwV4t9NDRt517R+H3crpgjInefGcE/
         EouZ5pRnZmYWfTTRXqFFobn7C3tSCK9/M6FH+eFo0cqiNN15lk38rs8G5i/q8iKfgL
         NaInMD6x3lbr4gJefKIix+BP4Oh1DiUb0SPaew4k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.88]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv2xU-1m0Ew047Jg-00qyEs; Tue, 09
 Feb 2021 17:27:17 +0100
Message-ID: <0cc4b82f25554cf4406d7326704662eed7ba9cff.camel@gmx.de>
Subject: Re: [patch] preempt: select PREEMPT_DYNAMIC under PREEMPTION
 instead of PREEMPT
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 09 Feb 2021 17:27:16 +0100
In-Reply-To: <YCK0m8FD9kp8QZWJ@hirez.programming.kicks-ass.net>
References: <7d129a84b0858fd7fbc3e38ede62a848fbec536e.camel@gmx.de>
         <YCKmhnoSKgdYqxOL@hirez.programming.kicks-ass.net>
         <269ee10aac93d819e48dc81f09a01d01fcd44fb1.camel@gmx.de>
         <YCK0m8FD9kp8QZWJ@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AkPPvFXXGvN7PlPTyF123cAZifASAeJdlAZLYolGsANyhiBZ3HG
 R4bxiDXkofrpQmDD5eH//+tilX9fJw30Z1mWxDsSseGlSF8HjrgSVMUlXfgEBNxVTnyZHAE
 bonJacBoW6wt9EKx44jblaOvBQf+fw6/tjN4VzWRWyYRJezG5qABrYXePPdKTpj9DTbnwdM
 WPIlaXUXMDqE1rHT4DEHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UOZ353OpCog=:/rsXqy1lexaa5Fu3sXd0U5
 zBKdtDIsrI5pYjdRp+v1MOD8YkeE6oF0eYO8Je43UaNGZ/mc+DIhZDxCGBb80yyurUoqELkZI
 bmGqZLK9WVl3RFz7N66ZEAP/pgYU1zlm+Dc3lKY+7BkZ5GtitAmTmgL46tygCYJEDs+o5lNHf
 LqoUgcjV1YMHqfKaQN2KBoGq7dDD1yl2oiQFh4F/dn4rPz+GDMDifkfHSTWU2mDWV4eGVuZbq
 8RtTPFha4iNa2+bV6Z9WTJgEkZuEJPx0q/eY2iFrs4LNbGzF7pMvxOhiIpHQVleJW9wOz/O9L
 RpE6iWg4WzZ3e25Fb+Ys/FzUjSa5HprHvEqcHpICJti1O4c6LmwZQJ1awJ54Q9ueNZT96YnhJ
 pmAeB3zrg8EPSx/XEMk1bfC31IYQ/h8ysnMXJG3guJNZh34OR6U+7ueUEoOUoIdcw3aGv0/h5
 u/RRwQ54TIdQKRH0CE15yRGQu0DDTr58AAuv59aD0wqABMgsU20NJctE0VTuVy9slXSKasb4+
 M2vZT70pKxHMWQpMPXp1P/397mtaEtbhVOuNd6vpH1AIwon46oroZH5JaGBg9SwyauiKPBtXv
 TVOm67K2dMh9LCVz6pjoNmlrMGckNukFcj0rI7J+PmarkLnbhTyBphAs641JmNMxiIJsUAYna
 Nbn7d+JpGyUgTd6w8InSXw//xlE8t/e+T71X4+4P9moqUb7En95TWOdVXp4sRw9H8GLS7KlrB
 txaVRcbCiVReSlXpzULwaHWM8DnadC4byxFb38a2kww7OvueEwniBiLG/riQxMtPsWpHHAH4G
 V2qadxn+difbBeiz/e7ajT06+JPVUMATirXtMyiSCOPVXX1gJgowGkJgH7RCZQ08DAOyxoqKR
 hNYMYFIggVXb3HoXDf3g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-09 at 17:13 +0100, Peter Zijlstra wrote:
> On Tue, Feb 09, 2021 at 05:05:14PM +0100, Mike Galbraith wrote:
>
> > ld: init/main.o: in function `trace_initcall_start':
> > /backup/usr/local/src/kernel/linux-tip-rt/./include/trace/events/initc=
all.h:27: undefined reference to `__SCT__preempt_schedule_notrace'
>
> Ooohh... this is because x86 can't build PREEMPT without PREEMPT_DYNAMIC
> anymore. Maybe I should fix that. Lemme see what that would take.

Uhoh, looks like something a lot worse managed to sneak into master.
While test-driving that tip-rt build, I couldn't help noticing that
evolution is going mad, chewing cpu and being useless enough that I
couldn't reply to you.  Unfortunately, it ain't my tip-rt tree, nor is
it virgin tip, the evilness is present in virgin master, but not in
5.10 stable.  Hohum, a hunting I shall go I suppose.

	-Mike

