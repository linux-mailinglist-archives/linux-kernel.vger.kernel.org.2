Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2846C3ABEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhFQWfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhFQWfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:35:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DF7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:33:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s6so5872538edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaoP1XPBwGk1yK5n09/1HQPhsRu1MIRshfXxsvpXFEY=;
        b=AuD2WdEmm3enMlcrr8WgqrpyI6kR1vZW7RtXxN7W1WvwB/4/+XMMUMSVDGN7mp0ZCo
         2IDJMrYjYjClOYU19NJnG8qCyB41siT+DQ9ltGLm3gpGXcJpCLtlmAFhgSQxJnUjZtTU
         0F58BykXf/Ihm45GNEvbJdkG/NBf4oa+4AEur2xLoT+WmGhxRNm9NemCGoaKMF/oWtQV
         iOCKGr5lf5NCgHGyWvmy5J7BSpJ5J600tdiHjyX4hN0C+J0MxOp2tTv94KunSanPfEHV
         sK7oGw/gFHqiK52SyahSOWZmoKPQ3KOZmLLT+A4puT069ncGTav4cWjRwbe4j9kJ+QAB
         hFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaoP1XPBwGk1yK5n09/1HQPhsRu1MIRshfXxsvpXFEY=;
        b=d7qoRvd4yokCeh7wJP9ugDnOz3s9P1EmJJYg8mmqlZ3IWffoA2nWSWT8hQojVjAz1L
         7n9/t446jLVT7nJ3rVi2GSH1IpIhV5cwrU4HXDCGbCjssje06xjKiMIONWQnHruweuWq
         7sgoqbdYodpI7XgMVqvUHFO4C6XD7/b5G+sCy57GEqoou8uRlGnW0RaSnzW3wTRlTPcV
         yrSIvQQZuhiIIYVMTL2T3Ymj5ohsvJm8brKfpVMcmIJnAAwtEFWX9zigEhOtUEXjeUrb
         lE0zdVNMqxeoQ4TIqyND9nxK8oj3g9uXaTg0nlS07H5floznAj8vLj3IQTv2jBw+wN5d
         CNtw==
X-Gm-Message-State: AOAM530qnHZAvRc9CweeG+FmluYMBXvyS2W0odFV4ntux5rBbCjcUBMJ
        j0d/1CIq8xr8CKpyhrj4Ib0cPc0CVlmPBp0ezI0=
X-Google-Smtp-Source: ABdhPJzH7Auby+UpfdN925mgN1EmQk+eJ1uoHhcMCWAa33jXnDkaDWCJ17XcAI3qk6jxhazLHLxEu83SYBoFGqBA38Q=
X-Received: by 2002:aa7:de1a:: with SMTP id h26mr812353edv.176.1623969214809;
 Thu, 17 Jun 2021 15:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-2-linux.amoon@gmail.com>
In-Reply-To: <20210617194154.2397-2-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jun 2021 00:33:24 +0200
Message-ID: <CAFBinCC4_bsTEwj5+=iH-ZF3LpSzSjN-x44Yr_XU4R9=Wzq-Mw@mail.gmail.com>
Subject: Re: [RFCv1 1/8] phy: amlogic: meson8b-usb2: Use clock bulk to get
 clocks for phy
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

On Thu, Jun 17, 2021 at 9:42 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> +       int                                             num_clks;
> +       struct clk_bulk_data                            *clks;
personally I'd get rid of the num_clks as this value is static
instead I would add a #define with the number of clocks and then...

>         struct reset_control                            *reset;
... use something like:
struct clk_bulk_data                            clks[MESON8B_USB2_PHY_NUM_CLKS];

[...]
> +               dev_err(&phy->dev, "Failed to enable USB clock\n");
clock -> clocks

[...]
> +       priv->num_clks = ARRAY_SIZE(meson_phy_clks);
> +       priv->clks = devm_kcalloc(&pdev->dev, priv->num_clks,
> +                                 sizeof(*priv->clks), GFP_KERNEL);
> +       if (!priv->clks)
> +               return -ENOMEM;
by using a fixed-size array as suggested above you don't need to
dynamically allocate memory anymore


Best regards,
Martin
