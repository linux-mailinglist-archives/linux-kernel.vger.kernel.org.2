Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C98386DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 01:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344577AbhEQXrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 19:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhEQXru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 19:47:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A668CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:46:33 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id v6so9318510ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVEEpIXI/Y5CtVnRyxBQ3wjVOQ3Vlf0v5827celIsKo=;
        b=nMBqhSpQSNGHZUcZtE4vR9rjwvtGJDraTV1gmLxW1M85AMzZj0UzVm74oTMMebnUXQ
         WUBsl1vtJj18d0zmOJ/Ho4JD+GGT/lxzvAgQM3kQLTTz7THuWCxwFpSINd+DoeUIATeE
         lDNarF+k4qT0/7akXNOMqzx4n8ZM0zvQcuV5vwpUPzIcTtX2PgJZpHhermsa/S5P/wH3
         GiM4XuG5hqEo/bN9easQvihiBQ4ax8Nxh1K6JcWyJ01fE8YTj1yW1GnYxAx7EeB4ogfa
         zgfKczId40OPPuzodgNZt66+dl1nVRCGQuj6m69KMDcKLhgejMwCl+gTOL9cWO4YBriN
         /emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVEEpIXI/Y5CtVnRyxBQ3wjVOQ3Vlf0v5827celIsKo=;
        b=Hxa9FIEjfOk8P3Np2dsB5UZaNG6RZjwLwwKYuvWDVLd7kzHduFO+OhQ+ZDIwLPJ9Nx
         AkrMEKwmeWWY7P+cbfwsj5NgQxkKHmYG4FpvKN78nLy3fAGQgQiBEL4/aqJvECY6sBPn
         KsFrpPjvrlNUjM3KetRnw7d87vtKo+5F+NRuxlJ1+p10N17Hm9Jp8Ux6A+3nfDJyvW2o
         T0T/7ROg83wqKABOr7Hbg4TJn+uakSVMIr0KrfuV7R7/QEGm56DmYCT+Aw+8AdfkuZma
         pOw7dLjF0fEG87Fv1MXLSVwIa9oIAtWMuN1+xgWbkixCNhShnJBiW3sX/9kJ5sb+aQyH
         zowQ==
X-Gm-Message-State: AOAM531hot5tpTFkvEmzSY6NgEpyotX0lmYIe9gdZ73Yud1X0ZybmAy7
        sd+xw55R+aArxRTJUlytiCNEvI8hm23ULooZvECu1yj6JhR56Q==
X-Google-Smtp-Source: ABdhPJzt0OHOWOBh2f/7ip9SW9OpdwvzwD16NBHIqmNMbaI9JWSwPO/iXIy/XDXuqsOkAcaOFtHYons8j7cCqxQgO1Y=
X-Received: by 2002:a2e:90c7:: with SMTP id o7mr1613773ljg.368.1621295192148;
 Mon, 17 May 2021 16:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210517193205.691147-1-clabbe@baylibre.com> <20210517193205.691147-5-clabbe@baylibre.com>
In-Reply-To: <20210517193205.691147-5-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 01:46:20 +0200
Message-ID: <CACRpkdY3c4uvo1zbEgNW0meF-4P8be_nmoOEQAHP5V+GXgoG=A@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: gemini: add device tree for edimax NS2502
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

this is looking nice! Just one thing:

On Mon, May 17, 2021 at 9:32 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> The edimax NS2502 is a NAS box running a SL3516 SoC.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

> +&flash {
> +       status = "okay";
> +       /* 8MB of flash */
> +       reg = <0x30000000 0x00800000>;

No pin control setting? I guess it may work but this doesn't hurt
(I think):

    pinctrl-names = "enabled", "disabled";
    pinctrl-0 = <&pflash_default_pins>;
    pinctrl-1 = <&pflash_disabled_pins>;

> +       partitions {
> +               compatible = "fixed-partitions";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               partition@0 {
> +                       label = "RedBoot";
> +                       reg = <0x00000000 0x00020000>;
> +                       read-only;
> +               };
> +               partition@20000 {
> +                       label = "kernel";
> +                       reg = <0x00020000 0x00700000>;
> +               };
> +               partition@720000 {
> +                       label = "VCTL";
> +                       reg = <0x00720000 0x00020000>;
> +                       read-only;
> +               };
> +               partition@740000 {
> +                       label = "CurConf";
> +                       reg = <0x00740000 0x000a0000>;
> +                       read-only;
> +               };
> +               partition@7e0000 {
> +                       label = "FIS";
> +                       reg = <0x007e0000 0x00010000>;
> +                       read-only;
> +               };
> +       };
> +};

Is the FIS broken since you hardcode the partitions?

Doesn't this work:

partitions {
    compatible = "redboot-fis";
    /* Eraseblock at 0x7e0000 */
    fis-index-block = <0xfc>;
};

(Needs CONFIG_MTD_REDBOOT_PARTS)

Yours,
Linus Walleij
