Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76274276D5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 05:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244125AbhJIDOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 23:14:24 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]:36683 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhJIDOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 23:14:22 -0400
Received: by mail-qv1-f51.google.com with SMTP id jo30so7622260qvb.3;
        Fri, 08 Oct 2021 20:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZSR3JWmSBMwGLbANGREyXBTPWcaZYMU43ykvJz+HmI=;
        b=vV3l25w8bCYVo3pxMIZTJ+32rLJyILCf3do8JCbFKZGJqjf6OyaeyRNO+d+oRlwf3i
         dXGvjakaTuo7cd8Kw5VA3lMWEbILVo2GW/sOMX1nEtXRETWOAqB5/WirLqgyGf376Xfl
         qvZt36Bp+SGnTC5jift3UgDGiSLMeaNM9oz0Sg/3htt+cyYY3aueOyO6FngwKRgRQzVF
         a8p8ZEowOjcxEwt3qG2z8E0MdyA6VLLEHrjpx11+zXB2GpTwXaZMg/wKQBrx4AKm8K4d
         tsV9btbbhnmXEJbgSNUlOn+GG3/5S+sH7li1RzUyaNuRKNkgDKVOzrFN8NMzhqteVZRn
         kBRw==
X-Gm-Message-State: AOAM532sQGfeQEP2wRuhH4/U+OtVgWqk/NU/+1hJ6rJC/jEEP0yyiKBG
        qtEQoy14CTIshql9uUNm2+eyVOetKYo=
X-Google-Smtp-Source: ABdhPJy/tr6e6T8hkvh04q9zNBiSwDkHyyvIf4ohzDR2hiO8Wb6yXpt8g/Li6dCVl7n8bq537HwqRA==
X-Received: by 2002:a05:6214:1022:: with SMTP id k2mr13642992qvr.53.1633749145983;
        Fri, 08 Oct 2021 20:12:25 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id g27sm935407qkl.27.2021.10.08.20.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 20:12:25 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id x12so11431055qkf.9;
        Fri, 08 Oct 2021 20:12:25 -0700 (PDT)
X-Received: by 2002:a37:b842:: with SMTP id i63mr5942720qkf.262.1633749145064;
 Fri, 08 Oct 2021 20:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211001000924.15421-1-leoyang.li@nxp.com> <20211001000924.15421-3-leoyang.li@nxp.com>
 <YVsrYp3kZNmB1CIu@robh.at.kernel.org>
In-Reply-To: <YVsrYp3kZNmB1CIu@robh.at.kernel.org>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 8 Oct 2021 22:12:13 -0500
X-Gmail-Original-Message-ID: <CADRPPNSqJJ3RObHLVmpcg71Gz6jXi+Qa3kv-Z2oyBHzv4qcx_g@mail.gmail.com>
Message-ID: <CADRPPNSqJJ3RObHLVmpcg71Gz6jXi+Qa3kv-Z2oyBHzv4qcx_g@mail.gmail.com>
Subject: Re: [PATCH 2/5] memory: fsl_ifc: populate child devices without
 relying on simple-bus
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 12:14 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 30, 2021 at 07:09:21PM -0500, Li Yang wrote:
> > After we update the binding to not use simple-bus compatible for the
> > controller, we need the driver to populate the child devices explicitly.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  drivers/memory/fsl_ifc.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
> > index d062c2f8250f..251d713cd50b 100644
> > --- a/drivers/memory/fsl_ifc.c
> > +++ b/drivers/memory/fsl_ifc.c
> > @@ -88,6 +88,7 @@ static int fsl_ifc_ctrl_remove(struct platform_device *dev)
> >  {
> >       struct fsl_ifc_ctrl *ctrl = dev_get_drvdata(&dev->dev);
> >
> > +     of_platform_depopulate(&dev->dev);
> >       free_irq(ctrl->nand_irq, ctrl);
> >       free_irq(ctrl->irq, ctrl);
> >
> > @@ -285,6 +286,14 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
> >               }
> >       }
> >
> > +     /* legacy dts may still use "simple-bus" compatible */
> > +     if (!of_device_is_compatible(dev->dev.of_node, "simple-bus")) {
> > +             ret = of_platform_populate(dev->dev.of_node, NULL, NULL,
> > +                                             &dev->dev);
>
> There's no need to make this conditional. of_platform_populate() is safe
> to call multiple times. If that doesn't work, it's a bug.

I think that it is probably an optimization to avoid re-populate the
bus for legacy device trees.  But it might be cleaner to just
re-populate anyway?

Regards,
Leo
