Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E5B38B331
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhETP0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbhETP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:26:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAE9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:24:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i9so25093636lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHf/1v1fGbUdpmCKcskQepvJMic+ILVUbOQLobw+E8Q=;
        b=CHhbCCoXLMa7YLC7+DNtAb8hhHdxRqAg0wQBXxTog8yWISm+WFO+q0LGTDYf483tsK
         MLF/j+75Wf4E6OiCTmEmaEjdV+235Q1JsQtIHuQr+WZpBtvw/hskTkwOrVVxK+M+rXMK
         ljdx85dvDX5rgTuEl9Kt3pDzhr/EualTnM8p3CeJk7I+qaJPwzPfhR6+e4L4zs0QzUGG
         QWeYvIlDbr0b3piZegVSvtONXv91dgFeVjmGG5KqW0NBdsh5VWpU8kp7/eOubF4qVtAI
         mPcBKeQRrvzgN4NEVXCL5JSuD4OK/hxNN7trcPkdHPMBKhj11HKwG8X5nwkiExAMkq5T
         250A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHf/1v1fGbUdpmCKcskQepvJMic+ILVUbOQLobw+E8Q=;
        b=Pt/xrfE55xiC08lqMf8v9r5d+LMYJ07rzNfW61bfLlDyhKyolg2jq6lwH64MwFVJ+f
         xfFHTugeOcBOY3p7QapUb9yeZzn+YLtyGLaaySTpmRq9R1p3/8b4SK4vZA3AuIoixual
         yvZTeZWz3U2yU1+gNbwJhgsEDJ/8W+P7eXPY/rKO2sOIR77h1T7gPgDVYPQeV46GAFeE
         AOtuDiKCHQu8Ul0gjI2REFfyqm7abS7rRaHaeoM0kE684VIhmsmFVkc+07T3GBhZCFrz
         CWTHLAfR38s+gcl5yXD5WWP27rdiL9hZ1Wj0ErsKDJay6cBzuZcSBrOkaFuMkrqY4Sf3
         feGQ==
X-Gm-Message-State: AOAM532/Wpgi5ExKt5WRoROMJUm6Op0gx7b/wKT3tlQIGpdDW0Lsyt4x
        u5BWkarg26pZ4PgYmyvb4e+7lX986b2CXKoEL+paWg==
X-Google-Smtp-Source: ABdhPJzJItWpdY1aIPg4g2EfiVyffJGj6ebM0naseD2zm9RG8i10R7z2Lh4yaAqdvoBYRdtz7FtG7T1QkEZHf93BkJ0=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr3640883lfn.465.1621524277719;
 Thu, 20 May 2021 08:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210520114851.1274609-1-clabbe@baylibre.com> <20210520114851.1274609-2-clabbe@baylibre.com>
In-Reply-To: <20210520114851.1274609-2-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 17:24:26 +0200
Message-ID: <CACRpkda6ou1SJZzBwHXN_kWofnFw8w7XAkr7VcFO2NrqbQug_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: partitions: redboot: fix style issues
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 1:49 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> This patch fixes easy checkpatch issues.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
(...)
> -    uint32_t     flash_base;    // Address within FLASH of image
(...)
> +       u32       flash_base;    // Address within FLASH of image

Does checkpatch complain about this? At one point the MTD maintainer
disliked the u32/u16/u8 types and explicitly wanted to use the C
standard library types, and it's the kind of eccentric maintainer
deviations we accommodate for.

From my personal side:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
