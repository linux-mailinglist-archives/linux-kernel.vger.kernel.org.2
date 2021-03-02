Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E339D32A322
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381935AbhCBIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381738AbhCBIcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:32:20 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC487C061793
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:31:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bm21so14767177ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 00:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vofce9cg4If43flccFXJozuKUDopXjDd/VnmpQDiTuE=;
        b=KtIbAa6zHDrkhlQLeR4CMC3GwzF1RsEG2IYJVT+dkS2rSg3SH4LMgKKKsujIB5jeub
         avD3FgsDrk772cG2xDNbYxlai9uOVUyXo2lHisYm0eXBiKdX1rLLJLHJDC3YzBSS6L7V
         YhiS8QDhXlvL9yF/P5wyUxc4XYUMyHxImSMM8qrUs9ZHpfZu54BZCKQsJ7JvzjKNYdFQ
         Es8x/68pheGALs9Aci2vz+MB0txBE9sKSUMI559e7qWstfxbSckepur87y/pnk2SueET
         E6wJsIIQb7X4NEFmzNeS3cL6aPq8mUoQk8tXl3VtPU0ECjDxZN2EONFu92jN606aYGm7
         6srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vofce9cg4If43flccFXJozuKUDopXjDd/VnmpQDiTuE=;
        b=OD+oEXkk42B6wreubQTjE8weddqzYiV8i+RP+0oED2y4axmO1wxVMG6c6RXZ391Plp
         aMFjvPdZ315+CetouVT8jZnGK3yLR3RxMfp947syhIF6VDPpxtrPww1A3T1EBpOEIfrd
         O2tOwU3QIF/8F0TKZcoReXu7I6aXsOeVVz23PYurh5JkrKoVSujzh2wzN2EZRwnFMpLM
         KsZPq+BEUYYTSdgz9ggwkjGV/ruBwlXCzyyXcJ1rzqk6E/XBQBf+BDJN8SoI7puE1TWG
         1d7qHnjAEG/vroXlsH1ugVmZTSe6SL05Xt/n77MSq0JloR8/UlHeIQ7d4EyPhgFgMyMQ
         /zrA==
X-Gm-Message-State: AOAM530JnYIv2phVZe7gP9NYaRyplMkFzFlnYkSKhW8bvuqU85+RgH+y
        qbFmYa6W3arlebPEz8BUbuHnyFJ62/5/jrEihF2QFA==
X-Google-Smtp-Source: ABdhPJxHjmZUC5iRC5r/bT/DMEL0arKjzFzU9Z29V5ZobxNwHR/p3WN8QdJROWOyDjb+iEND+NMSKlLCXwzgIX4WqgU=
X-Received: by 2002:a17:906:39d9:: with SMTP id i25mr20041528eje.226.1614673898323;
 Tue, 02 Mar 2021 00:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20210215121713.57687-1-marcan@marcan.st> <20210215121713.57687-22-marcan@marcan.st>
In-Reply-To: <20210215121713.57687-22-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 09:31:27 +0100
Message-ID: <CACRpkdbSCGgFBxaTHQ2b_ZS24G3+fnhA11nEg5717C-Na5Dpgg@mail.gmail.com>
Subject: Re: [PATCH v2 21/25] dt-bindings: serial: samsung: Add apple,s5l-uart compatible
To:     Hector Martin <marcan@marcan.st>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 1:19 PM Hector Martin <marcan@marcan.st> wrote:

> Apple mobile devices originally used Samsung SoCs (starting with the
> S5L8900), and their current in-house SoCs continue to use compatible
> UART peripherals. We'll call this UART variant apple,s5l-uart.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Interesting IP-transfer story here! Too bad iPhone Linux was
never upstreamed.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
