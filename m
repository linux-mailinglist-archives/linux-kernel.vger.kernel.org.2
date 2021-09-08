Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FB44032F1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 05:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbhIHDf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 23:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhIHDf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 23:35:57 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8C9C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 20:34:50 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id x10-20020a056830408a00b004f26cead745so1141100ott.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 20:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=L3P6E94KgYTggNi34VPrDx8IIAdEhyLCWWiN3zBY9Js=;
        b=JlNtynvnkpQ9cbDenz1tsa/nlyMA0maw6rFk81Gw0aVDGffXlQTTa+6b7htWTRdSK+
         NEVM+wK8g5PbVzZzPOq81FZZ98qHdAbLYXSFQBwE3yxL0ns2D4V+OZwja1z77ctRXV/u
         gpPA05WutWMCzrtTk6LL0g8uHqZ9KAJG7Ghv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=L3P6E94KgYTggNi34VPrDx8IIAdEhyLCWWiN3zBY9Js=;
        b=bibzLai5/aF3t1TdTUTO492qjTwGHKc+MCO1azDwKjLgQk0VN0TapeARannZbYvjkU
         OAESGJHTLtLlrr2qRhxH5DO8N7tlarut/qZUiM5UB3VNf30YNbI4UnH9XkuQCHrXn1dv
         RjeYTTVytmqWyzLPVPVdKwKZDUmsdTda4YNiFChfqTOu6ZLWpxukn2Oed/mQdtkB5ajS
         5zB5DHxEziMYVSGTqh92Nj/Zxpj0Jn6ynzD6adwZt24RKD/J8A1PRpIdMrCr02N1odIg
         khauU9rGkchj/Yp8yT+7rw8YfZ6Ir+7FnKPkA3WPVQpZzgEzDzkTzIJc1vrM6ayH75Lt
         m7Jg==
X-Gm-Message-State: AOAM530O1KZ+mqXDRJ6MLhWfkUfE83D58G53MLhxUesBqP503XTAL9WR
        mnVTX0UJojZeQkc4KiUAPXjRpcHq5LgOp7xq17NulQ==
X-Google-Smtp-Source: ABdhPJyg6igS7IIqsGysq/0S3geeIlQjSOmbIIyrAPs2dYADUam233q3f/f5Bbz2/xP4NNavIoeMzXqtJhdu5C4/8ws=
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr1328000otp.159.1631072089755;
 Tue, 07 Sep 2021 20:34:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Sep 2021 03:34:49 +0000
MIME-Version: 1.0
In-Reply-To: <1630924867-4663-4-git-send-email-skakit@codeaurora.org>
References: <1630924867-4663-1-git-send-email-skakit@codeaurora.org> <1630924867-4663-4-git-send-email-skakit@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 8 Sep 2021 03:34:49 +0000
Message-ID: <CAE-0n51CCqrbKr9NCkzaK3JxCtJgRKdXTeR4kxnnOK_wNKpP6A@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm8350c: Add pwm support
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        satya priya <skakit@codeaurora.org>
Cc:     mka@chromium.org, kgunda@codeaurora.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting satya priya (2021-09-06 03:41:07)
> Add pwm support for PM8350C pmic.
>
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8350c.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8350c.dtsi b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> index e1b75ae..ecdae55 100644
> --- a/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> @@ -29,6 +29,12 @@
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
>                 };
> +
> +               pm8350c_pwm4: pwm {
> +                       compatible = "qcom,pm8350c-pwm";

Shouldn't there be a reg property?

> +                       #pwm-cells = <2>;
> +                       status = "okay";
> +               };
>         };
>  };
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
