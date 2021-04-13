Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E74235D7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbhDMGTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbhDMGTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:19:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FA5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:19:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w8so16956216lfr.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aFTIw7FTQyrlvdHbvaHqi2YOVdE5Z2rYRPK86x4FEEo=;
        b=DgbTFDMqwDALgb6N7A7Vc+72Q55uhaTo8fAodUW2zeUxhsxD7EStETZErcuW98RJms
         jq8CMgiwedy4TZ/4m0SIdTZVKduHjj1FODVzvxYL85DbuMDoj+sIOR5SB8tnwd6tm6bB
         TaCwYlOqdvQI6Tc3OW4bxpTfAAZrr30j7b0wNDJPCcDiYJyIybiOvnoZC0uOpoQi83us
         g9/vcpnyDaAMkpnE4zvKRyZ5LAl+4EvfxXf7dcK1irOgGiro2YBzLN42YBfua6mjQgsD
         2hfSYF4wLknMODOPH+XB2cOJScF2zBBPsbIzmfk5SRgLnqua51gpIKTJgWmfcqDTeoZP
         n0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aFTIw7FTQyrlvdHbvaHqi2YOVdE5Z2rYRPK86x4FEEo=;
        b=m22NEaLgxi2F8F9IMvpM2vpaOWCmGay7osUNgQQWoLf5fxbEaInoHC49x/U8vGJdIm
         aKLPRcENu3LblnypUiq/g+uKIqhQ3cT1duksr+qJmIkBWWwMGQRf8nC9kNHM0/KRA+nv
         Bbt+tD0DVuyD4yRLtBYNssOB1UI9lnCBgRcz7I3RBu1qMzogowl8cu6bWjgR71UKib/T
         u7Kq8hgr790ZrwkboDm0w8uGb1ZZz4CqD+nenGRRQzN7UH0T+78UhgZ8bEJ+qtj+i/ML
         2HcpjRA7WusW3MJoOZ+PoXIzbG7nFFjdN0eF4CeDj5jmorN8UH3BQpCHnR/Ja4ZLNj5S
         SFJw==
X-Gm-Message-State: AOAM531WgFFXEBMP3gj6DYmuM8Aqw5ueWKZioXwgUlGlNXtn1kkVHtL0
        XzccYAcyRRFV2EFv2cpyZd6ldhjycebIhR9qqYY=
X-Google-Smtp-Source: ABdhPJxKm8sBl3ex1pQh/dfxE+tmaSHBVeDu0rvAa69WknFej5/XccI0vzlXoNML/bohWY+wF3hJ+14SgF/pWBs3rTA=
X-Received: by 2002:a19:4f54:: with SMTP id a20mr7712304lfk.212.1618294760840;
 Mon, 12 Apr 2021 23:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210412070819.23493-1-ruifeng.zhang0110@gmail.com>
 <87y2dnn3gw.mognet@arm.com> <CAG7+-3MsjuChoEOj11VAMX9W61UY6MmphkxWDF=-_R1A8sfvpA@mail.gmail.com>
 <121d5639-b827-937f-1cf0-e6c256e306db@arm.com>
In-Reply-To: <121d5639-b827-937f-1cf0-e6c256e306db@arm.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Tue, 13 Apr 2021 14:18:51 +0800
Message-ID: <CAG7+-3PDp7mQveNy8y2W2U9fYhZweEtwQT=VBLM6R0+_8Hb3bQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm: topology: parse the topology from the dt
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        mingo@kernel.org, ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dietmar Eggemann <dietmar.eggemann@arm.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=
=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:40=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On 12/04/2021 14:20, Ruifeng Zhang wrote:
> > Valentin Schneider <valentin.schneider@arm.com> =E4=BA=8E2021=E5=B9=B44=
=E6=9C=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:32=E5=86=99=E9=
=81=93=EF=BC=9A
> >>
> >>
> >> Hi,
> >>
> >> On 12/04/21 15:08, Ruifeng Zhang wrote:
> >>> From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> >>>
> >>> The arm topology still parse from the MPIDR, but it is incomplete.  W=
hen
> >>> the armv8.3 cpu runs in aarch32 mode, it will parse out the wrong top=
ology.
> >>>
> >>> armv7 (A7) mpidr is:
> >>> [11:8]      [7:2]       [1:0]
> >>> cluster     reserved    cpu
> >>>
> >>> armv8.3 (A55) mpidr is:
> >>> [23:16]     [15:8]      [7:0]
> >>> cluster     cpu         thread
> >>>
> >>> For compatibility to keep the function of get capacity from default
> >>> cputype, renamed arm parse_dt_topology to get_cputype_capacity and de=
lete
> >>> related logic of parse from dt.
> >>> Arm using the same parse_dt_topology function as arm64.
> >>>
> >>> The arm device boot step is to look for the default cputype and get c=
pu
> >>> capacity firstly. Then parse the topology and capacity from dt to rep=
lace
> >>> default values.
> >>>
> >>
> >> I'm afraid I don't get it.
> >>
> >> CONFIG_COMPAT lets you run 32-bit stuff at EL0, but the kernel is stil=
l
> >> arm64. So if you take your armv8.3 system, the topology parsed by the
> >> kernel will be the same regardless of CONFIG_COMPAT.
> >>
> >> Could you elaborate on what problem you are trying to fix here?
> >
> > There is a armv8.3 cpu which should work normally both on aarch64 and a=
arch32.
> > The MPIDR has been written to the chip register in armv8.3 format.
> > For example,
> > core0: 0000000080000000
> > core1: 0000000080000100
> > core2: 0000000080000200
> > ...
> >
> > Its cpu topology can be parsed normally on aarch64 mode (both
> > userspace and kernel work on arm64).
> >
> > The problem is when it working on aarch32 mode (both userspace and
> > kernel work on arm 32-bit), the cpu topology
> > will parse error because of the format is different between armv7 and a=
rmv8.3.
> > The arm 32-bit driver, arch/arm/kernel/topology will parse the MPIDR
> > and store to the topology with armv7,
> > and the result is all cpu core_id is 0, the bit[1:0] of armv7 MPIDR for=
mat.
> >
> > In addition, I think arm should also allow customers to configure cpu
> > topologies via DT.
>
> This patch ruins the CPU capacity detection based on capacity-dmips-mhz
> (Documentation/devicetree/bindings/arm/cpu-capacity.txt) on my TC2 [L B
> B L L] (armv7).
>
> tip/sched/core with *mainline* multi_v7_defconfig:
>
> root@linaro-nano:~# cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 516
> 1024
> 1024
> 516
> 516
>
> your patch with mainline multi_v7_defconfig:
>
> root@linaro-nano:~#  cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 1024
> 1024
> 1024
> 1024
> 1024
>
>
> There are 2 capacity detection mechanism in arch/arm/kernel/topology.c:
>
> (1) cpu_efficiency (only for armv7 a15 and a7) based, relies on
> clock-frequency dt property
>
> (2) capacity-dmips-mhz dt property based
>
> I currently don't see how this different MPIDR layout leads to you code
> changes.

Thanks for your test, I will update patch-V2 to solve this problem.
>
>
