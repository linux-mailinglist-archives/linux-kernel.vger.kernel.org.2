Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8132BF1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577678AbhCCSAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbhCCOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:53:23 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A346C061764
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:43:51 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g3so30225342edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gx/CAxRkG+g22fvZcYrKkczJRf8ZWzrsVOc8x8tG0jc=;
        b=NFP5g1auQ39CLU0pi5+DbFEiBU0tzQDkIivm7c/96UffPXAlcDWCcYv3wJkeVkoYkp
         7ZrepVdyYIR1+Y9OFPzjVHTwqmfGORIb3yxBdT+02LlBJWMS7hbhnsjtICLeOMAm7w7P
         H2zxhcP3q8jSkdnshsWDxH0iAoz3pvsnitkkutqm6nyfd/K/+kDk9Wd+3FYeBhZK25y8
         qGuHm91JEpdMnI4i49v8mD8qFtQX8j/L59pXQex3rxE/n79XqhBlqw/hQOhsxEHTLut3
         GS9762MKazYKXcDAH/YQTB+z7HsyQCV63pioAuz5jjv9gw+XccjfJaSAbrLx6cgJjtW9
         QVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gx/CAxRkG+g22fvZcYrKkczJRf8ZWzrsVOc8x8tG0jc=;
        b=BThh2mJoBFMEbzXy3YMP6NPGYe1as8xdpzjRVo8/Vqa8wcRd5xkEDuDEl3ZC05eJ4B
         GGELG7ycknctMDQLg+lfITuX6nxmgPySdqgeD+HTOZ5MogHnl/MtY9Uy7wTVpziP/zJ4
         ss+4kvA78/VO6KPWhYs//9GIOj0erjiMv5mkV17jzImgAiRpPDPB/1qcTHzg4Cq1pvrg
         nmlhQ6jFdrU+3aQpFM2yGduiWFh+/6xqw9NrSxAKfaGDo69P0Gf76McKYDhH3Atceal7
         rPdpTKQRdYSePGJBc81dmQqVBzJFFtabBE/QUnAqsC90mv7jLkFKe34ZwlbGOoI1sLhJ
         kHpA==
X-Gm-Message-State: AOAM532RfQQXhyuYbuNfd642ZQ2WzKEimm/SK7mje54ZGntZNjUxElwN
        m4GVNgubiAmztx0XMH3MkOH/wSQFVYvoNIXRHvTlIg==
X-Google-Smtp-Source: ABdhPJxxG4V/98LNDqu69Zvy0yA8l27EgNtixJRX41q+qMn1tV9KMwKw6dZ2etG+w3xe2TMZvfMcwLkvxjMcWdMfY6c=
X-Received: by 2002:aa7:db41:: with SMTP id n1mr7786562edt.186.1614782628333;
 Wed, 03 Mar 2021 06:43:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613134924.git.syednwaris@gmail.com>
In-Reply-To: <cover.1613134924.git.syednwaris@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 3 Mar 2021 15:43:37 +0100
Message-ID: <CAMpxmJXWk8YJR6-DHMj3+Dk4-TdE-FuFtxK_MvbsoLVqZA9rLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Introduce the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 2:19 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> Hello Bartosz,
>
> Since this patchset primarily affects GPIO drivers, would you like
> to pick it up through your GPIO tree?
>

Sure, as soon as you figure out what's wrong with the xilinx patch.
Could you also follow William's suggestion and rename the functions?

Bart
