Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C0F3F8A66
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhHZOuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:50:02 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:56511 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhHZOuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:50:01 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MplsZ-1mojLw0uej-00qBXb for <linux-kernel@vger.kernel.org>; Thu, 26 Aug
 2021 16:49:13 +0200
Received: by mail-wr1-f45.google.com with SMTP id u9so5482058wrg.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 07:49:13 -0700 (PDT)
X-Gm-Message-State: AOAM532s1G7jlaJ+axeRLjvUgnpS0+BXnwo9cAdmIFVplUV+aMOdPNwy
        oZW8vcJWwqH+JmDQEO0Y6eDrflxmR0dJSi063/8=
X-Google-Smtp-Source: ABdhPJx44vw9sPQLJZ7jYcP4UWiJ7TAMpZdv5UHdXHQfr3e6pUMO/iyLLPWpegusYvUir8vNXLzOv/jpqAWjmuO5TKc=
X-Received: by 2002:a05:6000:188d:: with SMTP id a13mr4484495wri.99.1629989352818;
 Thu, 26 Aug 2021 07:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-3-vladimir.oltean@nxp.com> <CAK8P3a1oDeU-S5dLqKTT3YFvGREvNt_a=PTkVoDhUJYquJGePQ@mail.gmail.com>
 <20210825220023.rqskspy2usvleoqr@skbuf> <CAK8P3a3FnsWbGRU7BNc8uwt0nFAHa7K4c+qpoZixwdW9kihC5w@mail.gmail.com>
 <20210826135725.lrn2afoekxzzvtbf@skbuf>
In-Reply-To: <20210826135725.lrn2afoekxzzvtbf@skbuf>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 26 Aug 2021 16:48:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3hrYU1mRFy0H0==Wh4T2-WtZqe9bF=MuoibsH8zP9d0Q@mail.gmail.com>
Message-ID: <CAK8P3a3hrYU1mRFy0H0==Wh4T2-WtZqe9bF=MuoibsH8zP9d0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: syscon: request a regmap with raw spinlocks for
 some devices
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Yqo5RM7wBwlNerRMAlbr/rtZ49Dn4fvQRba5Kg6tSe1gzBV1rry
 tw64/6izj+Sc9LT+fdYTcaFSsiy8gjUg6t0k506k9lF4oE1FBbMdUdxpbXQXUQb4GzOMPO+
 Ou/JmVsaq/p6qou8IDW4QQ+LkP74P5zJeRdDRtEpOezql5iPHDmTs3bH+bPcCcdpB5U+YU+
 TvXn6WF3z8CftsuawxaUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:il2CvKVGKNQ=:JBfIfwwHC0jKtCO+ZG4Cw2
 FdZBaVetjPKlVj2VCN4eUASMVGs9RvaiAdREvEMPhUFfZxLXv8xEFlhCCKR2HPKsojO5csG3q
 KsfH2/GzLcDYJaZyyF6XXpCMVyqqSYs6LJ87Kktao+7jIQU1wzmD7iD3Do2ohpvbDqlAfNuz4
 9CR4c+PksapGGS1894S1A5up/b34gyxVDXnZp6X2oBlKYrJCUe+IzwvZ5xZUZE5xFFvhVkmhk
 +xY+YUa59C1LTnr7QRQih0SVDn8F2dA/xP+UJ5VsEKdrJdIV4OSrOMr0uCBY5o7dlOeq/seML
 LFFCvBjmtZnLljXkOjPpYtDYGsNwZTdwLl05o//qxmpTJzokCfo8+mVb6fR8pCU9H5z3J7xIh
 ykA/ZnUmVJH65Uk1WmTjVWQSS4c8VhekTG8MymDd/iS4spJknDLuOtXvYcDlVj4kY/6yk/zdr
 0/zRTigJnxtWCWfrmoyOLVRtmJ35z35WBxygCc5+IVO5NhTCxkInbURYIwyqiSWLQeVoVzv8E
 QBycbd5d4iQiDQ2QWdeK+Y8KGrpHOoILbDk07DLUWhO2aelD5CznSR1dt0f44RrmLw198tgeh
 xA8TE0zr3knG+Luy9TFYVXWKLfeBB5KaoyDC9DwQguPSpiYU89WuRp2ArNUXPDy8/vD7TEwF7
 lkMoz4aDQ1NQX/bdpLnNhU4jS2pH37IY1uzXtAyHkvc07huJlXDdPmKcbAfO8A3XsbD0OupJF
 odqzTca5aPfa77Bs6DHIZWox7CN3kNPX6NlJQQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 3:57 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> On Thu, Aug 26, 2021 at 11:24:24AM +0200, Arnd Bergmann wrote:
>
> So basically you want me to create a platform driver under drivers/soc
> which probes on:
>         "fsl,lx2160a-isc"
>         "fsl,ls2080a-isc"
>         "fsl,ls2080a-isc"
>         "fsl,ls1088a-isc"
>         "fsl,ls1043a-scfg"
>         "fsl,ls1046a-scfg"
>         "fsl,ls1021a-scfg"
> and does the same thing as syscon, but sets "syscon_config.use_raw_spinlock = true;"
> and that is the only difference?

That would work, but it's not what I was suggesting.

> By the way, how does syscon probe its children exactly? And how would
> this driver probe its children?

syscon does not probe its children. As far as I can tell, your irqchip driver
works by accident because it uses IRQCHIP_DECLARE() rather than
builtin_platform_driver(), so it works even when no platform_device gets
created, as IRQCHIP_DECLARE() just looks for the compatible
string on its own.

My suggestion was to have the driver that binds to the isc node export a
high-level interface such as fsl_isc_set_extirq_polarity(). If the extirq
irqchip driver can work as a platform_driver(), then the new isc driver
can also be responsible for probing its children using the mfd
infrastructure, which solves the probe order problem, and lets you
have child devices that are not irqchip or clock controller.

       Arnd
