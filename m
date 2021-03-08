Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8255F3314CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhCHR0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhCHR0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:26:10 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5DDC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 09:26:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so1340020wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNnOrRuwwCUOE3F4oiw3Eu/7fXosgNb7OfGMwreMRa4=;
        b=UNy2SmaNgxgVpsMLZwloTKChgMgEdbpivQ1WTgAp6rXhuVrYkkAHJQ6xdJaaU8se5R
         QtTO5LyhdbiOS3DUMgrpc2/Okob7gxbxB1+MgfqrZAio1tWBm2i+WgRZBwpV31m6Ia12
         Hr3SJokeWN61i+cCQ6miXJU/81HNDLNBApwyuFL2RnvCJ2WspRVwuZ+D6BZHS2wC4ilB
         fC6BOw/l0qVz9jWvI5JQhjS7LbN3RGBWSfhdVRK1jIo8g6XBC4RPxSqdC6EV5aNdAPKe
         x69czX50TmgWN9JFh60MYzmy0LCLtq6n8kzTnMeIsN0x7yQwnWBY2rsZJ40n4SsMy4KC
         zacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNnOrRuwwCUOE3F4oiw3Eu/7fXosgNb7OfGMwreMRa4=;
        b=b9WwpJsZmVporrw/ewcKSgo+obEPPTiuPJvtl0j56Kzfa2uHTaWTZAR1geDw/Douuq
         KinjFx13Ec52ZFPCIhDEkLKlU6DPZ+9e9SMv0QgFCUIiIWhpRqlBddhzlkGKlrS5/UCv
         LNEFSWOV3zRGzgeZqZ5q3FQINuSaZe5CAmK3PaUmEnCpIFYC4g7XerFSi72MJiOo/vg7
         e38UuhxsuWdS+fQzAgvhqga9LJ2suWB58bscJZ5HhwX2s13f+HZSZgEJhkgyrk2jPD44
         ta88tIASw7aifuKxvmYIxSqKiYLQlcqLp7TQuvNCHwz3EQPYcBSWduropCP2soTr0m/S
         GwQg==
X-Gm-Message-State: AOAM533Ue15CFBTTOZ+iC6eLyopwmuR9PJgPIuR4jH7C8s+hYpAj6LRR
        q5ZcaNbdsVTLILacz96r8YZQUZe6+dgoqEkE5qM0Cw==
X-Google-Smtp-Source: ABdhPJzj4yI/dOdoh932RkxN8GJ8ffd69Edov0vdiU7TYpFgow3rvqo1yyeeXL7i2ExYpWZ8W9Q/HTaaaBmDL4DDx8k=
X-Received: by 2002:a1c:6a12:: with SMTP id f18mr23685207wmc.31.1615224368090;
 Mon, 08 Mar 2021 09:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-16-suzuki.poulose@arm.com> <20210306210627.GA1207387@robh.at.kernel.org>
In-Reply-To: <20210306210627.GA1207387@robh.at.kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 8 Mar 2021 17:25:57 +0000
Message-ID: <CAJ9a7Vgw5-kR7HJ+HzQ=rK41BOxhi5jOO7N+85kbxuDzzNO=-A@mail.gmail.com>
Subject: Re: [PATCH v4 15/19] dts: bindings: Document device tree bindings for ETE
To:     Rob Herring <robh@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki

Need to add this file and the TRBE bindings file to the ARM/CORESIGHT
section of the MAINTAINERS file.

Regards

Mike



On Sat, 6 Mar 2021 at 21:06, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 25, 2021 at 07:35:39PM +0000, Suzuki K Poulose wrote:
> > Document the device tree bindings for Embedded Trace Extensions.
> > ETE can be connected to legacy coresight components and thus
> > could optionally contain a connection graph as described by
> > the CoreSight bindings.
> >
> > Cc: devicetree@vger.kernel.org
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> > Changes:
> >  - Fix out-ports defintion
> > ---
> >  .../devicetree/bindings/arm/ete.yaml          | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/ete.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/ete.yaml b/Documentation/devicetree/bindings/arm/ete.yaml
> > new file mode 100644
> > index 000000000000..35a42d92bf97
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/ete.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > +# Copyright 2021, Arm Ltd
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/arm/ete.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: ARM Embedded Trace Extensions
> > +
> > +maintainers:
> > +  - Suzuki K Poulose <suzuki.poulose@arm.com>
> > +  - Mathieu Poirier <mathieu.poirier@linaro.org>
> > +
> > +description: |
> > +  Arm Embedded Trace Extension(ETE) is a per CPU trace component that
> > +  allows tracing the CPU execution. It overlaps with the CoreSight ETMv4
> > +  architecture and has extended support for future architecture changes.
> > +  The trace generated by the ETE could be stored via legacy CoreSight
> > +  components (e.g, TMC-ETR) or other means (e.g, using a per CPU buffer
> > +  Arm Trace Buffer Extension (TRBE)). Since the ETE can be connected to
> > +  legacy CoreSight components, a node must be listed per instance, along
> > +  with any optional connection graph as per the coresight bindings.
> > +  See bindings/arm/coresight.txt.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^ete([0-9a-f]+)$"
> > +  compatible:
> > +    items:
> > +      - const: arm,embedded-trace-extension
> > +
> > +  cpu:
> > +    description: |
> > +      Handle to the cpu this ETE is bound to.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +  out-ports:
> > +    description: |
> > +      Output connections from the ETE to legacy CoreSight trace bus.
> > +    $ref: /schemas/graph.yaml#/properties/port
>
> s/port/ports/
>
> And then you need:
>
>        properties:
>          port:
>            description: what this port is
>            $ref: /schemas/graph.yaml#/properties/port
>
> > +
> > +required:
> > +  - compatible
> > +  - cpu
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +
> > +# An ETE node without legacy CoreSight connections
> > +  - |
> > +    ete0 {
> > +      compatible = "arm,embedded-trace-extension";
> > +      cpu = <&cpu_0>;
> > +    };
> > +# An ETE node with legacy CoreSight connections
> > +  - |
> > +   ete1 {
> > +      compatible = "arm,embedded-trace-extension";
> > +      cpu = <&cpu_1>;
> > +
> > +      out-ports {        /* legacy coresight connection */
> > +         port {
> > +             ete1_out_port: endpoint {
> > +                remote-endpoint = <&funnel_in_port0>;
> > +             };
> > +         };
> > +      };
> > +   };
> > +
> > +...
> > --
> > 2.24.1
> >



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
