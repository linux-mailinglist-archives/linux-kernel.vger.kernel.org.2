Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A558F33C8C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 22:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhCOVt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 17:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhCOVtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:49:16 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95B9C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:49:16 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id n79so33301443qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERTU1eQzwztfytHCa5TeUnNRAyf3oJdDM4lto/zPk50=;
        b=DIALwvEWqeHYbujXDsiqzCi2GtIx9SBeXDHseYDHql6LrHtmS7SCtIaFerLl91Y8aC
         pYP07IOYVednud8Pfjf83sXJD9W66W4URhfR6TKZVfWzVsHokKPkqYE4GO+ZWIKJNqR3
         Y4Wam25X9ka58Finxy0Px9DFBKMgWviHQHwY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERTU1eQzwztfytHCa5TeUnNRAyf3oJdDM4lto/zPk50=;
        b=TADIbrrJ0JK+T1dHvhwZjLYo3NAj2hs9SVaOs6ghjMhzIeS5e2vDvkr522XQZkjNfF
         iZUXuYA7GG+kroa7NLxXBHKAzAc/PvOqeI7/7IVwAbDs6PiyJO8YNERmGV96oebo9jPH
         ktp7wi8JCd6qtScZzpdQDUdQRfD0Khkl/22RBG88Y0KfY3HDDxG2J2N/4Y0flydFj8Zf
         xJBlNeTl6fQQWoJPAC3eVCuoShCalDkwMYP3RK7+LrsoSNznl0OR3FY40UdgAeF8vWy1
         lj3Co+evrHJgpzv6Nl/lw7ky5mAGUxU8SG/pbQEuPsdkoz1YczO6jO2pPplPUB5neaId
         3/vg==
X-Gm-Message-State: AOAM533RoYgXb9SY5X0xMp7DO/p5JZ4VGMfSx7d/SCNxRUPHc0kZfLrY
        fGK3FR3pXdFCmyYK7spDT2aU9I298cdPvA==
X-Google-Smtp-Source: ABdhPJwi2JaMfvJLBlB8PzX2PuH0mcOSZA8Ds//lyaUSpzbRW9+fDj+2xXaEJIkZ7OxDLKXqoVQoRA==
X-Received: by 2002:a37:7985:: with SMTP id u127mr27518435qkc.333.1615844955568;
        Mon, 15 Mar 2021 14:49:15 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id x187sm13729976qkd.83.2021.03.15.14.48.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 14:49:03 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id p193so34756344yba.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:48:58 -0700 (PDT)
X-Received: by 2002:a25:dc4d:: with SMTP id y74mr2403139ybe.79.1615844938242;
 Mon, 15 Mar 2021 14:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210312183228.550779-1-mka@chromium.org> <20210312103211.v2.1.I6d587e7ae72a5a47253bb95dfdc3158f8cc8a157@changeid>
In-Reply-To: <20210312103211.v2.1.I6d587e7ae72a5a47253bb95dfdc3158f8cc8a157@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Mar 2021 14:48:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wb7Xu07M3AspNhZqRzy3H1zLy5HDbLWKOSijCV0kHM6Q@mail.gmail.com>
Message-ID: <CAD=FV=Wb7Xu07M3AspNhZqRzy3H1zLy5HDbLWKOSijCV0kHM6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sc7180: lazor: Simplify
 disabling of charger thermal zone
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 12, 2021 at 10:32 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Commit f73558cc83d1 ("arm64: dts: qcom: sc7180: Disable charger
> thermal zone for lazor") disables the charger thermal zone for
> specific lazor revisions due to an unsupported thermistor type.
> The initial idea was to disable the thermal zone for older
> revisions and leave it enabled for newer ones that use a
> supported thermistor. Finally the thermistor won't be changed
> on newer revisions, hence the thermal zone should be disabled
> for all lazor (and limozeen) revisions. Instead of disabling
> it per revision do it once in the shared .dtsi for lazor.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v2:
> - none
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts | 9 ---------
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts | 9 ---------
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts | 9 ---------
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi   | 9 +++++++++
>  4 files changed, 9 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
> index 5c997cd90069..30e3e769d2b4 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
> @@ -14,15 +14,6 @@ / {
>         compatible = "google,lazor-rev0", "qcom,sc7180";
>  };
>
> -/*
> - * Lazor is stuffed with a 47k NTC as charger thermistor which currently is
> - * not supported by the PM6150 ADC driver. Disable the charger thermal zone
> - * to avoid using bogus temperature values.
> - */
> -&charger_thermal {
> -       status = "disabled";
> -};
> -
>  &pp3300_hub {
>         /* pp3300_l7c is used to power the USB hub */
>         /delete-property/regulator-always-on;
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
> index d9fbcc7bc5bd..c2ef06367baf 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
> @@ -14,15 +14,6 @@ / {
>         compatible = "google,lazor-rev1", "google,lazor-rev2", "qcom,sc7180";
>  };
>
> -/*
> - * Lazor is stuffed with a 47k NTC as charger thermistor which currently is
> - * not supported by the PM6150 ADC driver. Disable the charger thermal zone
> - * to avoid using bogus temperature values.
> - */
> -&charger_thermal {
> -       status = "disabled";
> -};
> -
>  &pp3300_hub {
>         /* pp3300_l7c is used to power the USB hub */
>         /delete-property/regulator-always-on;
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
> index ea8c2ee09741..b474df47cd70 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
> @@ -14,12 +14,3 @@ / {
>         model = "Google Lazor (rev3+)";
>         compatible = "google,lazor", "qcom,sc7180";
>  };
> -
> -/*
> - * Lazor is stuffed with a 47k NTC as charger thermistor which currently is
> - * not supported by the PM6150 ADC driver. Disable the charger thermal zone
> - * to avoid using bogus temperature values.
> - */
> -&charger_thermal {
> -       status = "disabled";
> -};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> index 6b10b96173e8..6d540321b4a5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> @@ -41,6 +41,15 @@ ap_ts: touchscreen@10 {
>         };
>  };
>
> +/*
> + * Lazor is stuffed with a 47k NTC as charger thermistor which currently is
> + * not supported by the PM6150 ADC driver. Disable the charger thermal zone
> + * to avoid using bogus temperature values.
> + */
> +&charger_thermal {
> +       status = "disabled";
> +};

So this always confuses me too, but the sort order is wrong.  :(

While it _looks_like the node above you is "ap_ts", I believe the
convention for sorting is not to use labels added in this file. Yeah,
we gotta document this somewhere. Thus, this node should be sorted as
"charger_thermal" (using a label not defined in this file) and the
node above should be sorted as "touchscreen@10" and thus we should go
above it.

In general I think the reason we tend to use the node name and not any
labels is that it keeps us from having to redo the sort ordering if we
give something a new label. It also helps keep the i2c busses
together, the SPI busses together, etc.

That's just a sort order nit, though, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


-Doug
