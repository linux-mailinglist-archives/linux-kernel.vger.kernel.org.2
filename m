Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A1E41F201
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354937AbhJAQTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:19:39 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:35593 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhJAQTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:19:37 -0400
Received: by mail-qt1-f178.google.com with SMTP id c20so9462226qtb.2;
        Fri, 01 Oct 2021 09:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKg9mgF1rfjAjrXayimdKxGF/3vx77dbe9y4qadsSBo=;
        b=1gUGaYLxlraOXeNXD3H1pE9r+L1QrRlCCI+f7ysn58EgQRcOBBGAoMhi0nrqO3WP4s
         Y9kQFHlGyBc2HUzsKr9G9+L8sCrYe1Osz6NooTAhRBYjkO91Sf+i5h4l1MfZGaZf3Kx2
         czjI4OLLCyf4MC6VH4pehNfvuYzjLWToaUCDkJLv1eghKirec9KOgos+gLHHNgjXnHFK
         79iRpA78CSTIujt7MPP4kYoZJLjAz5N6XLuMu9OkXVOhDDQ6RuOb92jP5DomQ1wf2eG8
         iFs60GEzDy8QyLyS55SbIEAt2eKKA3YvszzGkDo4cydkuGB6oyCXcesqvIkf9XgKYscA
         lyGw==
X-Gm-Message-State: AOAM532Ww3e2pCKjWakJI2rlBIr1z3IF2rZh2e2X3Js97RndWYZEkBnT
        mLVDrRSt0r5kPVDWueoTyKs8z+wtnkI=
X-Google-Smtp-Source: ABdhPJwwmdNJ8cSAQ3rL0+dq6ULxndc0wybqoH/+G7OFoXG4AUOUO6vW+fjwkfvk6wtU48GaF9blpg==
X-Received: by 2002:ac8:4547:: with SMTP id z7mr13835420qtn.131.1633105071862;
        Fri, 01 Oct 2021 09:17:51 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id o15sm3116569qkk.129.2021.10.01.09.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 09:17:51 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id m26so9474521qtn.1;
        Fri, 01 Oct 2021 09:17:50 -0700 (PDT)
X-Received: by 2002:a05:622a:1341:: with SMTP id w1mr14334812qtk.127.1633105070007;
 Fri, 01 Oct 2021 09:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211001000924.15421-1-leoyang.li@nxp.com> <20211001000924.15421-2-leoyang.li@nxp.com>
 <db751cb1-9107-3857-7576-644bde4c28e5@canonical.com>
