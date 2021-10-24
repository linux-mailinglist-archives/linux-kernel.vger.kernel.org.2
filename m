Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70C9438707
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 07:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhJXFHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 01:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhJXFHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 01:07:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 740C361002;
        Sun, 24 Oct 2021 05:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635051897;
        bh=XPjRlyX01tPN+GDrTIw56jlzqIOPkkWonyHeLOcnpE0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cfLAqPB70XnUy0FGTSdeWBIV9kMPxVkHx/Yfx2sPpurdkhorzqOQojtrEaAsm8PB9
         xvm90JuGxOk8W5KvEQuQ6MJW3ujW2Ytvrov07fESirWI2iClc4Z2ox3UNwJPmz38x2
         uROogCBlpIb3G4PBOguDNgG2TSqd6OBI4/CAXR4KG+tJO+WTt3SP3gr17WL4a6iHcu
         RW2XznDpySWROLXVpUimxXPvqPF/Qj7XuIT8xix4NT+aRwG6+xxnLxk8G7NG+ERE+g
         TLeKzIOPS/F0cWyb/mvlkA+AHSfUAV7ej1bf593imVwyN34tRywOJ3uAxTElC10RtW
         sutrPq2PlDsWg==
Received: by mail-ua1-f43.google.com with SMTP id u5so15475865uao.13;
        Sat, 23 Oct 2021 22:04:57 -0700 (PDT)
X-Gm-Message-State: AOAM533ySgkzP9Ujxvc/D1jlPDquEdjnLeScoSLt/zNpoZSbae5qzmRt
        BSE2NIv+oXb7NZR/muQPHQlSiHXkTigkU3EQWSo=
X-Google-Smtp-Source: ABdhPJw1CJYlZm9uEwdRySScVK62eInO9uZQTLTlhSFUVGULNnIKZAhTOYkg9gev9SXm9l8KZSKnKJg8beINwFI0BQ0=
X-Received: by 2002:a05:6102:c4d:: with SMTP id y13mr9426070vss.33.1635051896426;
 Sat, 23 Oct 2021 22:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211020093603.28653-1-heinrich.schuchardt@canonical.com>
 <YXMriYWcOcgJSpKj@robh.at.kernel.org> <6d642c10-27b1-72bd-a38e-f966ae8831f0@canonical.com>
In-Reply-To: <6d642c10-27b1-72bd-a38e-f966ae8831f0@canonical.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 24 Oct 2021 13:04:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSzXwLmFskhGb2dAqAtOA7Ok_O66NCoDSh1h-bWAqdoDA@mail.gmail.com>
Message-ID: <CAJF2gTSzXwLmFskhGb2dAqAtOA7Ok_O66NCoDSh1h-bWAqdoDA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: T-HEAD CLINT
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@linux.alibaba.com>,
        Bin Meng <bmeng.cn@gmail.com>, Xiang W <wxjstz@126.com>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        OpenSBI <opensbi@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2021 at 8:03 AM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> On 10/22/21 23:22, Rob Herring wrote:
> > On Wed, Oct 20, 2021 at 11:36:03AM +0200, Heinrich Schuchardt wrote:
> >> The CLINT in the T-HEAD 9xx CPUs is similar to the SiFive CLINT but does
> >> not support 64bit mmio access to the MTIMER device.
> >>
> >> OpenSBI currently uses a property 'clint,has-no-64bit-mmio' to indicate the
> >> restriction and the "sifive,cling0" compatible string. An OpenSBI
> >> patch suggested to use "reg-io-width = <4>;" as the reg-io-width property
> >> is generally used in the devicetree schema for such a condition.
> >>
> >> As the design is not SiFive based it is preferable to apply a compatible
> >> string identifying T-HEAD instead.
> >>
> >> Add a new yaml file describing the T-HEAD CLINT.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >> @Palmer, @Anup
> >> I copied you as maintainers from sifive,clint.yaml. Please, indicate if
> >> this should be changed.
> >>
> >> For the prior discussion see:
> >> https://lore.kernel.org/all/20211015100941.17621-1-heinrich.schuchardt@canonical.com/
> >> https://lore.kernel.org/all/20211015120735.27972-1-heinrich.schuchardt@canonical.com/
> >>
> >> A release candidate of the ACLINT specification is available at
> >> https://github.com/riscv/riscv-aclint/releases
> >> ---
> >>   .../bindings/timer/thead,clint.yaml           | 62 +++++++++++++++++++
> >>   1 file changed, 62 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/timer/thead,clint.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/timer/thead,clint.yaml b/Documentation/devicetree/bindings/timer/thead,clint.yaml
> >> new file mode 100644
> >> index 000000000000..02463fb2043a
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/timer/thead,clint.yaml
> >> @@ -0,0 +1,62 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/timer/thead,clint.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: SiFive Core Local Interruptor
> >> +
> >> +maintainers:
> >> +  - Palmer Dabbelt <palmer@dabbelt.com>
> >> +  - Anup Patel <anup.patel@wdc.com>
> >> +
> >> +description:
> >> +  T-HEAD (and other RISC-V) SOCs include an implementation of the T-HEAD
> >> +  Core Local Interruptor (CLINT) for M-mode timer and M-mode inter-processor
> >> +  interrupts. It directly connects to the timer and inter-processor interrupt
> >> +  lines of various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local
> >> +  interrupt controller is the parent interrupt controller for CLINT device.
> >> +  The clock frequency of the CLINT is specified via "timebase-frequency" DT
> >> +  property of "/cpus" DT node. The "timebase-frequency" DT property is
> >> +  described in Documentation/devicetree/bindings/riscv/cpus.yaml
> >> +
> >> +properties:
> >> +  compatible:
> >> +    items:
> >> +      - const:
> >> +          - allwinner,sun20i-d1-clint
> >> +      - const:
> >> +          - thead,clint0
> >> +
> >> +    description:
> >> +      Should be "<vendor>,<chip>-clint" and "thead,clint<version>" for
> >> +      the T-HEAD derived CLINTs.
> >> +      Supported compatible strings are -
> >> +      "allwinner,sun20i-d1-clint" for the CLINT in the Allwinner D1 SoC
> >> +      and "thead,clint0" for the T-HEAD IP block with no chip
> >> +      integration tweaks.
> >
> > T-HEAD uses the same versioning as SiFive? If you use version numbers in
> > compatible strings, the numbering needs to be documented and correlate
> > back to the h/w design. See [1]. IP release numbers for FPGA IP for
> > example. What it should not be is the binding author making up 0, 1, 2,
> > etc. versions.
>
> The only publicly available information on the IP block is:
>
> https://github.com/T-head-Semi/openc906/blob/main/doc/%E7%8E%84%E9%93%81C906%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.pdf
>
> Page 3 has a version number for the whole document. Chapter 9 does not
> have any version number for the CLINT. So should we simply call the
> block "thead,clint" without any version number?
>
> @Guo: do you have more information accessible?
We didn't define the version of "thead,clint", and it belonged to the
CPU implementation version. We usually use "thead,clint0" at first,
and update it to "thead,clintX" when we update it.

>
> Best regards
>
> Heinrich
>
> >
> > Rob
> >
> > [1] Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> >
>
> --
> opensbi mailing list
> opensbi@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/opensbi



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
