Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0985235EEEA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349783AbhDNH53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:57:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:34569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245671AbhDNH5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618387013;
        bh=THS3x+hU0eqVl18y1Db7EOuahnPn/NI11RQChZnBbJw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=DclMOqzLj3H3kxQtuL/eClDM53XEQy9KHCPI2B9uFwki7yOcfi0w/XV92HZV4xw+/
         stjkgs/q+YFFiOTJDHYrAwdsFPHm/D+M4aQ7woLIN0TJHCz9ft6NC6J2FK1Mp68PP0
         rhkv+GECCJgjK9fLcFfOaHd7LNmI3iEzvoDyYx0M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.50]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1lT2pG16P1-008cGJ; Wed, 14
 Apr 2021 09:56:53 +0200
Message-ID: <d47e3abad714ddae643c7e3a10bbf428a65ddd17.camel@gmx.de>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=3A?= Question on KASAN calltrace
 record in RT
From:   Mike Galbraith <efault@gmx.de>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Date:   Wed, 14 Apr 2021 09:56:52 +0200
In-Reply-To: <DM6PR11MB420260ED9EC885CCD33840EEFF4E9@DM6PR11MB4202.namprd11.prod.outlook.com>
References: <BY5PR11MB4193DBB0DE4AF424DE235892FF769@BY5PR11MB4193.namprd11.prod.outlook.com>
         <CACT4Y+bsOhKnv2ikR1fTb7KhReGfEeAyxCOyvCu7iS37Lm0vnw@mail.gmail.com>
        ,<182eea30ee9648b2a618709e9fc894e49cb464ad.camel@gmx.de>
         <DM6PR11MB420260ED9EC885CCD33840EEFF4E9@DM6PR11MB4202.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lOl8XRpuQSDP5jCLgTZRxrpHEEiYy6+1yubRgO/J/4je0GfEMvp
 h4u1jz185MnWrGanzgpPolJ7uRtTXt5qqFIqhhM1d6+LYPP5fT/GVY9HMJ68Kste03PBL8d
 lcdJJFJpcs++Ksdv9Sz30NOudW63ejXvLTCwdTkkcwArK8GxWn1Bjwz23ThTMH57um1xfBB
 fJRvtKmBBfBmrUI0o5SOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:siDEEibQxqo=:EvtHd77BMBR0tdMlJIOtUs
 OmiK5HRrlJfX7CW1iIvdyOTDjOpD3MSOgDWwOJXPFHHwzL2NaAbt5E/FBHMNKDKUnxSOGHZDj
 12FJ2xKsK6P15mqaB2rykElfTDOyi6MSzcfmeaWGh7AvCMFzXs71fC2v6mktcM9gBNW3HRK8i
 7E2m7zB83moDV0deKWzsbvxgzyZ4yfwhLFRtOS4BM8gFTaVxsHLWtOMmI+VZ9nxfSqNha4CHg
 fJNgaOWcmvfIU4ImMFmW1i3IOYPxhFrIHfxfUF6vX9Vq31hyVjlpw+lypWv6FR6J0QKzMCGQY
 vEOqPgTOkBHbZtDpin1n8l/waME5m2wRh9FrOlfb1LK9qxMoHx/0nzr5S0t4Os0m9K30OJCRj
 JrR/DfR1yxVJTWyMk3VyLMDuEdztHXQMBjP5CN6RGy3hTMueNOKyX4WOJwP6LDo94cmDh1T7U
 0XCsvf/ggBKUSNiYPkBCdh7hpkF4wIwqvnku12fyxaO2nsMsvOQORIdX/G6Zn91nd6Ven3P2y
 p7ADfd+5JBce6ocSuY6dpW9Wx3Gu/lzdf7Y7/z6CcsWdMtv/F1+JBenUJJTg7um/EzErMHr57
 g1l70dUicQjFkrf17PpMpiZYEmY+lSuqIpXnpVFtPWs4jyeyd4Jtd4Ol7/negh04Cf9zzk0CN
 SItsFcxBEF/G5yHvCxtxURfJbBFttVNtuI/r/Sv+uzadlHt5rDuD4HmXhVvlj+Xrbz9KEAkWC
 A3TTValnN9yQ4pecWCaLgLCi0VsHVfRbz1U8Z0q7jYc2Prf3S8GgtMDshnxzcGynXux21ICQD
 x1P16Xpe9mLTCnhokC1XSWJh4XIT2Scq+wwS8YkozM8lLtwB/NaSuDeEbFIWIOdDLr+Qv5Fig
 3U1AGZWAi4W8+/fpqTjWGHmts/dZT7RrFkjQcdudqK7tBcwBDrVOibAcP7kF1AIrNZwXJtr3o
 kr2BB5ZT9LeflNSq9dRf5WlKCH/SaGK50mXoGX4/5rVdJfsw6bfN/Za9Nt3/JoXuSPx3T0lpn
 ypyOX85OKna/6HSTgVMOerIe+x8Kf0GUvcbtWp7dtAofZLAUX5jJWgHQGx7dOkjicZedaBBKI
 LpOWTzTkjzBLT+gIuiI11ddfx+LNaqWlMITYydwVvbdX0uVF2Mf9LXlZ8TOgwoQ/an799ozG5
 vtnofUFVLZ5ZdIpRlNrb8ZgqnORD78NZGeePRbW1vmWSzl9GiX4RTI3tXiskkbqxPvSb8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-14 at 07:29 +0000, Zhang, Qiang wrote:
>
> if CONFIG_PREEMPT_RT is enabled and  but not in preemptible, the preallo=
c should be allowed

No, you can't take an rtmutex when not preemptible.

	-Mike

