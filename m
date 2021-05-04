Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C983731A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhEDUxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhEDUxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:53:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AE0C061574;
        Tue,  4 May 2021 13:52:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u13so9353314edd.3;
        Tue, 04 May 2021 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4mJQuD4mnuaCWq1D6gvIPhHTbCcwKAIz+YjfBqx3dCo=;
        b=Hp1iYyOCcnpf53Q1fCKgIKV0WwgkMh/C8tJm6nrj5JrJd4ArrkpI6L4K5U+9Vtzu2K
         EjF2TbArco3pxszZBXr/devJ2be1uD77rt3WhsHyoq87GjaVNA+7uE7eMAafTlfQaY9H
         ZvOGc6en96CqXAzVUfPLUIPXpf7xYlTta0bvS3arvXs96ya/Xmdkax8tpimr443PcMTV
         BfP8PyrgBTPkkNUnasJ9pE1XB7TL+lZRdg6auJ4lPGmcRsViKRWoEZ1qg8CRcOmP7Vxp
         hayRpjMAM//E+In7pYXvBy077jf+yo5CKs4TSp+ln6DCMhFRAgHHs2Qa7UTH720VebLc
         wzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4mJQuD4mnuaCWq1D6gvIPhHTbCcwKAIz+YjfBqx3dCo=;
        b=dyI0yWzLAXNe9GP073W2dLfzH2aTrxMTXsQ17QsbVxjlK1nVDyKOaTwwm5QKGKRSfl
         MTV0xbBvl4w+ACLknF5zTaFHXa2UGJ/8Pb5twbAgLz1i0TCs0AA4W/zvcOnrOxE4G5M4
         8T1xlK6mA+QwlffewtUeNYyL0J4GiUfD7TXxfwbrNhdMlj5tIAxs63UMLMcao/4ryKFy
         4FAcwjvjiKy3cZKAWc6PI0SiDxHYEgKUVjsrf3I0Qh7Sf4y+AfoN7mAB42QDeueAL3ql
         tOrOWiLuzFa3/NcHY98up9jg+aZsFsp8UZoi6p7eFRhwlPaOWErQZiyyI9SqNKIyzVly
         Skkw==
X-Gm-Message-State: AOAM532qHs0wp8elewpCE/qxPLUuAhPGxG/5G1fhCmAaor/70ofTaDc3
        kP92DcCLy4j/T/qXGCQE9UyEyGBP1baPiaiRG8w=
X-Google-Smtp-Source: ABdhPJxNH8mE/dJ2Lo61gkk7613QibMuhjIUwzyR5nTasiUbR3oRDUNK6TMQx2gz45mqNhi/7ZSLwLIrEq0z9JI1Dm4=
X-Received: by 2002:a05:6402:36e:: with SMTP id s14mr15914973edw.338.1620161565812;
 Tue, 04 May 2021 13:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210504041659.22495-1-wens@kernel.org>
In-Reply-To: <20210504041659.22495-1-wens@kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 4 May 2021 22:52:35 +0200
Message-ID: <CAFBinCBZa-OjjLE0oaNQzAL+tGTkiC_Kf+iHR1H3K5-b+uFK0w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: meson-gxbb: nanopi-k2: Enable Bluetooth
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 4, 2021 at 6:17 AM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> The NanoPi K2 has a AP6212 WiFi+BT combo module. The WiFi portion is
> already enabled. The BT part is connected via UART and I2S.
>
> Enable the UART and add a device node describing the Bluetooth portion
> of the module.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v1:
>   - added uart-has-rtscts property
>   - added alias for uart_A
>
> Hi Neil, Martin,
>
> I dropped your review-bys since I added the UART alias and I'm not sure
> what the policy for those are.
>
> ChenYu
> ---
>  .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> index 7273eed5292c..f017a263784f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> @@ -15,6 +15,7 @@ / {
>
>         aliases {
>                 serial0 = &uart_AO;
> +               serial1 = &uart_A;
this should not be needed anymore since
a26988e8fef4b258d1b771e0f4b2e3b67cb2e044 ("tty: serial: meson: if no
alias specified use an available id")

IIRC for "newly added" .dts we are only adding the alias for anything
that shows up in /dev/ for the user
meson-khadas-vim3.dtsi for example is not adding an alias for uart_A
(also used for Bluetooth)


Best regards,
Martin
