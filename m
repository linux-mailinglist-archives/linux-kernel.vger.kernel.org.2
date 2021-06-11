Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1EF3A4B89
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 01:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhFLABb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 20:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhFLAB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 20:01:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BE9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 16:59:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a1so10929372lfr.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bnh77Qps8T12Yo/r2kYdixbFDzWVS8YUSFSt9pZejSw=;
        b=AWtH1zVWX9LrMGgrpUo8HPUUIvzDUyoZl633ankwLTvO9+62f67jyPXuHc8n+a02MG
         UHULZ1LG5CBtjgzuSZJXsdg0SjnrhKflsqkS4ZLewVv3lLY4FsQMK0W6BIl2aYe40nQx
         sto7cZqnjIxxo8Fx5z/HQRsPfzKR8PxSZoLSK0TKpxR5wlIqGVU2tqynp0DpZnjqC63Q
         NIHZ+boUkpYMzXf1yA9/gsKEGFZwD9ioyqzhk2iatGD+G8BahRSPtnQYGll1dcIhxP8n
         13BC+c0/5/XVpGwbcIsY41Fnb126vfb7mkGaCmZgiK7O8r8A0vLXttw2y4Hxm4te39Rz
         v+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bnh77Qps8T12Yo/r2kYdixbFDzWVS8YUSFSt9pZejSw=;
        b=RQWkGgl6jIK/XUVReT759+RXfFzt9LSOXFxVntuyvGPHQciRZvM431N98urglLeV0t
         FZUyjT+qIYNlvUzvou4io+SYqKAnXq86GPPX6HaoRfxYcb3T9qS/API4A4Fwug01yQPy
         sAV71o8J7ysw6dZyKSvknqC6ukZQl4gbNbkhtBe3FFp03uinNyixs0Dy4cs9K1nc214R
         rahk1mP4eE/kGigtINBLToZyOLMxaDjtQnZJgV9lECzyuFYIjE82A9Iz61zBfa2IjBiD
         d8aQlF5CewLKR+Ubw7NucCwG6qXrM26iXrinWYjZeBASDCEUdq5GDTF2hHFROB32Ag+O
         SXUw==
X-Gm-Message-State: AOAM531Pbpo8uhK1oj6iPJDhSP4OSiraZn3foX9zFmM91RZ9EqgYEP0q
        biZudRruqHakUgLc/lTtfuys19kFgKvM9xGMZ7FqZg==
X-Google-Smtp-Source: ABdhPJwagqfRiKpcWXHus3RD/FpEgWbbMjU5geKQlpNnM1DDaB0xKy+40r48Ne1QzLI3tptGAMTR2TGiC1N0nmUmS3s=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr4235452lfn.465.1623455956385;
 Fri, 11 Jun 2021 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210610132438.3085841-1-akaessens@gmail.com>
In-Reply-To: <20210610132438.3085841-1-akaessens@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Jun 2021 01:59:05 +0200
Message-ID: <CACRpkdbkjpV4DY+WMVdYX0136XxB9Z9bga-KbZ+D0oB+pQu_ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: mcp23s08: Add optional reset GPIO
To:     Andreas Kaessens <akaessens@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel@i4.cs.fau.de, Darian Biastoch <d.biastoch@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 3:24 PM Andreas Kaessens <akaessens@gmail.com> wrot=
e:

> The MCP23x port expander RESET# line can be connected to a host GPIO.
> The optional reset-gpio must be set to LOW if the reset is asserted
> at probing time.
>
> On page 5 in the datasheet [0] the "Device Active After Reset high"
> time is specified at 0 =C2=B5s. Therefore no waiting is needed after the
> reset transition.
>
> [0] https://ww1.microchip.com/downloads/en/DeviceDoc/20001952C.pdf
>
> Signed-off-by: Andreas Kaessens <akaessens@gmail.com>
> Signed-off-by: Darian Biastoch <d.biastoch@gmail.com>

Both patches applied, thanks!

Yours,
Linus Walleij
