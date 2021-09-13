Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5033409D85
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbhIMT6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242202AbhIMT63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:58:29 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C01C061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:57:13 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id x10-20020a056830408a00b004f26cead745so14984937ott.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=oVrHBVnA82OtmOYjdYw081CjAbJqok+5sFDiTTmJyOY=;
        b=FKMBKQTeyyzPpKaEb0ZcqQGcGxi2u+oJ6BAbbSTLb/qmG6yYs7aD8TekL6WQQLnawc
         gVaE3anPh7aiJhwpP4AmOxXAdbB/YtbBELHX2VQZ7uyUKUlafQsivwu2uKS9ajmfmqof
         WuOlWoTKO6xgV1zumIHyL4ZAU1I5UwdVXEfIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=oVrHBVnA82OtmOYjdYw081CjAbJqok+5sFDiTTmJyOY=;
        b=aWBxko75eEJTteDq8yPykyjomL2WiYtnyMtnU9I50T/IV3QoFSjxu9twOUSFBB+qV3
         6b75Artg4YdK9ycKIs76ootBArCqvFyuME0upSLQ+AP10ZVQfKSwP6HjrC9Claijpaij
         87kHnf/gHoqiOLhVX325wSijQJnFLxKL0PMLUo4u4F26H4itOsnp84Td0PPf67zl2wt+
         V1cfFKHQngN+jiEstJKVQKDoET+kE5uCQZxREhqXA42LnRBakqbAovvfQ+2UqnXBqIpZ
         0WU63UzweV4/+p6//VYYdMWAoB1GNCspX3OQhmn7pkH2L1gZ1OumhS7xFyzs9+CU8F+W
         /pWg==
X-Gm-Message-State: AOAM530ptFSpX7wHMD3WgtgSQHLggjmCdg/YbjtW03KB9h2zjU9s2/4j
        mFi9ApTlfr14GqBrKMyUogpDsJ2Q7eADYijsjUp7Kjze3XM=
X-Google-Smtp-Source: ABdhPJwQxAL+ThVF6V+sJim9YhLgx5h9y9zXk04Yj0aLrvGNLZyipOd51mVO66boDMbOaqY+usQDCemHnXuynotgc7Q=
X-Received: by 2002:a05:6830:719:: with SMTP id y25mr11159215ots.77.1631563032742;
 Mon, 13 Sep 2021 12:57:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Sep 2021 12:57:12 -0700
MIME-Version: 1.0
In-Reply-To: <1631530735-19811-1-git-send-email-rnayak@codeaurora.org>
References: <1631530735-19811-1-git-send-email-rnayak@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 13 Sep 2021 12:57:12 -0700
Message-ID: <CAE-0n51miUjP4dg4wQR_JBwNNvMNqAafv7jFvEKU+MrfQmhV5A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280-idp: Add vcc-supply for qfprom
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rbokka@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2021-09-13 03:58:55)
> Add vcc-supply for the IDP boards that was missed when the
> qfprom device tree properties were added for the sc7280 SoC.
>
> Fixes: c1b2189a19cf ("arm64: dts: qcom: sc7280: Add qfprom node")
> Reported-by: satya priya <skakit@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 371a2a9..99f9ee5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -207,6 +207,10 @@
>         };
>  };
>
> +&qfprom {

Maybe that node should also be marked status = "disabled" by default so
that it can only be marked OK if the board has setup the regulator
properly?

> +       vcc-supply = <&vreg_l1c_1p8>;
> +};
> +
>  &qupv3_id_0 {
>         status = "okay";
>  };
