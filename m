Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EB035A963
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 02:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbhDJAH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 20:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbhDJAHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 20:07:52 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916DBC061764
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 17:07:38 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o16so8397363ljp.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 17:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJNZvvQN4sPxM5wTrNOHML+RfF3Y8nDwxuD/Ny2pkH0=;
        b=XzsZoxckL2/lWNBV343T7e8p1OP1MEHfrrQySw3QeHFDCqhKSGv5/ETPu7lgi9+czL
         GCzTdNeJ/sv/szktTSmrR+2owxPBidWWcD6smgH2GCf10wu+l/4m1VF19xWl+Ip+jKLD
         K3ASd9yBJP8nC/sqUXiJNPb9ltqdqFHATegBbiYog/mmJV/XgUf9NGrOm2OOBr3Q7FUe
         1VGb0vo1Cwu5lWjTA+c7G8wgKFe9dw1cSOeyD/vvZL52W5BuLlgkL3qx0LRPCc5TVS1V
         KJN/jbBMZ0u+ZiWmtlTs23MUBSHUYzcx61NGUwKFwZ0xrqON6F5TzDVxbVgCW5wzQL0l
         TyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJNZvvQN4sPxM5wTrNOHML+RfF3Y8nDwxuD/Ny2pkH0=;
        b=BASkaMNIVmKp+eMU5IJO1J8RmCR3mVwv9doc6xS9A2SnVVvkWHEIQteUn9kd1HlRWZ
         JTDbej0Wd1xTOcqwwA50qGnKRRJ0u3xLt6v/temwG7TrClnPpbFCR+1Ce4bnYW44gxRT
         rYC4RhiX+ixaCbkGOGUN2YciXKXRFszgaZlgich+MocMCtM8q0nUiS84RcZsMEwAuQJK
         +kICgcKy9INCI8NKZM89fWIOO+4p6Hs6p9Id2b215n2YbXcr23topxVaBkqQpZexZRds
         FE22z0Mvdk/0Yvlt3tsZ++UQ+2rYBhpyKj2qdGuSA05drLANRFozFfO3L2GPBr8NjHMZ
         TpvA==
X-Gm-Message-State: AOAM530ZO7Ay7jnsilsP7gCkiLtCbsabsnPpWY2rkH2Ik/iL4yX8zQiJ
        RO8jPny/aP0MI7RhLE/C4cczR2aJFx63fF4vSta7LQ==
X-Google-Smtp-Source: ABdhPJyi9BNKN/wSUa0cnqzp5rwoSw8W2ep8I9VXh2Adb4f1hRty42wJTvzb17wXiXq9jMTCp9/8ZZiGbZUTThq0SQQ=
X-Received: by 2002:a2e:7001:: with SMTP id l1mr10693204ljc.200.1618013256948;
 Fri, 09 Apr 2021 17:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210408195029.69974-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210408195029.69974-1-krzysztof.kozlowski@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 10 Apr 2021 02:07:26 +0200
Message-ID: <CACRpkdYm0yG7mC0H7YwgQdPP1eT=GSkvHbohA7jc6LDsVPsZBQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: use 'int' for register masks in Exynos
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 9:50 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:

> The Special Function Registers on all Exynos SoC, including ARM64, are
> 32-bit wide, so entire driver uses matching functions like readl() or
> writel().  On 64-bit ARM using unsigned long for register masks:
> 1. makes little sense as immediately after bitwise operation it will be
>    cast to 32-bit value when calling writel(),
> 2. is actually error-prone because it might promote other operands to
>    64-bit.
>
> Addresses-Coverity: Unintentional integer overflow
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
(...)
> Please apply it directly, I don't have any patches for Samsung pinctrl
> in my tree.

OK! Patch applied!

Yours,
Linus Walleij
