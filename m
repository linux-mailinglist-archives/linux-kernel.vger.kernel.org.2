Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB86344D46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhCVR25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231339AbhCVR2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:28:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 378016198E;
        Mon, 22 Mar 2021 17:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616434124;
        bh=2rwrydkysmMQSc6N3DGjAv3Amy343ZJy9rlnSY8Ka3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TsPsyoeGWDpPaIjupNmnEfmQ/QtO7bbg1u57l7k1RKLpTpezdnr2AVK6ZSAz03vGb
         8wOHO0tU9OWZLg1KKbxgvtdsIaJ+1UFMvNmncXKKWKz9OIWWJ6weExpxwIXklP4pLf
         s6Oki27tUqhhMpv8GoR1LXTO7UX97LZWvWDc/u5AfhCRNhWrnXqKe57T1+c5Vg6INH
         p12mwurwyEx8T9/BFYMHunGAZAM6N4rZ/UDeBjMYd9eECiMMAeU4ND+7s1nExIm/7m
         d54gUt+V5LPy4r3QvIisntBJHlQJH8RByxs8v8eFFWt5jNCbQjdRQVJCiUPYDnZxoI
         XlsJ8EKd4+lMQ==
Received: by mail-ej1-f50.google.com with SMTP id r12so22624835ejr.5;
        Mon, 22 Mar 2021 10:28:44 -0700 (PDT)
X-Gm-Message-State: AOAM5305nPxjErerRhiApWKIaO6aS/dFQEODmPc0Tc72cWpqHc2491ru
        kGmrc2brHSLkybxeLv2qGP/FMKqyOO5eDkwinw==
X-Google-Smtp-Source: ABdhPJwEE650B2qCl+5dzHQkc1EyMEr+TgB0bws8QNe816t4WdDf58JhDwuvkc1YGlQWDvHsk10hPXfz4t7Qa3L9568=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr867472ejz.341.1616434122830;
 Mon, 22 Mar 2021 10:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-16-suzuki.poulose@arm.com> <20210306210627.GA1207387@robh.at.kernel.org>
 <f69ad530-baec-2e73-827a-b5a5a6df3d23@arm.com>
In-Reply-To: <f69ad530-baec-2e73-827a-b5a5a6df3d23@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 22 Mar 2021 11:28:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL6ZQPFqc_Q4A6cB+8d7eGidoFhvJwa_YrZm-Xz7oC6mQ@mail.gmail.com>
Message-ID: <CAL_JsqL6ZQPFqc_Q4A6cB+8d7eGidoFhvJwa_YrZm-Xz7oC6mQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/19] dts: bindings: Document device tree bindings for ETE
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:53 AM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> Hi Rob
>
> On 06/03/2021 21:06, Rob Herring wrote:
> > On Thu, Feb 25, 2021 at 07:35:39PM +0000, Suzuki K Poulose wrote:
> >> Document the device tree bindings for Embedded Trace Extensions.
> >> ETE can be connected to legacy coresight components and thus
> >> could optionally contain a connection graph as described by
> >> the CoreSight bindings.
> >>
> >> Cc: devicetree@vger.kernel.org
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Cc: Mike Leach <mike.leach@linaro.org>
> >> Cc: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >> Changes:
> >>   - Fix out-ports defintion
> >> ---
> >>   .../devicetree/bindings/arm/ete.yaml          | 71 +++++++++++++++++++
> >>   1 file changed, 71 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/arm/ete.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/ete.yaml b/Documentation/devicetree/bindings/arm/ete.yaml
> >> new file mode 100644
> >> index 000000000000..35a42d92bf97
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/arm/ete.yaml
> >> @@ -0,0 +1,71 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> >> +# Copyright 2021, Arm Ltd
> >> +%YAML 1.2
> >> +---
> >> +$id: "http://devicetree.org/schemas/arm/ete.yaml#"
> >> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >> +
> >> +title: ARM Embedded Trace Extensions
> >> +
> >> +maintainers:
> >> +  - Suzuki K Poulose <suzuki.poulose@arm.com>
> >> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
> >> +
> >> +description: |
> >> +  Arm Embedded Trace Extension(ETE) is a per CPU trace component that
> >> +  allows tracing the CPU execution. It overlaps with the CoreSight ETMv4
> >> +  architecture and has extended support for future architecture changes.
> >> +  The trace generated by the ETE could be stored via legacy CoreSight
> >> +  components (e.g, TMC-ETR) or other means (e.g, using a per CPU buffer
> >> +  Arm Trace Buffer Extension (TRBE)). Since the ETE can be connected to
> >> +  legacy CoreSight components, a node must be listed per instance, along
> >> +  with any optional connection graph as per the coresight bindings.
> >> +  See bindings/arm/coresight.txt.
> >> +
> >> +properties:
> >> +  $nodename:
> >> +    pattern: "^ete([0-9a-f]+)$"
> >> +  compatible:
> >> +    items:
> >> +      - const: arm,embedded-trace-extension
> >> +
> >> +  cpu:
> >> +    description: |
> >> +      Handle to the cpu this ETE is bound to.
> >> +    $ref: /schemas/types.yaml#/definitions/phandle
> >> +
> >> +  out-ports:
> >> +    description: |
> >> +      Output connections from the ETE to legacy CoreSight trace bus.
> >> +    $ref: /schemas/graph.yaml#/properties/port
> >
> > s/port/ports/
>
> Ok.
>
> >
> > And then you need:
> >
> >         properties:
> >           port:
> >             description: what this port is
> >             $ref: /schemas/graph.yaml#/properties/port
>
> Isn't this already covered by the definition of ports ? There are no
> fixed connections for ETE. It is optional and could be connected to
> any legacy CoreSight component. i.e, a "ports" object can have port
> objects inside.

'properties/ports' only defines that you have 'port' nodes within it.

> Given we have defined out-ports as an object "confirming to the ports"
> do we need to describe the individual port nodes ?

Yes, you have to define what the 'port' nodes are. A port is a data
stream and you should know what your hardware has. What the data
stream is connected to is outside the scope of the binding.

Rob
