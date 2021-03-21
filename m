Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDF1343227
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 12:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCULzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 07:55:49 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39979 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhCULzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 07:55:44 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MRmsG-1lGqDE041S-00TBN5 for <linux-kernel@vger.kernel.org>; Sun, 21 Mar
 2021 12:55:42 +0100
Received: by mail-oi1-f174.google.com with SMTP id n140so10080725oig.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 04:55:41 -0700 (PDT)
X-Gm-Message-State: AOAM533stLPyF6QQyz+8f9uawjotznJ/0GxqwWWv6bPz3QB5yvKbvSW/
        3jRqItGW0jcJ5lPpRiaC6+fBFfXHJRMfrMwQ+Ek=
X-Google-Smtp-Source: ABdhPJzEbNSzwBi9m8oHgAPzvOhvrX+PUnC+PwwlrAqGC6PntN0jWM36zMUMXQDa/i8wwQxJojDGd7IcxWmviZRdse4=
X-Received: by 2002:aca:5945:: with SMTP id n66mr6601309oib.11.1616327740761;
 Sun, 21 Mar 2021 04:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
 <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
 <CAFEAcA-s79=4VDSA3TO8tpLUMwJE=HcFT4eZO8L8CCkAAfj8PA@mail.gmail.com> <CAK8P3a0X5bVNLQme70-25Mps=hoing5txa8ap2YVHiUBr3najg@mail.gmail.com>
In-Reply-To: <CAK8P3a0X5bVNLQme70-25Mps=hoing5txa8ap2YVHiUBr3najg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 21 Mar 2021 12:55:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2A4d5iKZyA_Lexmfrn02ysiXuJPk9HK6ybYFgoVWuRdw@mail.gmail.com>
Message-ID: <CAK8P3a2A4d5iKZyA_Lexmfrn02ysiXuJPk9HK6ybYFgoVWuRdw@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9LvOmAhsWDWZPQx2QT5FOOXiBB4bHtfC01xznq5uOrIZ1nSS02T
 kSEtNh5QcpglVD402xdTIYQtHocnlXMwjQQZV7pjBhs4lUg5PHQ4dvVSTlKSiVX/8q39zTe
 8Lt8yG1TQB6TZnnmtSgYzmcqkQvXti5objGrovacFzbT4kBT8R4YXCGX8tjQNYmEhxJlK48
 0TID1mhfUaPW5I77r2ykA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:W17kw69YEsY=:NqHvyF4ZycvfLAdKiOl2q5
 lD1oSijDaRfK5iRkm/w96pf6IOQ/VKiEGlmXYrmNZS/MI8/FJKaHiqok+0HwdMlpX+VkOzzS7
 ELCOsVp0Q4oErwDQZbcfHvljaw3Q348dMIh1yCtRqLCQwTrSCUHeZRckwFqUY6aumzFQ2Dxba
 h3cGMmJI1R4eh5aY5ZeZEsPgIPrdKMEL7UWZ5gZm7jo63dzlDg4ik4BovjxGHicWbhbZQS14n
 gaQ+XPDje0Y0yJLKSiZQNey9SVr+NRWdktYHwj/biKA7dR4Wn6e9RUy9sUMO/oDDn0SUKkpRT
 1pE3Cy8ROSG+4b0LYMcmmpdnT1nP6D0RkfOhPnCIMU8FQizc9CgX7RwMrEkd0BJoJ64ObHpAn
 FoTDODC6eUWDfMLzrzDzSnnD/NGRZXWr4SoOmPneJtLKnwJB7KYLnZkbeAgfRD/xqlNfut6eO
 ktVwx1+iVsKUKfJ2CnqmIJclwstPwWOPVzEkXAv3fNsQVT8yLQ0rJCOwdd+/gU+gZcEZk8SdE
 ZcXNwpAF6+7DBXCOBvroj6/hyD9jaEeQW9IdCbIjBpW+qVkGVSOoKQvGFLAXWsxeA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 12:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Mar 20, 2021 at 9:43 PM Peter Maydell <peter.maydell@linaro.org> wrote:

> https://tldp.org/HOWTO/Plug-and-Play-HOWTO-6.html#ss6.12
> states the behavior of the ISA I/O ports and how Linux drivers rely
> on that. Is that enough for you?

Actually it only mentions it very indirectly, by saying that if a present
device has 0xFF in a register, the detection may fail since it looks like
a missing device.

         Arnd
