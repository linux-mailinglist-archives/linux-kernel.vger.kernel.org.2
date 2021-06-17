Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE14C3ABE9B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhFQWS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhFQWS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:18:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61E1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:16:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ho18so12481574ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwVsJszErVtiyw5bOlSHdlACIUbk2leEVGsI22Nm16c=;
        b=kJNfxLLxB72H4z5568lAYK6FwqUG64zbFQZGgHu0rNw3JSMmfIYJbli8QZgaHLkqwN
         dqGNlVi2B663P/UJFyPxXHsOhsML6veC9Sd2PIGMz+hwSi5aFjrSo3GNcjioZsymEJUA
         Xhw6CnEwgNZYNP8zdNaBu9ylCoLnUsO5jungvWWNorKlZiHs1kgXoMFXvdFI1r7NaBvB
         RiG6cxxfC+TpLGLP/RjArtcTWQvjExLFct8del+j85LN7oAyvABr2nfvp7j0pfgPYSCq
         xkmpWB1uJFj/dGkh35bZJSCxegWSck8lfgZIDsnyTimeTZJqygEl2DagMKzgWpmXb54G
         LfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwVsJszErVtiyw5bOlSHdlACIUbk2leEVGsI22Nm16c=;
        b=U8+6ABi3zTwK6+KV126YqkIkXf+9fPI7XZ0VSh1kHnQjuh36XxZnMSkecJ0Y+bOYgP
         XUsmL/emF8OeqU1NbHXjLWUiemUUgjZSGEDAyZ4FyVbumDXZ9VVPQqkmdGYmPnM7Glvc
         P8/+QUBypK//MwGl/VY39Xphf295xpVLh99qUJnYYWkwhABtb81pZwfoaF+muFs2Qlv0
         iSnzuW8hSrULmv8fY5IuZQWqBgimhHy9b7zft1HJK8jmHQ7SLlGM9H7BcjHT2epVsjZO
         b/SsXDYgxcBITcG2M+uCYMv5fgsY+fykJZT3nUCNrwKg5ebxCWUOLfUsXMQ8nGFTgRs4
         xbpQ==
X-Gm-Message-State: AOAM530WEiWm8PtcDvb4XBGkf1OF0Ff7Ev7/A4/qh9LOpJ9D66dsyIcu
        Pjq+Rp4mUdGy8y44g0Rv4ZaScT/N65j18EkYzpQ=
X-Google-Smtp-Source: ABdhPJwq5lDCttRtdcLtp8xWWsEyuZqDh41mR0y7tmleLZioJ3kdB5nIgDKCGPjdhNhzugBo1SrbqHNC/5oB4qsNROA=
X-Received: by 2002:a17:907:9607:: with SMTP id gb7mr7735421ejc.208.1623968177208;
 Thu, 17 Jun 2021 15:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-5-linux.amoon@gmail.com>
In-Reply-To: <20210617194154.2397-5-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jun 2021 00:16:06 +0200
Message-ID: <CAFBinCB1rrmJ5=M0tSGS_47BarFcrs2Kz5qFzrHw8+OEYxX3DA@mail.gmail.com>
Subject: Re: [RFCv1 4/8] phy: amlogic: meson8b-usb2: Use phy set_mode callback function
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Thu, Jun 17, 2021 at 9:43 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Reorder the code for phy set_mode in .set_mode callback function.
> For now configure the phy in host mode.
as mentioned in the cover-letter: to my knowledge these register bits
are "static"
The settings for dr_mode == USB_DR_MODE_HOST mainly apply to the
second PHY (usb1_phy)

[...]
> +static int phy_meson8b_usb2_setmode(struct phy *phy, enum phy_mode mode,
> +                                   int submode)
>  {
>         struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
>         u32 reg;
>
> +       switch (mode) {
> +       case PHY_MODE_USB_HOST:
> +               if (priv->match->host_enable_aca) {
> +                       regmap_update_bits(priv->regmap, REG_ADP_BC,
> +                                          REG_ADP_BC_ACA_ENABLE,
> +                                          REG_ADP_BC_ACA_ENABLE);
> +
> +                       udelay(ACA_ENABLE_COMPLETE_TIME);
> +
> +                       regmap_read(priv->regmap, REG_ADP_BC, &reg);
> +                       if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
> +                               dev_warn(&phy->dev, "USB ID detect failed!\n");
> +                               return -EINVAL;
> +                       }
> +               }
> +               break;
> +       default:
> +               dev_warn(&phy->dev, "USB ID detect failed to setnode! %d\n", mode);
> +               return -EINVAL;
I have tested this driver already with PHY_MODE_USB_DEVICE (on my
Odroid-C1) so I don't see why we should drop support for this
Also if we want runtime mode switching in this driver then we would
need to undo the changes from "case PHY_MODE_USB_HOST" above

I suggest dropping this patch until we know for sure if and which
registers need to be updated based on the DR mode.


Best regards,
Martin
