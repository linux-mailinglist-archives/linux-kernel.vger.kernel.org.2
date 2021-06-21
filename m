Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB183AE3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhFUHR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUHR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:17:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EC0C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:15:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i5so25071eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2VmOBbh4kfF26YhpUPXGB28rPvNAwUjRDpuCeiXVHo=;
        b=fqKD5IDT5oHBC8maBgSPfZhCXdKhsBTj5jzlUbJgQijXi1mI575CgsyZDErzU7gicQ
         6zayRSxarLEgm9D8EQ+x9C2pNhfQIcNUNBg/LYsQeopH3uwf+qu4W5L1BU1+Af4L5TYT
         Bfyt1AlBB6sL1WTP8+D1QO5VUuD1Qazv+e09PNXA0WOTO1L2OeovaSWYfhGDIP56NVfd
         1DDM4cTu4NUx3w8g0z36UnxoC4gWrOWrei5wWqoRdD0B9Okc69xFtNlY7DfE1pu0HeGW
         IK4LE+G6hFiGGG1fuvzlvKAXqTIg1/qjHo+ynoQDOddWnwXkTtkV7jM7NceWlViXHmSm
         0eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2VmOBbh4kfF26YhpUPXGB28rPvNAwUjRDpuCeiXVHo=;
        b=ZFJpgFRa2y/Hb6XkNiauNY2c61GBSep6cjjiVwa8Xc+VGSBXyw0XBumBSaHeQjLKRP
         B2EIVLFMWj2N/TIyyNg1E0ZIE/gfmDp1iPwKZF6gt2xavFx5pgm1ZKmSHZP2oHXXD7Ks
         OpSMBS4LuMAmxr94bOWofIEo3tpHIlaGdzDGdZyoA+ieubgOzDZFcpgSCN6ZvcaBzMRG
         tTHdhCV9gaKQXehTs4RFomHTcjWARwY7FDWejBGhuRQY3KROCK2DT0EtL5C/Dgdm3g2p
         gqqQNopwA+x5ofV0qPM3FCylapPjVoKgjJsRQ5/RCE4mKvwBDAMWS7JsV8V+Hz2UbtMC
         CSRQ==
X-Gm-Message-State: AOAM532jQy15fbt3j9kgTXV/ZUpHKNP53jRv4BkPmKoRM3oaozucBgxt
        gWIeSwEzXrm64a0PQgmFSUKVGHoD13XVMPtUbA8=
X-Google-Smtp-Source: ABdhPJxMw27+fNAEFULQjd6QLuyehyn4PR4Z6KE+kRdu0VUzdLm6B8ZIFnOIpuWRHMTIhMVnTwggmWHQo2W09KWm6rQ=
X-Received: by 2002:a05:6402:4395:: with SMTP id o21mr19677609edc.163.1624259711929;
 Mon, 21 Jun 2021 00:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-8-linux.amoon@gmail.com>
 <CAFBinCC0KScn6cJ36ZB_=TRncOOCXJHWwR3s=o3TobH=yOrGJA@mail.gmail.com>
In-Reply-To: <CAFBinCC0KScn6cJ36ZB_=TRncOOCXJHWwR3s=o3TobH=yOrGJA@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 21 Jun 2021 12:45:00 +0530
Message-ID: <CANAwSgRi7UcS22QKZRRhwYvB3Dyk0ChowX+KByEsxP35ezjtKw@mail.gmail.com>
Subject: Re: [RFCv1 7/8] phy: amlogic: meson8b-usb2: Power off the PHY by
 putting it into reset mode.
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

Hi Martin,

On Fri, 18 Jun 2021 at 04:07, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Thu, Jun 17, 2021 at 9:44 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > @@ -245,8 +250,6 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
> >         regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_FSEL_MASK,
> >                            0x5 << REG_CTRL_FSEL_SHIFT);
> >         /* reset the PHY */
> > -       regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_POWER_ON_RESET,
> > -                          REG_CTRL_POWER_ON_RESET);
> The vendor driver uses the following sequence for the power on reset:
> - set the power on reset bit
> - wait 500us
> - clear the power on reset bit
> - wait 500us
>
> With your change we now:
> - wait 500us
> - clear the power on reset bit
> - wait 500us
>
> I don't know if this is sufficient to bring the PHY into a well-defined state.
> Maybe it works, maybe it doesn't reset at all in this case - I don't
> know how to verify this though.
>
Initially, I tried to some bit mask code to resolve this but it failed,
So no harm in keeping the original changes.

There is another parameter REG_CTRL_PORT_RESET to be considered.
>
> Best regards,
> Martin

Thanks



-Anand
