Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A5D409A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbhIMRJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241817AbhIMRJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:09:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E95C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:08:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n27so22582199eja.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cjPU+X9z9q5//ZdtVdqefXjWrLECo/nmrS1BCrfqx7g=;
        b=ghiF91VkcaKIpKSUng2aUjJ9vVT9FvGOpbvsTPrpeC/Xlosl0bJN7JExpc+JWor1Hm
         4yvTiO1X6f5vOWiI4lWguUEQc4MAsEM1hSZvY0sbrYesGX/5MGxjNIwMKt5qXlc5QPtR
         GeWyokind7pfnfdD9Deph1ghZsRaYkmsWYvGJecZwNvjIWMXsHhzHalM7M7CObpn0j3f
         LPs2a83a2qk2DqAGDKejG73kqz++sFzSLnXaNAcIakBKE7c3wv+uW8izyMpzJVV54hCI
         F3pHZcUDht13JnLmsWbTRoDfTgXqqMHvIIfRDzgYQTgfAQSs6WEhP5EG5nY4aM0kCUxE
         hQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjPU+X9z9q5//ZdtVdqefXjWrLECo/nmrS1BCrfqx7g=;
        b=rDlP1OP+TtgeLoSXfi+90xhwpC+5kT+ZT9+OIUmgA3B+ExLCmOtOvSjP0HhkVoLI7i
         ji5ArJoci030Svyj098N20GekCZuUGBkJjno/kxbbvfIz5oLvQd6e2Q/3d2j97bh+81M
         tgMo4A3xfTIxESR4um4e8i0Vwf9TPnq7bShFRsK8p+NgSqkGeRl7VeGqRfIFwkwpoIQw
         oF3GVppopCfcQ1fKVJC8wsN9sSp4SMVmzgo3mUP1VYym1Of60yGmRtKgmUi/DHZ3X8+J
         62kyRq0vkf3WZ/GxOTrpC83vrnO6kB0x/jY9RDQZXprblyKuwE7GdRtVtsq9pr2+KFKn
         LwQA==
X-Gm-Message-State: AOAM531nkqpyXl1XvaG/Ph91RjSVNZaB3IQXO3cH/fLmTGObLk/wla03
        pR2XAmITf/ETYje3mCii0OxqY+SUcv8rOCpbLUkBuA==
X-Google-Smtp-Source: ABdhPJyZlYWjcU4fshnZAhArELY92YocVWhkvsqsWqoxB6o41HaD+s6nKUDT9uEmHcDzaizJBz3LhL1qETW2KBy5mP8=
X-Received: by 2002:a17:907:2662:: with SMTP id ci2mr13615318ejc.107.1631552911570;
 Mon, 13 Sep 2021 10:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <1631092255-25150-1-git-send-email-shengjiu.wang@nxp.com>
 <1631092255-25150-5-git-send-email-shengjiu.wang@nxp.com> <YTvRlmIedfBiXSCg@robh.at.kernel.org>
 <CAA+D8AM3RhN+=J1daZAV=DZJT52w4-KarBNMNHUzeg=GbtARvw@mail.gmail.com>
