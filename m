Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A693ACF29
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhFRPfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbhFRPfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:35:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E373C0617A8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:33:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r7so9147524edv.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7+uP79JThVaX8f53c7eMngvAvys/A7Np1BX1mntKjE=;
        b=mRLykS7ioyfUInLCKyugxfYIbQA1nW7S1oNhEUyFkiSp7eggq3BCN3mamatVEHbwvH
         sp4rxG+AX6EV/kIEvdI7+nPD6iVJU3/mhL3KvRMXMyTj/erLDUE/3q1QDNwhRjzLpgLb
         yUfFZaEEO5KIIUtp7JuhS5Rgv40SLegrVmV4CoHEBheMMkVvmR2k+7bkwMho5/kuXodG
         IyiSjFjRXWQeoxJ6PVHHAY6Y9bnDiIiHWaSZ+gdyBu/O1GSMfoansFSBGUxOqtpntgj4
         xuYw20gmMzVdOFH3POAEcLJY0G9mNDR7wK49JcXX4YqhOGy9HnmezEoQTKegD6O4kHuD
         dLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7+uP79JThVaX8f53c7eMngvAvys/A7Np1BX1mntKjE=;
        b=qtZMVmX5AYVvlSanC8zjcrIUgR0Y+kUZYZD5Flu+FISAPpICViUsCKDGkybf1m98tJ
         O/ORsYsQi/XWvPMHzckBgGXM8tecctRW3jup4ZH+32S+mrvzj2KEVVykMJzvHzuopT8D
         QpaNnH/TwDhLc8n/Byhss/UafdjdYB7ycRWmZQxLnDtF5lDv3vLxxZzoewYB+81S41IG
         tXi+pqtTW7NFlKM5f2UqP1/7q1EN6/Lx4jch0iRe6BXzHndUt12vNLMyXmw/domu7HU6
         O32Dq1Zn5IUrFT2mXH2zENr48LG19QIDQIjqyXctvzXohk7E/oUAX4cl8pW+oTPwPfb0
         lyoQ==
X-Gm-Message-State: AOAM5325c5jWmCrdp2O0pVWBHPYootQNghzfonyc+LjbBa+6wLMEHZmZ
        U/G61sQ9AbrcKfewuZvs3xALwz8utTeSlBEurDE=
X-Google-Smtp-Source: ABdhPJzVpYdl46kNg1iSo7yUJy2SDRIUByyY0vMTJTeroezDWoNPYoH2CNyDv8bb6R/+Yej27Wl9gPheNol3ueOZCCk=
X-Received: by 2002:aa7:c40a:: with SMTP id j10mr5732813edq.59.1624030390723;
 Fri, 18 Jun 2021 08:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-2-linux.amoon@gmail.com>
 <CAFBinCC4_bsTEwj5+=iH-ZF3LpSzSjN-x44Yr_XU4R9=Wzq-Mw@mail.gmail.com>
In-Reply-To: <CAFBinCC4_bsTEwj5+=iH-ZF3LpSzSjN-x44Yr_XU4R9=Wzq-Mw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 18 Jun 2021 21:02:59 +0530
Message-ID: <CANAwSgSbr-NZknhQXjhNQiDcz9FNOdFjZKsHhBk3bbEt_UCCEw@mail.gmail.com>
Subject: Re: [RFCv1 1/8] phy: amlogic: meson8b-usb2: Use clock bulk to get
 clocks for phy
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

On Fri, 18 Jun 2021 at 04:03, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Thu, Jun 17, 2021 at 9:42 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > +       int                                             num_clks;
> > +       struct clk_bulk_data                            *clks;
> personally I'd get rid of the num_clks as this value is static
> instead I would add a #define with the number of clocks and then...
>
> >         struct reset_control                            *reset;
> ... use something like:
> struct clk_bulk_data                            clks[MESON8B_USB2_PHY_NUM_CLKS];
>
> [...]
> > +               dev_err(&phy->dev, "Failed to enable USB clock\n");
> clock -> clocks
>
> [...]
> > +       priv->num_clks = ARRAY_SIZE(meson_phy_clks);
> > +       priv->clks = devm_kcalloc(&pdev->dev, priv->num_clks,
> > +                                 sizeof(*priv->clks), GFP_KERNEL);
> > +       if (!priv->clks)
> > +               return -ENOMEM;
> by using a fixed-size array as suggested above you don't need to
> dynamically allocate memory anymore
>
>

Thanks for this tip.It works for me.

> Best regards,
> Martin

Thanks

-Anand
