Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949693F847C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhHZJZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:25:30 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42755 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbhHZJZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:25:28 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MQdI8-1mdRlO1714-00NgZO for <linux-kernel@vger.kernel.org>; Thu, 26 Aug
 2021 11:24:40 +0200
Received: by mail-wr1-f47.google.com with SMTP id h4so3939529wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:24:40 -0700 (PDT)
X-Gm-Message-State: AOAM532I4GNVznuEliXLi0UQ0Y53bWzLNjxBA1sj0Ev3JM3M8+KdLdOc
        8QZKPwvDZ9tqwj8XRcRgVy05SwIfSms++TWpK14=
X-Google-Smtp-Source: ABdhPJzxfVdCmNw2RZKuz6mpSUu/MVgkqui0iOiq/yr9eT5WYxf5v9z8ZhtGl7wzeRjv8qua7C+/AcCbigr+M2wawtI=
X-Received: by 2002:adf:c390:: with SMTP id p16mr2844843wrf.105.1629969879916;
 Thu, 26 Aug 2021 02:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-3-vladimir.oltean@nxp.com> <CAK8P3a1oDeU-S5dLqKTT3YFvGREvNt_a=PTkVoDhUJYquJGePQ@mail.gmail.com>
 <20210825220023.rqskspy2usvleoqr@skbuf>
In-Reply-To: <20210825220023.rqskspy2usvleoqr@skbuf>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 26 Aug 2021 11:24:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3FnsWbGRU7BNc8uwt0nFAHa7K4c+qpoZixwdW9kihC5w@mail.gmail.com>
Message-ID: <CAK8P3a3FnsWbGRU7BNc8uwt0nFAHa7K4c+qpoZixwdW9kihC5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: syscon: request a regmap with raw spinlocks for
 some devices
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Bdt/xbbhTFhGBtROuE7o931rhSth+lJt3hoOzyusg2WklyQhrdN
 82MpVpqUMTdKyMcumVBnEVRyQY0POdiSxFxo/LNIodMlyb2hmLxIGtSAewco1mFhRkGThO5
 qiZlSnv6FFeobY30nokRTleAol/wX6Hp5Q6qyHZo/I6dUacZZFWgI0GUXRunnAvxc+tNJRP
 1Hod7IA7Hu1WH60Mwul5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:trgnzm9He+8=:KQrbaRxVin1yvo8oWhY88g
 7GVDuoGd5lyVgFMy7wOcLGIHohZMxi3QEnR4xVPgG/uzf3ZsaJltg2hYf8LJBat22UBDp25r5
 U/DPNOInpIoI+jQo+ZKN/OQdkySo/KlCwGlLlG3rHGvNJEVwuYHHxAlWlvN/MKarxk/IqYvkc
 85vNi5/cy/tVRc7Hc57Shq6ITz0EEuN/A6BO4tSxBgky8GaahUssbW/asB5nfo/3IVtCH9T4V
 YTsThM1uzlVqG2zHhMyMjVzMZNlMjgGiISZ9VkG/n+pijjVj9sV1L6gf+IYXPij3OSFHtlLf/
 zmxsimmyKxzwDJc49fYekxokN9M7vbftauLIqMioJJgaAa3tmibI7I4yhtOR+A41X1bSi3/js
 bjnhIaxm0epcQuJ5Of6sYX/N2qjT4yb/z01SGRt/zvs4ng+E6SpsWMk9ZQRDQyTuCVPbDAHrT
 iEYlUMJhqK2BwzQJljcyNWupWPvQLy6ERs++VT0ylqc9x3dQ4SaQyvQQlD71UP8EMCIxp6SdX
 mVjgFlxIURyRvAOlWmWFBzdjnmq1fBoFZvTwsoOUMbHFSyXWC4EnIJnhHiDDqUMuMKa5oOfsU
 KhThBBwTf23KS5EfKupwH5ME7/k3bkqn8UKCBYePP3LmlXFoHbjFUdmSdm221zfWBPqYCZhsu
 J1ljpoC57JZTamZ0+oASStQyO1fOH4adQ39NN6YbkLwasFhihDy5ezTfXvye6vNtMppa01caP
 eTeQlUc9DZjT9TeusYWxlVDlrYGWqUENsq457w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 12:01 AM Vladimir Oltean <olteanv@gmail.com> wrote:
> On Wed, Aug 25, 2021 at 11:24:52PM +0200, Arnd Bergmann wrote:
>
> > Are there any other users of the syscon?
>
> Not that I can see, but that doesn't make the fact that it uses a syscon a bad decision.
>
> For context, Layerscape devices have a "Misc" / "And Others" memory region
> called "Supplemental Configuration Unit" (SCFG) which "provides the
> chip-specific configuration and status registers for the device. It is the
> chip-defined module for extending the device configuration unit (DCFG) module."
> to quote the documentation.
>
> The ls-extirq file is a driver around _a_single_register_ of SCFG. SCFG
> provides an option of reversing the interrupt polarity of the external IRQ
> pins: make them active-low instead of active-high, or rising instead of
> falling.
>
> The reason for the existence of the driver is that we got some pushback during
> device tree submission: while we could describe in the device tree an interrupt
> as "active-high" and going straight to the GIC, in reality that interrupt is
> "active-low" but inverted by the SCFG (the inverted is enabled by default).
> Additionally, the GIC cannot process active-low interrupts in the first place
> AFAIR, which is why an inverter exists in front of it.
>
> Some other SCFG registers are (at least on LS1021A):
>
> Deep Sleep Control Register
> eTSEC Clock Deep Sleep Control Register (eTSEC is our Ethernet controller)
> Pixel Clock Control Register
> PCIe PM Write Control Register
> PCIe PM Read Control Register
> USB3 parameter 1 control register
> ETSEC MAC1 ICID
> SATA ICID
> QuadSPI configuration
> Endianness Control Register
> Snoop configuration
> Interrupt Polarity <- this is the register controlled by ls-extirq
> etc etc.
>
> Also, even if you were to convince me that we shouldn't use a syscon, I feel
> that the implication (change the device trees for 7 SoCs) just to solve a
> kernel splat would be like hitting a nail with an atomic bomb. I'm not going to
> do it.

I was not suggesting changing the DT files. The way we describe syscon
devices is generally meant to allow replacing them with a custom driver
as an implementation detail of the OS, you just have a driver that binds
against the more specific compatible string as opposed to the generic
compatible="syscon" check, and you replace all
syscon_regmap_lookup_by_phandle() calls with direct function calls
into exported symbols from that driver that perform high-level functions.

In this particular case, I think a high-level interface from a drviers/soc/
driver works just as well as the syscon method if there was raw_spinlock
requirement, but with the irqchip driver needing the regmap, the custom
driver would a better interface.

        Arnd
