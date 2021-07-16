Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC313CB8A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 16:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhGPO2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 10:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhGPO2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:28:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D71FC06175F;
        Fri, 16 Jul 2021 07:25:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r11so12310628wro.9;
        Fri, 16 Jul 2021 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVnjG/+uXUwA1TsIYDH7nvmxJ4xBCgnrB5THQ+2D+qg=;
        b=nmniNX+atXPU7ho+t8GwMmFltwGS6Ihpv2UTWVKOtddmqzb7KVIOt0xTam4FS1XSMM
         4coBRSmzO0gVWrjsCvLDeWpNbLD+COBo/f6MxkgpftEk8OiPodreZ1Svpt6lMpMFN84n
         5ll8HRM+lvOZoZ4XfwXh51iPVNR/ygA3IkAR/NxaJ6qIZij3JaMoxGmw5iy4HNC0ViO9
         NILUBLNTOywJ0uaak0kAhzmp99UOk10AvZ1ICAx5rxBvafEIvNVW9Ba+x3b15QRlsi1/
         b+joNyvYxUdx+Gi0zanLEoY10tuefxGXb7vpCdTHBLIi+V0e7q+sLaH4Ul3N2wa8SZDQ
         BimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVnjG/+uXUwA1TsIYDH7nvmxJ4xBCgnrB5THQ+2D+qg=;
        b=Zz298QfvpMxHJK5Dh69G6QmlIjVNMb6BRdCzP1HCrXmJwqf+HwMAjv72/q37T3yGIA
         3SeLhO+YfXU4XsCFE69e0/yGtmXUc2yYQ5UfHH/O0VTbZKhJPi++f52tCyH0kAmB1tjZ
         2h8t99Yr0GiLt3isJRxWnCEo2Ufe4msn28NvOxBQGioO3dTQ2W0FfMBosatFP0g/KV+E
         R1cnseZmXJPWs0YGBn6NS84xCEm7UF3MsFz/IxWOQX6EgX0PAi38Ik/yuqbQQk+eB6Bl
         mzfB1/QpGjsA8ERlUFQ3Xrp74Mw5l7pvV+NuNf2OP07eUsxqCowPTEgNhY+0UA5vdcHJ
         +FEw==
X-Gm-Message-State: AOAM531NmekTHaAYEDWtwTWZZXdZ2d/puHrrw+yWmlwhYHMS8/k7XgWV
        Z6b/RIrz05r2X62+eEIM6/GeW7kzPzisjU3nM7A=
X-Google-Smtp-Source: ABdhPJygEwGSx9s3w6+u2tEOsbZsFudYTpHorAQs8Gk+4jNB+JVE/ct8b5iIt+4v78W81rYNoXL/E0IMnrB342JNBR4=
X-Received: by 2002:adf:ce83:: with SMTP id r3mr12829270wrn.204.1626445543092;
 Fri, 16 Jul 2021 07:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com>
 <20210715141802.880911-4-daniel.baluta@oss.nxp.com> <CAL_Jsq+r0Tw46=iW8etyR9H=V7M+sE=dguqsEMm3R4B=Xg=qSA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+r0Tw46=iW8etyR9H=V7M+sE=dguqsEMm3R4B=Xg=qSA@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 16 Jul 2021 17:25:31 +0300
Message-ID: <CAEnQRZCLMSKJfDVP0U4Wdy6+9ZfhRBschG5RyiPHWMcUpbut_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: dsp: fsl: Document newly introduced fsl,properties
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 5:59 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Jul 15, 2021 at 8:18 AM Daniel Baluta <daniel.baluta@oss.nxp.com> wrote:
> >
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > Document firmware-name, tplg-name and machine-drv-name properties.
>
> That's obvious from the diff.
>
> Why do you need these?
>
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > index 7afc9f2be13a..8095aa178e7c 100644
> > --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > @@ -60,6 +60,22 @@ properties:
> >        used by DSP (see bindings/reserved-memory/reserved-memory.txt)
> >      maxItems: 1
> >
> > +  firmware-name:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      If present, name of the file within the firmware search path containing
> > +      the DSP firmware loaded by SOF at DSP boot time.
> > +
> > +  tplg-name:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Should contain the audio topology file name loaded by SOF driver.
>
> Is this some format the DSP requires? Why do we need a separate file?
> This is defined by the board or user config?

This is not specific to DSP but to ALSA (See ALSA topology [1]).

We need the .tplg file in order to describe the support Audio scenario
by our board.

This could be defined both by:

board:
- e.g our CPU board can have a baseboard attached (so the audio
scenario changes).
user config:
- e.g user wants to enable post processing or any audio component.

I couldnt find a good way to specify this except via DTS. Intel folks
derive this information from ACPI tables.

[1] https://www.alsa-project.org/wiki/ALSA_topology
