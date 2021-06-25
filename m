Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AA23B41CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhFYKkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhFYKkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:40:07 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74F7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:37:45 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id m9so3908351ybp.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6XeqvwioJzGji6/V4D6QblypBkwkFKvIMSZgeY/xpU=;
        b=vFu+Y+G+MND1bMG9cj4xq1Madmq4tXHM9sgxuP/oSedGnbq6z3JXPItCBzh2SPnH7+
         DhyJVzxS7YduipJrSNzKfhTYgsyiZn8/BEEAVa0q3OrKuy1DsRjOv4BWu1JwjW3BttoW
         GdVjjWm9otv8up6jKnaKJSXVexm966YvB4B4vOb15gzoG6h/hCsRNcvfcx67axMy8A1C
         EMNW6uqJdt2+Y0/qhwWS+fqoedAIoCngT1eu+MUFO2gC2l0nVkBu8eaIj7XCsCNmI8iz
         I22IrowsSfiuFCc2SyRFoZr3QNfV29b9OPvWeeqDKYBL1Es7GTFM7uRSZ45CVBsQI8D/
         R/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6XeqvwioJzGji6/V4D6QblypBkwkFKvIMSZgeY/xpU=;
        b=cUJG31MOzAP+DNrrkWTRq9KCiOoGoWuhLmG6sE7KCPgICzX/V/J0aZyL9Sl1WQX52l
         KcZ28NhLDhKugWyJXS0egoy2xEvUk9V574M57DJ2PZgGJYIDvGUBMD5wYjL7xWuitheX
         atwhkRHoe81Y8sXsYJkjxiT/EPr2imr8QPu9O76zME5/zklIOk80+rGWPLYVzQnXsEcV
         ejyrVRm3ERSCd+xHT7/kz9MuRHlflvQTJ3HAVBgq0PPqkqvg0hBVl+XqksvuBLydHhRe
         oRMUCAD7hNvUKho35kfA7nHv+D1frqyxtUywYjbrUJ37Wh05r+gmjqCkbaUBdQWJpclv
         yQYA==
X-Gm-Message-State: AOAM5336+bL8qZfYANkFkaLYnfrwX35kyO5DjBPllBUpAc9s42yOlqnD
        KUqPYeDnJ1pmuYKh7O+IfLLJupmhhs1Qd0DTXPjA+g==
X-Google-Smtp-Source: ABdhPJxc93bfE1vaCKQGKslN7h1GqLpHt52fBEz+aUCkpB4CjQFVdiFg5tvFcEtt80z/I3CW0n7HpE8/Y7ekn33y+uw=
X-Received: by 2002:a25:738e:: with SMTP id o136mr11371053ybc.469.1624617465175;
 Fri, 25 Jun 2021 03:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623824363.git.mchehab+huawei@kernel.org> <506a41353937c455c2e79b5960b0976edc8aa9e9.1623824363.git.mchehab+huawei@kernel.org>
In-Reply-To: <506a41353937c455c2e79b5960b0976edc8aa9e9.1623824363.git.mchehab+huawei@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 25 Jun 2021 12:37:34 +0200
Message-ID: <CAMpxmJVAgFcSoVE5jE9hPT=o_7o+fpvG-gGfxS+3=S3K91tnDg@mail.gmail.com>
Subject: Re: [PATCH v2 14/29] docs: driver-api: gpio: using-gpio.rst: avoid
 using ReST :doc:`foo` markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 8:27 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The :doc:`foo` tag is auto-generated via automarkup.py.
> So, use the filename at the sources, instead of :doc:`foo`.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/driver-api/gpio/using-gpio.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/driver-api/gpio/using-gpio.rst b/Documentation/driver-api/gpio/using-gpio.rst
> index dda069444032..64c8d3f76c3a 100644
> --- a/Documentation/driver-api/gpio/using-gpio.rst
> +++ b/Documentation/driver-api/gpio/using-gpio.rst
> @@ -9,13 +9,13 @@ with them.
>
>  For examples of already existing generic drivers that will also be good
>  examples for any other kernel drivers you want to author, refer to
> -:doc:`drivers-on-gpio`
> +Documentation/driver-api/gpio/drivers-on-gpio.rst
>
>  For any kind of mass produced system you want to support, such as servers,
>  laptops, phones, tablets, routers, and any consumer or office or business goods
>  using appropriate kernel drivers is paramount. Submit your code for inclusion
>  in the upstream Linux kernel when you feel it is mature enough and you will get
> -help to refine it, see :doc:`../../process/submitting-patches`.
> +help to refine it, see Documentation/process/submitting-patches.rst.
>
>  In Linux GPIO lines also have a userspace ABI.
>
> --
> 2.31.1
>

Applied, thanks!

Bartosz
