Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633973D3834
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhGWJSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhGWJSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:18:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0817DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:58:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z2so1214880lft.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXuM8D5k6/Yl7ozL3DfM+PVJYiIerLcTEkx5mVID/UU=;
        b=NGgdq7v+o5iqkF3EI+m7OhMam7v6/wLB+PtgVWtPK+zgiAfitTZEjpKoG8KZfnGRZ0
         XJ8xuYkmi14aUj966cwbUP99rci0Pn0csyZhH9ZTUDnuQSS32kadqR3lypzYlQJVtsnM
         M/Ob2kqRn3bnETXtydx4LmnRgUUYyQCgOuGSK3GFT7vITGtGj0rltsuaNPV67aIl2IPE
         bHvysTHvHR7wop3cRkd0567v6cxdtTxGnhtE0ta1ytVcgpKU5CaZP8raw12NEl4CmFcw
         RqAlqSRFEHdmfT39ZgMX58L1/MNwxVvr9JKjOeHcHDvcFn9WS2ZMo7vYxE3BPlFA+Tmq
         I92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXuM8D5k6/Yl7ozL3DfM+PVJYiIerLcTEkx5mVID/UU=;
        b=rIDHTxJFNq/vxJrf96j/Xo/zQMYwBAiG0lqc8Nu6tznZJBxBpplneBPC5gjP4sv2re
         t1nD/hPqZmyr3ndhkQ4Ie3MZ/jVb/6dD+qQjacfSXKAHMn9B1BLCKoIqm/Ujgb7+9vDu
         HWBRsTs7CpWFYQaI+Imd3zlHP0SqUDaWJGqGN1YPefk9gocbXmQiZ3F9HsObofttDGOD
         3LIXFCsApJiVmnELZZxSN9tduMhlZrldgSdT2PLCrOJN01/ELmTnp/8K00mjisYJZZ/x
         Kx185p83Hd9SqMvCuI/QVBypFoaQkCNBHB9oG9C2sKPhmJoP2ar4QkcHsAc2A/RshGG4
         ahyw==
X-Gm-Message-State: AOAM533qZ/+N+72W2do1Skj2agpj3pWkLEA4OoDSHjYokHcV9ePb9kD3
        p+4A5Wwr0c85JX6ebsfNQ1hv0iP8rCYpfwZMydcV9Q==
X-Google-Smtp-Source: ABdhPJzUNSEtuAGq/AntijcVwb7VOysRbc8PRRpm+HrzsTl4s4LzDpYbxtndNsmw3C9e7zr97SPpp9rInqEhXg6DtRs=
X-Received: by 2002:ac2:5e71:: with SMTP id a17mr2434778lfr.465.1627034325426;
 Fri, 23 Jul 2021 02:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210712100317.23298-1-steven_lee@aspeedtech.com> <20210712100317.23298-7-steven_lee@aspeedtech.com>
In-Reply-To: <20210712100317.23298-7-steven_lee@aspeedtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Jul 2021 11:58:34 +0200
Message-ID: <CACRpkdbKyV_Crw8MS63SZGf=nKztDkKnJgRprLdvXe0u7BmVNg@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] gpio: gpio-aspeed-sgpio: Add set_config function
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 12:04 PM Steven Lee <steven_lee@aspeedtech.com> wrote:

> AST SoC supports *retain pin state* function when wdt reset.
> The patch adds set_config function for handling sgpio reset tolerance
> register.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Excellent reuse of existing pin config property.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
