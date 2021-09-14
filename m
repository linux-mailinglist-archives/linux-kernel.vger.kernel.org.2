Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D56640B842
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhINTjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbhINTjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:39:35 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4C6C061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:38:18 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x10-20020a056830408a00b004f26cead745so93222ott.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=MLQfJAb2nshbl/BB+0CPYD8WzePweEOPxKjryODlhBY=;
        b=fU+2fUmhgATKS8sAffT3oVU6G2cnoZkbVdK4P3jZkCaJb9Xfxl7zEis23p11wyRKLT
         gevV9/SEA5s4KPdSYD/V458UJayvvtRbj36OivXuugfYVP8wsl59bEM5GB4iKnz7Luph
         dlhHwKeU4rYMBNLJ08Mo9iphxOG4w0qe+9FXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=MLQfJAb2nshbl/BB+0CPYD8WzePweEOPxKjryODlhBY=;
        b=Q9zf+puoA+6883d2RjO8GlfbtI5kCg9lDvxWisYxVD4sxBUBe9bg+q/KfE2XkjjLPY
         v78eSIjkTRl2oQisilpcbDFyvH0pbRZITg/h8TkHiBXrSruvIRDpG502PVFFays7ms3m
         wJFsz9S3SVQ0EgjApWtYQeESFR4T8+7VV7EmFUnroAXS1dg087wIx0DzF3LDxD8T+gTe
         1uFwtf0eEIaTugR20bnP9jhRLR9eCNZCtMFBF7dihD+/hKKfIprNivfipWnlJkWkgKs/
         d+nogBRl49Y4AkuXLI2PlIc0mJg+h+I0hGLLbPdT/alEyNFQ0dkU74JGz9gDKaTmz96Q
         UsjA==
X-Gm-Message-State: AOAM533HJVbRTXzO3ugBdTVIGpu/eUS+DH7Vae84zGkv7Z3wEeLzv3T8
        lDyDSrl9xjm4yj8QthSiPoZGKOKKFP5y8piTqMcVHQ==
X-Google-Smtp-Source: ABdhPJxur0KKzVgNz/Rt1leSMplGKbq52Yi9bMuRCAElrwUadKtFKUESc7Cpo+vzi77WMrUS5VZsmr6ZB/ewu6AFCd0=
X-Received: by 2002:a05:6830:719:: with SMTP id y25mr16212633ots.77.1631648296004;
 Tue, 14 Sep 2021 12:38:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Sep 2021 12:38:15 -0700
MIME-Version: 1.0
In-Reply-To: <1631624108-15491-3-git-send-email-skakit@codeaurora.org>
References: <1631624108-15491-1-git-send-email-skakit@codeaurora.org> <1631624108-15491-3-git-send-email-skakit@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 14 Sep 2021 12:38:15 -0700
Message-ID: <CAE-0n53z4SmMAM4VfY+beCHNzpYfQN7+LsXJBGXC3+7Lm-s1XA@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] arm64: dts: sc7280: Add volume up support for sc7280-idp
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <skakit@codeaurora.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2021-09-14 05:55:08)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 371a2a9..003112f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -239,6 +239,26 @@
>         cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
>  };
>
> +&soc {
> +       gpio-keys {

This should be in the root node, not soc node as it doesn't have any reg
property. Please move it to / and put it at the top of the file.

> +               compatible = "gpio-keys";
> +               label = "gpio-keys";
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&key_vol_up_default>;
> +
> +               volume-up {
> +                       label = "volume_up";
> +                       gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
> +                       linux,input-type = <1>;
> +                       linux,code = <KEY_VOLUMEUP>;
> +                       gpio-key,wakeup;
> +                       debounce-interval = <15>;
> +                       linux,can-disable;
> +               };
> +       };
> +};
> +
>  &uart5 {
>         status = "okay";
>  };
