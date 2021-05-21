Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A4A38D229
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 01:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhEUX5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 19:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhEUX52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 19:57:28 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12FFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:56:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id f12so25909227ljp.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xV/zcZZmjMB2lMxY7tGt9DtNWfH1pvDZsCFKmDpfnOc=;
        b=Li5AXrEfKDYOBoJTHlK4Tw9+1se1u8DJC+ZfzYoKbuijFOqYXLFxJ/9jNn3na7KKw/
         K5v6wWmah+b6WecoQ0NtcXahunZngjXz3QjRv/EAHIuJpYIdZzGtqZIqbikHS5EGRra1
         pBArwZL6fsAERFO+S3E8a2xgfV45imF/Ma1TzYheor/PNjs1p8v82QdLbjTMBZZIaDll
         +Lh9x5zJrhNssBRfG8WDQM5Urfc6ohNMZJbwYpX+Z1uKPnMfjww7p7v2cMkKjTJ+10J6
         nsNgQYJWHeGgl5/pl0OcVUCg2rhzj92vwbfPdR6G1Xzrz4fra1o4W5ytPI1ECqaNFj6i
         Yycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xV/zcZZmjMB2lMxY7tGt9DtNWfH1pvDZsCFKmDpfnOc=;
        b=Ms8jl/8wfNt9ewfOPiRhzc33DVzp6x0o+s/9zp8xZ6flXMNMPRoxC9I5U7vXKtjQtw
         4rXw9EiHA7ZFzVnQRyZlphvtM30ucrwNcBAvke3mFuOhb+ywPUKDD4GXagtqw2c+Bx1c
         TkMCrsfyGxI6tAHLaLLpk/76rQcSdkTRFdi2gvuXTqgL0rGrNtmZ1GbCWl6klQ85UcIW
         7eHKPHVYiZPlZO/1KkPDc04p/+jkopg2C3ZSrt7P1KT7oqM7QxoHk5oRI2SuwEo3EwzN
         3csVIR00tU2a8skiWT0ytH6+d3yzlVBw5ylrj8ESIlADYkWiDeIuQLvZ3AUOadtqN3dk
         3HrQ==
X-Gm-Message-State: AOAM530+41j0E8ZcJMmULc0iPcP6LrbpfnLH8Qu3D9qpUwz7tGD3O3ls
        fiv2QsaJ8FN5WdyCxtD6fMG5N/aoVxcJ4ebX3VHI2A==
X-Google-Smtp-Source: ABdhPJzSKTF9N4rFGkkbLa6MruOk7Rzrek6hSegUVpJ6ifSaLKAZ+WHBeQv0qHZgaPFztEgwHjz29RLeg83spwEL0UA=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr8483381lji.438.1621641363241;
 Fri, 21 May 2021 16:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210519203547.837237-1-clabbe@baylibre.com> <20210519203547.837237-3-clabbe@baylibre.com>
In-Reply-To: <20210519203547.837237-3-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 22 May 2021 01:55:52 +0200
Message-ID: <CACRpkdZ9L2xH0vWm5bY_8i4cvdxsBihEf_y-6xY4M6ePumqSvQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: gemini: remove xxx-cells from display
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:35 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> dtb_check complains about #address-cells and #size-cells, so lets
> remove them.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Patch applied to the Gemini tree.

Yours,
Linus Walleij
