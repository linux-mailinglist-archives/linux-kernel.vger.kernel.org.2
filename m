Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B3533886D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhCLJRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:17:01 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:34177 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhCLJQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:16:25 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mq2za-1m6Zu93JdC-00n5GJ for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021
 10:16:24 +0100
Received: by mail-oi1-f182.google.com with SMTP id t83so16189522oih.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:16:23 -0800 (PST)
X-Gm-Message-State: AOAM530s3IQ55joEp6ZTC6VaYZvw5W32LWi7q6wN7AUN27tLgD2d5eke
        PkhVohiFLoRtj2MVNSIJ/9be3qeSVOzZzmvbhjM=
X-Google-Smtp-Source: ABdhPJzmaVJ1BJErR0dLY0ZxkdxZtpByDi2BzxzHbvs2pmhYjuIxfSu88HTZsMy7qzRtHS5rf9KAplSRmoOlQnAR19o=
X-Received: by 2002:aca:5945:: with SMTP id n66mr1452819oib.11.1615540582581;
 Fri, 12 Mar 2021 01:16:22 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com> <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
In-Reply-To: <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Mar 2021 10:16:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
Message-ID: <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
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
X-Provags-ID: V03:K1:DQkhMu1oVOffxNsOUlwi9GTiGGqMmjg3ajOF+kNugpIha9Nxj9P
 zjLrojwHLVPXWurPTrsvPaJVmmGWLP9bN+nkc1EufG111pA8KXNuEWOkJnHsckdDc8SZRRb
 /OJxVu9YmaqIwSjpHDqWH7uS2UFVVH/XQ1bgc8dR6RINdj6lfJOUSBsBGiJFw/z2lkdbvqT
 NS4ug4SDwLt7LhZpZtk+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bQS5kUZcg6Q=:Lawee56K8oohShpggzm8LO
 AVgFUUt5QLscimAeTwdjfjRpwBDJI4DIOn4ilaQEH6tecpkLvNYD80xL40tAppqKm1kmeYoGJ
 f9vsSg8dnpzwQcI2sV5Rahki5UHgr32tZOT/+9eSOhzuenUkN/F5NPyGsSutwZN4ImeMU4evR
 X+VkFbyPw0NYwpqGUVN300k2iRny9+u4HN7lJ1XZZCwarHHvXs8lq0FeJXMl6oeiJ4UYpqJ4O
 81UBDhl1fpzhdQ88Y0Z4fZxPka/7ONwNpUaMQtPPH/r4FpTqndgYKp7lxqJhAeyBhzugAOemI
 rs0wkpbG+bqN9CnP+DzFz1z5Zpe0+IHwkoPB2qJzp4KjhRhaAAsD4RRX04iBNijit/rsVaFWS
 qTDhfUGSOAQE9ScCUnE9CSJh+/LW9v78o92w7Ai5Sn78tRlP1fug6MQbd/gNF77Bh97N+WyLq
 5QrgZWsloeIsThbR66TZthJU86m+/VTG6DV81bULQnsKrawhDTS04gCuFnEDtKI4FbK3sqV/s
 M4WAfay+ZtaUjlJQUJeSkeLty321bJhx1ApgsZgnIkO/2znd4OXNT2FT01ikaSsZA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 9:46 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Mar 12, 2021 at 9:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Mar 11, 2021 at 6:57 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > a) accessing a legacy ISA/LPC port should not result in an oops,
> >     but should instead return values with all bits set. There could
> >     be a ratelimited console warning about broken drivers, but we
> >     can't assume that all drivers work correctly, as some ancient
> >     PC style drivers still rely on this.
> >     John Garry has recently worked on a related bugfix, so maybe
> >     either this is the same bug he encountered (and hasn't merged
> >     yet), or if his fix got merged there is still a remaining problem.

> > b) It should not be possible to open /dev/ttyS3 if the device is
> >     not initialized. What is the output of 'cat /proc/tty/driver/serial'
> >     on this machine? Do you see any messages from the serial
> >     driver in the boot log?
> >     Unfortunately there are so many different ways to probe devices
> >     in the 8250 driver that I don't know where this comes from.
> >     Your config file has
> >    CONFIG_SERIAL_8250_PNP=y
> >    CONFIG_SERIAL_8250_NR_UARTS=32
> >    CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> >    CONFIG_SERIAL_8250_EXTENDED=y
> >    I guess it's probably the preconfigured uarts that somehow
> >    become probed without initialization, but it could also be
> >    an explicit device incorrectly described by qemu.
>
>
> Here is fool boot log, /proc/tty/driver/serial and the crash:
> https://gist.githubusercontent.com/dvyukov/084890d9b4aa7cd54f468e652a9b5881/raw/54c12248ff6a4885ba6c530d56b3adad59bc6187/gistfile1.txt

Ok, so there are four 8250 ports, and none of them are initialized,
while the console is on /dev/ttyAMA0 using a different driver.

I'm fairly sure this is a bug in the kernel then, not in qemu.


I also see that the PCI I/O space gets mapped to a physical address:
[    3.974309][    T1] pci-host-generic 4010000000.pcie:       IO
0x003eff0000..0x003effffff -> 0x0000000000

So it's probably qemu that triggers the 'synchronous external
abort' when accessing the PCI I/O space, which in turn hints
towards a bug in qemu. Presumably it only returns data from
I/O ports that are actually mapped to a device when real hardware
is supposed to return 0xffffffff when reading from unused I/O ports.
This would be separate from the work that John did, which only
fixed the kernel for accessing I/O port ranges that do not have
a corresponding MMU mapping to hardware ports.

       Arnd