In-Reply-To: <db751cb1-9107-3857-7576-644bde4c28e5@canonical.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 1 Oct 2021 11:17:38 -0500
X-Gmail-Original-Message-ID: <CADRPPNROVBp_QB=6XEgk8WF5fnEPFTSko4Nn+mm8oLM3iGTuuw@mail.gmail.com>
Message-ID: <CADRPPNROVBp_QB=6XEgk8WF5fnEPFTSko4Nn+mm8oLM3iGTuuw@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: memory: fsl: convert ifc binding to yaml schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 5:01 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 01/10/2021 02:09, Li Yang wrote:
> > Convert the txt binding to yaml format and add description.  Drop the
> > "simple-bus" compatible string from the example and not allowed by the
> > binding any more.  This will help to enforce the correct probe order
> > between parent device and child devices, but will require the ifc driver
> > to probe the child devices to work properly.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> > updates from previous submission:
> > - Drop "simple-bus" from binding and only "fsl,ifc" as compatible
> > - Fix one identiation problem of "reg"
> > - Add type restriction to "little-endian" property
> >
> >  .../bindings/memory-controllers/fsl/ifc.txt   |  82 -----------
> >  .../bindings/memory-controllers/fsl/ifc.yaml  | 137 ++++++++++++++++++
> >  2 files changed, 137 insertions(+), 82 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> > deleted file mode 100644
> > index 89427b018ba7..000000000000
> > --- a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> > +++ /dev/null
> > @@ -1,82 +0,0 @@
> > -Integrated Flash Controller
> > -
> > -Properties:
> > -- name : Should be ifc
> > -- compatible : should contain "fsl,ifc". The version of the integrated
> > -               flash controller can be found in the IFC_REV register at
> > -               offset zero.
> > -
> > -- #address-cells : Should be either two or three.  The first cell is the
> > -                   chipselect number, and the remaining cells are the
> > -                   offset into the chipselect.
> > -- #size-cells : Either one or two, depending on how large each chipselect
> > -                can be.
> > -- reg : Offset and length of the register set for the device
> > -- interrupts: IFC may have one or two interrupts.  If two interrupt
> > -              specifiers are present, the first is the "common"
> > -              interrupt (CM_EVTER_STAT), and the second is the NAND
> > -              interrupt (NAND_EVTER_STAT).  If there is only one,
> > -              that interrupt reports both types of event.
> > -
> > -- little-endian : If this property is absent, the big-endian mode will
> > -                  be in use as default for registers.
> > -
> > -- ranges : Each range corresponds to a single chipselect, and covers
> > -           the entire access window as configured.
> > -
> > -Child device nodes describe the devices connected to IFC such as NOR (e.g.
> > -cfi-flash) and NAND (fsl,ifc-nand). There might be board specific devices
> > -like FPGAs, CPLDs, etc.
> > -
> > -Example:
> > -
> > -     ifc@ffe1e000 {
> > -             compatible = "fsl,ifc", "simple-bus";
> > -             #address-cells = <2>;
> > -             #size-cells = <1>;
> > -             reg = <0x0 0xffe1e000 0 0x2000>;
> > -             interrupts = <16 2 19 2>;
> > -             little-endian;
> > -
> > -             /* NOR, NAND Flashes and CPLD on board */
> > -             ranges = <0x0 0x0 0x0 0xee000000 0x02000000
> > -                       0x1 0x0 0x0 0xffa00000 0x00010000
> > -                       0x3 0x0 0x0 0xffb00000 0x00020000>;
> > -
> > -             flash@0,0 {
> > -                     #address-cells = <1>;
> > -                     #size-cells = <1>;
> > -                     compatible = "cfi-flash";
> > -                     reg = <0x0 0x0 0x2000000>;
> > -                     bank-width = <2>;
> > -                     device-width = <1>;
> > -
> > -                     partition@0 {
> > -                             /* 32MB for user data */
> > -                             reg = <0x0 0x02000000>;
> > -                             label = "NOR Data";
> > -                     };
> > -             };
> > -
> > -             flash@1,0 {
> > -                     #address-cells = <1>;
> > -                     #size-cells = <1>;
> > -                     compatible = "fsl,ifc-nand";
> > -                     reg = <0x1 0x0 0x10000>;
> > -
> > -                     partition@0 {
> > -                             /* This location must not be altered  */
> > -                             /* 1MB for u-boot Bootloader Image */
> > -                             reg = <0x0 0x00100000>;
> > -                             label = "NAND U-Boot Image";
> > -                             read-only;
> > -                     };
> > -             };
> > -
> > -             cpld@3,0 {
> > -                     #address-cells = <1>;
> > -                     #size-cells = <1>;
> > -                     compatible = "fsl,p1010rdb-cpld";
> > -                     reg = <0x3 0x0 0x000001f>;
> > -             };
> > -     };
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> > new file mode 100644
> > index 000000000000..19871ce39fe3
>
> Thanks for the patch.
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> > @@ -0,0 +1,137 @@
> > +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>
> Checkpatch should scream here. If it doesn't, maybe you work on some old
> tree, which would also explain why you send it to my old address (not
> the one from get_maintainers). Please use both checkpatch and
> get_maintainers.
>
> You basically relicense bindings from GPL-2.0 only to new license,
> including GPL-3.0.

Ok.  Will update the license.

>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/memory-controllers/fsl/ifc.yaml#
>
> File name should be "fsl,ifc.yaml"

Ok.  But probably it is a little bit redundant as the upper level
folder also has fsl.

>
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: FSL/NXP Integrated Flash Controller
> > +
> > +maintainers:
> > +  - Li Yang <leoyang.li@nxp.com>
> > +
> > +description: |
> > +  NXP's integrated flash controller (IFC) is an advanced version of the
> > +  enhanced local bus controller which includes similar programming and signal
> > +  interfaces with an extended feature set. The IFC provides access to multiple
> > +  external memory types, such as NAND flash (SLC and MLC), NOR flash, EPROM,
> > +  SRAM and other memories where address and data are shared on a bus.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^ifc@[0-9a-f]+$"
>
> Nodes should be generic, so this looks like "memory-controller".

Ok.

>
> > +
> > +  compatible:
> > +    const: fsl,ifc
> > +
> > +  "#address-cells":
> > +    enum: [2, 3]
> > +    description: |
> > +      Should be either two or three.  The first cell is the chipselect
> > +      number, and the remaining cells are the offset into the chipselect.
> > +
> > +  "#size-cells":
> > +    enum: [1, 2]
> > +    description: |
> > +      Either one or two, depending on how large each chipselect can be.
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: |
> > +      Offset and length of the register set for the device.
>
> Skip the description, it's obvious.

Ok.

>
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: |
> > +      IFC may have one or two interrupts.  If two interrupt specifiers are
> > +      present, the first is the "common" interrupt (CM_EVTER_STAT), and the
> > +      second is the NAND interrupt (NAND_EVTER_STAT).  If there is only one,
> > +      that interrupt reports both types of event.
> > +
> > +  little-endian:
> > +    $ref: '/schemas/types.yaml#/definitions/flag'
>
> type: boolean

It will not have a true or false value, but only present or not.  Is
the boolean type taking care of this too?

>
>
> Best regards,
> Krzysztof
