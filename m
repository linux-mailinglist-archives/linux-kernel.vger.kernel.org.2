Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3077430130
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 10:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbhJPIoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 04:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbhJPIoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 04:44:34 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2372C061570;
        Sat, 16 Oct 2021 01:42:25 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id m67so16665963oif.6;
        Sat, 16 Oct 2021 01:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRFpjv0QFobuihrGVtFv7+z3s3YwkmdjK5buj6rIYYk=;
        b=e4XZ+unUBUbMrqDFojloAf/MWyJ+7XUX2dM0yuSK7u14qDHlWK3jvBmprF3eYtc41J
         8M1c6eZrCrVKlQMU3PM/uYlBL2ivf3LPcCL9qO4B5xzvOLu3F+OdSCR+kwSs+MArGLWx
         yCGehbJXmOGnWkjKKBbtmCoQnhT+pPutBIpW28uG/F222mq9CRKO1EW+ktqcNg0F6Bcm
         NqLkFbsjp44wrmkxs/PJYxsqfz+90YowR+fIn4d5mfPvSr4nu2Ytf3CyLgnnu8RLdHX2
         vNT0PjLvR0IlNPR0R2v2CCa/yJidaWB1Ynu+B93MI53bqYT6Naw/xFwcyLLdHbI/s3qb
         MiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRFpjv0QFobuihrGVtFv7+z3s3YwkmdjK5buj6rIYYk=;
        b=duLWg2GD3eZAuI208tJTjOAPVolmhPQf05oTaoNLNj7YtU3zUpRpQEJC5smoHMuyzz
         pFuKX5KrTrybnWPKCcjz43o0t56d8BNGOQ/FT+XDfVWC3Je9RP23TVWVAeIKUIMQPhwx
         zW4H9dm+L1whAX3sCMCkBJbwrU1g2rx0MoXtAcZsXX1WXounS1t4bJ1iEMEt2XKdCBCU
         WD4iX89ukJ/RbQXfzHO/H/u38AGDFj02Bx2sOvJdF5ZU1phOAdje7kvjn5c141lO/iBj
         44rqT19C5gO+9izDhv6+xZrz6WqUYE2wnUx6qozcAEJ6VA7WRbVPLi8VXJwQtON7zjzr
         7rGw==
X-Gm-Message-State: AOAM531dqogw6G62N9QsAurSREWuiKWDhJS4NCFZGjd2w5zEYDqEDAsY
        IEvM1fk9NjnR3M1+5MkUYNUzS2lUEjEnOV5IOFQ=
X-Google-Smtp-Source: ABdhPJy7lxlVoFewmgMKKAJEJU2jodl1MUdYceXgsLVeOYAQGnAFtkQKC4i0vOQatn7rMG5PNtcsz8B3nHzpLxeEnuY=
X-Received: by 2002:a05:6808:309c:: with SMTP id bl28mr7351673oib.140.1634373745382;
 Sat, 16 Oct 2021 01:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-2-zhang.lyra@gmail.com>
 <CAMuHMdWq3M3i+5yATeGEUxupU6Gb5ZnJeNsn9czX6tukEbHQng@mail.gmail.com>
In-Reply-To: <CAMuHMdWq3M3i+5yATeGEUxupU6Gb5ZnJeNsn9czX6tukEbHQng@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Sat, 16 Oct 2021 16:41:49 +0800
Message-ID: <CAAfSe-sQB4wXGwGSPYpoF_YmzJjT=dFLTz36haJ6orE_=zai-Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for the review.

On Wed, 13 Oct 2021 at 22:23, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Chunyan.
>
> On Thu, Sep 23, 2021 at 8:42 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Add a new bindings to describe ums512 clock compatible strings.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
>
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 4
>
> After applying this to my local tree, as it is a dependency for 2/4 in
> for-mfd-next:
>
>     Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml:
> properties:clock-names: {'required': ['maxItems']} is not allowed for
> {'minItems': 1, 'maxItems': 4, 'items': [{'const': 'ext-26m'},
> {'const': 'ext-32k'}, {'const': 'ext-4m'}, {'const': 'rco-100m'}]}
>     hint: "maxItems" is not needed with an "items" list
>     from schema $id: http://devicetree.org/meta-schemas/items.yaml#
>
> so please drop the maxItems 4.

Ok, I will, but I don't have this compile error on my side, how do you
get this error report?

I use the command below:
make -k dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
and,
make -k dt_binding_check

Thanks,
Chunyan

>
>
> > +    items:
> > +      - const: ext-26m
> > +      - const: ext-32k
> > +      - const: ext-4m
> > +      - const: rco-100m
> > +
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
