Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4195C315458
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhBIQuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:50:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:52083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232868AbhBIQsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612889178;
        bh=37N4vy20Z52BIFw5qSWY9NeNLzUusQrvh5fef3MtDhk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=QhX0163ljSGbwh9LxWyDsvP0rp9fAnZsz46hqjiuKH/Eriym+n5E1pLI0ZrEgWpf6
         rt0pAeRBVu1fPJ7F971P4N4Dj4XO6h4VaqSbDBB/pbaPFmDxdE8RVx63Q9qY/eToXK
         uTWy6hFb+iaJMdkl1BWT+nvqqo9L5qElleUjr9R4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.88]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7KU-1l2KMF1t5W-00BYWF; Tue, 09
 Feb 2021 17:46:17 +0100
Message-ID: <967ba94b84727c6b16b18ec7afba916d7852a9e1.camel@gmx.de>
Subject: Re: [patch] preempt: select PREEMPT_DYNAMIC under PREEMPTION
 instead of PREEMPT
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 09 Feb 2021 17:46:15 +0100
In-Reply-To: <YCK1+JyFNxQnWeXK@hirez.programming.kicks-ass.net>
References: <7d129a84b0858fd7fbc3e38ede62a848fbec536e.camel@gmx.de>
         <YCKmhnoSKgdYqxOL@hirez.programming.kicks-ass.net>
         <269ee10aac93d819e48dc81f09a01d01fcd44fb1.camel@gmx.de>
         <YCK0m8FD9kp8QZWJ@hirez.programming.kicks-ass.net>
         <YCK1+JyFNxQnWeXK@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wp/fjLpXNx+o2f5+0bMqee8cBDQGMvbcMJigzQ5qaq6jHm8GTyT
 Qsu3lUAbd6ZvnhYNnMqvEG60uTMIC2e0eEnP6KXSkHr+JItJvRMvldgLYqlBGy+A8IN2VDR
 06dt2kjPLzIhwaDABonAgXE/sXSQf/O+ldEo47nl70DHS/SsGw8eWnf30Mu9tBdANHdhXaw
 yIgENST6inQFnfDyZhD3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0WTLvrlQXik=:tjlEaW4vdBlCZlZ7VzchFh
 puutFEPnFKdbO2FInnyywgOvjPbtlfhpUyuLWF6nSvvdFm2JHXFHkzowByUnmYiU8XtzrBfOZ
 kevFlotlRbNCsUSxKjpSokT+ygybKP0rk4KTRv8slIcL0K5z/OPlXuotMTottKX1t7kysD3m0
 49qwM42BDUgpBpTEEYLRv3oFH3iVmCWn2Q+/5uiuJ+ky8WdSZHN7LPVoRan+J7BY+s2BRqJ81
 22aTRZMMr09wVEmaPZOjKEAQ/xRw68SUJFtdMap1BO0s/wNwt7s7w4mm3S2jzie8FFNV497J5
 +SRV1q9HB98UxYFGmY4IBh+y7Vg5FXWfx71SzKIZRNyYhHET7l/T2F7ZOmq85gU6SaJErEhEW
 ky/NS2bMFcTd3ff+OErDXXC2PirsPnn7Fi78OYMYsd5wqaUSN2pEtbkPmMXqOxvQBHCs3/+Sg
 HN43iKz4pmnnCePk/Iynftwe0GjSIkt6gceS3PPGMbhCWov2EAXqorleXYmeyyp0YN7t71dxG
 EnZYUObyTekyzCzalS3eNNdFFbTsxXv3mdWSZypwosdZg9234krXg+NQ2n3CZAt+Cf7FEE/eL
 VT6XkqnvEHO7VW70qPprjL+wswiKAxS1W3Vbxfo0QU60pVk4zKboZk+TPUlYGFW2VKrG98ngl
 CgEDhPa0NzfnNRKgc2dbaQVxWW96awNKHT2n9m2f/Ju9ARmpB/RGgukS1jRDxcIYcx9qWWQoe
 L9EWhDYShKH8lBaRI+01a6xdFzfOfG9vYg3WixoIqTEkODMHntDe6hPgwo5eJySIXJV5s9RIz
 dwfLlhUe7FiEGEXIPrXld2PeXxceYsAyMQUIQfuOpIOQ8XRlsQvjgHkaesua7smRMYqABFx8a
 xvh3SaaBU+o9cfqyNm7Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-09 at 17:19 +0100, Peter Zijlstra wrote:
> On Tue, Feb 09, 2021 at 05:13:15PM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 09, 2021 at 05:05:14PM +0100, Mike Galbraith wrote:
> >
> > > ld: init/main.o: in function `trace_initcall_start':
> > > /backup/usr/local/src/kernel/linux-tip-rt/./include/trace/events/ini=
tcall.h:27: undefined reference to `__SCT__preempt_schedule_notrace'
> >
> > Ooohh... this is because x86 can't build PREEMPT without PREEMPT_DYNAM=
IC
> > anymore. Maybe I should fix that. Lemme see what that would take.
>
> Does this work?

Yup, worked fine.

	-Mike

