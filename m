Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C910D342018
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhCSOrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhCSOr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:47:27 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDE4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:47:27 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r193so6344666ior.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=If30wdK7W0VSXINojS1LMjY/MwaXGwEZ4xZVwECT2YU=;
        b=C+a5hzb1+6KPh3RyG/W9UuPiUXaSCUDLD8ATDqfCGs2RBTpkWg226M3sfCJ5zAe6b7
         TBAKQZxTvBkc48yQ6s85OaWA8AhjSrIsU3m9qmFtoPAf2zrR8UZ4bfi97wwdIDnkVw8h
         +rR3DM6ScUP9NfTrLsyBiKZ7N3glxahNHlUulw69Kqf6V+jK+5Rw9RWoL6+YxaUVEkoT
         s/rSMrpgMMwXz4riCZcj26STVwiIqwD2MIqh4wa57UixO6w9zj2X2z2WnkrLshBzLZ+7
         VXBmTlYVr2KZd6y019HjUa8eFAYNAYZyQ2OYDKWL3X0xAuTn9phS25lpAx3VISqaF1lM
         RicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=If30wdK7W0VSXINojS1LMjY/MwaXGwEZ4xZVwECT2YU=;
        b=Z8tBJqY4tTA6HchiqVg5jR9goH4X2uJAlLQvo65qP1yrjkt5BieUZHm1rBYZaguEKl
         VXYT25NSdyaEzS4tFjdH6Roue57S7Av7glSu91iCnJKf6OxOWLwua6nB4S4gM3+a4LbH
         XvDk+SK+g6M3KSS+EwqNyG+pgCK3jIBNTvPtlLS9DfHyVxeupihO6ygRVkzMuqoe2wKZ
         XrISU8nslu0SdlqVyWThLZ5icUISjJL6kbTdcSOzhGo0MF5xrCLnaXOkIshEClibTYU1
         zRVdgp5CGBFXH/fg0J8OXA+twYXYe8Xst4uuKUvBZsDoECKIXTsDYGRExYNi2/Wyd9j2
         PdUw==
X-Gm-Message-State: AOAM530ffKgdMM8gx1nYUp30QdOsaA2gRrz6GXqhGvu5Vq16VR3uXT/4
        YXCML40KaXucrpxiWeNBmZzlce5uslb8Yv6u04N/Bg==
X-Google-Smtp-Source: ABdhPJzLZD2SMWaMraK9szCPesCoQenO2VCJ0XKT2mKA9SiInNaL6y8gS7tF3Dg6rpBr0mS4Z/5R0jV87NOF86y69Ag=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr3092179ioh.73.1616165247110;
 Fri, 19 Mar 2021 07:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-19-suzuki.poulose@arm.com> <20210318180824.GA1532406@xps15>
 <50177F38-6EF9-46F9-88FA-AB2978AD4A9A@arm.com>
In-Reply-To: <50177F38-6EF9-46F9-88FA-AB2978AD4A9A@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 19 Mar 2021 08:47:16 -0600
Message-ID: <CANLsYkz=ms1XziU3sh4zxp4y7ZbS7jj_N=hZRMBYqra97sF6xA@mail.gmail.com>
Subject: Re: [PATCH v4 18/19] coresight: sink: Add TRBE driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 at 04:34, Suzuki K Poulose <suzuki.poulose@arm.com> wro=
te:
>
> Hi Mathieu,
>
> > On 18 Mar 2021, at 18:08, Mathieu Poirier <mathieu.poirier@linaro.org> =
wrote:
> >
> > Good morning,
> >
> > On Thu, Feb 25, 2021 at 07:35:42PM +0000, Suzuki K Poulose wrote:
> >> From: Anshuman Khandual <anshuman.khandual@arm.com>
> >>
> >> Trace Buffer Extension (TRBE) implements a trace buffer per CPU which =
is
> >> accessible via the system registers. The TRBE supports different addre=
ssing
> >> modes including CPU virtual address and buffer modes including the cir=
cular
> >> buffer mode. The TRBE buffer is addressed by a base pointer (TRBBASER_=
EL1),
> >> an write pointer (TRBPTR_EL1) and a limit pointer (TRBLIMITR_EL1). But=
 the
