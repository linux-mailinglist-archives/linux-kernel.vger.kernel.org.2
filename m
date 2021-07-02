Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5DF3BA363
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhGBQyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 12:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhGBQym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 12:54:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0C0561360
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 16:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625244729;
        bh=ZMOJ+aU0iHUQNvK8N1KkxNlPoJ/sEmmo8Cx9jkbgpS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o4b/RO+IHhibGjwiJqsV/b52Gn8nI5ApOGDpYoKSkVLzWiZprsbsQI8sBGvpgbTir
         GDkDp0c8IOaeAjldzcogX2qmHzrObL+faxcoxLCWeSjwgJ9k+e0zIxJUr7zOnmPMb1
         mD2NHFD2Eh1irEchIli8H6dVaCFbml6iZ/3IjlujgPV0SKVIOtxC3CptCDdmqeN8n4
         D9QIjE2AqodrkY2RMrhZ67bphNFfT+DPsroZTqKppZ7PLHtEpyzgzbIJj8Jh89C5yF
         oAQxboL+urLEze47LRL48sRi/2McBXJvq2nKFHAr/RxFbWFvrvsDSj0zg71FdIxYMp
         TD9x9WX7iimAA==
Received: by mail-ed1-f42.google.com with SMTP id h2so14117732edt.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 09:52:09 -0700 (PDT)
X-Gm-Message-State: AOAM532XioOEplQ11IO7xyAbP7s9gNMu2H/8i+Xo7PNyr/rKIMf3O4Hp
        G9LCe4MrXfnYfkg7jhhJMqa0oOIZ/6GDIjFxbA==
X-Google-Smtp-Source: ABdhPJyLlWXKWuur9jDnDAmS9SFa+IIcxbWH3+5Db4q9ZDyoSlsa8HatLFkZREPjrb9f0D3x8oyDKsU+WcT/aS87VPc=
X-Received: by 2002:a50:ed82:: with SMTP id h2mr496062edr.165.1625244728367;
 Fri, 02 Jul 2021 09:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <847aca40-2ded-8e37-72bf-c38ccbdc28e5@linaro.org>
In-Reply-To: <847aca40-2ded-8e37-72bf-c38ccbdc28e5@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 2 Jul 2021 10:51:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com>
Message-ID: <CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com>
Subject: Re: [RFD] DTPM hierarchy description via DT
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 7:51 AM Daniel Lezcano <daniel.lezcano@linaro.org> w=
rote:
>
>
> Hi,
>
> recently a new framework based on top of the powercap framework was
> introduced to limit the power of some devices when they are capable of
> that. Based on the approximate power numbers from the energy model, it
> allows to have a rough estimation of the power consumption and set the
> power limit [1].
>
> This framework describes via a hierarchy the constraints relationship
> between all those devices and it is SoC specific.
>
> The problem is how to describe this hierarchy.
>
> The hierarchy could be like:
>
> soc
>
>
>    |
>
>
>    |-- package
>
>
>    |      |
>
>
>    |      |-- cluster0
>
>
>    |      |      |
>
>
>    |      |      |-- cpu0
>
>
>    |      |      |
>
>
>    |      |      |-- cpu1
>
>
>    |      |      |
>
>
>    |      |      |-- cpu2
>
>
>    |      |      |
>
>
>    |      |      `-- cpu3
>
>
>    |      |
>
>
>    |      |-- cluster1
>
>
>    |      |      |
>
>
>    |      |      |-- cpu4
>
>
>    |      |      |
>
>
>    |      |      `-- cpu5

We already have all this with cpu topology binding which feeds cpu
topology functionality in the kernel. Is there a case for the
powerzone hierarchy to be different? For CPUs, I don't see why we'd
need anything else or perhaps just a new property in cpu nodes for
something?

For other devices, is there a need for a hierarchy or just grouping?

