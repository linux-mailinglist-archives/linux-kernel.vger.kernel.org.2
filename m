Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C73338A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhCLKxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:53:13 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:35185 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhCLKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:53:04 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQMm9-1l78uN3hBJ-00MMFA for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021
 11:53:03 +0100
Received: by mail-oi1-f172.google.com with SMTP id o22so16667379oic.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:53:02 -0800 (PST)
X-Gm-Message-State: AOAM532qWWddjtBUcj1ELifIBRvk550iBlw2xDwBxCnmBmtP8LOtWOet
        bh+l2ZsBKwqQAgOy4uBrfO6OnKJlDo6dX/BpSOg=
X-Google-Smtp-Source: ABdhPJwKmviGryakQv3hEjgc4PKe9QSoOA16jH61KkQEnJXVeNc6baGY1p89vU6Z0yJ9KRZ+JLh/ODFX++/1r+S6nog=
X-Received: by 2002:aca:5945:: with SMTP id n66mr1642040oib.11.1615546381701;
 Fri, 12 Mar 2021 02:53:01 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
 <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
 <CACT4Y+bLdCw+nWndwnv6W9=0EhNNxi=n5Zp032hZE1j0QBMkaA@mail.gmail.com>
 <CAK8P3a0yxbeY0z=6EQhvBN8NWF++1Cww4tRaSwrUQFt3A-BMaw@mail.gmail.com> <CACT4Y+aTbdE1CeUOgCKLJ3XpjazN5=yTmToXN_03M9EQ_hhayg@mail.gmail.com>
In-Reply-To: <CACT4Y+aTbdE1CeUOgCKLJ3XpjazN5=yTmToXN_03M9EQ_hhayg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Mar 2021 11:52:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a221xG9dM1UZXNGhjkVyxn6sjscSYdsFwWO6CVB_HQhXw@mail.gmail.com>
Message-ID: <CAK8P3a221xG9dM1UZXNGhjkVyxn6sjscSYdsFwWO6CVB_HQhXw@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:unMsv9NS25jyohvxw/uFQ7yGiRl464Ya/+upIcAM8j/2nHRw51V
 lS/u+/pvBwjCY90vqexxPbjP0Z8rcWu1wKRCjcvwBE1P43Lul/rb2Vtvd1Fgw4L1X3zhSRz
 ZZNU559ZRJ94d5QUI8wUn9dsWzwOoArwPLGOMq/zGqDbxUzc3BRQt8TxfjTu8b7DVR/okHQ
 jIlN7ORagaG6XMjOdNitQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ps7g53BJIhU=:8geVCHPaK/KZWfZ1EWAHv4
 B38lGxpts6r3krZW5vqNk804+XPMLUUBWQFitK8R1ehcBj/BZWuLkhGSlNuEkxC6a0J6tnpP5
 L6tJCU0+ZpW7+90mS7dkMdgFGa5DHyekxopR5uDROWAOoBCyZSodWg/kuorViehAzYVWGrtsl
 NCV02q4hqCgwQNq/1hWWFt6U6+mSfKvEq8s/WXVGHbNZqC2RfNVf+nrDI8hGdMuuOENJ/To3q
 VJL2Ba5BARMt9K6dGNkQRd8NaWchK++DuMUHTql4OXwlqttn6Jy/hJFzzT2hsii2GJIjnX5nr
 CoKE9FAFPSUuekTnnYw+XnJz/DJrKEOHMwKnutG1z5bPsE2VqT/40RvUPMR+knJZr789Fh70H
 JlMX2Nfc3i3blmFPIcMoApwWCWy9Pw2MQGY2Ma9rBke/IOoXecivdY57+fp5YmdFM0NsWCzFO
 acXOlWtJ+87s4t3nJk9F0O/JCaSg12M042ypligHXtTdStksSKGik/AVvPdP/fc2y/ryYF95w
 pY8ABQS7eYFZaW6FybK6at0+oDcApLoz/QfyIOIy8tuF+tO+qvE086F7tdRaQP7dA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 11:38 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Mar 12, 2021 at 11:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> It does not happen too often on syzbot so far, so let's try to do the
> right thing first.
> I've filed: https://bugs.launchpad.net/qemu/+bug/1918917
> with a link to this thread. To be fair, I don't fully understand what
> I am talking about, I hope I proxied your description properly.

Thanks, looks good. I provided a little more detail in a comment there.

        Arnd
