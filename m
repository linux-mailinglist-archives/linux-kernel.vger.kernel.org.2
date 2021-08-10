Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9D53E5A15
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 14:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbhHJMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbhHJMjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 08:39:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF263C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:38:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z20so4050186lfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqPESqjgmWgALZq9dnXABMl8Vg5hguPUvo5W3Xrxf3k=;
        b=JVbUmhAH5zgYRhQNH4gd8yXFNNsCDkA64qbCAMYGZ223wkQ66XkcYiSesU4Obq4nIP
         xRBxrBrR8dWNDkg0njCTspEINYS1iNM5Qb+lj0e6Z5czdOFOIxuPIOYSuqKOXMF2sRnw
         7qPGKb+SBNOKbS7wpoHzOLzUW+CFPlpEL8P9cDPOdH38wpHuJecC1Qk7iIF2/7jkSg09
         4omrE9BIDqGu1dvL8fOijxPvA+rsqmUJV5InTLeRAhXM2t5Sc5pLnDedWFmlyNSu664w
         9GFzTmD5eQp8pkEgZry0kD7ALm9drjOFV2ga/m0JyM5V3CEoG5V8QQBt2V+p7XHAvv/Y
         Ys/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqPESqjgmWgALZq9dnXABMl8Vg5hguPUvo5W3Xrxf3k=;
        b=ae3u32WOkC5XBF4L6AC7QDk1FvwIIXj7Al0VWWO74Y15YgM5iu9oltPBCAKQJDbxOC
         vJhLMJa6Rv3/0ZWkKWgAPaKx9sGh4cuZbWq/eSCS9ZWwkK1XfLlU4Qp7jpf4kLrqu3sI
         +FnHwOJi6sPAzZiHp39X0Wm/xIicDVZZequV+SzwkvORyb3isTIbj2jR71PJHB0qEZtr
         6mqRJhI2bsyRjGXrIGDw5NU+j+0/BWO/OlYKINxeMZGL/i0YbSQ8ZsDEdldW8H7cIPT4
         +USSPy1kyVq2QY5IlMwpt3ReOi7b+JBar2no9uBg6aMLxe7VGE+pfaDQSx3GSApL8wxe
         G0xg==
X-Gm-Message-State: AOAM5322PlkqYuKtgkN3E4mgeQJ14gD4lNGBa0u5cY2Y15yFerkYOz1I
        NqISBV8WTPQ2dvHJkHvxYPLFJjOkT5Jt+YnqDZ4HDw==
X-Google-Smtp-Source: ABdhPJxCH32JmAlqn5LAdRI634JOmrxRSuLk6eTMuhYyoMuTesZ8ZwY0luzOzNE+RnBim73zKfg6EnPTOK7Nv5pLy2E=
X-Received: by 2002:ac2:5d4a:: with SMTP id w10mr21903717lfd.529.1628599122109;
 Tue, 10 Aug 2021 05:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210629003851.1787673-1-bjorn.andersson@linaro.org>
In-Reply-To: <20210629003851.1787673-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Aug 2021 14:38:31 +0200
Message-ID: <CACRpkdb2BZ4Cpc4zm+rTyxjr16Z4ZJGSN78wKmQxZOAdQ0o7ng@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: Add pmc8180 & pmc8180c
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 2:40 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> The SC8180x platform comes with PMC8180 and PMC8180c, add support for
> the GPIO controller in these PMICs.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Patch applied, sorry for missing this. I blame stress.

I had to hand-edit in the DT changes, not even fuzzing worked
so check the result.

Yours,
Linus Walleij
