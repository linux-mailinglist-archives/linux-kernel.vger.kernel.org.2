Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F53742D978
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhJNMtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhJNMtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:49:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EBF660C49;
        Thu, 14 Oct 2021 12:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634215624;
        bh=+d01KHTRSumOEZT8agvd8tWEcK3PRRbA5A7BnnIbdpQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SXdxOowlZ7aya9QAoUheTtExbJZKUXxsrsgkhJtRxFO5U/6UOhjDEbbkgc/eAhvnl
         8VDJy5Qls3NqYv00avhVHiihQyHEWNURxN94FMfMOwT4OzaE5ddz0lCArRUKuyjlu4
         ypBeYZx/qfynSMviuCAUnjkQ/rvsK/ajrxAlSlJtz2MTz0o7EjUB1WE/8dDabWV5u0
         JBfg7vG7ROz2sslGyTYewlVnw0Oj7ms/PXk1hu62BcTZutTXH5zudlJ7A1nHzWfUhz
         xO2+keIbybqoaGgEUObO2GFdHsjYg8KhUNuD1XwsBveDBXYXZui4cqjlRssZQgwHYD
         eE0sUkebLL2RQ==
Received: by mail-ed1-f51.google.com with SMTP id y12so24328608eda.4;
        Thu, 14 Oct 2021 05:47:04 -0700 (PDT)
X-Gm-Message-State: AOAM532QYPNuP3XNDybx3FB43D/IsELlAn3zC8480mj8suDZ7Yk+kjs1
        iNy2lbvyAB+KBoz7a+yKAGPHqCEdQsm63NTJqg==
X-Google-Smtp-Source: ABdhPJwSm3HuhEJ063Rw9UsGLNFNs045f3GLTDsPTojmKwFpUBlKoUE++pS+H7a9JGog+S1ZtaakwJ8m1wxPCvagazI=
X-Received: by 2002:a17:906:9399:: with SMTP id l25mr3551972ejx.363.1634215622699;
 Thu, 14 Oct 2021 05:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211001000924.15421-1-leoyang.li@nxp.com> <20211001000924.15421-2-leoyang.li@nxp.com>
 <db751cb1-9107-3857-7576-644bde4c28e5@canonical.com> <CADRPPNROVBp_QB=6XEgk8WF5fnEPFTSko4Nn+mm8oLM3iGTuuw@mail.gmail.com>
 <e42fa620-810b-fdcc-c827-602a14d10d97@canonical.com>
In-Reply-To: <e42fa620-810b-fdcc-c827-602a14d10d97@canonical.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Oct 2021 07:46:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLvdFgiPLZoUzXXPmoff2u1pz5pcSdaCh9p=bh1+3PMSg@mail.gmail.com>
Message-ID: <CAL_JsqLvdFgiPLZoUzXXPmoff2u1pz5pcSdaCh9p=bh1+3PMSg@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: memory: fsl: convert ifc binding to yaml schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
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

On Mon, Oct 4, 2021 at 4:31 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 01/10/2021 18:17, Li Yang wrote:
> > On Fri, Oct 1, 2021 at 5:01 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> >>
>
> (...)
>
> >>> +
> >>> +  interrupts:
> >>> +    minItems: 1
> >>> +    maxItems: 2
> >>> +    description: |
> >>> +      IFC may have one or two interrupts.  If two interrupt specifiers are
> >>> +      present, the first is the "common" interrupt (CM_EVTER_STAT), and the
> >>> +      second is the NAND interrupt (NAND_EVTER_STAT).  If there is only one,
> >>> +      that interrupt reports both types of event.
> >>> +
> >>> +  little-endian:
> >>> +    $ref: '/schemas/types.yaml#/definitions/flag'
> >>
> >> type: boolean
> >
> > It will not have a true or false value, but only present or not.  Is
> > the boolean type taking care of this too?
>
> boolean is for a property which does not accept values and true/false
> depends on its presence.
> See:
> Documentation/devicetree/bindings/phy/lantiq,vrx200-pcie-phy.yaml
> Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml

They are equivalent, so either can be used.

Really what is needed here is a common schema for the endianness
properties defining the type once. Then any binding using a property
can just do 'little-endian: true'.

Rob
