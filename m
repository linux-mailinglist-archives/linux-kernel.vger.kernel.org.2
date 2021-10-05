Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7FA4227C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhJEN3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:29:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234950AbhJEN3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:29:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EE5E61251;
        Tue,  5 Oct 2021 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633440461;
        bh=MOH/wIgGZg6o0CoLkFJQmfzWGtCwlnQSYLFTb25uQlE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OSXc2LRUI4jwymWNkorUMTx3IFqUVd8nGbunxnV4tDHJIzKX/UmPIEKW1LZC+dqhg
         fj4xIOWMU+FrFQnf8liB/iuwu8aPd7Ebrrqu/+/2D/tbDLdnBGDQ/iLWqGIAIoGQAj
         dhBY9itF4VbZYAQV87Cj+YGui9E4aYT6LvtQz6cibckn3yYskVxxMsYwLpKQR/WjQc
         540JNRJwmIx/zi16917RkiXb4UjmQs9RGD25YrwBNJNfICyVjI6Ft639964CpbVSWz
         bVZ1dR7Px+wZgFhhrlNWlWiWIfgXYUpOMu2wzqtoHCp+OF7MmyAhxPBvxmLK2ItSIe
         8awC367gFY1fA==
Received: by mail-qt1-f182.google.com with SMTP id r16so19001491qtw.11;
        Tue, 05 Oct 2021 06:27:41 -0700 (PDT)
X-Gm-Message-State: AOAM533VO+z33Rj879OrOmE79gktQMMahsUdD6RlY6hQ+e+QHcvzNwAI
        Yt5ceVXUkdh88ILyETbdjevklsaVtnXakY5bfw==
X-Google-Smtp-Source: ABdhPJxQAFhHe4+av141S3+5nqxD6ijBY6lLkb+QsF2zqe+Qv+Dlzut6+e0uaRWT3UFTk7nE4P0ehgvDvleY8Qztn3c=
X-Received: by 2002:ac8:1090:: with SMTP id a16mr19819375qtj.297.1633440459286;
 Tue, 05 Oct 2021 06:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210926145931.14603-1-sergio.paracuellos@gmail.com>
 <20210926145931.14603-3-sergio.paracuellos@gmail.com> <YVtCtGcLjNcO2NJ0@robh.at.kernel.org>
 <CAMhs-H9TDEWEffDn7hBQxT127RNU4eUtPxaSciuiis0fPqTN_w@mail.gmail.com>
In-Reply-To: <CAMhs-H9TDEWEffDn7hBQxT127RNU4eUtPxaSciuiis0fPqTN_w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 5 Oct 2021 08:27:25 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+U_0JnCoJVaHH0T+kdmxX_OosD9=OT0dWyNdwbe=CLoQ@mail.gmail.com>
Message-ID: <CAL_Jsq+U_0JnCoJVaHH0T+kdmxX_OosD9=OT0dWyNdwbe=CLoQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt: bindings: add ralink RT2880 resets device tree
 binding documentation
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-staging@lists.linux.dev, John Crispin <john@phrozen.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 1:23 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi Rob,
>
> On Mon, Oct 4, 2021 at 8:06 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Sep 26, 2021 at 04:59:30PM +0200, Sergio Paracuellos wrote:
> > > Adds device tree binding documentation for resets in the ralink RT2880 SoCs.
> > >
> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > ---
> > >  .../bindings/reset/ralink,rt2880-reset.yaml   | 39 +++++++++++++++++++
> > >  1 file changed, 39 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/reset/ralink,rt2880-reset.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/reset/ralink,rt2880-reset.yaml b/Documentation/devicetree/bindings/reset/ralink,rt2880-reset.yaml
> > > new file mode 100644
> > > index 000000000000..88eddeb4ee45
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/reset/ralink,rt2880-reset.yaml
> > > @@ -0,0 +1,39 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/reset/ralink,rt2880-reset.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Ralink RT2880 Reset Controller Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > +
> > > +description: |
> > > +  Ralink RT2880 reset controller driver which supports the SoC
> > > +  system controller supplied reset registers for the various peripherals
> > > +  of the SoC.
> > > +
> > > +  See also:
> > > +  - dt-bindings/reset/ralink-rt2880.h
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: ralink,rt2880-reset
> > > +
> > > +  '#reset-cells':
> > > +    const: 1
> > > +
> > > +required:
> > > +  - '#reset-cells'
> > > +  - compatible
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/reset/ralink-rt2880.h>
> > > +    rstctrl: reset-controller {
> > > +      compatible = "ralink,rt2880-reset";
> > > +      #reset-cells = <1>;
> >
> > How is this h/w controlled? If this is part of a system controller, then
> > it needs to be documented as such. IOW, you need to document the binding
> > for the whole block.
> >
> > Do you really need a child node here? All you need to make a system
> > controller a reset provider is add '#reset-cells' to it.
>
> I am just documenting what is already mainlined (see [0]) in order to
> get mt7621-dts out of staging at some point of my life. What am I
> supposed to do? Should I rewrite all already mainlined code? Because
> if that is the case we need to rewrite tons of things from the ralink
> platform...

On the flip side, am I not supposed to review bindings because the dts
is already in staging? Code dependent on DT bindings shouldn't have
been mainlined without any documented binding.

Looks like the resets are part of "mediatek,mt7621-sysc" to answer my
question. Add a #reset-cell to that node (and binding) and then change
this line to "mediatek,mt7621-sysc":

        reset_dev.of_node = of_find_compatible_node(NULL, NULL,
                                                "ralink,rt2880-reset");

That's the minimal change, but really I would move the reset code to
the clock driver as that is what handles the sysc node.


> I'd also like to know what we should do with those nodes already added
> to the dtsi file that have not got associated compatible driver
> mainlined. Can we just get rid of them?

Yes. Typically dts files start with minimal support.

A dts file in staging is odd. We shouldn't be adding them there.

Rob