> >> access to the trace buffer could be prohibited by a higher exception l=
evel
> >> (EL3 or EL2), indicated by TRBIDR_EL1.P. The TRBE can also generate a =
CPU
> >> private interrupt (PPI) on address translation errors and when the buf=
fer
> >> is full. Overall implementation here is inspired from the Arm SPE driv=
er.
> >>
>
> There is a mention of the SPE driver here in the commit description.
>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Cc: Mike Leach <mike.leach@linaro.org>
> >> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >> Changes:
> >> - Replaced TRBLIMITR_LIMIT_SHIFT with TRBBASER_BASE_SHIFT in set_trbe_=
base_pointer()
> >> - Dropped TRBBASER_BASE_MASK and TRBBASER_BASE_SHIFT from get_trbe_bas=
e_pointer()
> >> - Indentation changes for TRBE_BSC_NOT_[STOPPED|FILLED|TRIGGERED] defi=
nitions
> >> - Moved DECLARE_PER_CPU(...., csdev_sink) into coresight-priv.h
> >> - Moved isb() from trbe_enable_hw() into set_trbe_limit_pointer_enable=
d()
> >> - Dropped the space after type casting before vmap()
> >> - Return 0 instead of EINVAL in arm_trbe_update_buffer()
> >> - Add a comment in trbe_handle_overflow()
> >> - Add a comment in arm_trbe_cpu_startup()
> >> - Unregister coresight TRBE device when not supported
> >> - Fix potential NULL handle dereference in IRQ handler with a spurious=
 IRQ
> >> - Read TRBIDR after is_trbe_programmable() in arm_trbe_probe_coresight=
_cpu()
> >> - Replaced and modified trbe_drain_and_disable_local() in IRQ handler
> >> - Updated arm_trbe_update_buffer() for handling a missing interrupt
> >> - Dropped kfree() for all devm_xxx() allocated buffer
> >> - Dropped additional blank line in documentation coresight/coresight-t=
rbe.rst
> >> - Added Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
> >> - Changed CONFIG_CORESIGHT_TRBE options, dependencies and helper write=
 up
> >> - Added comment for irq_work_run()
> >> - Updated comment for minumum buffer length in arm_trbe_alloc_buffer()
> >> - Dropped redundant smp_processor_id() from arm_trbe_probe_coresight_c=
pu()
> >> - Fixed indentation in arm_trbe_probe_cpuhp()
> >> - Added static for arm_trbe_free_buffer()
> >> - Added comment for trbe_base element in trbe_buf structure
> >> - Dropped IS_ERR() check from vmap() returned pointer
> >> - Added WARN_ON(trbe_csdev) in arm_trbe_probe_coresight_cpu()
> >> - Changed TRBE device names from arm_trbeX to just trbeX
> >> - Dropped unused argument perf_output_handle from trbe_get_fault_act()
> >> - Dropped IS_ERR() from kzalloc_node()/kcalloc() buffer in arm_trbe_al=
loc_buffer()
> >> - Dropped IS_ERR() and return -ENOMEM in arm_trbe_probe_coresight()
> >> - Moved TRBE HW disabling before coresight cleanup in arm_trbe_remove_=
coresight_cpu()
> >> - Changed error return codes from arm_trbe_probe_irq()
> >> - Changed error return codes from arm_trbe_device_probe()
> >> - Changed arm_trbe_remove_coresight() order in arm_trbe_device_remove(=
)
> >> - Changed TRBE CPU support probe/remove sequence with for_each_cpu() i=
terator
> >> - Changed coresight_register() in arm_trbe_probe_coresight_cpu()
> >> - Changed error return code when cpuhp_setup_state_multi() fails in ar=
m_trbe_probe_cpuhp()
> >> - Changed error return code when cpuhp_state_add_instance() fails in a=
rm_trbe_probe_cpuhp()
> >> - Changed trbe_dbm as trbe_flag including its sysfs interface
> >> - Handle race between update_buffer & IRQ handler
> >> - Rework and split the TRBE probe to avoid lockdep due to memory alloc=
ation
> >>   from IPI calls (via coresight_register())
> >> - Fix handle->head updat for snapshot mode.
> >> ---
> >> .../testing/sysfs-bus-coresight-devices-trbe  |   14 +
> >> .../trace/coresight/coresight-trbe.rst        |   38 +
> >> drivers/hwtracing/coresight/Kconfig           |   14 +
> >> drivers/hwtracing/coresight/Makefile          |    1 +
> >> drivers/hwtracing/coresight/coresight-trbe.c  | 1149 +++++++++++++++++
> >> drivers/hwtracing/coresight/coresight-trbe.h  |  153 +++
> >> 6 files changed, 1369 insertions(+)
> >> create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devic=
es-trbe
> >> create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
> >
> > Please spinoff these two file in a separate patch and CC Jon Corbet and=
 the
