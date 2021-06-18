Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1270C3ACF2B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhFRPfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbhFRPfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:35:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC81C061767
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:33:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id df12so6719746edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lXIZf4M/Wk9OMiaT+VN4VJVU8FiWIRaCbWAUXPgEmuw=;
        b=B7ozRKMdsIZaq6CpNHJIsNxfc7Y4J7UTN6kDIxjZ2eigM59O+qyBRu5WyYOxllcJqS
         KRiSIKk8kGaUxnxrmaA5F0JiqukeXaiNs/BpI7+azHPmO1mDg5FvPfRsGEza4HOh8K7v
         Xpw7H3VfrZ8Q4IeT/HhbdkpwPSIyaSgTXpWC6AYJ3JY0muXE5l2ISZQmAuoSY/gfQ6cM
         HPUmMuX/ID9Kfdiqh7q7s3pgPih9RzRnjMQ/3Iw/I9bZaQxqGUczLfviGtSEKZ0gxrkE
         +Y5qYTLL2YiIReOIDDGnSJML9EUYmGi6/xox47WBgWLx1kheJDwTE89FTeQfFO2Zjem4
         825A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXIZf4M/Wk9OMiaT+VN4VJVU8FiWIRaCbWAUXPgEmuw=;
        b=E0bkyK32L/ecQqgmoaDtx3Evb6Q0VvZnEBqfoH+1pI3MSsWZv/LLQB4jzUUv9Ind+S
         8tXuV4c+4ytxOIoy8X75wCN0J1/Ks50vOZt28R1Dqjaz2SSmvn2Xean8bKc+Y4U8BCIL
         8oTewrRdRDMzATRe738M0K8PjJPNf/OwclZYzFqEgBApuIHp6KK+LH2DLIIFt+n84sDy
         JP/QK/itcAuJV/J7dVaj30we0GzHJ7GNa+mgvlVJeqgcED1eDauKs5N2AkBD56uIioNE
         1jeDk+TQw30vTRXCv4rmGzJp0Hs84DAxMvVEynSwlw3qSE88E8/y4L7Ho2NRPUhDsL29
         Y29A==
X-Gm-Message-State: AOAM530qhw5I3YcTKpWq6zfB3Wtr3zwoiop6uQtfaXnUufP1n9ShmMt+
        funrOHXDmFx9mEFO+3lxO3TAzZgp6zbxuwOtyZc=
X-Google-Smtp-Source: ABdhPJwFJcPj6QNZ7mrUZAXYq1D2D8ElUkYJuaamLyvnmY7CMT0+IuOidETWvP+w4NxG1p7vSUDH+tDXXfIYEk1gkmE=
X-Received: by 2002:aa7:cb8d:: with SMTP id r13mr5853072edt.184.1624030413483;
 Fri, 18 Jun 2021 08:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-7-linux.amoon@gmail.com>
 <CAFBinCCE+6G7QtDoxfbcZVVRf-MDX-epSo=_k_PJZgWX+_Whvg@mail.gmail.com>
In-Reply-To: <CAFBinCCE+6G7QtDoxfbcZVVRf-MDX-epSo=_k_PJZgWX+_Whvg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 18 Jun 2021 21:03:22 +0530
Message-ID: <CANAwSgRqixugUr-t2OheLBVwD=EOkaLqxnGkT-Bx=p_A4Nyr8Q@mail.gmail.com>
Subject: Re: [RFCv1 6/8] phy: amlogic: meson8b-usb2: Use phy reset callback function
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin

On Fri, 18 Jun 2021 at 03:54, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Thu, Jun 17, 2021 at 9:44 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > +static int phy_meson8b_usb2_reset(struct phy *phy)
> > +{
> > +       struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
> > +       int ret;
> > +
> > +       if (priv->is_enabled) {
> > +               ret = reset_control_reset(priv->reset);
> > +               if (ret) {
> > +                       dev_err(&phy->dev, "Failed to trigger USB reset\n");
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> will this reset change the register values back to some kind of default?
> If it does then we're not re-applying our desired register values
> afterwards - which is probably asking for trouble.
>
> For shared resets (like the one we have here) reset_control_reset will
> only trigger the reset line once until all drivers using that reset
> line are unloaded.
> So effectively this new phy_ops.reset callback will be a no-op.

I know his register is shared between two USB IPs,
but I have not observed any issues.
>
> [...]
> > -       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> > +       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, "phy");
> I think this breaks compatibility with existing .dtbs and our
> dt-bindings (as we're not documenting a "reset-names" property).
> What is the goal of this one?
>

OK, If we pass NULL over here there is the possibility
USB phy will not get registered.

>
> Best regards,
> Martin

Thanks

-Anand
