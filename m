Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD2F3F8DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243296AbhHZSNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbhHZSNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:13:15 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32836C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:12:28 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id z1-20020a4a2241000000b0028e8dfb83b4so1213246ooe.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=AxuMHEj6fNThx2BafHSJxMXA6L5giJ6rsjtS/v61dCk=;
        b=nlTPsZyafxTMTHVJGQtCR2Wyadxf5wJkwXZsETVKpNjWYNfo3yayF0agsAFi8c4R17
         N5D7w7jVKx/sDKsxvrABMScXcIMCezJ5rxnnYGJkqA/kqXq9fgI/qii5A5AQCBkNEHrQ
         Qd2hntalOnHgrAwnGNwAETf3USMPefWsbT2hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=AxuMHEj6fNThx2BafHSJxMXA6L5giJ6rsjtS/v61dCk=;
        b=Xk5BNDIFTrcaknIWxdNM0DeD7G4yHcp8gSQZzgnRjo7qMh23uwGLPHAitD6m+N4T7Y
         eF3LN2hnHbFAQ+tKEIIJnChJRdT3ygYckRx1+WrYfnHfpGl9dkf1R9k1yKge6UyHv2tB
         wz37+5lRT6tYxF8VG76UrS7GjnPwg7SdahpseTIcWf1bZ9k3I7GW8UkfHxTqQ3jdsf/t
         nsQoZ8MqnGY9PdEwzBuNOdK6pofPWnDGphCbSgV5HaFg0PZAS6j6nfwp1GyGZiVNXff+
         mMXqfVYrUUEFGaYPCf6t5PaB2jJn81RzSu4r9yX6TqKMqMHNDTKv1o4NnnjITJ31GDva
         KoyA==
X-Gm-Message-State: AOAM532yzHE13kT1ocPwrhEd/EUeMLTi0t8qAl2o7PrE8RfGS5I7ArrD
        dQ6BIcpV3CGJkklOsH7VFUa/J5cjDlYgB7ny0x/dIg==
X-Google-Smtp-Source: ABdhPJw6hmNBI0LDQvr1Y2brYsZM09cv+lpcrLntgYK0k8jmoAK/ueKoVpRHYGOyz8FSljlStnpzUDJhO3v7OCexqmQ=
X-Received: by 2002:a4a:a841:: with SMTP id p1mr4333374oom.92.1630001547429;
 Thu, 26 Aug 2021 11:12:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Aug 2021 18:12:27 +0000
MIME-Version: 1.0
In-Reply-To: <1629983731-10595-8-git-send-email-rajpat@codeaurora.org>
References: <1629983731-10595-1-git-send-email-rajpat@codeaurora.org> <1629983731-10595-8-git-send-email-rajpat@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 26 Aug 2021 18:12:27 +0000
Message-ID: <CAE-0n538LE+Ln_4j63heVsuADOma5+oD2z6uSiQGdn7qpEhwgA@mail.gmail.com>
Subject: Re: [PATCH V6 7/7] arm64: dts: sc7280: Add aliases for I2C and SPI
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajesh Patil (2021-08-26 06:15:31)
> Add aliases for i2c and spi for sc7280 soc.
>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 32f411f..c659f61 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -28,6 +28,38 @@
>         aliases {
>                 mmc1 = &sdhc_1;
>                 mmc2 = &sdhc_2;
> +               i2c0 = &i2c0;
> +               i2c1 = &i2c1;
> +               i2c2 = &i2c2;
> +               i2c3 = &i2c3;
> +               i2c4 = &i2c4;
> +               i2c5 = &i2c5;
> +               i2c6 = &i2c6;
> +               i2c7 = &i2c7;
> +               i2c8 = &i2c8;
> +               i2c9 = &i2c9;
> +               i2c10 = &i2c10;
> +               i2c11 = &i2c11;
> +               i2c12 = &i2c12;
> +               i2c13 = &i2c13;
> +               i2c14 = &i2c14;
> +               i2c15 = &i2c15;

Please alphabet sort this on alias name. "i" before "m"

> +               spi0 = &spi0;
> +               spi1 = &spi1;
> +               spi2 = &spi2;
> +               spi3 = &spi3;
> +               spi4 = &spi4;
> +               spi5 = &spi5;
> +               spi6 = &spi6;
> +               spi7 = &spi7;
> +               spi8 = &spi8;
> +               spi9 = &spi9;
> +               spi10 = &spi10;
> +               spi11 = &spi11;
> +               spi12 = &spi12;
> +               spi13 = &spi13;
> +               spi14 = &spi14;
> +               spi15 = &spi15;
>         };
>
>         clocks {
> --
