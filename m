Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A923DB5A2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbhG3JGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhG3JGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:06:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EEDC061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:05:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h2so16548972lfu.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fjXkwTW0XnvdKErYY4YL2ErCAYkMkBwM+Rl2m8Fj6I=;
        b=eGvLfG7jvtnjTQ7y+uCAzJHDZINAwVBBBlKWuE7mlsW14wdA2ixv+vViZ8bNRmLRFU
         LcZoDot0roZma+aktjsr9qvzqe8VziNoIxS6VbmN/Ana/GyH3CH2OW5qUr74F+/Ta7qV
         vC+gStNco8y/HFqsuHSWQXiHCoqm2WKHBfHpK+PodFsejdDk7xYD8NJ0fkdozpy5zQUu
         7H4wxOHYbkp987bOegnd8nuNL4HbDbj9g38tCQeSg2sX+1DQUFUdUbpnCAR+TwYhIWqu
         wnQepbb3xRK2LFHiVbYJaR1RDMCVGatNdlDwUrBc9nVMV0ZB1pg+jhVJts5TEcUb9qkV
         Li3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fjXkwTW0XnvdKErYY4YL2ErCAYkMkBwM+Rl2m8Fj6I=;
        b=uVQi59bw5Jcsqom9JWJxqKHfHqHBz/9VJ5fl/hYvp1En13s/dkKt7yEs9Sar5hPYVN
         j9sjBLAsnIco+ZGQAnGwZ2uY8I8Lms37oN5OPVZm5X4U1722w1sgMr7Vn9cXKN/k8HRC
         k2G7Ej1eJwqzXnBynVxqmG3dTppnNXqWl2Q3pdpjxV1xBvtsfIsUi1e5qD1/ISVekPbJ
         grYUV0d5icr66XOegsRa+Ne582Fjgu1JG/gSqsR15PkGijy4B1i4ZRPK6GX1uKJlir0Q
         rB4DLF5XZL9UK960g7+5sVq5G4STSXDmTuBcsn+dx8JmpmNkVQUueOgq0p90tfQhP/xp
         yRqg==
X-Gm-Message-State: AOAM532+cM/Vk0lZNcoMoon+BJqH20M6omfgfU8Zswse77LvkLKz/lmJ
        ChT9Dxa8fgsr2V2BUikL2bMe0R0LooX6ZRZBu0haqQ==
X-Google-Smtp-Source: ABdhPJzIglz1+X4aSDlLJ6cYQdggCLwPPABBzmggXznaSbU40ecn/VSlTll3FYW9jH0fHE4V0yz43gnugLU0kCh26VA=
X-Received: by 2002:ac2:5d4a:: with SMTP id w10mr1160863lfd.529.1627635954345;
 Fri, 30 Jul 2021 02:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210716162724.26047-1-lakshmi.sowjanya.d@intel.com> <20210716162724.26047-2-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20210716162724.26047-2-lakshmi.sowjanya.d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 11:05:43 +0200
Message-ID: <CACRpkdZdK38iwwCQKqUQ1Xbd-5kf8NFjAxT8pvq+e7jT+wiThA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: Add bindings for Intel
 Keembay pinctrl driver
To:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lakshmi,

sorry for slow review.

Since this is one of those "Intel but Arm" things I don't know how
Andy feels about picking up the patch to his Intel pinctrl tree
(I think we discussed it in the past) so I need to know how to handle
this. It'd be great if Andy queues "all Intel stuff" but I don't want
to force unfamiliar stuff on him either.

Andy? Do you pick this (when finished) or should I?

On Fri, Jul 16, 2021 at 6:27 PM <lakshmi.sowjanya.d@intel.com> wrote:

> +        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;

Did we discuss this before? Are these hierarchical or does these IRQs
map to more than one GPIO line?

If they are hieararchical then the driver should just pick the lines
in hierarchy from the parent with no data in the driver, but if one
of these IRQ lines maps to more than one GPIO line they should
be like this.

Yours,
Linus Walleij
