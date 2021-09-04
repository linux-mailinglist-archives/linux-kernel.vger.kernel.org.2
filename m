Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BF9400BB7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbhIDOwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 10:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhIDOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 10:52:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9CAC061575;
        Sat,  4 Sep 2021 07:51:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q26so1997970wrc.7;
        Sat, 04 Sep 2021 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QuAjwG4QD/tyhAwpENnTdRM0gpwUf3SSs1urtonm/5o=;
        b=hqsCaXRi5oajodRiLPHYun8CWVH9oX5HsGLIzwG5boH9DFx0dHCAMG8GRdzpQJCJ9N
         LN7EBHaMgOJwJQIj3vcDYpLC3cd5UdsyVPbss1RwMrHtbm4Ee0bqATEn5ieoxpKqBuDW
         aHulBhJ7AngFtiFDlsY5bIu7oKh+cwyUTcA7lzlNluAgL4KdXdToSPyZQNpufoFrjidV
         MzfLFmd5MWZP/cAuuBuQMFbW/4Cut0DWrq0/BSc8gbMFGwEKY2kXbe9aEC3wlgX7wGHA
         hVkkhTcqYCT5GpY0FhjPQvzQiSGSayHiuOzHqrOBfRdELfBkxyOo+ho9YM76cdM6hEOg
         CODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuAjwG4QD/tyhAwpENnTdRM0gpwUf3SSs1urtonm/5o=;
        b=rUFyvsKTDp+vwLDA9dqvCcWqJQQzxh0ri9iZ6722HcwrEuzwwA18HMDJQPdMRpTNc6
         HD8jM9aNI+coHyhxq+aNQo73HTJksQsdYhqeHfQFqYMDoXKd8Rbl8Ko7CrLKYGdxXEpX
         9gnvboV6uFshQeKMgh3/3YEcf0ORgutkpnENExCjDcgEE09SdQOSuRMYkU6U94SAEmKs
         go66fiNaaGsZ+4/ecnkTfRsQVmajoCxZNVb4JpD2FR6rAoATW36B+R4z4Vwt4H1YXGpU
         +r902QaTAGNo0y1NRaAXSmtsfpt+xmIaG60w1YoYOBpYtBdbvjJ9tTTeLbI1wwoMjY0q
         MIYQ==
X-Gm-Message-State: AOAM533pSzy7ze+BNH0IKccd9kf1ivfx7sqFur48jf2Rgl+ejhDVM5VV
        BLSZu4qB6PiRU0WP8vNDwqP6JFqo7NhM/Y6YShY=
X-Google-Smtp-Source: ABdhPJyW2q+CbgV9QbnLTyhMWnPi5rIdh11b+hIJQvDopYZ6pkVm5dd8/GgD2piV3vD8tChZ6JIo088AsyNvTtRg83o=
X-Received: by 2002:adf:d193:: with SMTP id v19mr4279370wrc.377.1630767068862;
 Sat, 04 Sep 2021 07:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210903145340.225511-1-daniel.baluta@oss.nxp.com>
 <20210903145340.225511-3-daniel.baluta@oss.nxp.com> <YTJTF5VMOyG2iZb0@robh.at.kernel.org>
In-Reply-To: <YTJTF5VMOyG2iZb0@robh.at.kernel.org>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sat, 4 Sep 2021 17:50:56 +0300
Message-ID: <CAEnQRZC-GN9iEPk6-A_oKPHcCYj8_WeQC0TT_NpK_QntkmAqiQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: dsp: fsl: Add DSP optional clocks documentation
To:     Rob Herring <robh@kernel.org>
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
        s-anna@ti.com, Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 8:11 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Sep 03, 2021 at 05:53:40PM +0300, Daniel Baluta wrote:
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > DSP node on the Linux kernel side must also take care of enabling
> > DAI/DMA related clocks.
> >
> > By design we choose to manage DAI/DMA clocks from the kernel side because of
> > the architecture of some i.MX8 boards.
> >
> > Clocks are handled by a special M4 core which runs a special firmware
> > called SCFW (System Controler firmware).
> >
> > This communicates with A cores running Linux via a special Messaging
> > Unit and implements a custom API which is already implemented by the
> > Linux kernel i.MX clocks implementation.
> >
> > Note that these clocks are optional. We can use the DSP without them.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > index 7afc9f2be13a..1453668c0194 100644
> > --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > @@ -24,16 +24,49 @@ properties:
> >      maxItems: 1
> >
> >    clocks:
> > +    minItems: 3
> >      items:
> >        - description: ipg clock
> >        - description: ocram clock
> >        - description: core clock
> > +      - description: esai0 core clock for accessing registers
> > +      - description: esai0 baud clock
> > +      - description: esai0 system clock
> > +      - description: esai0 spba clock required when ESAI is placed in slave mode
> > +      - description: SAI1 bus clock
> > +      - description: SAI1 master clock 0
> > +      - description: SAI1 master clock 1
> > +      - description: SAI1 master clock 2
> > +      - description: SAI1 master clock 3
> > +      - description: SAI3 bus clock
> > +      - description: SAI3 master clock 0
> > +      - description: SAI3 master clock 1
> > +      - description: SAI3 master clock 2
> > +      - description: SAI3 master clock 3
> > +      - description: SDMA3 root clock used for accessing registers
>
> Sigh, I just rejected this kind of thing for the other i.MX8 DSP
> binding[1].
>
> Add a reference to the h/w block and then get the clocks (and other
> resources) from there.

The H/W block is controlled by the DSP firmware. So, we don't want
to use the Linux kernel driver (thus the H/W block device tree node).

The only thing that we cannot control from the DSP firmware are the clocks
hence we handle them in the DSP node.

We moved the DAI clocks under the DSP node as I think you suggested here:

https://www.lkml.org/lkml/2020/3/12/969
