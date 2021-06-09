Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4981E3A1DAF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 21:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFIT2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 15:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhFIT2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:28:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E746361403;
        Wed,  9 Jun 2021 19:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623266813;
        bh=96jmhnDdYUYzWGwtTwwo8iS1dyMXAQKNuE9fkGS8Jp8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QEeuED2qUENZ5eKaeFZq3umwdELglPNxR3cRotVCa4Oo5IP/ZaglO7x6AD14MdWNU
         8P+AYdzyEBcvxcaHeIvg/rM0p4CZYGk+XjjYgkfaDGm9Q64vn0dI5/qoGoZPWj3sFo
         UpaKQZNB1EXW8aRdLzNc99VG1fKuOyjVLpznxdXOG3Cb4wdW+veNCumvP7KFB7CAzL
         ancWjMbJ8bDn92OnLrBC915Ctc8fDuC8IDnv0YDTBFxBat3821kieMJBgWQmh3qizb
         uP5GNw2QKtQvWtLKsQCvAPizgfhDcFOZLRRbB0kBM2YQ8yXfUN144FEm+NBbgSh3ZX
         GveVNpCQUHIpA==
Received: by mail-qk1-f177.google.com with SMTP id i67so24848139qkc.4;
        Wed, 09 Jun 2021 12:26:53 -0700 (PDT)
X-Gm-Message-State: AOAM530tSjQ5CL2CKM1N49ZhUuwK+OBZJRZrDc35FdEAkXZ9Nmz8G2ig
        KABHwpVOzfcn7w5EpWmkVaUw0NdzdUy9AL6WoQ==
X-Google-Smtp-Source: ABdhPJwIF2VAc3W3tDLHATbFdB2v0fwn3EwAFw2Dy6hysy99DIc0dA4ocPbE/DdU1zN+5F7yffjXWx/yn9jFgvfWsnM=
X-Received: by 2002:a37:947:: with SMTP id 68mr1188220qkj.364.1623266812990;
 Wed, 09 Jun 2021 12:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
 <20210609080112.1753221-10-miquel.raynal@bootlin.com> <e431d594-05cd-27b8-fcbe-11c310b99cd3@canonical.com>
 <20210609153410.53eadf8e@xps13> <77db74d3-c44a-6aa3-1b61-f6bed565fa04@canonical.com>
 <20210609161128.16cdf5ec@xps13> <32c7adf2-6f4e-ef2d-a137-a9674f9e6baa@canonical.com>
In-Reply-To: <32c7adf2-6f4e-ef2d-a137-a9674f9e6baa@canonical.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 9 Jun 2021 14:26:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJW6Nt5h_gpfd5OgaTjSQGnrH2mCdwDeWvsnq1y_3uV=A@mail.gmail.com>
Message-ID: <CAL_JsqJW6Nt5h_gpfd5OgaTjSQGnrH2mCdwDeWvsnq1y_3uV=A@mail.gmail.com>
Subject: Re: [PATCH v22 09/18] dt-binding: memory: pl353-smc: Convert to yaml
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        devicetree@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Helmut Grohne <helmut.grohne@intenta.de>,
        Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 10:26 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 09/06/2021 16:11, Miquel Raynal wrote:
> > Hi Krzysztof, Rob,
> >
> > Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote on Wed, 9
> > Jun 2021 15:54:19 +0200:
> >
> >> On 09/06/2021 15:34, Miquel Raynal wrote:
> >>> Hi Krzysztof,
> >>>
> >>> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote on Wed, 9
> >>> Jun 2021 14:12:40 +0200:
> >>>
> >>>> On 09/06/2021 10:01, Miquel Raynal wrote:
> >>>>> Convert this binding file to yaml schema.
> >>>>>
> >>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >>>>> ---
> >>>>>  .../memory-controllers/arm,pl353-smc.yaml     | 133 ++++++++++++++++++
> >>>>>  .../bindings/memory-controllers/pl353-smc.txt |  45 ------
> >>>>>  2 files changed, 133 insertions(+), 45 deletions(-)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> >>>>>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..1de6f87d4986
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> >>>>> @@ -0,0 +1,133 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/memory-controllers/arm,pl353-smc.yaml#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> +
> >>>>> +title: ARM PL353 Static Memory Controller (SMC) device-tree bindings
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> >>>>> +  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> >>>>> +
> >>>>> +description:
> >>>>> +  The PL353 Static Memory Controller is a bus where you can connect two kinds
> >>>>> +  of memory interfaces, which are NAND and memory mapped interfaces (such as
> >>>>> +  SRAM or NOR).
> >>>>> +
> >>>>> +# We need a select here so we don't match all nodes with 'arm,primecell'
> >>>>> +select:
> >>>>> +  properties:
> >>>>> +    compatible:
> >>>>> +      contains:
> >>>>> +        enum:
> >>>>> +          - arm,pl353-smc-r2p1
> >>>>
> >>>> That's a const... but also I don't get the need for select.
> >>>
> >>> I think this is needed to ensure this binding is not enforced against
> >>> arm,primecell compatible nodes which are not featuring the
> >>> arm,pl353-smc-r2p1 compatible.
> >>
> >> Which seems to be result of unusual compatible match, so once you
> >> convert to regular match, this select is not needed.
> >
> > I don't think so, I received a hint from Rob some time ago, he told
> > me to add this additional select line as in all other arm,primecell
> > binding.
> >
> > Rob, any additional info regarding this?
>
> Hmm, I think you' are right. Since arm,primecell is used in many other
> compatibles (including ones without schema yet), the select is needed.
>
> In such case the select can be only:
>
> select:
>   properties:
>     compatible:
>       contains:
>         const: arm,pl353-smc-r2p1

The above is true if there's no 'compatible'. So you need 'required: [
compatible ]' as well.

Rob