>
>
>    |      |
>
>
>    |      `-- gpu
>
>
>    |
>
>
>    |-- memory
>
>
>    |      |
>
>
>    |      |-- bank0
>
>
>    |      |
>
>
>    |      `-- bank1
>
>
>    |
>
>
>    |-- multimedia
>
>
>    |      |
>
>
>    |      |-- camera
>
>
>    |      |
>
>
>    |      `-- dsp
>
>
>    |
>
>
>    |-- modem
>
>
>    |
>
>
>    `-- screen
>
>
>
>
> We are far from this description yet but it is for illustration purpose.
>
> All the nodes of the tree do not necessarily reflect real devices, for
> example, 'package' or 'multimedia' are not described in the DT.
>
> What we want is to build this hierarchy which is SoC dependent.
>
> A first proposal was made to create those nodes in configfs but because
> it results in creating a node in sysfs also the approach is not valid [2]
>
> It was suggested to use the devicetree to describe such hierarchy. There
> are several possibilities but the nodes not describing real hardware
> above is difficult to describe. Also, the hierarchy should not be over
> complexified.

I'm very leary of yet another CPU PM related binding. We already have
topology, idle states, OPP, ...

There's less on the device side, but it's more fragmented with each
vendor doing their own thing.

>
> On the other hand most of the devices are already described, so it is a
> question of tightening them together.
>
> There are different possibilities to describe this hierarchy:
>
> 1. Create the hierarchy in the DT:
>
>         power-zones {
>
>                 package {
>
>                         big {
>                                 powerzone =3D <&cpu_b0 POWERZONE_DVFS>,
>                                         <&cpu_b1 POWERZONE_DVFS>;
>                         };
>
>                         little {
>                                 powerzone =3D <&cpu_l0 POWERZONE_DVFS>,
>                                         <&cpu_l1 POWERZONE_DVFS>,
>                                         <&cpu_l2 POWERZONE_DVFS>,
>                                         <&cpu_l3 POWERZONE_DVFS>;
>                         };
>
>                         gpu {
>                                 powerzone =3D <&gpu POWERZONE_DVFS>;
>                         };
>                 };
>         };
>
> 2. Let the kernel build the hierarchy but add a property in the
> different nodes:
>
> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=3Dpowerc=
ap/dtpm-dts-1.0&id=3D05943f5a1cf33df36dbe423fd4b549a9aa244da1
>
> And from there the kernel does for_each_node_with_property(). The kernel
> has to know "cpu-pd0" and "cpu-pd1". That implies a per soc
> initialization code:
>
> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=3Dpowerc=
ap/dtpm-dts-1.0&id=3D7525abb234695d07a0094b2f511d5fe8bea0a979
>
> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=3Dpowerc=
ap/dtpm-dts-1.0&id=3D70e1deb642a939d14dd9b0391d8219cf21a03253
>
>
> 3. An intermediate description between 1. and 2.
>
> The nodes have a property which is a phandle to the parent node. But if
> the parent node does not exists, create an empty and point to it.
>
> package {
>         powerzone;
>         powerzone-parent =3D <&soc>;
> };
>
> cluster0 {
>         powerzone-parent =3D <&package>;
> };
>
>         ...
>
>                 cpu_l0: cpu@0 {
>                         device_type =3D "cpu";
>                         compatible =3D "arm,cortex-a53";
>                         reg =3D <0x0 0x0>;
>                         enable-method =3D "psci";
>                         capacity-dmips-mhz =3D <485>;
>                         clocks =3D <&cru ARMCLKL>;
>                         #cooling-cells =3D <2>; /* min followed by max */
>                         dynamic-power-coefficient =3D <100>;
>                         cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP>;
>                         powerzone-parent =3D <&cluster0>;
>                 };
>
>         ...
>
> I implemented 1. and 2. but before going forward and writing the yaml
> bindings which are time consuming, it would be preferable we agree on
> something instead of having to drop the code again and again.
>
> Thanks for your comments
>
>
> [1] https://lwn.net/Articles/839318/
> [2] https://www.spinics.net/lists/kernel/msg3891770.html
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
