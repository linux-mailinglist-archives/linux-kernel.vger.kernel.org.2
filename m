Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2645A33D89D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbhCPQEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:04:20 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:44205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbhCPQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:03:47 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M4rHF-1lO7BG26jP-0023Ag for <linux-kernel@vger.kernel.org>; Tue, 16 Mar
 2021 17:03:45 +0100
Received: by mail-wr1-f44.google.com with SMTP id x16so7725157wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:03:45 -0700 (PDT)
X-Gm-Message-State: AOAM5318I7drsaOpXElyKeV9k/xEsDrH7wgFjoiApRSJzOVZioFKTPYC
        BGoAtGKG+3xgal/qbBxK3GqxqD30CDLCVathuhw=
X-Google-Smtp-Source: ABdhPJzvg7khTfsWw0+lYh5ooXKFpK4N7dQmAEpOTsDsESTAmD+qkzykYqJhHr+bPCnXpTkiKegc41OpcF0yH5B0hAg=
X-Received: by 2002:a5d:4fcb:: with SMTP id h11mr6005224wrw.66.1615910625200;
 Tue, 16 Mar 2021 09:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069802205bda22b7f@google.com> <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
 <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
 <CACT4Y+aC0YWU6gM32S3NoT+-wR7B1-_rhPyh4w542h21UCRRGw@mail.gmail.com>
 <CAK8P3a0zA9pv005d_P_e64j4EwXDh75yC6gNGRVdyy-VzO+7Fw@mail.gmail.com> <20210316155102.GP1463@shell.armlinux.org.uk>
In-Reply-To: <20210316155102.GP1463@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 16 Mar 2021 17:03:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3A=TVWWmog=1YsALUhsaSkqReNrao5OTRd5mwyd0pnig@mail.gmail.com>
Message-ID: <CAK8P3a3A=TVWWmog=1YsALUhsaSkqReNrao5OTRd5mwyd0pnig@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: corrupted stack end in openat
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:X7FDwIoafQL7yCMOseVGYMUPwWF/JP1FmtARuINQjm6xOgeXn2G
 hJl4s/Qxg4rHEnaV44WCM/yEWwd/XJ53dTK3Cz9KGR3CN6UD1zr+7tdGarCUl2jAHU5/vN+
 F2VEKPSUh1ywU+LuXLOKkKHqxNLZll/IPZx+b8GdsJNaLdMPURNP7gDMx2+JCly/lawRchN
 A4LdV3bqAx3lK0/goEQhw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PMtEIu9vSV4=:MQEngHvoZYPoq3Y8I8YVdb
 EA/98FAe0Eu11H3FMhZjsxPTAAO1QR5fnuegjj26QHRzAW/xTfdFikVg2AhcGicHMi+4vFGtJ
 5c30kmwR82IR6UJvjU01yNyhxrCDt05Su8j73fzfdyM4Sh7m4oXwJKoPOHSmQwNeY1R3I2TjU
 Y76Qb0k+VuGyNXxTuqa3skHduDVadFWCL5SbFdgbTtLh/iCW/9KUNrYzS19ow4I6lgEhRvw8z
 hheyhhJDRawWxXu75MB58ObKO2Yjyu+0oPbTGNbXDOxXX3W5dnfh9oA3zeu/lhD23KDbc2sX5
 nCIkg+04JCDQMNjg6+bdbuJGX/GCGXsnnWMzyJ0PyqLtx2MYsfPowdwXV3ZMNRT2UKl2NvWfM
 /E29lemVEhZi90BVXynVLu56+Bx07ySO7SXkw7TyObSbzlcmjqdqFkdMlb9Wu/+9BGXufWdlE
 W5vepi4TU95DAruBM6ZATu2MplSD2VqViYFRuyVpehAwykMg3/iy/mj4ZQtr0ImOOqjQvn2W6
 WSHOR+Kp9qBBafGAUwhPnXQeWmro1MSm/6lnVBq/cANxFRyYNbZmOUvfO2ytgGeZg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 4:51 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Tue, Mar 16, 2021 at 04:44:45PM +0100, Arnd Bergmann wrote:
> > On Tue, Mar 16, 2021 at 11:17 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > The compiler is gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> >
> > Ok, building with Ubuntu 10.2.1-1ubuntu1 20201207 locally, that's
> > the closest I have installed, and I think the Debian and Ubuntu versions
> > are generally quite close in case of gcc since they are maintained by
> > the same packagers.
>
> ... which shouldn't be a problem - that's just over 1/4 of the stack
> space. Could it be the syzbot's gcc is doing something weird and
> inflating the stack frames?

It's possible, I think that's really unlikely given that it's just Debian's
gcc, which is as close to mainline as the version I was using.

Uwe's DEBUG_STACKOVERFLOW patch from a while ago might
help if this was the problem though:
https://lore.kernel.org/linux-arm-kernel/20200108082913.29710-1-u.kleine-koenig@pengutronix.de/

My best guess is something going wrong in the interrupt
that triggered the preempt_schedule() which ended up calling
task_stack_end_corrupted() in schedule_debug(), as you suggested
earlier.

       Arnd
