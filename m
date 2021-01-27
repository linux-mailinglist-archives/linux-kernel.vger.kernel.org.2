Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E083066CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhA0Vvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbhA0VvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:51:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509DDC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:50:31 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id v24so4806744lfr.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXnYo/XJRlIPCj8X2tLXK8QJF68OekDoMODkg5Cs0to=;
        b=pg/6iGqfQaKlxtC68K+rAGE0l/r+jCk3jRYKTNxeIe/kGFvlAozMiF7FkhXAwDotpc
         sq0SEzqhWBoliRNAZ2d48vK8ONUKg36SPHiRRD2F416LQhXC3HBvWXWjLzFPZr4wJA9T
         w3DEUyCGwbxMwEcr7ATZqBcqPcav29/24zG57LhL5q48JBKEkCeQg/SQFgByG/CEKAFm
         pyJ7PUnX75Ti8dA5e+cN3b4p3CqM8uKn5lfkttlyKoCF38gcfbgWrfceE8NWN7Zgsl0v
         9d0mpuMOcSA4KaT+K1A12zFgPIqKV0WxrxytOw6qwl/GQUusiCSlS30BdYDAOku9iQ4k
         mGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXnYo/XJRlIPCj8X2tLXK8QJF68OekDoMODkg5Cs0to=;
        b=KO0snOy6mMkg9vVwPJOF94WQe3BgEDi8Ag7I7vk8TWFE5Fg1FzJVMzQobIMNOcOa0X
         prGNlnm5yDuVRfH04+s9w4lTCTu5sFR2i7Tbby8m56XdG5Lp8gkFdWyJsItWc5JDdvfE
         FXXjpdrl4WkCBP13FK1HTsofGP8UgR2DaCD1SyAUFNF11zDRlB3O0x6VOGToL83IrqQs
         +VMOD9aRzHCumB96PH5+XuCHhyTwTnaAzuV3kl17wf5z8ZNl5FskvpQIYIv9VYbYK7Hw
         +WdYB/MbvRBOTUgUzaHzNMznDZbOQ+ll9A1D4G/KV3nNdmws05AWYjjwwSlOzGvlQsnM
         EZIQ==
X-Gm-Message-State: AOAM531s13Z79sOpwBY9Gt/ns8rq2D+b5ee6xVyn9AODYT98AVovMKfK
        E7CckHj1ngqoAadPrs2zH6bbQl8PxoonL11e74XlMDK61aQc5A==
X-Google-Smtp-Source: ABdhPJwPwhCSnEu4DJXmWxHiGV0Kg1iUL+SLH552zkH5ER3+Ncg66gbxNzy3d0LGDZ+iGDktGzsR7vteAkTwFG2AuUc=
X-Received: by 2002:a19:600e:: with SMTP id u14mr2420516lfb.465.1611784229621;
 Wed, 27 Jan 2021 13:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20201228150052.2633-1-nikita.shubin@maquefel.me>
 <20210127104617.1173-1-nikita.shubin@maquefel.me> <20210127104617.1173-4-nikita.shubin@maquefel.me>
In-Reply-To: <20210127104617.1173-4-nikita.shubin@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Jan 2021 22:50:18 +0100
Message-ID: <CACRpkdasDvLjYj=xAVUD+8L-D=fh7Jvk8xM1NERUuAxwev0FTw@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] gpio: ep93xx: Fix wrong irq numbers in port F
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 11:46 AM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:

> Port F irq's should be statically mapped to EP93XX_GPIO_F_IRQ_BASE.
>
> So we need to specify girq->first otherwise:
>
> "If device tree is used, then first_irq will be 0 and
> irqs get mapped dynamically on the fly"
>
> And that's not the thing we want.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

True, to satisfy old board file-type machines we unfortunately
have to do this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
