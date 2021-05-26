Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BBC392341
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhEZXcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbhEZXcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:32:16 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275ECC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:30:43 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so2686064otk.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=f5inNoG6a1gTVFSlqHBbHpaamu/nM0OCFBdJlQ1D2b4=;
        b=XDHTBKkDEJnhJrFGseooYsd4kQeneJs4gHZDUzntBQK2nX6BR0r8RRK/jXNZWJW+yk
         udmeLGKlob/OFeevQOnF6CU7EhfozmZckYdxCtTP+DXOACzlXL5aTmXAV3BF7ukwf9Dk
         84BXoMjH5IAWQZYBbtS7ydMQbPoU+NIMEN+JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=f5inNoG6a1gTVFSlqHBbHpaamu/nM0OCFBdJlQ1D2b4=;
        b=IsFMl/LtfSOIM5sM4riYLZuOMQI2b6AFedHnzITfd7aFirbQGqQsEpFH9r2b2eUio7
         jSCeAT3A9NItTGgMiTRyyigbLTyN3XGQHmvO7xQp998r53nBZxU00eKM4v22+3GaX4cw
         zzzhLCP4Rqwkb4HpPEDI8KC4AIDjME+ndWmPqZOfTN6jZRgNInkmeVQjTeqOQnaMySZ/
         ErqymN1W0iG6SPN30/Iecr+3Kt80ePx02fkdDq3EnOPR2FmEG9MCVnaIotnQ2yM+6dD5
         pVZI06sEoewXyp/GAjCdc7mndjngrYOkIFa9Hw6PjVzt0pAXp9n3Q9c2Cqx1DQtpW9aw
         U/6w==
X-Gm-Message-State: AOAM533XSbOrUSGWydQQNd9Lqo/At3N1RmLrn/WzGRHkJ2kZHcWblWN5
        Kej3puKQoQF4aG3ZNnM7hStvxpyE13U+ojw6g+zD9Q==
X-Google-Smtp-Source: ABdhPJxUxK7okjBvGfnVz8YwxgspwwpdkerGy69t5hvFu8M6YbAcJcqhes4w84JyUA3Qjzurg3kZlbcmXZenHnLSHts=
X-Received: by 2002:a05:6830:1556:: with SMTP id l22mr563949otp.34.1622071842580;
 Wed, 26 May 2021 16:30:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 May 2021 19:30:42 -0400
MIME-Version: 1.0
In-Reply-To: <1621596371-26482-6-git-send-email-mkshah@codeaurora.org>
References: <1621596371-26482-1-git-send-email-mkshah@codeaurora.org> <1621596371-26482-6-git-send-email-mkshah@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 26 May 2021 19:30:42 -0400
Message-ID: <CAE-0n53-4sLWh9LAX9eqUutc206vq8mnUTPfQKmvvsRPiCiDew@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] arm64: dts: qcom: sc7280: Enable SoC sleep stats
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, linux@roeck-us.net,
        rnayak@codeaurora.org, lsrao@codeaurora.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2021-05-21 04:26:11)
> Add device node for SoC sleep stats driver which provides various
> low power mode stats.
>
> Also update the reg size of aoss_qmp device to 0x400.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Same question as in sc7180.

>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 2cc4785..47afca8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -827,7 +827,7 @@
>
>                 aoss_qmp: power-controller@c300000 {
>                         compatible = "qcom,sc7280-aoss-qmp";
> -                       reg = <0 0x0c300000 0 0x100000>;
> +                       reg = <0 0x0c300000 0 0x400>;
>                         interrupts-extended = <&ipcc IPCC_CLIENT_AOP
>                                                      IPCC_MPROC_SIGNAL_GLINK_QMP
>                                                      IRQ_TYPE_EDGE_RISING>;
> @@ -838,6 +838,11 @@
>                         #power-domain-cells = <1>;
>                 };
>
> +               rpmh-sleep-stats@c3f0000 {
> +                       compatible = "qcom,rpmh-sleep-stats";
> +                       reg = <0 0x0c3f0000 0 0x400>;
> +               };
> +
>                 spmi_bus: spmi@c440000 {
>                         compatible = "qcom,spmi-pmic-arb";
>                         reg = <0 0x0c440000 0 0x1100>,
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
