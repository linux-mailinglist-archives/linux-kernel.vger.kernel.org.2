Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07982382A04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhEQKlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbhEQKlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:41:10 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CCFC061573;
        Mon, 17 May 2021 03:39:53 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id y12so4423959qtx.11;
        Mon, 17 May 2021 03:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9t98eUjKj6gDcKcxxVBCrgjV/xSgE7bQnCfYmjhVhU=;
        b=lJIewHJ5kTyrY82X8MK8oal0zVdmDeiJCgaEtxhPmMYOhq7KtcgyCz4etI5570uBmn
         y44cJr/tus37yOQpjgmi3O/XyNHHsWlA6JcQqZAC4oFATVuPrfTIp4NR6sqwImtLxpmD
         aD8JLo7IEjsNxQ1e6gDJA5uTeb6U8nDB1nEv21anaoh4vEMT2QVjmuCNVooxFsqhbpkh
         XXkL9Y5c4Nzc0i9F4mfXfQHtYmi6IxbV+9hKTFDEd7pgFAqGjoOW/5VluHEneOeIN3Fz
         /1daKx1wOzHg2rdXO682JxGj/vREANmVqxEYQqUuX2j3i/pnCVxKwif/gHNszzh9P6Jx
         py7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9t98eUjKj6gDcKcxxVBCrgjV/xSgE7bQnCfYmjhVhU=;
        b=t2pOSL4wq1qpwzLvRUsgCiEuhYfaSJJEbShazlJIIbpTov+AZ4XnIagdJWpNrOKCoW
         f12Gf4G4vSRkMZ6odZvHruy8sMe8BJzibooMCvvumLkofn+Qmv1+3W1ADePu9FHRqdbs
         +XHh27j8JvGQA3QwLg1QRcHGAI4bcidU2+91H4ZvGITXv4sS7xbOp6p/nV3k6P1tRKDF
         t3kdnwvHgAGoymxBPMyDsiJoKiREC4SUqLstKprTY9UctqXsyD5mWRwpcCFkKjfLk/Nu
         Mi2jFzpIV/2DYgl9Ju+Z7Uaxhxhx0SfpquCCuSdoX3QONQnyBjrl8GBSBMCeDxQqMSUY
         emhg==
X-Gm-Message-State: AOAM531kmOZ2gwHglHJkrvWAjZrfNw9cPTJEDMqMxlX9jEQ3gAPqTSZb
        knE1Np/AylmuoZ/0Pbxqe/hVyJBmPteY213xsZQ=
X-Google-Smtp-Source: ABdhPJxP2yInzaLOWHJ5yaYXJgH9PtDXyh5iBmZ7BS7Et2hKC0KXRWFB5kV1XtbtFyN7JRNeEd4rI0s5qieH76fQIF4=
X-Received: by 2002:ac8:4cda:: with SMTP id l26mr50675557qtv.54.1621247992548;
 Mon, 17 May 2021 03:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <1620630441-14358-1-git-send-email-shengjiu.wang@nxp.com>
 <1620630441-14358-2-git-send-email-shengjiu.wang@nxp.com> <20210511190057.GA2416585@robh.at.kernel.org>
In-Reply-To: <20210511190057.GA2416585@robh.at.kernel.org>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 17 May 2021 18:39:41 +0800
Message-ID: <CAA+D8APEdrK0rVz_Mcad6k0ZGS2k9wkXJ6-NOykQ-NdDzFXhrg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: imx-akcodec: Add binding doc
 for akcodec machine driver
To:     Rob Herring <robh@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 4:07 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, May 10, 2021 at 03:07:21PM +0800, Shengjiu Wang wrote:
> > Imx-akcodec is a new added machine driver for supporting
> > ak4458/ak5558/ak5552/ak4497 codec on i.MX platforms.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > changes in v2:
> > - update doc accoring to Rob's comment, use the common porperties.
> >
> >  .../bindings/sound/imx-audio-akcodec.yaml     | 107 ++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml b/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> > new file mode 100644
> > index 000000000000..0812c4779b59
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/imx-audio-akcodec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP i.MX audio complex with AK4458/AK5558/AK5552/AK4497 codec
> > +
> > +maintainers:
> > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8mq-audio-akcodec
> > +      - fsl,imx-audio-akcodec
>
> We gone from individual codecs to a family of codecs. Is there something
> specific for the machine driver about this set of codecs? Why can't it
> be *any* codec?

Yes, there is something specific. but let me do further updates for this in the
next version, then the document name needs to be changed to
"imx-audio-card".

best regards
wang shengjiu
