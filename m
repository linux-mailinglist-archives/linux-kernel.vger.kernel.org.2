Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF22A35ED15
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347834AbhDNGQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:16:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:48231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhDNGQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618380954;
        bh=LutR6DvZ3BWEG3fagVRG7i7mzJ5l1vET1psDib4/VJA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=kGoeBbSaTL4ITAtEsDpxtBbrpi/IppekwhvdnQv94nUMWzkloattfwY1VvehH3FlN
         bTr6KLC70IcDvBLLQmYf5uNhT8tz4DCoDwfFawa652Wqm9Y7LTo+MxWhVeTIjFnwiN
         GcEpeicowCfdVrcJQuPS7viyPehzBqmTIb669JwY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.50]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1l9HSv0MjP-00O1tK; Wed, 14
 Apr 2021 08:15:54 +0200
Message-ID: <a262b57875cf894020df9b3aa84030e2080ad187.camel@gmx.de>
Subject: Re: Question on KASAN calltrace record in RT
From:   Mike Galbraith <efault@gmx.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Date:   Wed, 14 Apr 2021 08:15:53 +0200
In-Reply-To: <CACT4Y+bVkBscD+Ggp6oQm3LbyiMVmwaaX20fQJLHobg6_z4VzQ@mail.gmail.com>
References: <BY5PR11MB4193DBB0DE4AF424DE235892FF769@BY5PR11MB4193.namprd11.prod.outlook.com>
         <CACT4Y+bsOhKnv2ikR1fTb7KhReGfEeAyxCOyvCu7iS37Lm0vnw@mail.gmail.com>
         <182eea30ee9648b2a618709e9fc894e49cb464ad.camel@gmx.de>
         <CACT4Y+bVkBscD+Ggp6oQm3LbyiMVmwaaX20fQJLHobg6_z4VzQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i2oTji6pkK7Awnn4kp8awBkagqnDehpwQ19loaFFTEDOWWzpnJT
 5ZWePAPbDr4rTHVpYVUUBYlMAKHS6+2sdX7n1tdPxczJZz8mzCKpkoxzCe7SWM/50iSywXK
 RH+YSrCdoOHBhEZ9MRZu3dJKn6zt9yAYMAWf3yTAZ4J5yi6w59Stoy+3HZ0PutFJUNeI8g+
 PceWxcmskbS47vHR1NR0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d0fpSXM5V8w=:DBY15R1nVlW7LxOLFEPwLs
 UREHxo4fBskbInhck33ZUBkKQdD0vRU0gjuSKhx2B3cgiTI3SV6Er/3ZhFIgZlyTcvwIbUCOz
 lnHDE10fPuKpJyCsIoN5bd6Cs2IAoTJByLtufFeY+/YnMnA+YMPv8uxzuesxiuFqjSbSS8lyO
 B1uqZc0SF3s7xp3ixbFph8mCq1KxSGaStEeEwtgIx0J57bY85dMhR6UFaPHUTtuGv4pxBz0it
 ThXrI0/n6as1AWVOTmEI2hkLDSh3wMmb3rcMwI3ulj9k1XCCw3PtkrTcOtyLp04gTvNn3kNBa
 +ZGO4Ib0lFpyHneqmA/vLy+LY5u8oBeeYHRHvVm2TS6g1Pi/VIPSh1lTd21aKQ2d31aY7AS/O
 OHKtphiOQEtNn/SeapMt6q9kfIXeXnXLPzeY55CKq6WgN8Wp4/+KBbueAufhHHSissdFVJ5rP
 Ad7v+NqxWF5fkVlqMQpIou147d9Oh+4mliH8Hj0opjX9MU+W0hpn0RbgjiLUYu7vGfCz61+Fv
 vUwc92f2tXBZv5Gd4LqOACDpDBI5m3S+1Cpb5t/N0TBrpD4aze83LL5ZIjw3ECmDcMqpRCdvo
 Tp57EcGXefPGV14+ErR4hIj3traBLNLIw7ucgO8AHbpETHS/GfC+LnbJYA4WE7NqlLp4CUdNO
 HAXj6TdWpHW0uAdOK1U4gMnXo/FBHCCYCxwuIsXiQoAB2aWUd+r3nKD6L76lpwxFu2elozIR6
 57PMDNI0xc3iA2QAoHFBKzuvBkt76phX5IBor7L/yjOdoheBnN9Lzx7FIsSxBli0cFKmGVbhL
 6X4N49j3erCH2vTuV1GvJtE0VBwqzauzJy+Jjldmug9BJKJEJgJZGs/fjyc5E2rX727gtdPy4
 5BaXrpFCMvn+f8r4P5xYpKtT+Suz+0I32a2yG0C0FFKibLUTD6cAtl2nlg0F1qRuEbe7KZRsp
 G/lP2w6vlI7HHIK7lYrLzdpcY3EOPiaHD6Bnx0+aAKH8cutZSlzPWVANdCg748YZdbP/ihiBM
 HiSRMEkevol7wFeengVrkC8nIBIBgcDPIyChaQKA/re8Zjc+VRCbGP1gEzKFw0i/MbXUj5QUw
 pYoBrS4v3T40HXvwvfm3JBm8wjEwgS9HXZWa21b9cvLMqxj6DFXDqvBMs/94eBg6LQVe4dvXV
 R+v5deDlKTUkSCh604hAC/anoJMeOoRjI5g0rN79RqScYNhpCr1YKO14vtywz5Gt9eNSg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-14 at 07:26 +0200, Dmitry Vyukov wrote:
> On Wed, Apr 14, 2021 at 6:00 AM Mike Galbraith <efault@gmx.de> wrote:
>
> > [    0.692437] BUG: sleeping function called from invalid context at k=
ernel/locking/rtmutex.c:943
> > [    0.692439] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: =
1, name: swapper/0
> > [    0.692442] Preemption disabled at:
> > [    0.692443] [<ffffffff811a1510>] on_each_cpu_cond_mask+0x30/0xb0
> > [    0.692451] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.12.0.g2afef=
ec-tip-rt #5
> > [    0.692454] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20=
C 09/23/2013
> > [    0.692456] Call Trace:
> > [    0.692458]  ? on_each_cpu_cond_mask+0x30/0xb0
> > [    0.692462]  dump_stack+0x8a/0xb5
> > [    0.692467]  ___might_sleep.cold+0xfe/0x112
> > [    0.692471]  rt_spin_lock+0x1c/0x60
>
> HI Mike,
>
> If freeing pages from smp_call_function is not OK, then perhaps we
> need just to collect the objects to be freed to the task/CPU that
> executes kasan_quarantine_remove_cache and it will free them (we know
> it can free objects).

Yeah, RT will have to shove freeing into preemptible context.

> >
> > [   15.428008] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   15.428011] BUG: KASAN: vmalloc-out-of-bounds in crash_setup_memmap=
_entries+0x17e/0x3a0
>
> This looks like a genuine kernel bug on first glance. I think it needs
> to be fixed rather than ignored.

I figured KASAN probably knew what it was talking about, I just wanted
it to either go find something shiny or leave lockdep the heck alone.

	-Mike

