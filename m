Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088E23FC03F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 03:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbhHaA65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhHaA64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:58:56 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358A6C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:58:02 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id n27so22682782oij.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=XYpN3SAtfvTTijjUpUhGm+neUMN/BjViflHhfgj+W+M=;
        b=L1SCg7SonFYijTI7AWQxcDtkQmPNoWFDMG13dWrcS1VQ/1iHc3PEAkb9tExC8YJbKy
         4snvL1BY+USFvZP7f0P7Cbu7NDyBed617lUjXt+lDKKURJmqQLdG/wG2Htcv5cj64mb9
         rxH50EQScj5U8ghqPdl/ltVmwxEsXiwPQ7JtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=XYpN3SAtfvTTijjUpUhGm+neUMN/BjViflHhfgj+W+M=;
        b=SL0dJi3nFiSA1R2fFtj3Bt62DFtdTw+05qo/Do8qd7xL5iPX7T3dtaWqT1n/kfsHKI
         pAKlZqGwQen8wPkmNd98jmkH0yly5uMfJ0+2PAJD997nB2cZAFp4HCE8ilmOMFCsC8FR
         pSzrkenmwrsI/e1T8lr+ZtxefBy+lQLz0ARuAd4sLioaSTLHtPE16Eka5jcldjJ+x6Gj
         xhxcKPbbRbT5INDFTpGJj+/xI1Z26RsoANKrFjA0S8RenRLSaHfdXD3GNas4HKZzRJs+
         VbbsCXbG0oWyCAXdey/Nbta4FQsP3ODTJw+byDI4KFON15mavPF2Bcqh36R/xiiE9I5C
         U7bA==
X-Gm-Message-State: AOAM530bRd82jZeMoTWauhXHYQvKrOyKYOvVn2WdZN/+kMMRxLdeh+fn
        QT75C9PW+q3o1H4yGAdF8AMLja0rFs77QVo1Zy0yAg==
X-Google-Smtp-Source: ABdhPJyAt70CIHuM1fAQgI+/NvPTolzh5c0egjVTluneOAw3mU57bB65j1CAQcMKkEBiPn0xE3peYDhwnb/M7j3U7Sk=
X-Received: by 2002:aca:2310:: with SMTP id e16mr1421394oie.64.1630371481520;
 Mon, 30 Aug 2021 17:58:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Aug 2021 17:58:01 -0700
MIME-Version: 1.0
In-Reply-To: <1630339489-23172-1-git-send-email-khsieh@codeaurora.org>
References: <1630339489-23172-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 30 Aug 2021 17:58:00 -0700
Message-ID: <CAE-0n52OjXovJJ2HNFPgyGn6vS84wgrEv4C66-tb176nUbdwSg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Add Display Port node
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        robdclark@gmail.com, robh+dt@kernel.org, sean@poorly.run,
        vkoul@kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        mkrishn@codeaurora.org, kalyan_t@codeaurora.org,
        rajeevny@codeaurora.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-08-30 09:04:49)
> Changes in v2:
> -- break this patch into 3 patches

Are there two more somewhere?

>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 88 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index c29226b..f224029 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3202,6 +3202,13 @@
>                                                         remote-endpoint = <&edp_in>;
>                                                 };
>                                         };
> +
> +                                       port@2 {
> +                                                reg = <2>;
> +                                                dpu_intf0_out: endpoint {
> +                                                        remote-endpoint = <&dp_in>;
> +                                                };
> +                                        };
>                                 };
>
>                                 mdp_opp_table: mdp-opp-table {
> @@ -3389,6 +3396,78 @@
>                                         };
>                                 };
>                         };
> +
> +                       msm_dp: displayport-controller@ae90000 {
> +                               status = "disabled";
> +                               compatible = "qcom,sc7180-dp", "qcom,sc7280-dp";

It should be most specific to least specific from left to right. I'd
rather see "qcom,sc7180-dp" dropped entirely as it will become important
to know that sc7280 has eDP and DP whereas sc7180 only has DP. We should
key that knowledge off the compatible string, so having sc7180-dp here
makes that harder, not easier.

> +
> +                               reg = <0 0x0ae90000 0 0x1400>;
> +
> +                               interrupt-parent = <&mdss>;
> +                               interrupts = <12>;
> +
> +                               clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +                                        <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
> +                                        <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
> +                                        <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
> +                                        <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
> +                               clock-names =   "core_iface",
> +                                               "core_aux",
