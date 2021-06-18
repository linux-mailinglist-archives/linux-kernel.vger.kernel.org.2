Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650263AD361
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhFRUJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhFRUJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:09:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E059DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:06:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t7so10162086edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jd6Y9FdRbI8WadsWZ8AlDZHBohYqsQzy8vJ8yBRlmjY=;
        b=NkcH1LO5w4su6nqdC6W+7rrRp4CL85LjmCG4Xm9yjd68m/9Qu+lZD/z92BsQP8JIFT
         rnQNsTX5bLt9tO05Yg5lD58qMlFRQe0oFo0EXj81q5Y1UAXZ8vVNN+ZKY/7o0JumIp4g
         m6laKU+RGHL626SDXA0pPxO3WwVGtR55PmY3gLFLazY0NmL4tompZZnpUNvpZQitC/ac
         EIhxE/KEfCAzsZFF3hazazsBGqFPLd0qJTK5NZv8mQUXil25YRSS0XdtC1zjE1q/3ioh
         GzibQePBbyWvj3biOHS9oVhvWi0R6eXe0AgFA+CkVdTr80uIpkFzzpkpOlXCTf2mH66g
         UtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jd6Y9FdRbI8WadsWZ8AlDZHBohYqsQzy8vJ8yBRlmjY=;
        b=lnz+gtcpoHHPmkTCU+VGjrUu+D8IUdJ36tpKgHCBm4XQ7SCe0+H3xlJd6LZ4FoCwuN
         ZyS0ZpkV3JgJCoxVHtw69yl6U53Sm0FzU+8vCVA+XTS4WB+cx4JbDQGQtZMexuruqWo/
         nsvQ56j4kkL6TgSam91T/SyLw7Ga2PsN38+R+h3BOaeQ7Rrbg8YQTy3L8doKrRpNUv68
         2dThzAYTRydmXwLq4ijKAGr+vplOVBfdt6ZWM7ia4EsfAU79cVTB65MTkIoB7ObGoUSY
         ldGae5R8kirRdVSnPQd3ytt0ODhxsiGMY7eK+7oxDNcOK4EFDgLoWC5qazG+3v0rXVn8
         1fPQ==
X-Gm-Message-State: AOAM530x1kYMnEIjbgJmXhXbf3yt3IdwCr7fS7AXLMBJvsales/t6JD4
        MlGzNUqwVJWMwVTCNX/T6qjPpYwv7cN7W0pRlaE=
X-Google-Smtp-Source: ABdhPJy/eX13COPO4fwgWcbKjgdq/roFKgUhw73XmjuLqQVOrKeFvYgYKC+Ud97JzQ6PtlAQofSyde0mLEhzq7onpSI=
X-Received: by 2002:aa7:c790:: with SMTP id n16mr7323619eds.98.1624046815446;
 Fri, 18 Jun 2021 13:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-7-linux.amoon@gmail.com>
 <CAFBinCCE+6G7QtDoxfbcZVVRf-MDX-epSo=_k_PJZgWX+_Whvg@mail.gmail.com> <CANAwSgRqixugUr-t2OheLBVwD=EOkaLqxnGkT-Bx=p_A4Nyr8Q@mail.gmail.com>
In-Reply-To: <CANAwSgRqixugUr-t2OheLBVwD=EOkaLqxnGkT-Bx=p_A4Nyr8Q@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jun 2021 22:06:44 +0200
Message-ID: <CAFBinCALsnpbJGEb4LBLd_jy3E8fOZAQaacz-P7ijfkeyYg2dA@mail.gmail.com>
Subject: Re: [RFCv1 6/8] phy: amlogic: meson8b-usb2: Use phy reset callback function
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

On Fri, Jun 18, 2021 at 5:33 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > For shared resets (like the one we have here) reset_control_reset will
> > only trigger the reset line once until all drivers using that reset
> > line are unloaded.
> > So effectively this new phy_ops.reset callback will be a no-op.
>
> I know his register is shared between two USB IPs,
> but I have not observed any issues.
have you checked at which point we're then actually triggering the reset?
I assume that you will find that the reset is only triggered for the
very first power_on/init call - which makes this patch effectively a
no-op (yes, we're calling reset_control_reset then, but that doesn't
mean that a reset is triggered on hardware level - see
drivers/reset/core.c at around line 346).

[...]
> > > -       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> > > +       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, "phy");
> > I think this breaks compatibility with existing .dtbs and our
> > dt-bindings (as we're not documenting a "reset-names" property).
> > What is the goal of this one?
> >
>
> OK, If we pass NULL over here there is the possibility
> USB phy will not get registered.
I don't understand why - with NULL everything is working fine for me.
Also no matter which name you give to the reset line (in reset-names),
it will be the same reset line in all cases. If it's the same reset
line before and after: why is this needed?


Best regards,
Martin
