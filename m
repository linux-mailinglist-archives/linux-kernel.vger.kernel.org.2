Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDC039C72F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFEJzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 05:55:49 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:40678 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhFEJzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 05:55:48 -0400
Received: by mail-ed1-f50.google.com with SMTP id t3so13965346edc.7;
        Sat, 05 Jun 2021 02:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0AfCe+AnGuvkOIER3nDjEqdQTuYBtNrjSVqb94ABWM=;
        b=BqMzg/S9cDMDkZYiXVBCycIeo7ddgthjkqzFqqWYzcAo+SrHpYLe2KcATTz99bai+t
         29vE9+raYz3cyLM2j/QOj30ytpEcwzN4OFxwuIX8EudPjQ3hJQ1lseT9ItFYQHuKnMjO
         /vTc9AD2NrG4NmG9FFa1+FboycLSHbaAGEZqCW7ge5NB+S0oWNxOouoY0cxP6NoTI5j1
         aqC1vskHtDQX5MPgRTQbJ7tH/Kddc0qvghBw8tIJwe0zX10QURhPsv6UF53Lw1haMbFt
         8aVC6xQjpPunsQ2DRuk/B2ilH/A4gg/E0TeDrcu88FpWGl114h4jIPyObZgHYBdARym7
         e9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0AfCe+AnGuvkOIER3nDjEqdQTuYBtNrjSVqb94ABWM=;
        b=rV2wwc/emQIe6nekyhk1WwMEhUp+dYFgbs8zBimdUuMp9pWiVUgMQo/eTmei1Hou/L
         Vn7Zvx2HU83zt/WlHy9zD/BCTXILV30rMsxRWovyWuHB4KzYRe326Ml3JolTRwsM00/u
         2KbksziDO5h3Kz3UKN7JCA/c+4or5Tiz41uuPxt7+11rAnUEiIjsZsH9Qylaxg4OC0Yg
         +1u+hEsi8OLw1/mqXZNWDsHGlFgwlRRSMOg53g+AJtn29Y04xF1RxnNWRxX1F1/OgK1s
         py5ZzW808QrRP2CzE26P7zMcqAJZPfNqzT3wEfx/erWaxK36wWE9HPSNDoyYr7iPF3O4
         HuuQ==
X-Gm-Message-State: AOAM531gtQaz8rbbpVn4Zpas+o0/nepzkaKD8wfB5zxGIn1sjHX1ezRH
        1cUp7LYqUVGZOIQ/RwNKj6tt3PTitbn7c2uOKpA=
X-Google-Smtp-Source: ABdhPJyKglIG9Jms2+CsJNo7kBtqYbUy0dCCoVZc7b/D2JH8g0ejV5RMArrBSbT3dFZIxWaS4XrRXrGh1wxvv00JeL8=
X-Received: by 2002:aa7:cfc7:: with SMTP id r7mr6251662edy.13.1622886765949;
 Sat, 05 Jun 2021 02:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210605062313.418343-1-xieqinick@gmail.com> <20210605062313.418343-2-xieqinick@gmail.com>
In-Reply-To: <20210605062313.418343-2-xieqinick@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Jun 2021 11:52:35 +0200
Message-ID: <CAFBinCCsix8MJKzsapmNA-Fe9wKk7xZMsLj9bGWZ_GskiqZLoA@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: dts: meson: vim3: add serial aliases
To:     xieqinick@gmail.com
Cc:     robh+dt@kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        khilman@baylibre.com, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        nick@khadas.com, artem@khadas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 8:23 AM <xieqinick@gmail.com> wrote:
>
> From: Nick Xie <nick@khadas.com>
>
> Add serial aliases for Khadas VIM3/3L.
>
> Signed-off-by: Nick Xie <nick@khadas.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> index 66d67524b031..4686ea7abe0b 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> @@ -13,6 +13,10 @@
>  / {
>         aliases {
>                 serial0 = &uart_AO;
> +               serial1 = &uart_A;
uart_A is used for the Bluetooth module so with mainline Linux it will
not get a /dev/ttyAMLx character device
For that reason we are not adding an alias for uart_A when a new
board.dts is added

I suggest that you also drop this alias here because it is not visible
to the user ever
Same applies to VIM1 and VIM2 as well


Best regards,
Martin
