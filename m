Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C3D3DC615
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 15:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhGaN1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 09:27:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:40603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232211AbhGaN1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 09:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627737963;
        bh=V0yAwALrjwuyRY/iLQoZt3ZobTIwnDVGefmqjtd/ZIs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=cmZ3CdyZ2RJ/NX/HychQYgJud80e+afsQj7xH10pAc8iW6Z2OQdtDAJikLWfevZrz
         w0d/IYgkjfPn3oVn1ycn6lfpjQ/GjXwXNj9A/LNQsUwThuX9eiJGxPsxCELauS2Ncc
         2CQGKleFEG5UYusBcx1JH5p6NkAVnhLhYBeCIxus=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.109]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMuX-1mVUaY0XBZ-00MLTb; Sat, 31
 Jul 2021 15:26:03 +0200
Message-ID: <9c710ceb11c98797f77fb90b483761a2eecac425.camel@gmx.de>
Subject: Re: [patch 50/63] locking/ww_mutex: Implement rtmutex based
 ww_mutex API functions
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Date:   Sat, 31 Jul 2021 15:26:01 +0200
In-Reply-To: <20210730135207.978916983@linutronix.de>
References: <20210730135007.155909613@linutronix.de>
         <20210730135207.978916983@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xs9aFqibgN6PfgnwWn0Kt6Rgp2TM81bxNJGHYnKF0hBnEvCLRN/
 9yEuf+o9QwM9O1d5nvEhqLc3KzJwI8E4vtKBQIqGwa02ZYdZbzUZ0sRMdmvd2X4yPlKgU9f
 jG7zL6lTC4vGwOLHoykWa6qpgQA7jj7X92nOdKB8UHNdToLCD+uCurjJ54G5pcWS24aSAq1
 HT0kzUw4HtVqU3w56iy0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VUqTM4ezzZw=:2EdbGdM8REfz5F3mBM/mpT
 KM5iycg4VtIAR7faRfZ7eM5zkWVY9vPffmA30ZSc1yUcwM2j89K9/WaMksbbdwRA4vsitd5jg
 GJeAFKJAKeAWOIO9LeYKEQ1ailudb7Q+51T/pwwsGURHgDMqqe6P23uq4nEts4mLSwT1Us2Et
 9itiqFvJnA04+o8GEaOj2m0k5qfIrft6NtZN77gKz4vTCbnfC5EKhR0bBAtu9VOMKmIGyBrRc
 rgsLu+Xd1kJ+ssbhkMrRrDvbPc8cAuAgR4uT8wlrxjcCdtusxuwYqztvXdvNN0yKaNR+vrCS+
 AHXbzqpYbFt5OmYlyZLTayCZa1gwcMbBWVGCD8YkF+x044Pz8jk6qEM1WvTDgBbhigAeWuBKQ
 ShONaFNG+60nDuj0mA7AwgOgShg49b+OF5RQpvNEHTGUKrGTUsVlgmqg/fbEp5qT77Zreof+u
 Wgvvzs1lAoq7hy9xlxO9ujgmNenYi18tnnA1xI8jsw3nYle7VZ1VLExCIUTjpdUE00frTcgNA
 1xv8/zv7GvFGcK+LNrNJX8O8oZYg53RDJ0Hj1bS+6WYN/2Ij10iMoUFldSzl6mc2PacIZ0yCd
 jHY8wLDyk3mSh5Nl4S6xoEAQb7oH1dLf2YjVxOGVeoByVdauUUsKAA3k0ejxtOg+4isipvPim
 da17KjoBiM0IE+PD/++6Hs75ShRgbvG1NV+smhQ3kTRMQGLr945QeeAj8lTGpXz+rRS2rR3Wp
 HFKhwMev2PaAee53BWcurcQME+HKLB5e3A9j7pQMNA5qFn1f6EPfnOxPK3yGzxctY0SXJxJsa
 mK0dXFdzOg78Cx+B4y/rAHW62GmnPry6CSePvw5z7J3jOj1o4zmgOdQncBQWZUcv3G+r0fIJL
 MrQPEtFnq1CBHNhjLWew1bFOC6/gVlG2jCKLh1zF8Bubld+hQqtZNrmsQtpVmcQC6Ig/k497e
 5+4x2DQqWeIDVDUj00PHBvUUWxGfo84ofU7xZljBznpD1V/kI5x3n38596Y2G6lRrvvAMXM3X
 AUr30x6qkDLk49kzu+nGIOoJMe1AhodCx5+rZTuhcEIqn2aoD7MrgKSwfM4gAPUKBJU46kv2a
 PqzyBf421kcZPGkwF5ypEp4S3wEPCBwHXq4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-07-30 at 15:50 +0200, Thomas Gleixner wrote:

...
> --- /dev/null
> +++ b/kernel/locking/ww_rt_mutex.c
>
...
> +int __sched
> +ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ct=
x *ctx)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return __ww_rt_mutex_lock(loc=
k, ctx, TASK_UNINTERRUPTIBLE, _RET_IP_);
> +}                                                ^^typo

