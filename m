Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115593DE9AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhHCJ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhHCJ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:29:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB78C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 02:28:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d6so20514531edt.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrOvFvaZNsn80q6GJRAYC0L2UxPiAmkAJahNroTMzWw=;
        b=sJ4VvJR39jrzum72mmX2j09NRS9SPJrfuVoApDoiPBuLyUdJ2UmDbQPJyi7sBkIat7
         lAT0G8OA2XWU1rRsPvrniiXkT0GweabA2lfTSsO8yAJ0xKmYJS3S9toIlTOON6Z+7pjX
         OoH8EQmXpM79UWzzz2ZunOWArdv+YPwqgEQ4VYu0fWVjiTbXhbh8SyaSoE/kucx5khx4
         0Om1Z9O/LEULtjDGWSHN+ZUaiYWr0rgWHVIouFplupJdgonOaxMR2JcF65ThD9fdXO1V
         rshWLyTfeF0vbOjTF4BESqKts03wkPoRnS6onzHkE5Ht2DgkFUg6EPMdQ1uQib8sFwyE
         1A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrOvFvaZNsn80q6GJRAYC0L2UxPiAmkAJahNroTMzWw=;
        b=FfUD9WUO0d8qF0gt1/ApRxdhahaCOkofocMRpNRpMLCIY8C1r8WqMjPhb2DpMiWR/O
         2ai0Peizj+V2YvkBNj3nU7vFQKHyYDXGQN3DCglrpAZNBKwKlLqCptbmkDzsgAc5lsfz
         BbyDFr/hpcSYrqJoJnrrBr7D4bNQ/hNpyYBGxyLh0gROTUhr8UDCO1p3mqASAubrX31f
         sTUZ6JEI31Xfe/ZMOqi5Ly4V7xq1XQPRbvBL0hFuFmCUccXxhjbLLCU6FSSNKn8UR4zv
         aJj4RHrHiODBlra3oDIOzvKs2DcjDXn0uaaj3u+TzqoEdUAFJ/dT4EtAd0ZxMpDRwuDA
         A1dw==
X-Gm-Message-State: AOAM532zTr6ez8vs72D2zci4iUDagk86/nBAx2PcVGXm9xdM5KRgWfm1
        YizP2IaIzm0706SsKEu924xuWWqrawZr2nP5kWw=
X-Google-Smtp-Source: ABdhPJx40FgCKtbZnSuzncIgNCtbPavmibXfXPduegfNAEuzGHImMWZzg3lrDxqoX6jIPEaYFIIJMvtB4CmetZfPFZs=
X-Received: by 2002:a05:6402:28b0:: with SMTP id eg48mr24415074edb.241.1627982929392;
 Tue, 03 Aug 2021 02:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210803075159.2823913-1-mudongliangabcd@gmail.com> <81ccbbb5-5499-7a75-88ba-bae5328ffbf9@canonical.com>
In-Reply-To: <81ccbbb5-5499-7a75-88ba-bae5328ffbf9@canonical.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 3 Aug 2021 17:28:22 +0800
Message-ID: <CAD-N9QXfdossFaQFwa-DPCyY-deHZ-75=LtSQYihvPNDpzwqiw@mail.gmail.com>
Subject: Re: [PATCH] memory: fsl_ifc: fix leak of irq and nand_irq in fsl_ifc_ctrl_probe
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 3:57 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 03/08/2021 09:51, Dongliang Mu wrote:
> > In fsl_ifc_ctrl_probe, if fsl_ifc_ctrl_init fails, we should free the
> > resources allocated by irq_of_parse_and_map.
>
> Your code is doing much more. You also touch nand_irq, not only
> fsl_ifc_ctrl_init(). This looks incorrect as IRQ is optional, isn't it?
>
> The problem is entirely different than you described here - the error
> paths of fsl_ifc_ctrl_init() and request_irq() are wrong. They do not
> release resources in proper paths.

Yes, you're right :). This patch rewrites the whole error handling
code. Any comment on the code changes?

I will rewrite the commit message in the patch v2.

BTW, there is a minor issue: if request_irq fails, we should not
invoke free_irq.

>
>
>
> Best regards,
> Krzysztof
>
> >
> > Fix this by adjusting the error handling code.
> >
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/memory/fsl_ifc.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
> > index d062c2f8250f..391390dd3dcb 100644
> > --- a/drivers/memory/fsl_ifc.c
> > +++ b/drivers/memory/fsl_ifc.c
> > @@ -258,12 +258,17 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
> >       /* get the nand machine irq */
> >       fsl_ifc_ctrl_dev->nand_irq =
> >                       irq_of_parse_and_map(dev->dev.of_node, 1);
> > +     if (fsl_ifc_ctrl_dev->nand_irq == 0) {
> > +             dev_err(&dev->dev, "failed to get nand_irq resource for IFC\n");
> > +             ret = -ENODEV;
> > +             goto err_unmap_irq;
> > +     }
> >
> >       fsl_ifc_ctrl_dev->dev = &dev->dev;
> >
> >       ret = fsl_ifc_ctrl_init(fsl_ifc_ctrl_dev);
> >       if (ret < 0)
> > -             goto err;
> > +             goto err_unmap_nandirq;
> >
> >       init_waitqueue_head(&fsl_ifc_ctrl_dev->nand_wait);
> >
> > @@ -272,7 +277,7 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
> >       if (ret != 0) {
> >               dev_err(&dev->dev, "failed to install irq (%d)\n",
> >                       fsl_ifc_ctrl_dev->irq);
> > -             goto err_irq;
> > +             goto err_unmap_nandirq;
> >       }
> >
> >       if (fsl_ifc_ctrl_dev->nand_irq) {
> > @@ -281,17 +286,17 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
> >               if (ret != 0) {
> >                       dev_err(&dev->dev, "failed to install irq (%d)\n",
> >                               fsl_ifc_ctrl_dev->nand_irq);
> > -                     goto err_nandirq;
> > +                     goto err_free_irq;
> >               }
> >       }
> >
> >       return 0;
> >
> > -err_nandirq:
> > -     free_irq(fsl_ifc_ctrl_dev->nand_irq, fsl_ifc_ctrl_dev);
> > -     irq_dispose_mapping(fsl_ifc_ctrl_dev->nand_irq);
> > -err_irq:
> > +err_free_irq:
> >       free_irq(fsl_ifc_ctrl_dev->irq, fsl_ifc_ctrl_dev);
> > +err_unmap_nandirq:
> > +     irq_dispose_mapping(fsl_ifc_ctrl_dev->nand_irq);
> > +err_unmap_irq:
> >       irq_dispose_mapping(fsl_ifc_ctrl_dev->irq);
> >  err:
> >       iounmap(fsl_ifc_ctrl_dev->gregs);
> >
>