> > linux-doc mailing list.
>
> Sure, makes sense.
>
> >
> >> create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
> >> create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-trb=
e b/Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
> >> new file mode 100644
> >> index 000000000000..ad3bbc6fa751
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
> >> @@ -0,0 +1,14 @@
> >> +What:               /sys/bus/coresight/devices/trbe<cpu>/align
> >> +Date:               March 2021
> >> +KernelVersion:      5.13
> >> +Contact:    Anshuman Khandual <anshuman.khandual@arm.com>
> >> +Description:        (Read) Shows the TRBE write pointer alignment. Th=
is value
> >> +            is fetched from the TRBIDR register.
> >> +
> >> +What:               /sys/bus/coresight/devices/trbe<cpu>/flag
> >> +Date:               March 2021
> >> +KernelVersion:      5.13
> >> +Contact:    Anshuman Khandual <anshuman.khandual@arm.com>
> >> +Description:        (Read) Shows if TRBE updates in the memory are wi=
th access
> >> +            and dirty flag updates as well. This value is fetched fro=
m
> >> +            the TRBIDR register.
> >
> > For this file:
> >
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >
> >> diff --git a/Documentation/trace/coresight/coresight-trbe.rst b/Docume=
ntation/trace/coresight/coresight-trbe.rst
> >> new file mode 100644
> >> index 000000000000..b9928ef148da
> >> --- /dev/null
> >> +++ b/Documentation/trace/coresight/coresight-trbe.rst
> >> @@ -0,0 +1,38 @@
> >> +.. SPDX-License-Identifier: GPL-2.0
> >> +
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >> +Trace Buffer Extension (TRBE).
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +    :Author:   Anshuman Khandual <anshuman.khandual@arm.com>
> >> +    :Date:     November 2020
> >> +
> >> +Hardware Description
> >> +--------------------
> >> +
> >> +Trace Buffer Extension (TRBE) is a percpu hardware which captures in =
system
> >> +memory, CPU traces generated from a corresponding percpu tracing unit=
. This
> >> +gets plugged in as a coresight sink device because the corresponding =
trace
> >> +generators (ETE), are plugged in as source device.
> >> +
> >> +The TRBE is not compliant to CoreSight architecture specifications, b=
ut is
> >> +driven via the CoreSight driver framework to support the ETE (which i=
s
> >> +CoreSight compliant) integration.
> >> +
> >> +Sysfs files and directories
> >> +---------------------------
> >> +
> >> +The TRBE devices appear on the existing coresight bus alongside the o=
ther
> >> +coresight devices::
> >> +
> >> +    >$ ls /sys/bus/coresight/devices
> >> +    trbe0  trbe1  trbe2 trbe3
> >> +
> >> +The ``trbe<N>`` named TRBEs are associated with a CPU.::
> >> +
> >> +    >$ ls /sys/bus/coresight/devices/trbe0/
> >> +        align flag
> >> +
> >> +*Key file items are:-*
> >> +   * ``align``: TRBE write pointer alignment
> >> +   * ``flag``: TRBE updates memory with access and dirty flags
> >
> > For this file:
> >
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >
> >> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/c=
oresight/Kconfig
> >> index f154ae7e705d..84530fd80998 100644
> >> --- a/drivers/hwtracing/coresight/Kconfig
> >> +++ b/drivers/hwtracing/coresight/Kconfig
> >> @@ -173,4 +173,18 @@ config CORESIGHT_CTI_INTEGRATION_REGS
> >>        CTI trigger connections between this and other devices.These
> >>        registers are not used in normal operation and can leave device=
s in
> >>        an inconsistent state.
> >> +
> >> +config CORESIGHT_TRBE
> >> +    tristate "Trace Buffer Extension (TRBE) driver"
> >> +    depends on ARM64 && CORESIGHT_SOURCE_ETM4X
> >> +    help
> >> +      This driver provides support for percpu Trace Buffer Extension =
(TRBE).
> >> +      TRBE always needs to be used along with it's corresponding perc=
pu ETE
> >> +      component. ETE generates trace data which is then captured with=
 TRBE.
