Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549473D3847
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhGWJUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhGWJUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:20:07 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041E5C061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 03:00:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id n10so1044428ljq.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 03:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55qDSs4WDIz8l0MaQDVpOoMRLPHxzbPjJoCBzhMJJ8M=;
        b=t0VfOY5DOKMdO4UZ1wz28sycelxsa11TOCksLBsdZvZvMQczDIGKtx8a1UoVG9f66L
         HD9XcjArtzwd4DkawwmM7Ns3/zOmBlp9BjoCfp50P0tPCluAXaDENmo+OdXQaKFZr+nk
         F/H4rNK4st+nQz7TOK2RYbI371Yf8TSV1jwBbtTGiDXTBUmFgS2Nn0HsAFdxxjvU6pgQ
         cbal5cDj8lzKLeh6gxijirLZ1zrY/XRiSczqnT7AwxoX9rcErjkjEMqa0vpOhEe0jxnp
         WhCE+9N9OH2OFjzTMp7OJ/es6gvK7YIqqfWWyFRHxn5cjSOaAwP37M/kgQXO70hdNT+U
         M7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55qDSs4WDIz8l0MaQDVpOoMRLPHxzbPjJoCBzhMJJ8M=;
        b=JXIt4fc3OT9a4xCv19C6ZRXGe2QUp5SU+l0cSiXYxE40Mo3zxd327CdJIDXBFSVyZQ
         OqaQhImd5MsL8OHU/PMLtU9AWCHXowtCaj+tdFmnLhij6Wh8V4You55OKjONDZ+iae1G
         AKXPOlBrqpCsOyGFBlOOuBd1GbiUFPltxRAog33NSZKBGn4RjZSirQc9CfjXpG1wxAuk
         0YlPDxcCmWPoL5GM44YdkLoAlvslIErzJwO4zBdar0kzbFCrpV7DgW8Ek+IB25sWTTqr
         GwOcm1yl2yNz8jLLX6cVXd0COhsCF1wGObhB8vjX8o4pdpi4i6Z7vZt33WFFddqfAUsY
         I3Sw==
X-Gm-Message-State: AOAM531LvV2kYc/aolMJaMcwSXw8p0UhT9QvtGXTXhk69Qx21hQwEk4u
        YOFohBMdxk83EhwvhhMhFDNhJ5AZ9LHc3+mK8XwGoA==
X-Google-Smtp-Source: ABdhPJwmAzTPEt47e7H6MBHXMnZLqcBXHqbxHBeC/SzF8xZtLU2Y144wU08Unv3L6vzEGejGY0moi+vwH6czk+js7FU=
X-Received: by 2002:a2e:9d15:: with SMTP id t21mr2854482lji.200.1627034439330;
 Fri, 23 Jul 2021 03:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210712100317.23298-1-steven_lee@aspeedtech.com> <20210712100317.23298-10-steven_lee@aspeedtech.com>
In-Reply-To: <20210712100317.23298-10-steven_lee@aspeedtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Jul 2021 12:00:28 +0200
Message-ID: <CACRpkdZkcQyN-JuNF24gHkNOx3uk9PEWD18-0k49fV-UO=ZB2A@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] gpio: gpio-aspeed-sgpio: Return error if ngpios is
 not multiple of 8.
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

> Add an else-if condition in the probe function to check whether ngpios is
> multiple of 8.
> Per AST datasheet, numbers of available serial GPIO pins in Serial GPIO
> Configuration Register must be n bytes. For instance, if n = 1, it means
> AST SoC supports 8 GPIO pins.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
