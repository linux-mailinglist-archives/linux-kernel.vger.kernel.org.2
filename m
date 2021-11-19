Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5674E4567C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 02:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhKSCCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 21:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhKSCCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 21:02:00 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED04C061748
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 17:59:00 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso14318192otf.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 17:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxrvQVF4m+QropEcfFogeAEuTKECfRdkgZwzd9IzrTY=;
        b=qmbmNijJFXVueQEeCkVZMl9HEyYSS88lgyh02VxPk7XYJ9R2Ott8UtcJh+tk7QOsf0
         REdukpk7uYSqlK4IKNpEKPS/Ipuec4CwCOIb1fLUc1xCeXKG7fhq0S1ZfhVxkDmLG3Je
         wVbJ/mC9FVT2/lexDnWW2Khc4F8lyISisxsiGFpydpT8PjMK+/IhEMbGbag0HyQJJ/6c
         Pxq1CzLaCI0xe+4e/r0dJJ9emSlXuK99Mm8K+cJ6yTMqpINU4iydU8NDyq9kBZkfkqUP
         vyAu0BwCxsgx8ByQkfkCBOAcrmu0y1zo9acBpy80lk+3qsyv9PtXFKU2sdyY/RXg4k1j
         QKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxrvQVF4m+QropEcfFogeAEuTKECfRdkgZwzd9IzrTY=;
        b=BxiOgpui0KsjYuItI3JToauYmSNCDQ/0scQD8HitcBdoxKZP4eM4GTMvpL6oe/q0Z9
         RRIXmXN8o8cRG4whh6nzWpaTstl5jD8Ep/dbchqoX89Vs1YTQE/MyNT1yk3Q60d9BHuy
         8lV+jHQP+aVSrFeutDFB5QoIsN6RI386HZb6F8UU5f8mpA+nq34FqT3ARGZ40AkwM/Nv
         5SAoXDbQ4cklvKaUzbRcwsoV6kPa5+MGjPM9/k+uUree0726081Rp+uU2UH/x5q2oXFG
         9kZujnVojfbKNwHzPmhr+wYfmWWlPEQ60k2rNV8SHLuaPmgL10t9gpUf3uoP67mCQuOc
         SkdA==
X-Gm-Message-State: AOAM530YOIo2iRd9ROYDFxV8+h2wyM8w9CYl7A3HcZMOyBpU/4BeE5Ud
        +ns4O+U+W2WFn9FJW0bUaUexA1QnLvcLfusjLjkikQ==
X-Google-Smtp-Source: ABdhPJzSFZ//VcGp3AB1vc1IzBZbVM7vx0cGqccethKqVq73UW3XVPTuPDlEDoJKJOKhIjVIp+D+2yK89HGChzwnLWk=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr1540817otg.179.1637287139427;
 Thu, 18 Nov 2021 17:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20211116062328.1949151-1-colin.foster@in-advantage.com>
In-Reply-To: <20211116062328.1949151-1-colin.foster@in-advantage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 19 Nov 2021 02:58:47 +0100
Message-ID: <CACRpkdaFmFFpYrreFsD6XRPAoivDPK1nSfAVKacNG8bWUR7rHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 net-next 00/23] add support for VSC75XX control
 over SPI
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

nice work!

On Tue, Nov 16, 2021 at 7:23 AM Colin Foster
<colin.foster@in-advantage.com> wrote:

>   pinctrl: ocelot: combine get resource and ioremap into single call
>   pinctrl: ocelot: update pinctrl to automatic base address
>   pinctrl: ocelot: convert pinctrl to regmap
>   pinctrl: ocelot: expose ocelot_pinctrl_core_probe interface
>   pinctrl: microchip-sgpio: update to support regmap
>   device property: add helper function fwnode_get_child_node_count
>   pinctrl: microchip-sgpio: change device tree matches to use nodes
>     instead of device
>   pinctrl: microchip-sgpio: expose microchip_sgpio_core_probe interface

Can these patches be broken out to its own series and handled
separately from the DSA stuff or is there build-time dependencies?

Yours,
Linus Walleij
