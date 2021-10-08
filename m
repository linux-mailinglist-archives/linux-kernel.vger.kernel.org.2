Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB7F427337
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 23:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbhJHVwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 17:52:45 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]:44981 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhJHVwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 17:52:44 -0400
Received: by mail-qv1-f42.google.com with SMTP id 11so7265063qvd.11;
        Fri, 08 Oct 2021 14:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87pjQOukYh/71KH9vTFlkUdLWGcZvypjWjlv+KGMBmE=;
        b=3t4gg7Ldc7yHH21Ws1Ny144jCEUsw/1Q/71Hl14k/nsyP5/Pk324ZSiNPnFshArFIJ
         wYKxOlaThpuT+A8Y8FzY69BW6KkPn9j/mUw1gcU/s9ACvz1kF1oVaqQp1+4jYSdjWTmt
         WKkM+8WeY7biTR83wVHGyUv73WspSwqDVg3tIz2dTashRhfbQ4TS5DD5btP+EESVX8mI
         HNk28/yXmnA3nF4oFeOygXrOuL8IYNNYNwXG5iHmIQrYVwZtufvZkAbqP6hAoyGtmDs5
         RJLk23wmPkXl/F7B05ektjE4Q7EWh7taPoJke529fURiynpgZdmWzojsxGWGVdx5CN9n
         N2QA==
X-Gm-Message-State: AOAM530FqBIAXOmorSmMgWotHNYMXqFRE1ckiFbsgEUDK4/FPmsFypE2
        0LvwvUq9aFOoOmoB8FQk7GO0VU2X6S4=
X-Google-Smtp-Source: ABdhPJxnV6jWX4cEYsQ2S596e7/UBCYXwri2C1NfPXavjE6W1qgfEKwgnG8NGSAkOjHjNdnM9Eo2ow==
X-Received: by 2002:a0c:8045:: with SMTP id 63mr12097036qva.63.1633729847675;
        Fri, 08 Oct 2021 14:50:47 -0700 (PDT)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id a16sm469305qkn.16.2021.10.08.14.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 14:50:47 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id z40so9513570qko.7;
        Fri, 08 Oct 2021 14:50:46 -0700 (PDT)
X-Received: by 2002:a37:c12:: with SMTP id 18mr5001969qkm.12.1633729846634;
 Fri, 08 Oct 2021 14:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211001000924.15421-1-leoyang.li@nxp.com> <20211001000924.15421-2-leoyang.li@nxp.com>
 <db751cb1-9107-3857-7576-644bde4c28e5@canonical.com> <CADRPPNROVBp_QB=6XEgk8WF5fnEPFTSko4Nn+mm8oLM3iGTuuw@mail.gmail.com>
 <e42fa620-810b-fdcc-c827-602a14d10d97@canonical.com>
In-Reply-To: <e42fa620-810b-fdcc-c827-602a14d10d97@canonical.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 8 Oct 2021 16:50:35 -0500
X-Gmail-Original-Message-ID: <CADRPPNQ=32pzrLLqB+a_Ek6U8GcTeNDB18pRY_f2+JYcxDo0=Q@mail.gmail.com>
Message-ID: <CADRPPNQ=32pzrLLqB+a_Ek6U8GcTeNDB18pRY_f2+JYcxDo0=Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: memory: fsl: convert ifc binding to yaml schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 4:32 AM Krzysztof Kozlowski
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

From the dtschema/schemas/types.yaml file, flag type is defined as:
  flag:
    oneOf:
      - type: boolean
        const: true
      - type: 'null'

It looks like more than the boolean type itself.  But if the standard
boolean type is actually the same as the flag type we defined.
Shouldn't we remove the custom flag type then?

Regards,
Leo