> >> +      Unlike traditional sink devices, TRBE is a CPU feature accessib=
le via
> >> +      system registers. But it's explicit dependency with trace unit =
(ETE)
> >> +      requires it to be plugged in as a coresight sink device.
> >> +
> >> +      To compile this driver as a module, choose M here: the module w=
ill be
> >> +      called coresight-trbe.
> >> endif
> >> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/=
coresight/Makefile
> >> index f20e357758d1..d60816509755 100644
> >> --- a/drivers/hwtracing/coresight/Makefile
> >> +++ b/drivers/hwtracing/coresight/Makefile
> >> @@ -21,5 +21,6 @@ obj-$(CONFIG_CORESIGHT_STM) +=3D coresight-stm.o
> >> obj-$(CONFIG_CORESIGHT_CPU_DEBUG) +=3D coresight-cpu-debug.o
> >> obj-$(CONFIG_CORESIGHT_CATU) +=3D coresight-catu.o
> >> obj-$(CONFIG_CORESIGHT_CTI) +=3D coresight-cti.o
> >> +obj-$(CONFIG_CORESIGHT_TRBE) +=3D coresight-trbe.o
> >> coresight-cti-y :=3D coresight-cti-core.o      coresight-cti-platform.=
o \
> >>                 coresight-cti-sysfs.o
> >> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hw=
tracing/coresight/coresight-trbe.c
> >> new file mode 100644
> >> index 000000000000..41a012b525bb
> >> --- /dev/null
> >> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> >> @@ -0,0 +1,1149 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * This driver enables Trace Buffer Extension (TRBE) as a per-cpu cor=
esight
> >> + * sink device could then pair with an appropriate per-cpu coresight =
source
> >> + * device (ETE) thus generating required trace data. Trace can be ena=
bled
> >> + * via the perf framework.
> >
> > If I remember correctly the last version stated the driver was tailored=
 on
> > Will's SPE driver.
> >
>
> Yes, it was and is, still in there the description. But it is good to men=
tion that here.
>
> >>
> >> +static int arm_trbe_device_probe(struct platform_device *pdev)
> >> +{
> >> +    struct coresight_platform_data *pdata;
> >> +    struct trbe_drvdata *drvdata;
> >> +    struct device *dev =3D &pdev->dev;
> >> +    int ret;
> >> +
> >> +    drvdata =3D devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> >> +    if (!drvdata)
> >> +            return -ENOMEM;
> >> +
> >> +    pdata =3D coresight_get_platform_data(dev);
> >> +    if (IS_ERR(pdata))
> >> +            return PTR_ERR(pdata);
> >
> > Given there is no in and out ports, do we need a platform data for this=
 driver?
> >
> > More comments on this patch tomorrow.
>
> I had the same comment in one of the earlier versions.
>  But it looks like the coresight_register() requires this argument, to sc=
an the connections for a component. And we don=E2=80=99t want to break that=
 assumption everywhere in the generic driver.
>

Ok, that confirms my suspicions...  Using a platform driver here
doesn't provide anything other than compatibility with the core
framework, which never expected to see components that don't have
ports.  Fixing that is out of scope and better left for another day.

> Cheers
> Suzuki
>
