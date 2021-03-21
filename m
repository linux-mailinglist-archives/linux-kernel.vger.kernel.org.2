Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E70343226
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 12:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCULxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 07:53:35 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:34317 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhCULxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 07:53:17 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBmDy-1lXp3v1Bvw-00CCOl for <linux-kernel@vger.kernel.org>; Sun, 21 Mar
 2021 12:53:15 +0100
Received: by mail-oi1-f178.google.com with SMTP id c16so1186569oib.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 04:53:15 -0700 (PDT)
X-Gm-Message-State: AOAM5303s31v8lxvyuWZD7KR2Q13dA+qGVRUDPv3PXXUiOWQPbhLBmn0
        wUWqPkXH8ND4SPUz3RKdYienrRq/Opm/JoHvbcI=
X-Google-Smtp-Source: ABdhPJzdrdNu0/976S9nPBHtXVOauuaVG3EDLga/VkNgu94m7hzX65T0kx2hglnGYYbbi2qxGL2nAuC34LMfLqVyDrE=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr6541428oie.67.1616327594034;
 Sun, 21 Mar 2021 04:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
 <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com> <CAFEAcA-s79=4VDSA3TO8tpLUMwJE=HcFT4eZO8L8CCkAAfj8PA@mail.gmail.com>
In-Reply-To: <CAFEAcA-s79=4VDSA3TO8tpLUMwJE=HcFT4eZO8L8CCkAAfj8PA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 21 Mar 2021 12:52:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0X5bVNLQme70-25Mps=hoing5txa8ap2YVHiUBr3najg@mail.gmail.com>
Message-ID: <CAK8P3a0X5bVNLQme70-25Mps=hoing5txa8ap2YVHiUBr3najg@mail.gmail.com>
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
X-Provags-ID: V03:K1:hWf95woDn4Oki4P0tPlrC1sAIg/cU5g1H2+1pkHzwbuV4T22z7C
 MxVjc+OK3lIJnuiUwyWWqNoQqNed/hkX8kSbTpPFTyzhjXOxow68oPuuaxFdfbXJn391X9T
 2DQ70I7iGDxdCML9wBRo0mTE+nhIr5Vfy6MqdFixOzQyhK1WkQ6r84aPikxVRRuh8btmT9H
 F3kmUqtmPnhWG4xMP8aNQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:56kzO+ltDWw=:s21faXoEJCTf8hserHl06G
 pAtEq0xyLTFBC+v1+3uLyPLg1/CnPjxKe5kbSccWBNiV6Z0UvQDtfa5gemqFuayVzbdcZ2ZQt
 bODU6j7INoAOsKPIcs4oge4YX3DtOLQpGF9a+TDlpfggH058KoogyhIWFDTa6HHQQfeQAxbkt
 wiHpQpTQwbNoz1n2Mr9eTMQXN75/GRQHHJqzP2T57gvdspF/eCPIV0CG2d6baK5aqz7u96Z5i
 chUndEqpJ31oSs7lGN9mX5PPUOpI4zVSxO9qDi1kWFedwwYacQM4/GjWpiJUenXVJ1MziILoq
 InRZe4rGE0NZT1sNy+sXlFy2tAVbym0mhBySpbs+0bWUZw0kUKEChliZISAOsDCyLtTtJ+BEI
 Mi5KvVQpZeZHQtlM76Vl5hn53zsMk3+JCa2PvyBnhemjvF130LI/U81wPJkIVW2S/uibHkei+
 aehRb9314EldovVxh6XaTrX3a/p1Nn1GDM6eFhS2KC76GbvusUAAC0+Qpmx+q1BMKRXmyWmj0
 IGUJeq//hW5pyDKBRQ+hdwM8WZHICdescIGm6pEKTLwsbTM2GnnU2S4zK2zt+M+ZQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 9:43 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 12 Mar 2021 at 09:16, Arnd Bergmann <arnd@arndb.de> wrote:
> > So it's probably qemu that triggers the 'synchronous external
> > abort' when accessing the PCI I/O space, which in turn hints
> > towards a bug in qemu. Presumably it only returns data from
> > I/O ports that are actually mapped to a device when real hardware
> > is supposed to return 0xffffffff when reading from unused I/O ports.
>
> Do you have a reference to the bit of the PCI spec that mandates
> this -1/discard behaviour for attempted access to places where
> there isn't actually a PCI device mapped ? The spec is pretty
> long and hard to read...
>
> (Knowing to what extent this behaviour is mandatory for all
> PCI systems/host controllers vs just "it would be nice if the
> gpex host controller worked this way" would help in figuring
> out where in QEMU to change.)

Sorry, I don't. I can probably find something in there myself,
but in the end it comes down to Linux drivers relying on this
behavior for ISA devices since the start. On an old-style x86
PC, this is the only method for finding out if a device is present
or not, since there is no description in the firmware that lists them.

PCIe devices remain backwards compatible with the old ISA
bus, so the old behavior must generally be kept possible.
I don't think a specification for the ISA bus exists at all, and
I found nothing in the related LPC specification about reading
from an unknown device.

https://tldp.org/HOWTO/Plug-and-Play-HOWTO-6.html#ss6.12
states the behavior of the ISA I/O ports and how Linux drivers rely
on that. Is that enough for you?

          Arnd