In-Reply-To: <CAA+D8AM3RhN+=J1daZAV=DZJT52w4-KarBNMNHUzeg=GbtARvw@mail.gmail.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 13 Sep 2021 11:08:19 -0600
Message-ID: <CANLsYkw16JfX3ysBQ4xrHqyQkHV907Ni6uzy5D8mkcXL+Wk1yw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] dt-bindings: dsp: fsl: update binding document for
 remote proc driver
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, daniel.baluta@nxp.com,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sept 2021 at 20:50, Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
>
> Hi Rob
>
> On Sat, Sep 11, 2021 at 5:43 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Sep 08, 2021 at 05:10:55PM +0800, Shengjiu Wang wrote:
> > > As there are two drivers for DSP on i.MX, one is for sound open
> > > firmware, another is for remote processor framework. In order to
> > > distinguish two kinds of driver, defining different compatible strings.
> >
> > What determines which firmware is used? Is it tied to the board? Or for
> > a given board, users could want different firmware? In the latter case,
> > this configuration should not be in DT.
>
> The compatible string determines which firmware is used.
> For a given board, users could want different firmware, then need
> to reboot the kernel and switch to another DTB.
>
> >
> > > For remote proc driver, the properties firmware-name and fsl,dsp-ctrl
> > > are needed and the mailbox channel is different with SOF.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 81 +++++++++++++++++--
> > >  1 file changed, 75 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > > index 7afc9f2be13a..51ea657f6d42 100644
> > > --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > > +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > > @@ -8,6 +8,7 @@ title: NXP i.MX8 DSP core
> > >
> > >  maintainers:
> > >    - Daniel Baluta <daniel.baluta@nxp.com>
> > > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > >
> > >  description: |
> > >    Some boards from i.MX8 family contain a DSP core used for
> > > @@ -19,6 +20,10 @@ properties:
> > >        - fsl,imx8qxp-dsp
> > >        - fsl,imx8qm-dsp
> > >        - fsl,imx8mp-dsp
> > > +      - fsl,imx8qxp-hifi4
> > > +      - fsl,imx8qm-hifi4
> > > +      - fsl,imx8mp-hifi4
> > > +      - fsl,imx8ulp-hifi4
> > >
> > >    reg:
> > >      maxItems: 1
> > > @@ -28,37 +33,63 @@ properties:
> > >        - description: ipg clock
> > >        - description: ocram clock
> > >        - description: core clock
> > > +      - description: debug interface clock
> > > +      - description: message unit clock
> > > +    minItems: 3
> > > +    maxItems: 5
> > >
> > >    clock-names:
> > >      items:
> > >        - const: ipg
> > >        - const: ocram
> > >        - const: core
> > > +      - const: debug
> > > +      - const: mu
> > > +    minItems: 3
> > > +    maxItems: 5
> > >
> > >    power-domains:
> > >      description:
> > >        List of phandle and PM domain specifier as documented in
> > >        Documentation/devicetree/bindings/power/power_domain.txt
> > > +    minItems: 1
> > >      maxItems: 4
> >
> > How does the same h/w have different number of power domains?
>
> For different SoC, the integration is different, on i.MX8QM/8QXP, there are
> 4 power-domains for DSP,  but on i.MX8MP, there are 1 power-domain.
>
> >
> > >
> > >    mboxes:
> > >      description:
> > >        List of <&phandle type channel> - 2 channels for TXDB, 2 channels for RXDB
> > > +      or - 1 channel for TX, 1 channel for RX, 1 channel for RXDB
> > >        (see mailbox/fsl,mu.txt)
> > > +    minItems: 3
> > >      maxItems: 4
> > >
> > >    mbox-names:
> > > -    items:
> > > -      - const: txdb0
> > > -      - const: txdb1
> > > -      - const: rxdb0
> > > -      - const: rxdb1
> > > +    oneOf:
> > > +      - items:
> > > +          - const: txdb0
> > > +          - const: txdb1
> > > +          - const: rxdb0
> > > +          - const: rxdb1
> > > +      - items:
> > > +          - const: tx
> > > +          - const: rx
> > > +          - const: rxdb
> >
> > These are completely different mailboxes?
>
> It is the same mailbox, for this mailbox, there are 16 channels
> (4 for tx,  4 for rx,  4 for txdb, 4 for rxdb).
> For sound open firmware and remoteproc firmware, they
> use different mailbox channels.
>
> >
> > >
> > >    memory-region:
> > >      description:
> > >        phandle to a node describing reserved memory (System RAM memory)
> > >        used by DSP (see bindings/reserved-memory/reserved-memory.txt)
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    maxItems: 4
> > > +
> > > +  firmware-name:
> > > +    description: |
> > > +      Default name of the firmware to load to the remote processor.
> > > +
> > > +  fsl,dsp-ctrl:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description:
> > > +      Phandle to syscon block which provide access for processor enablement
> >
> > Curious, how is this done with the open sound f/w?
>
> Currently the code for this in sound open firmware is not upsteamed,
> I think this phandle is also applied for sound open firmware.
>
> By the way, Should I separate the change of this file from this
> patch series?  Does it belong to your linux tree?

Please keep the patches together.  Once Rob acks the bindings, patches
in this series will be picked up in the remoteproc tree.

Thanks,
Mathieu

>
>
> Best Regards
> Wang Shengjiu
