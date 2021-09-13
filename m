Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7E840A128
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 01:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350145AbhIMXCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 19:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350111AbhIMXCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 19:02:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF4AC08EBAC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:41:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y28so88979lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upRGSvfI0tAPjnVdV7FbBFHnENJLudrtgzcATKEHgT4=;
        b=h6B7gVAlebvZcb1esp+vXodBjuwKJessM+ghgQHzsD2ni5g1VZIhBt1OuMZdSxFiJT
         KrcE06Nx4XN6B3hE3DaVjvWQngWHvaeDrVMR/JIdFGDUrJm4iDsrsiCjudkDODl+IMdQ
         wL0xPxFV8pVGbKQmUGZ0y+TxSddLlmi0VmiMbEOFpsnde5Y/PILjYRzpS8lQKDjXk1ln
         XKztWgHmLeuhiforjNPCPqP34n2dvpb4gTsJpBthdvpYPmyORkm/9SqXVnqCAZoZxlEe
         Imxgmf2pxNyKrAC2n7j3AgkieIgK2PiKv8OUYPM1HiDNJ0+WM1e0RHxKerKfc7VYorp2
         kDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upRGSvfI0tAPjnVdV7FbBFHnENJLudrtgzcATKEHgT4=;
        b=xUlEcqyIH+GEf6pWM+gx74pRbT/gwR/fWarRY+wwhXLS/Naiv061NNrxE9m+NO3zRR
         0Fb6TOkjHg5Zg3mUVeDo+422/m69KM3fsRKX1BO1j1bxf3O6whKdjVa8PE5y7slUK/CN
         eSk9AQpG8qzI41dJaNKVgcgXEw7TVuWoMoQW8rbOW2LGjHNKSb6K9FhnrvxXiGHnedeN
         PLcEQKRBGCckauDYavkQ+9gRobltRoMaRUct58xplqEsR+aLEVoXSFg9/P/pl81s0gvu
         qt/L8AwD7ViA2NxXW0vbA3ZdfR+jQ2OflAUV6Vm19pR7qenxYky2YHA8ZUlR6hqcF9UJ
         caxg==
X-Gm-Message-State: AOAM532hJVtcwtFY+YNPq8/7DgmYR1k4yezL+g1cc6iHH/slzmDF2fG+
        BEBW4P9dMjZHG6ZoD2bo0DnhgIWpi3iZdYAjmJC9iA==
X-Google-Smtp-Source: ABdhPJyClz/wdZ2qN3qY1qOBTysf44ukjyOseGX9SIs771urlmNDjXsAudAHpy1eyUkJpyeI9gvh48oOwTuyy7n4LA4=
X-Received: by 2002:a05:6512:12c4:: with SMTP id p4mr11067299lfg.72.1631572901904;
 Mon, 13 Sep 2021 15:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210913192816.1225025-1-robh@kernel.org> <20210913192816.1225025-2-robh@kernel.org>
In-Reply-To: <20210913192816.1225025-2-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Sep 2021 00:41:31 +0200
Message-ID: <CACRpkdZX6_rBEpScxSjmiBQr_cCY9mSipm-a5B8nFRLJVBqXaw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: leds: Convert register-bit-led
 binding to DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 9:28 PM Rob Herring <robh@kernel.org> wrote:

> Convert the register-bit-led binding to DT schema format.
>
> As the example just repeats nearly identical nodes, trim it down to a
> few nodes and use some documented values for 'linux,default-trigger'.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-leds@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for doing this!

> v2:
>  - Drop undocumented linux,default-trigger values

Will this lead to warnings? People tend to want to use these.

(Possibly we could actually create operating-system independent
triggers that make sense on any system. But it's another can
of worms we don't need to open today.)

> +    enum:
> +      [ 0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80, 0x100, 0x200, 0x400, 0x800,
> +        0x1000, 0x2000, 0x4000, 0x8000, 0x10000, 0x20000, 0x40000, 0x80000,
> +        0x100000, 0x200000, 0x400000, 0x800000, 0x1000000, 0x2000000, 0x4000000,
> +        0x8000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000 ]

That's an interesting looking enum :D

But I can't think of anything better, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
