Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A65402964
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 15:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344642AbhIGNKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 09:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344507AbhIGNK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 09:10:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A08F161057;
        Tue,  7 Sep 2021 13:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631020161;
        bh=EwAZ6xsh+B077xdiAiUPyl2HqmdVrDjC+5YWJzZ/NfU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q/zlmlKmY5yaK8vdBrwafAOfK+k7tAOK2PrHwh8Y7zubnXxcJNdNEK3MGJd7YYk8t
         sVl5Iu+QmwjsouHH6tILI1wa00lk2DaRqTAA5QfccE5pIVUom4M8sghvYRxsBkj2FH
         fu8HjQChFTdeBL09bWX+HBa4oYvDUhf0iKabh82sdWM1dtDS/4qAMSkAqSng5JuHj2
         4h3AnJHki2aETz+rcuvDs0HiTdNEL5+UsvCFeXrlbc2lTl1lOSbnMGZu9fJxtrcO7j
         3rSOF6EWvhoobW0F7JVSY7MaQGZzVM2UUtoW+vwTyvjnOA/L0fJzuYdmV7faaUqPM/
         jsXz/nziD5lXg==
Received: by mail-ej1-f44.google.com with SMTP id a25so19578065ejv.6;
        Tue, 07 Sep 2021 06:09:21 -0700 (PDT)
X-Gm-Message-State: AOAM530VhfuOXCNWvMa6BOfNEjYNHIOAPkJA8LvYbg3gWFmHn7GHSzLO
        A4vReSfg3p0kvQGR439jHSEp2bm+a2YKEvmKKw==
X-Google-Smtp-Source: ABdhPJxBSSSWDWXZKUa0KTwW8npz3Wes4pinOo+DiOg4l/HZ6ENDCXtawjSrYUBvQFdNIbIB14Rbld0CnFGz+MWKkhk=
X-Received: by 2002:a17:906:2dcf:: with SMTP id h15mr18410957eji.320.1631020160188;
 Tue, 07 Sep 2021 06:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210903145340.225511-1-daniel.baluta@oss.nxp.com>
 <20210903145340.225511-3-daniel.baluta@oss.nxp.com> <YTJTF5VMOyG2iZb0@robh.at.kernel.org>
 <CAEnQRZC-GN9iEPk6-A_oKPHcCYj8_WeQC0TT_NpK_QntkmAqiQ@mail.gmail.com>
In-Reply-To: <CAEnQRZC-GN9iEPk6-A_oKPHcCYj8_WeQC0TT_NpK_QntkmAqiQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Sep 2021 08:09:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK_DGqYQxKBHDS7PyviF35V-OP7__KRmmTePn9ZHhiz_w@mail.gmail.com>
Message-ID: <CAL_JsqK_DGqYQxKBHDS7PyviF35V-OP7__KRmmTePn9ZHhiz_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: dsp: fsl: Add DSP optional clocks documentation
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 4, 2021 at 9:51 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Fri, Sep 3, 2021 at 8:11 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Sep 03, 2021 at 05:53:40PM +0300, Daniel Baluta wrote:
> > > From: Daniel Baluta <daniel.baluta@nxp.com>
> > >
> > > DSP node on the Linux kernel side must also take care of enabling
> > > DAI/DMA related clocks.
> > >
> > > By design we choose to manage DAI/DMA clocks from the kernel side because of
> > > the architecture of some i.MX8 boards.
> > >
> > > Clocks are handled by a special M4 core which runs a special firmware
> > > called SCFW (System Controler firmware).
> > >
> > > This communicates with A cores running Linux via a special Messaging
> > > Unit and implements a custom API which is already implemented by the
> > > Linux kernel i.MX clocks implementation.
> > >
> > > Note that these clocks are optional. We can use the DSP without them.
> > >
> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > ---
> > >  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 33 +++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > > index 7afc9f2be13a..1453668c0194 100644
> > > --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > > +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > > @@ -24,16 +24,49 @@ properties:
> > >      maxItems: 1
> > >
> > >    clocks:
> > > +    minItems: 3
> > >      items:
> > >        - description: ipg clock
> > >        - description: ocram clock
> > >        - description: core clock
> > > +      - description: esai0 core clock for accessing registers
> > > +      - description: esai0 baud clock
> > > +      - description: esai0 system clock
> > > +      - description: esai0 spba clock required when ESAI is placed in slave mode
> > > +      - description: SAI1 bus clock
> > > +      - description: SAI1 master clock 0
> > > +      - description: SAI1 master clock 1
> > > +      - description: SAI1 master clock 2
> > > +      - description: SAI1 master clock 3
> > > +      - description: SAI3 bus clock
> > > +      - description: SAI3 master clock 0
> > > +      - description: SAI3 master clock 1
> > > +      - description: SAI3 master clock 2
> > > +      - description: SAI3 master clock 3
> > > +      - description: SDMA3 root clock used for accessing registers
> >
> > Sigh, I just rejected this kind of thing for the other i.MX8 DSP
> > binding[1].
> >
> > Add a reference to the h/w block and then get the clocks (and other
> > resources) from there.
>
> The H/W block is controlled by the DSP firmware. So, we don't want
> to use the Linux kernel driver (thus the H/W block device tree node).

'status' is how you disable a device to not be used by the OS.

The information about that device's resources are already in DT, we
don't need to duplicate that here. If you want a list of devices
assigned to the DSP here, that would be okay.

> The only thing that we cannot control from the DSP firmware are the clocks
> hence we handle them in the DSP node.
>
> We moved the DAI clocks under the DSP node as I think you suggested here:
>
> https://www.lkml.org/lkml/2020/3/12/969

No, that's certainly not what I was suggesting. The resources in the
DSP node should be the h/w resources of the DSP itself.

Rob
