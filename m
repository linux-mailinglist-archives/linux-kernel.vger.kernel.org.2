Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D103B0DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhFVUDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhFVUDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:03:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B2AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:01:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hz1so300944ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zf4vdgRI2eIvOyP4BfdsN5wqUDVZRwFofOZUaIYATtY=;
        b=Xg5E90d+x7IHvd/rCJj3o+qjOEM4/AqGVdQHwicqleR2GFmKMJHRY9cvZgzHw86/if
         tznrosDerhJy+e7zX7Mx5kJmlnmmU5NF7vNhlzJ5dymzT2wGhQiVyDdlXdDYPL58wpTa
         BSNCwXlew5vXQ3W3lXJn5DO+f3JucPqUu1BYh3aEezggPgSfaEiiXXbWr0YlcBVsu5go
         6nxrn5NW+fUFsh8NFcnVEh0+8mBDjxibwRtGGDaZjQNLCYK1yTTJ8DjYbw2HA6o4LIQu
         ho0jE/spAvLFFsIAk3PUZwld3AuKaV58T5AydE6JNGqqRXq42T+FKerU/2wRvAF9G7rX
         Qtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zf4vdgRI2eIvOyP4BfdsN5wqUDVZRwFofOZUaIYATtY=;
        b=d6Sj9it6GOx2B5m/VGx2VtJ9WFmpMnqP/+kCGiPp7yJUBoNMkq4ub/3ZgxcLKkRGBQ
         fMA6M53eAhhiF6jPdT71/VdngT2xsv7zKv/T9gcamJq+KM00hJdBokIi2jsu2Udh15SO
         8UHLxTToBn0D00kAhjpBbp2PiU7G5rDYJybF1zM9VrGW1qVTOmFM7vknl8+qU9bBdNQr
         Bq/l34hHyTPSvGdB/zEIPk00YUf+r5JXcshygLHzP5zwxHyxou/XkkWVoHTJA5ZM7U2b
         W+k1sshytSQUm5AbPTEGwLISivCCawdGoVvfRMC7MVgrpuhW8TZQf3OVAB1fOwA2A4we
         Fl1w==
X-Gm-Message-State: AOAM533bmwji596v75f6Z6JLQMGO0UFSbF2iidKR9Rx1I2vj+gAHOGVF
        lY0iv+g+UiR3T46YW3R966KqgAoCGeLWFWZwF4o=
X-Google-Smtp-Source: ABdhPJzvh7nsvk4PVuaKFHZXXafU6Hb6v8/HVjM/U5isfltZa2k5+fZ9AxpjVdjuvx1dttC8PnkMnC39zlrovwF3pH8=
X-Received: by 2002:a17:906:64c8:: with SMTP id p8mr5646217ejn.428.1624392060989;
 Tue, 22 Jun 2021 13:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-8-linux.amoon@gmail.com>
 <CAFBinCC0KScn6cJ36ZB_=TRncOOCXJHWwR3s=o3TobH=yOrGJA@mail.gmail.com> <CANAwSgRi7UcS22QKZRRhwYvB3Dyk0ChowX+KByEsxP35ezjtKw@mail.gmail.com>
In-Reply-To: <CANAwSgRi7UcS22QKZRRhwYvB3Dyk0ChowX+KByEsxP35ezjtKw@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 22 Jun 2021 22:00:50 +0200
Message-ID: <CAFBinCD1+FTx59kVn7w=RurZVK48S3+pdXYjjW_LEQtTEr87mg@mail.gmail.com>
Subject: Re: [RFCv1 7/8] phy: amlogic: meson8b-usb2: Power off the PHY by
 putting it into reset mode.
To:     Anand Moon <linux.amoon@gmail.com>
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

Hi Anand,

On Mon, Jun 21, 2021 at 9:15 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> On Fri, 18 Jun 2021 at 04:07, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Anand,
> >
> > On Thu, Jun 17, 2021 at 9:44 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > [...]
> > > @@ -245,8 +250,6 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
> > >         regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_FSEL_MASK,
> > >                            0x5 << REG_CTRL_FSEL_SHIFT);
> > >         /* reset the PHY */
> > > -       regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_POWER_ON_RESET,
> > > -                          REG_CTRL_POWER_ON_RESET);
> > The vendor driver uses the following sequence for the power on reset:
> > - set the power on reset bit
> > - wait 500us
> > - clear the power on reset bit
> > - wait 500us
> >
> > With your change we now:
> > - wait 500us
> > - clear the power on reset bit
> > - wait 500us
> >
> > I don't know if this is sufficient to bring the PHY into a well-defined state.
> > Maybe it works, maybe it doesn't reset at all in this case - I don't
> > know how to verify this though.
> >
> Initially, I tried to some bit mask code to resolve this but it failed,
> So no harm in keeping the original changes.
yes, I feel more comfortable with that

> There is another parameter REG_CTRL_PORT_RESET to be considered.
none of the vendor kernels that I have sets or clears this bit explicitly
I agree that the name seems related, but due to lack of an example or
documentation how/when to use this bit I suggest we don't touch it for
now


Best rergards,
Martin
