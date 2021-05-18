Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC410388277
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352651AbhERV4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbhERV4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:56:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5278AC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:55:18 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a2so16010732lfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkrHwFXuonxLm5iDdJ3GtAunCIVS4uNey/s/gmA9qII=;
        b=AU1FYN+YPLrrcpqdk93hUps142FI9u50Upipl/5vJqomzUF0z2WNfqfHR37Zp7iebh
         feqtivkL/u2Wafb4kQ/YzUqSKgGNdrKaIZJBN3en5R+jCNfro1DuQby8XvHgMbMXhQF6
         OhqnhYqxohXqln7+PRuUMZY4V+QHiSL30NCZojyMjkT/eJCfGmqImDQg8SgpShUmKMsf
         bTXsHFuZFsGhWo8QGdRryEVMuuGTMhrAIQYobnp6UQyx9CgrebwdEp02k2qoHre477KG
         0rmJrsggg4sirK3RhtOdRNPnbhSW6I2Rpua/JBUnFz5gIwraJHX3N4m/HSnojveMLYea
         uPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkrHwFXuonxLm5iDdJ3GtAunCIVS4uNey/s/gmA9qII=;
        b=Z2WcCI9ytSABaN9958j+G5V00wS2ivXGyvvSn02A6ed5QwynQQijgTTtQwVvuMq3Es
         fFaDImJmSXyMULaj9xCL+dRMKKNpwZ7K62jMNHE2JLALMNQiLn9BnvBV1nCj6wUjtJmQ
         B+tINxguKmgpgi3OlsCx1C0c916e/tnoB+6dE3rGMd4exUAQslfk8IcGguQzWu9OgMjt
         1jDVJ2ufY+XWXoEKQlLqRd7siFW+/lwctm5usnB+X4xqHTpj3jwwvd0IksiPXp0N5dl/
         +0zIlHgtiRGxcwnn/FddOKhLDtQi+CW6k69TIY7hpx/7uktfFG0xU92DOTReASRxv18H
         5o5A==
X-Gm-Message-State: AOAM530whqbL6sI7tDgt17QPcnyXZPOLfSjIc8QTq4XcHRmOQ5zUQp7V
        ISVrwRkFxmIGVgCbcYrgAGth5AeqYwCXtM3vhz1d0g==
X-Google-Smtp-Source: ABdhPJz9MA53JA954IbUUfEyxfpo4uPR8Ul7Uig4rJHfmQ7MaPqfNQ6SM8JW041MR4qdzpgyVUbRq0S/NwMESjwAGs0=
X-Received: by 2002:a05:6512:1050:: with SMTP id c16mr5611408lfb.586.1621374916871;
 Tue, 18 May 2021 14:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210511165448.422987-1-clabbe@baylibre.com> <20210518002624.GA3346846@robh.at.kernel.org>
 <YKQJjrlTB0RZYNOK@Red>
In-Reply-To: <YKQJjrlTB0RZYNOK@Red>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 23:55:05 +0200
Message-ID: <CACRpkdYncNhe=iuqk7tAu=XeBSOcbbG=ArvxYYRmOGbHY7gyJg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: convert faraday,tve200 to YAML
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     Rob Herring <robh@kernel.org>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 8:38 PM LABBE Corentin <clabbe@baylibre.com> wrote:

> The only solution is to remove "reg = <0>;" and calling the node "port".
> Does it is acceptable ?

It's what I've done in the past at least so looks like the right thing to me.
It is only used in this device tree:
arch/arm/boot/dts/gemini-dlink-dir-685.dts
if you send me a patch to change port@0
to just port then I'll merge it pronto. (I can apply this patch to the DRM
misc tree as well when Rob thing it's fine.)

Yours,
Linus Walleij
