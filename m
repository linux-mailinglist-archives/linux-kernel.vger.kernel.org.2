Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59756368CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbhDWGBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhDWGBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:01:36 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158C4C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 23:00:59 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id i12so17166583qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 23:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zXbbkPjngrwljOT9VBaO179g4Z8CpNvhyukw5pJMEf0=;
        b=BqdKfnE5gTr+IxYA68kgxtp8xgIJSs7HUX2G3Y34vJIVSoXZN2vZmr6SNfY+NsAt1h
         6Z9FVzW23v+UsE17nbBevDS9LDj/xIbWUkovFe2AzWgqRGtH/OjA+UDKf9uakinnVDDk
         G/iVLPApwJ4jyyKHYnakYqvsctBy2LZ61ZdIhkaZVUc8I+dQV4gCxrK1t70gH1gbUoEx
         NkIz+tFnXRFigV+00b3g6qfo3EuYVY8HHW0lJVrbNwhrA/jNVsqhUWl25t9I5cj+GNc3
         QqyROXdy2MHkeh99ox3Xto2yCZQuiwJdjqj/BTGQtOPv+Cf0zOId1NDQkH1mjGWj2m4L
         EUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zXbbkPjngrwljOT9VBaO179g4Z8CpNvhyukw5pJMEf0=;
        b=FDB+8PMCGbnzaKlx1A6HS8tcO7bK6z3V5loWuxsn5+tntB7CaAIujQ57jr9kruVxgl
         pJmlP3+UEpA/oTObMs9gAcndyurQN823a+vqfoY8nvnmbsQ329uOgfazER7Z2JN+/W2M
         s4CMOik14Zf9G3NY5qKoLYUQvEeJ7rF7pc/LUXVbVbb+FohUk0ARITl0/Z8AchjB1pPK
         4Nr3ELyCI2i2xl89kviQZR+ii8CKeeaBBlwQa8q+HMiHEPFnG7+ReO8lT7dNDHn+AVzD
         50LfEWdg9Ng1c5fHn7DhnVrbJsIJg3cctQMOobCJzBi8maRONq/vHCKFaQeS7ZlFU80D
         nG6A==
X-Gm-Message-State: AOAM532J70ERLNHucUYBuR85c08FZTxsuaoCIOjnwPxLLCpnKrUUHQbZ
        ICARwkOaU2PbNMi7pt2howLNNjoyO+YymVG44gCa3A==
X-Google-Smtp-Source: ABdhPJwxX/DyEHtnoolCQBXwRfYcutuh7B7+vAQpk+myjOKhbp7t59COpYccNOY5D1ZYJJzQQyB3SuCxC0y+8qAqRwg=
X-Received: by 2002:a37:c41:: with SMTP id 62mr2529779qkm.66.1619157658130;
 Thu, 22 Apr 2021 23:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-f3dd2202-8d2b-4e17-9067-c4521aac8125@palmerdabbelt-glaptop> <mhng-41850660-4a95-462a-9b1e-33dfc67815a4@palmerdabbelt-glaptop>
In-Reply-To: <mhng-41850660-4a95-462a-9b1e-33dfc67815a4@palmerdabbelt-glaptop>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Fri, 23 Apr 2021 14:00:46 +0800
Message-ID: <CAHCEehJHZGEUy2TO6fPg1WyAbQCoVee=AcRrkZE4Zhw+ibYKqQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add SiFive FU740 PCIe host controller driver support
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        jh80.chung@samsung.com, Zong Li <zong.li@sifive.com>,
        robh+dt@kernel.org, vidyas@nvidia.com, alex.dewar90@gmail.com,
        Erik Danie <erik.danie@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Stephen Boyd <sboyd@kernel.org>,
        hayashi.kunihiko@socionext.com, hes@sifive.com,
        khilman@baylibre.com, Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>, devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2021=E5=B9=B44=E6=9C=8823=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=881:10=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, 22 Apr 2021 21:43:03 PDT (-0700), Palmer Dabbelt wrote:
> > On Sun, 11 Apr 2021 19:37:50 PDT (-0700), greentime.hu@sifive.com wrote=
:
> >> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> =E6=96=BC 2021=E5=B9=B44=
=E6=9C=889=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:54=E5=AF=AB=E9=
=81=93=EF=BC=9A
> >>>
> >>> On Tue, 6 Apr 2021 17:26:28 +0800, Greentime Hu wrote:
> >>> > This patchset includes SiFive FU740 PCIe host controller driver. We=
 also
> >>> > add pcie_aux clock and pcie_power_on_reset controller to prci drive=
r for
> >>> > PCIe driver to use it.
> >>> >
> >>> > This is tested with e1000e: Intel(R) PRO/1000 Network Card, AMD Rad=
eon R5
> >>> > 230 graphics card and SP M.2 PCIe Gen 3 SSD in SiFive Unmatched bas=
ed on
> >>> > v5.11 Linux kernel.
> >>> >
> >>> > [...]
> >>>
> >>> Applied to pci/dwc [dropped patch 6], thanks!
> >>>
> >>> [1/6] clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
> >>>       https://git.kernel.org/lpieralisi/pci/c/f3ce593b1a
> >>> [2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
> >>>       https://git.kernel.org/lpieralisi/pci/c/0a78fcfd3d
> >>> [3/6] MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
> >>>       https://git.kernel.org/lpieralisi/pci/c/8bb1c66a90
> >>> [4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
> >>>       https://git.kernel.org/lpieralisi/pci/c/b86d55c107
> >>> [5/6] PCI: fu740: Add SiFive FU740 PCIe host controller driver
> >>>       https://git.kernel.org/lpieralisi/pci/c/327c333a79
> >>>
> >>> Thanks,
> >>> Lorenzo
> >>
> >> Hi Palmer,
> >>
> >> Since the PCIE driver has been applied, would you please pick patch 6
> >> to RISC-V for-next tree?
> >> Thank you. :)
> >
> > Sorry, I got this confused between the Linux patch set and the u-boot
> > patch set so I thought more versions of this had kept comming.  The DT
> > is on for-next now.
>
> I spoke too soon: this actually dosn't even build for me.  It's the
> "clocks =3D <&prci PRCI_CLK_PCIE_AUX>;" line
>
>     Error: arch/riscv/boot/dts/sifive/fu740-c000.dtsi:319.20-21 syntax er=
ror
>     FATAL ERROR: Unable to parse input tree
>     make[2]: *** [scripts/Makefile.lib:336: arch/riscv/boot/dts/sifive/hi=
five-unmatched-a00.dtb] Error 1
>     make[1]: *** [scripts/Makefile.build:514: arch/riscv/boot/dts/sifive]=
 Error 2
>     make: *** [Makefile:1388: dtbs] Error 2
>     make: *** Waiting for unfinished jobs....
>
> I'm not sure what the issue is, I see an anchor for "prci".  Do you mind
> sending along a new version that compiles on top of for-next?  If I need
> the definiton of PRCI_CLK_PCIE_AUX from a PCIe tree then it's probably
> best to just keep the DTS along with the rest of the patches.  IIRC I
> alredy Acked it, but just to be clear
>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> Thanks!

Thank you, Palmer.
It is defined in the first commit of this patchset. "clk: sifive: Add
pcie_aux clock in prci driver for PCIe driver"
You can select these whole 6 patches to make sure it can be built.

Hi Lorenzo,
Would you mind to pick the 6th patch along with the other 5 patches?
Thank you.
