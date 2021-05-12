Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F16B37B719
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhELHwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:52:05 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50985 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhELHwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:52:04 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MNKqC-1lrGPF0aJm-00Opx3 for <linux-kernel@vger.kernel.org>; Wed, 12 May
 2021 09:50:55 +0200
Received: by mail-wr1-f49.google.com with SMTP id d11so22578045wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 00:50:55 -0700 (PDT)
X-Gm-Message-State: AOAM532uwhXvg0hFJMV5cd6+YJLFK15aW7ezBjtvDIvrnDYAaMEy34hW
        SAauR+24663RWodOywstNCyNyw9+H0igDwsbNvw=
X-Google-Smtp-Source: ABdhPJzm9hGc6GFO+ktghBbYuOPr2K5dzQRME7cq8HnEoH7pqFRJ5zO5mfv9O5dbJVmJs6K3958/WPdA/jfdunKpoW8=
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr45023093wrw.361.1620805854855;
 Wed, 12 May 2021 00:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210510093753.40683-1-mark.rutland@arm.com> <CAK8P3a0pO=Jqbd503Kx-H_S1AzikcPjHT5=40ACZuxSF3dUFNQ@mail.gmail.com>
 <20210511092701.GB6152@C02TD0UTHF1T.local> <YJuDtid8/IrajZ5T@hirez.programming.kicks-ass.net>
In-Reply-To: <YJuDtid8/IrajZ5T@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 May 2021 09:49:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2gY88guguWAP-oPXBEZRPSxn_x6zkA-yNduT82a4s0sQ@mail.gmail.com>
Message-ID: <CAK8P3a2gY88guguWAP-oPXBEZRPSxn_x6zkA-yNduT82a4s0sQ@mail.gmail.com>
Subject: Re: [PATCH 00/33] locking/atomic: convert all architectures to ARCH_ATOMIC
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Brian Cain <bcain@codeaurora.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Henderson <rth@twiddle.net>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gY6U1MxbJRHXYGLmlkcHDrPyE+dzd0Npk0Hoxnxjb7ZdlSFEwJe
 Xe0RFj/FR6v3KJocKHo/Ewm/xO+bJFDttzRk9A8mUlC9lo2cDR8tz1c/jfrTAb4/V9Bht8N
 R3tX8fxBP72ULYSO1ilF1JUWxvd+p0t6CzXMeEXKMEhCEQ/IE0CX7r3YFFFICXm1r+tZDpf
 t3+KRQTwGvHdhpaV7WLGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JH9usKpvIrs=:yh4TBwc3REZPJAdh25+O2h
 9IR1McBjp8Ivz4a+V15lGnNG3dMeIOlpKv9AaBrs0cGvOYycK6Er5153wbw3wQAa1EKgVAwqm
 30q2cSdVScRpZyG4VRitzpSTsSpqaImdC8iTK5yKRCiutrGj3e7KEIlY++DMiM2J28vzTkZWo
 6m/kkTHMHF2N7yCWty9UginwToq88EVURmHHfnuGTHvJQCF7y+oizH5XymAf/obsIMnUM4lDk
 FYlYjsGQ7X3FVhhjx+niHlWuvm+JP566So+5pCpX7e2strzv9lDleg4aq8MHNxtjN9MvoVQLB
 45KyAk3sb11dvN7PSOjuhV+2GLwzlGh6vh9rJGghMRlBMsX0GscvpVKClXrf7JNAdO8mwQIUx
 wlLOoK+Zd3QevgU9QYfO5gCB/kxu2OiJ1j2+GXHQsFLZ8iSx2ZFMtzCUHisC1ToG2IrknRCcw
 vURWbq8J+QQMbzLQFcsfhHJG04zUuIRSHY68ZATsa9iajfOHSRTA0JQeqUSq7fp4sO19SbNUN
 Y6CMtsTyZAmH56dRTcSQd8IbTpJyRxZitEiazU6j1bnaJYzdWyoLe+xo75q8luEjxJoH2gfiA
 o5itJ/lHzxHqSX6rC2vq7I3QPBLKJzH0hvrzu2i6IxW4QPZ5Fg0XTlYPaEecwbWam49v9oadJ
 LWpw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 9:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, May 11, 2021 at 10:27:01AM +0100, Mark Rutland wrote:
> > > I'm happy to put this into the asm-generic tree once you have
> > > collected enough Acks.
> >
> > Great! Going via asm-generic sounds good to me. The kbuild test robot
> > has found a few issues, so I'll probably have a v2 with those fixed and
> > some acks accumulated.
> >
> > Peter, does that make sense to you, or did you have reasons to want this
> > to go via tip?
>
> I was expecting this to to through tip/locking/core, and I think I
> briefly talked to arnd about that on IRC, but whatever works I suppose.

Yes, that's fine with me if it helps you.

      Arnd
