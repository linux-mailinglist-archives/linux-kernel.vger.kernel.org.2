Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CB9440985
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhJ3OZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 10:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhJ3OZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 10:25:54 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B56C061570;
        Sat, 30 Oct 2021 07:23:24 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id i6so9349732uae.6;
        Sat, 30 Oct 2021 07:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2X5YJfC5EItlH9jFztQTg0PcOzeEO1fDAz5we8++GiY=;
        b=DTCl4uKh0judLjcX5ts/CnqE0z1+pHIvmxbPrm9qjNWUPUaIpb5juM6IqQpP2tTA3n
         FDwrPf6WiGmNKHWR1g9aFsqtGiWoylNL4xjCjOab1kJsXmSCl5R9hKG6BYL6vBX8FfCt
         5HEmn7XEFkhI/nVdX5vpO/8EO/kIRwg6lUMRyuv0rQpEXL2PQczEFo5IPILiUjpwgI1O
         FxFHOF83Kyg5g2fqu442ApFy/CRd0Jvu9V14J1PAu4P/98c12CJzE7AwLFfy00X0GCwP
         5r1y3eHR/Hgi1+PECLHcwyMYmM8P4DikrCu+P8gwSqRNHMcF6gTtnNDgRJ6EnfUcnMCh
         yQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2X5YJfC5EItlH9jFztQTg0PcOzeEO1fDAz5we8++GiY=;
        b=R5NL2q6CPvfVSSrjarSEMw4VEVMw/AH8RV+2mytNlvtdRcvaXmZar+9BkoxN9c4HaO
         icGPEw6zrFh7qIiqI7t+sHuRt7A4Fu5slLbIJ5oKrWJMrNpYXaTmA61KOyk76aqV+Gs8
         1hbpW6oGvI/X8EtMrj8gUzPQGUe2DAQZ0uj0ks5XxPO4PkorVNwcLHxyYD4rrwESpXPy
         9pRpdJVI5z+U1+mR0tfoxJ+x1O8Y8OxujMpwgpJYLxZk7WV/5ZAEXbdwLymEGHbSc/ib
         GXSFA0YIOlDhtFn3IP9Kfh6ISqHYbhL6WWayt+YOqP6m1efBve/YyRlsK9TqH0LsADFM
         LegA==
X-Gm-Message-State: AOAM530UfBJHOcInh4sE7pguG9rXY82aBcPCXj1oR62cPjj9KevEb5Yc
        jKvgsvzutzz8wZ4Mes3cP5yXSqe4elDmZiZS6qk=
X-Google-Smtp-Source: ABdhPJyxHRhDw+BgPFeGayDFg1fzBys5+4RzsLm1jCgvQC3cS74mErFYc6nvXUaE92sjBXof/G8E23ko3XAcQxTh9O0=
X-Received: by 2002:a67:ec57:: with SMTP id z23mr19405997vso.55.1635603803625;
 Sat, 30 Oct 2021 07:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211006112306.4691-1-sergio.paracuellos@gmail.com> <CAMhs-H_h9=sj5_p58WcqrYJuT-CGHp38xELwD1jvt=XzfvG2bw@mail.gmail.com>
In-Reply-To: <CAMhs-H_h9=sj5_p58WcqrYJuT-CGHp38xELwD1jvt=XzfvG2bw@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 30 Oct 2021 16:23:12 +0200
Message-ID: <CAMhs-H8zCdhRUaqo3t6RZ95C2E89YFhvPN52SgDbPBAFtTwO0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] clk: ralink: make system controller a reset provider
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sun, Oct 17, 2021 at 8:51 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi Stephen,
>
> On Wed, Oct 6, 2021 at 1:23 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > Hi all,
> >
> > This patch series add minimal change to provide mt7621 resets properly
> > defining them in the 'mediatek,mt7621-sysc' node which is the system
> > controller of the SoC and is already providing clocks to the rest of
> > the world.
> >
> > There is shared architecture code for all ralink platforms in 'reset.c'
> > file located in 'arch/mips/ralink' but the correct thing to do to align
> > hardware with software seems to define and add related reset code to the
> > already mainlined clock driver.
> >
> > After this changes, we can get rid of the useless reset controller node
> > in the device tree and use system controller node instead where the property
> > '#reset-cells' has been added. Binding documentation for this nodeq has
> > been updated with the new property accordly.
> >
> > This series also provide a bindings include header where all related
> > reset bits for the MT7621 SoC are defined.
> >
> > Also, please take a look to this review [0] to understand better motivation
> > for this series.
> >
> > Thanks in advance for your feedback.
> >
> > Changes in v2:
> >  - Address review comments of Dan Carpenter [1]:
> >     + Avoid 'inline' in function definition.
> >     + Return proper error codes (-EINVAL) instead of '-1'.
> >     + Make use of 'devm_kzalloc' instead of 'kzalloc'.
>
> Can you please take a look into this series? I'd like them to be added
> in the next merge window and if something needs to be changed I'd like
> to have a bit of time to do it :)).
>
> Regarding how to merge this I guess all of the patches should apply
> cleanly in any tree but since there are already changes in mt7621-dts
> maybe patches 1 and 4 which are related can go through the staging
> tree (if Greg is ok with this) and the bindings doc change and driver
> changes (patches 2 and 3) can go through your tree.

I have just sent v3 since PATCH 4 did not apply cleanly anymore in
both clock tree and staging tree.

Best regards,
     Sergio Paracuellos
>
> Thanks in advance for your time.
>
> Best regards,
>     Sergio Paracuellos
>
> >
> > Best regards,
> >     Sergio Paracuellos
> >
> > [0]: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210926145931.14603-3-sergio.paracuellos@gmail.com/
> > [1]: https://lkml.org/lkml/2021/10/6/204
> >
> > Sergio Paracuellos (4):
> >   dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
> >   dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
> >   clk: ralink: make system controller node a reset provider
> >   staging: mt7621-dts: align resets with binding documentation
> >
> >  .../bindings/clock/mediatek,mt7621-sysc.yaml  | 12 +++
> >  drivers/clk/ralink/clk-mt7621.c               | 79 +++++++++++++++++++
> >  drivers/staging/mt7621-dts/mt7621.dtsi        | 27 +++----
> >  include/dt-bindings/reset/mt7621-reset.h      | 37 +++++++++
> >  4 files changed, 140 insertions(+), 15 deletions(-)
> >  create mode 100644 include/dt-bindings/reset/mt7621-reset.h
> >
> > --
> > 2.33.0
> >
