Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEF23547E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 22:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbhDEU4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 16:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbhDEU4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 16:56:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C917FC061756;
        Mon,  5 Apr 2021 13:56:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f8so9934803edd.11;
        Mon, 05 Apr 2021 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQ/sz4QIHDjzJ8nBtshigsYBFNP5a7OC28YN9pA/Mgs=;
        b=pqY0VoiUuzbRQXs8ucTKXxClB62OzQM+BlbkkZ2Hye6SXe/syKCvG6pTuMLdaVubLl
         5mgLqR8fESyG3no3UFkaTx1QNBSPOiD3mpwRa6Tyia2y19PsRP2Kg0dccNPZzXp1vh1h
         QT3K4XtgNf1kTxFvziOT/8W9P3N1PdcHhUuqGvbq8F7dH2rhg/34XVPlgCXN3CydNaM9
         kKHHfKXjwg5HVDkEjBvrd/lutrJglYGOecJlYhiruWYFyhGnet76U46FxPZH5q2xvFLy
         aO7xfTHcQHF0FvHGQjJSbyyoSy+vy7q0SMFhXl4o/qLIiAy2zvfHxpW7iq+jB1hPq2xO
         EvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQ/sz4QIHDjzJ8nBtshigsYBFNP5a7OC28YN9pA/Mgs=;
        b=YUNT9uvdbHaBFZUpjCS+bsRqA/FBo7bq5WspaVmKaEWTdQtCsbny9u8SgSvwwLWoTz
         Au4urQ9ooa6MF02Wk7m5Yq+oc1A/hOQxfx3X1rmMhQjG/++Z/cna9PBC4qpq2WSR3tEU
         d4863KqAcdMBFn47Y8qh0t42F0uh6iyMnDi1kvkgWtfvP2fl9+AM9+Y4h0P8J2PhdYUl
         1+33PDnnV2GSBIJlLo0/YfXS8tCLbq8LPyzEc6tgu8/ayDWzVjZCzpG1mjxqxlgnKiR/
         tmx5yfhA54frMN40bn0HtP+ETBQ3Sj9fKawFWa4MI+awh65jID8j3Gt9EbC4r2uiWUqY
         nXKw==
X-Gm-Message-State: AOAM533oUZL8FW1j5vejp8Di4hjIM7WyaPUpi7L6ZcSKYniWRTX368Dj
        IABLz9GMjWiAzXHdy6/mu5BgVjDACo04ocuTpdY=
X-Google-Smtp-Source: ABdhPJzX3Q8IXaEZkwIhW5K8Z3KZLRUvOlw+9yPPAdzK4VJIqdsuppTBkPO+VE5uuz4LwXuK1++UzZHn2k9D3o8cyOU=
X-Received: by 2002:a05:6402:1713:: with SMTP id y19mr33533620edu.52.1617656205602;
 Mon, 05 Apr 2021 13:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210329161256.31171-1-christianshewitt@gmail.com> <20210329161256.31171-3-christianshewitt@gmail.com>
In-Reply-To: <20210329161256.31171-3-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 5 Apr 2021 22:56:34 +0200
Message-ID: <CAFBinCAJMvdus+bUjDpJxrATfifG7BstdKi=x_yUEYH0RqhJUQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: meson: add saradc node to ODROID N2/N2+
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hyeonki Hong <hhk7734@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 1:18 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> From: Hyeonki Hong <hhk7734@gmail.com>
>
> Add the meson saradc node to the ODROID N2/N2+ common dtsi.
in general I am fine with this as some SAR ADC channels seem to be on
the pin headers...

[...]
> +&saradc {
> +       status = "okay";
> +};
...but a vref-supply should be provided to get meaningful numbers
