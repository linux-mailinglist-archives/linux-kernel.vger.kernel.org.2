Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7A4004AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350447AbhICSNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350403AbhICSNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:13:32 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EC9C061760
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 11:12:31 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h133so211413oib.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=EmxGvSFHzwGSo5pc2/hQyVW83mXoB+h7zPtCUkGNIwE=;
        b=K9bKKR5p2Hj2dhQigCQ/Rvb66nsPCiDyB65R1H+Uc84IFdA9pH+Fj4/myNe5PdhG2x
         WtYjgGbOGYPlmE3ASrCrurIbw5w9QLknsSyS3BcSfN4BvuLQm0LWnjbq0cQS/hf38Tqe
         ZK/KbCE1Mq0CMe4+goX2oFt1VZ5xN4pIg580A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=EmxGvSFHzwGSo5pc2/hQyVW83mXoB+h7zPtCUkGNIwE=;
        b=g7pkkFyJcrIN0V9j5j6S1lKCyOzSxPC7fnHTYS2axz0a+eSC3fi4f+JpnApR5YXeUT
         hhvkM2nHK29VuxkO5uFSrHdJGe0mznn/rVy1x+uIT+Kj9+v843cDsCZuYfpJXCx2zQ3e
         Ll4rstxKnHtXH5mZevQMiKh4IbVPRbssPdcKXtL9+0sQEc3lxnlfRHrXp6Xmqs56ml06
         8geWKu1ggMBYczXNBQD7uc2Zn20bElkOeds6FQJuvsP0qljDJfNofEfJ0VKF6L6P0u62
         g03P3ZQY0H8ZOY5bg1u5kKOXiNWwsa/sB0xbf+gk63KAuASm7H1lmRgc/wQRFO/HQfBE
         iKXg==
X-Gm-Message-State: AOAM531Gij/t0f1G9wKYYYnMoA0/FEASackgFqqLXWkgyNEEWvrrLgm6
        00Xw9IF+4YEp7H+FdMto8eGs99yB2z1T/MSmuch+sg==
X-Google-Smtp-Source: ABdhPJwF6W9Z4C+HCFQkMAT6oKcjVmRCjzrzU0QSEWMUFiOx8lt5Tj7tw21m1kfNNgGcgcNqMTNn1WdwOzXEDm98oh8=
X-Received: by 2002:a54:4419:: with SMTP id k25mr125286oiw.32.1630692751276;
 Fri, 03 Sep 2021 11:12:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Sep 2021 14:12:30 -0400
MIME-Version: 1.0
In-Reply-To: <1630574106-3394-3-git-send-email-skakit@codeaurora.org>
References: <1630574106-3394-1-git-send-email-skakit@codeaurora.org> <1630574106-3394-3-git-send-email-skakit@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 3 Sep 2021 14:12:30 -0400
Message-ID: <CAE-0n52VOzjexezuEe449vT_crB_zVkn5Bnrkh6-RcJfWGTQ9w@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] arm64: dts: sc7280: Add volume up support for sc7280-idp
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        satya priya <skakit@codeaurora.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting satya priya (2021-09-02 02:15:06)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 371a2a9..52bcbbc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -199,6 +199,37 @@
>         modem-init;
>  };
>
> +&soc {

's' comes after 'p' so this is in the wrong place.

> +       gpio_keys {
> +               compatible = "gpio-keys";
> +               label = "gpio-keys";
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&key_vol_up_default>;
> +
> +               vol_up {
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
> +&pm7325_gpios {
> +       key_vol_up_default: key_vol_up_default {

Please move this to the "PINCTRL - additions to nodes defined in
sc7280.dtsi" section and then sort alphabetically on node naem.

> +               pins = "gpio6";
> +               function = "normal";
> +               input-enable;
> +               bias-pull-up;
> +               power-source = <0>;
> +               qcom,drive-strength = <3>;
> +       };
> +};
> +
>  &pmk8350_vadc {
>         pmk8350_die_temp {
>                 reg = <PMK8350_ADC7_DIE_TEMP>;
