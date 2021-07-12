Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07263C5159
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347766AbhGLHkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245103AbhGLHLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:11:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CDCC0225B2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:01:40 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a18so22468089ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VYxdyspSXWiwtPigXq/rsDU61HEXCt6NK9gvUcQWdw8=;
        b=j9Vqu0fE81dKuB+kJrj1mFKs1Q4XuZf15mdQ7y/28wrgXUmux6EGDh3Kqzc0D6Soyh
         x4glUdP6MiOg1LSsMctR2/tU3EPVNIM5mAtqztMYzmeGxNhimHPfdbtt9VU6ew3ecE7A
         7ZhwHClVVPOUnoVqqTpfiHDdu1GFefzp/GoZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYxdyspSXWiwtPigXq/rsDU61HEXCt6NK9gvUcQWdw8=;
        b=S2y+JMEVEVcAW5uGGNdxLGiLd85et1g2dsPL1y0im7hy4/SRCAyJlQWhlEY6Suxs9F
         H9uZlDhlvQOF6hBXIqX5X5RmgbLTzHWdjHOlTn+ie+UGx41Rq3jBZ65ad0QuRYjW6TV4
         R8aY814zdtUPTblj9RDsNjHgs3QdIkil4akXo29px640hynlqDoZ4ULepFqTY8e3phOL
         aXWfbVujDvATCpHUg3Qcn/pMcZfWSHJChvHscIVpGKOdViTYxd5Vh8XK7utjha9RrUhR
         C76fiqrcu4SXc+EaQ0VOdRoc6QPfMGE38orv5S/Iy1XA4H0/PGZi7sX5xNK3ouedOCP9
         ccAA==
X-Gm-Message-State: AOAM533Q6r7DYK09oRl+ce1QkY84VrlvyQzwLG5ScSHxq2l38044umzT
        +VuFd/9KHFfJuQg5/BpLus5mR1fovtzvF8oR0q4HWg==
X-Google-Smtp-Source: ABdhPJyfLdmeFKBf+PLnkJ30PFYffQcwVgdTfzPp/i11j8aApmws194sn2QFP1ISlk6TVNbu9PCbxv1IXO8m7OC1XiY=
X-Received: by 2002:a2e:a583:: with SMTP id m3mr41042486ljp.305.1626073298718;
 Mon, 12 Jul 2021 00:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210710122446.5439-1-tinghan.shen@mediatek.com>
 <CA+Px+wUVsY6CYwEdfSeK+KQGmvb224hvchgnTwX0rgBzMvXfqw@mail.gmail.com> <CAGXv+5EtUqe=HECJFkZXdDX9cV_wMp0OykHDOBJVWPF3MwA4ZQ@mail.gmail.com>
In-Reply-To: <CAGXv+5EtUqe=HECJFkZXdDX9cV_wMp0OykHDOBJVWPF3MwA4ZQ@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 12 Jul 2021 15:01:27 +0800
Message-ID: <CAGXv+5Hww-fgvEkjOtLQod6wbnThgdg0eiEx=45nQVY2wtWHcQ@mail.gmail.com>
Subject: Re: [v2 1/2] dt-bindings: remoteproc: mediatek: Add binding for
 mt8195 scp
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 2:59 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Mon, Jul 12, 2021 at 2:06 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
> >
> > On Sat, Jul 10, 2021 at 8:25 PM Tinghan Shen <tinghan.shen@mediatek.com> wrote:
> > > @@ -5,13 +5,15 @@ This binding provides support for ARM Cortex M4 Co-processor found on some
> > >  Mediatek SoCs.
> > >
> > >  Required properties:
> > > -- compatible           Should be "mediatek,mt8183-scp"
> > > +- compatible           Should be one of:
> > > +                               "mediatek,mt8183-scp"
> > > +                               "mediatek,mt8195-scp"
> > Just realized we forgot to add DT bindings for mediatek,mt8192-scp[1].
> > Could you send another patch for adding the missing property?
> >
> > [1]: https://elixir.bootlin.com/linux/v5.13.1/source/drivers/remoteproc/mtk_scp.c#L879
> >
> > > -- clocks               Clock for co-processor (See: ../clock/clock-bindings.txt)
> > > -- clock-names          Contains the corresponding name for the clock. This
> > > +- clocks               Required by mt8183. Clock for co-processor (See: ../clock/clock-bindings.txt)
> > > +- clock-names          Required by mt8183. Contains the corresponding name for the clock. This
> > >                         should be named "main".
> > Let's move clocks and clock-names to "Optional properties".  See [2]
> > for your reference.  I guess it doesn't need to mention which chip
> > needs the properties.  For those chips that need the clock properties,
> > they won't work correctly without correct clock properties.
>
> I would suggest still adding them. We will need to describe the requirements
> anyway then the binding is converted to DT schema.

Also, a coprocessor without any clock feeding it makes little sense.
Any processor requires a running clock. Whether that clock is controllable
is beside the point.

> ChenYu
>
> > [2]: https://elixir.bootlin.com/linux/v5.13.1/source/Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt#L87
> >
> >
> > Suggested to provide a cover letter for the series next time.
> >
> > nit: other patches usually use "[PATCH v2 1/2]" in the email title
> > instead of the one used in the mail.
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
