Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9AE31E76A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 09:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhBRI0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 03:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhBRHYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:24:21 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EFFC0613D6;
        Wed, 17 Feb 2021 23:23:41 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id z190so1222706qka.9;
        Wed, 17 Feb 2021 23:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DMQ5f7QLDVBk/p2SiqG1fJ9qgjmg4Wvt4LKaLla7OLk=;
        b=Qr+3L4Ej72qJJCUzgwXnoe8zPmqTe6qAIrA9wxq09tbDV+0BJsv0uj1Xmt4kN0GWfp
         UI8iKGh6hST1VZsf2N+jbD5SGBeUIHhc5BCxqighrUK/Ih+wVBhuVZaOd5INd2oqfGL4
         jJbY8ItUecjLQSUNyn748dNMO4OftT3Uekj7jsQbJ3uvYZmRYdFN+C3dDPjotfTimi3u
         dYMJgv2G51C8ObnUsBMT550ob0cAYwzlY5ll659v03CFgjroC3k6iIZ0agwfo2X8htYB
         u4NzgebNkTccMwmDz1tswEL93PqROQQpFRn+XtDWpo+2LWJCwUSnHG7T5rd89nL5ST3h
         W3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMQ5f7QLDVBk/p2SiqG1fJ9qgjmg4Wvt4LKaLla7OLk=;
        b=ShvQ3XDs4dZwNLiW25m99cMroo/LMI6aTTSUk0HRia7bKLbMtNAD65VBu5n+rCNuEO
         OlbjLrD70twp12i+iGnY4ZbSgQCcICuzBk+T+vYgaiJIoibuF0NQr5x8m4MguLPlSBEe
         BJ1Y2ufw5Ke9xgr+eXYGSg2MJFaL6jkm4iMuRnpQTvyGkYDLZ13cMAMfvUBlvHjZMno6
         25lsdGBLBFvhRsOyqup3UQ1NUraHCaf9t1LoSljvirbDp+W3B+HdNCRpipXwOvt148lX
         qZ2vRIaY+gVNcrcYdb/d3thhURUY/CibcP+Vurwz8dGr0VRTVkaRV0GbB/UxF2XbFhed
         K+NQ==
X-Gm-Message-State: AOAM531YpnWZg+/ldM752B6ajWf9wHqpyDJpMTHsjWxruqRmceuw0plu
        zCBHAP8UDGB8PbOnEuIUC7gWgHJ2XufSpWf2RMw=
X-Google-Smtp-Source: ABdhPJylVF96WbxLINqVRFOjTFAGRMnVEk2QlGKbvhtHZHX/gaUOI3ZLpVhymTMSwzoULhFZK6nK3ZSKpvRjTLfioMc=
X-Received: by 2002:a37:a896:: with SMTP id r144mr3006847qke.121.1613633020261;
 Wed, 17 Feb 2021 23:23:40 -0800 (PST)
MIME-Version: 1.0
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-8-git-send-email-shengjiu.wang@nxp.com> <20210210221704.GA2894134@robh.at.kernel.org>
In-Reply-To: <20210210221704.GA2894134@robh.at.kernel.org>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 18 Feb 2021 15:23:29 +0800
Message-ID: <CAA+D8ANOv91jr4381Acz1B2mZ6=Mx2J_2CMTGXmPKztv7bMjPA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: imx-rpmsg: Add binding doc for
 rpmsg machine driver
To:     Rob Herring <robh@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 6:18 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Feb 07, 2021 at 06:23:55PM +0800, Shengjiu Wang wrote:
> > Imx-rpmsg is a new added machine driver for supporting audio on Cortex-M
> > core. The Cortex-M core will control the audio interface, DMA and audio
> > codec, setup the pipeline, the audio driver on Cortex-A core side is just
> > to communitcate with M core, it is a virtual sound card and don't touch
> > the hardware.
>
> I don't understand why there are 2 nodes for this other than you happen
> to want to split this into 2 Linux drivers. It's 1 h/w thing.

This one is for the sound card machine driver.  Another one is
for the sound card cpu dai driver. so there are 2 nodes.

>
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../bindings/sound/imx-audio-rpmsg.yaml       | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml b/Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml
> > new file mode 100644
> > index 000000000000..b941aeb80678
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/imx-audio-rpmsg.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP i.MX audio complex with rpmsg
> > +
> > +maintainers:
> > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx-audio-rpmsg
> > +
> > +  model:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: User specified audio sound card name
> > +
> > +  audio-cpu:
> > +    description: The phandle of an CPU DAI controller
> > +
> > +  rpmsg-out:
> > +    description: |
> > +      This is a boolean property. If present, the transmitting function
> > +      will be enabled,
> > +
> > +  rpmsg-in:
> > +    description: |
> > +      This is a boolean property. If present, the receiving function
> > +      will be enabled.
> > +
> > +required:
> > +  - compatible
> > +  - model
> > +  - audio-cpu
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    sound-rpmsg {
> > +        compatible = "fsl,imx-audio-rpmsg";
> > +        model = "ak4497-audio";
> > +        audio-cpu = <&rpmsg_audio>;
> > +        rpmsg-out;
> > +    };
> > --
> > 2.27.0
> >
