Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5873337EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 21:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhCKUF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 15:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhCKUFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 15:05:05 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54725C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 12:05:05 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso233463ott.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 12:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0RGEdH4qXmWUyxNfL/0Qo4+5Mh265qbBkTRMR+tqRI=;
        b=OAERhww90Ydo9cxJC3XtIm6VlKfEfVD/B1Wrc3Lo7PDMjqvJ0MDVxP7v5PlekaTETo
         /0cCyd9BnnjRsw1GVjAR3R4ocwjMs95l6AaJOmhskigSHLLgyX4XAHjopgVsX3K9Vsyu
         ewDcNw0kzpX6SuEtmoml2wkkWBwDFevbJKolE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0RGEdH4qXmWUyxNfL/0Qo4+5Mh265qbBkTRMR+tqRI=;
        b=eZZslmJA5pnxijyDFGq4B4laoq0OwURVPYZnTiJQAkVALdPs5PrC/4xbsx7eeQ/2T3
         PsXfHJslfiIIZk+/NZHX1ravROSwOsW1+4ya1JLbiJsYP8+x9eyjB4WD8wKABx7/S7sr
         iCNzFtQVIO5/4p3OkScesT3MToQRUZVNPQRHcGRm2+oFuzqITRojhQ+6I22i53u72cgD
         shp7NT7w3gD/EvEL0zbzikHrQfVHGf0IV4eULHK8aVcLA+u/2QJuyLE4aQpsZ2eX1hxD
         O5eHcF541PEBkxa5L0GhFUrNEKNK+3YcZyE3+zbm6Yq114naFGHllWcusCzP3HytPwT+
         78AA==
X-Gm-Message-State: AOAM530TpgQP+EIBuH7B9+jHUAIF/VTLDDpE48fJiS0o+nMo0AoVrR2t
        HgEg3UNn+El/r35YuR30yepTKYRSi2Wjjw==
X-Google-Smtp-Source: ABdhPJy1GH7rexrANrYh99tBRt7V0CmnFop8DsRYTUmI6e6bI6sD6gUjgOYPgzLH0qWYByOxNNweWg==
X-Received: by 2002:a05:6830:1acf:: with SMTP id r15mr493467otc.255.1615493104586;
        Thu, 11 Mar 2021 12:05:04 -0800 (PST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id y194sm741426ooa.19.2021.03.11.12.05.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 12:05:04 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id t16so2459778ott.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 12:05:04 -0800 (PST)
X-Received: by 2002:a25:aa43:: with SMTP id s61mr14771793ybi.32.1615492624004;
 Thu, 11 Mar 2021 11:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20210311164815.14113-1-srivasam@codeaurora.org> <20210311164815.14113-2-srivasam@codeaurora.org>
In-Reply-To: <20210311164815.14113-2-srivasam@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 Mar 2021 11:56:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VSnhOSFtLX==DYF1WFszaJwgnbZY-EycP4=SNs6rqajw@mail.gmail.com>
Message-ID: <CAD=FV=VSnhOSFtLX==DYF1WFszaJwgnbZY-EycP4=SNs6rqajw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: sc7180-trogdor: Add lpass dai
 link for I2S driver
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     gross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 11, 2021 at 8:49 AM Srinivasa Rao Mandadapu
<srivasam@codeaurora.org> wrote:
>
> From: Ajit Pandey <ajitp@codeaurora.org>
>
> Add dai link for supporting lpass I2S driver, which is used
> for audio capture and playback.
> Add lpass-cpu node with  pin controls and i2s primary
> and secondary dai-links
>
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 58 ++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 436582279dad..501e3d4c9097 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/input/gpio-keys.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/sound/qcom,lpass.h>

It seems marginally better to include "sc7180-lpass.h" to get this? I
don't really know the difference between the two but since unless
we're planning to delete the sc7180 version it seems like you might as
well include that one?


>  /* PMICs depend on spmi_bus label and so must come after SoC */
>  #include "pm6150.dtsi"
> @@ -283,6 +284,42 @@ keyboard_backlight: keyboard-backlight {
>                         max-brightness = <1023>;
>                 };
>         };
> +
> +       sound: sound {
> +               compatible = "google,sc7180-trogdor";
> +               model = "sc7180-rt5682-max98357a-1mic";
> +
> +               audio-routing =
> +                       "Headphone Jack", "HPOL",
> +                       "Headphone Jack", "HPOR";
> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               dai-link@0 {
> +                       link-name = "MultiMedia0";
> +                       reg = <MI2S_PRIMARY>;
> +                       cpu {
> +                               sound-dai = <&lpass_cpu MI2S_PRIMARY>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&alc5682 MI2S_PRIMARY>;

I'm an audio noob but isn't "MI2S_PRIMARY" something to be used with
"lpass_cpu", not with "alc5682" ?

I have no idea what the IDs correspond to on "alc5682". Are you sure
we even need an extra ID there? The "alc5682" bindings upstream don't
talk anything about dai-cells, but maybe they're just wrong...

-Doug
