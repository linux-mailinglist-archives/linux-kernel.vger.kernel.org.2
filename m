Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D9E34343F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 20:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCUTA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 15:00:28 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58137 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhCUTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:00:11 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MAtoX-1lYong0w9J-00BISS for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021
 20:00:09 +0100
Received: by mail-ot1-f44.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so13808758otk.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 12:00:09 -0700 (PDT)
X-Gm-Message-State: AOAM530PB54+ZSf3XQcsFau7XLI38fuXH0VZrnUZMAF9ObRADEYEwg+s
        libm4w94NHhTfgT2yPyf8lfbjI4c33Vd7BLKCuc=
X-Google-Smtp-Source: ABdhPJybH4GsSHDVF63TrZC0HLL2rVmPAVn9K3V1fSlJF04CEVe0+nsLseDn44KoWji0BeRcTqynosSoI+6j3MqRnJI=
X-Received: by 2002:a9d:316:: with SMTP id 22mr4722339otv.210.1616353207990;
 Sun, 21 Mar 2021 12:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
 <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com> <CAFEAcA-s79=4VDSA3TO8tpLUMwJE=HcFT4eZO8L8CCkAAfj8PA@mail.gmail.com>
In-Reply-To: <CAFEAcA-s79=4VDSA3TO8tpLUMwJE=HcFT4eZO8L8CCkAAfj8PA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 21 Mar 2021 19:59:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a26dWjbS8CjGwc7S5S0M4SonWh4afqdxpoa8Q9vQhC0TA@mail.gmail.com>
Message-ID: <CAK8P3a26dWjbS8CjGwc7S5S0M4SonWh4afqdxpoa8Q9vQhC0TA@mail.gmail.com>
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
X-Provags-ID: V03:K1:pbC1xdMBCn4LA6auhd3jgd8VkxHDgJqrGbFaDXsRhuRO+ZhbL/d
 7oPDP6OSBHRtOvGvPsd7LzSNzLrkOBpSiWtocwAByhsvcjwAPOQTlRK0NC0jEKPqfmy9pOZ
 1pd3758sJ88XTxMMuRmyljds5JAZMclWBo3jdQmwAkvuTNSd1RFGGbNB0qpHmRw+4ob4unx
 yedxDTt2TaNo4ViQe3xWg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DMMNpiWVmjo=:Jv1H2Nhr1PV98cwkQCZR7l
 m0oPs6oso4ZGr08hFNl4Zu6sDSA77YafBFn7hbVDtKinvpPb33+hSuZ3txtTyjWmI6jq15XwP
 Q/LwdfMsjAbmvo86VQJtDJW/AubdzR8Hs7q/tr357o2oq+SYAC9EZe8lGrsvg+K0yPC5h4Gxc
 w8Ns8BAnBxjH6NaUSgt8LitpQAeWO88lId/x3Mj40iDp6Wv/e9NRPvSW9q39e2+tBYhStmVCQ
 rh+PFosO+bkFc3/NA4RKZUAiT0yXrMEYcvOCYsLIXV6w3RoZlWGIotZy+BsszaNO+ACY1Z7Vn
 l/brlsIQ9cZkB5TJvSTMBpkNhrFTCAlZ0A9w91J/6YeUj+V2A669fbsgPjmgnk/I6oDai/bNB
 4X+XCEg/+GEHR5WgWUeNTFSlXRp1cs8tcg8rPgvMHmRNJFgPug1X/sMKxFEFy
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

I spent some more time looking at both really old PCI specifications,
and new ones.
The old PCI specs seem to just leave this bit as out of scope because
it does not concern transactions on the bus. The PCI host controller
can either report a 'master abort' to the CPU, or ignore it, and each
bridge can decide to turn master aborts on reads into all 1s.
We do have support some SoCs in Linux that trigger a CPU exception,
but we tend to deal with those with an ugly hack that just ignores
all exceptions from the CPU. Most host bridges fortunately behave
like an x86 PC though, and do not trigger an exception here.

In the PCIe 4.0 specification, I found that the behavior is configurable
at the root port, using the 'RP PIO Exception Register' at offset 0x1c
in the DPC Extended Capability. This register defaults to '0', meaning
that reads from an unknown port that generate a 'Unsupported Request
Completion' get turned into all 1s. If the firmware or OS enables it,
this can be turned into an AER log event, generate an interrupt or
a CPU exception.

Linux has a driver for DPC, which apparently configures it to
cause an interrupt to log the event, but it does not hook up the
CPU exception handler to this. I don't see an implementation of DPC
in qemu, which I take as an indication that it should use the
default behavior and cause neither an interrupt nor a CPU exception.

      Arnd
