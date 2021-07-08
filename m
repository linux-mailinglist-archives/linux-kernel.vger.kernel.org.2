Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A283C1BA7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 01:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhGHXHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 19:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhGHXHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 19:07:35 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8472C061762
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 16:04:52 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso7517413otu.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dXlhvqLqeesC0V9Ud3A6Hb+9uMtm23VDqYomKJ4kiMo=;
        b=KjK2DfuIawxaKf5cNWtZqEpy5YsTzJPZzEMxA3F1Wac7TiFBC1WaU9LyfzPL1pEYba
         L5miusR+y5Kw9ZyPQYhheJvQyrIjoG93pL1BXQTqC2+nT90rkZCF3PMoK5JdjMIcXf68
         xe4ovI39dOIqWfqyKlL2lC08ZN0rpKl8UYWR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dXlhvqLqeesC0V9Ud3A6Hb+9uMtm23VDqYomKJ4kiMo=;
        b=CEkwdF7qzeuR8nMq3u06XhWe0l7aA3JHGT2h8gVvAkw+Z5efXX2gSSwCrCvxiceT4o
         i74fb6wfA1LCyEIVbGFILUY9xoEwfU5QiFdViIzUoZXx8H+qSL0y67mjtm3l4ndohcwm
         PJaPJEhu1jxVMZSdrMS+0Ew8rh9RIPuBVzZHvk9OiLCk0aZ2ybqud6e0Uh6/nOEIchR7
         /GdrXF+QcV6fmKCdKylPARyk4OtWspsRZ44fjMysq7xhVq+DE93u/LHZxiaKIij2XytA
         Y2ptQu4p4pkaWg6A+R2bCs4l+aGECReJfSoC/cWAvV0SLWmUDYvG0pbxBaKI9dVt7jyz
         6pyQ==
X-Gm-Message-State: AOAM533jlthmJrkKZOiGgiqnMXGxj2nXKtUVjJQwyBFs2DI3qWBTkpL9
        tiwTqHea8rkiU9eHYBKnveTEZYUsWa2KvRwNeYvRbA==
X-Google-Smtp-Source: ABdhPJzQhxGAjOGE9PXbxeTBzmNHSu8sTbztwVFR1Qu05dto6fm1iVJ7+yGW4nD7WJ/Larke5f6IrsaQzkuiij9sJfI=
X-Received: by 2002:a05:6830:1353:: with SMTP id r19mr25979929otq.233.1625785491904;
 Thu, 08 Jul 2021 16:04:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jul 2021 23:04:51 +0000
MIME-Version: 1.0
In-Reply-To: <1624015734-16778-4-git-send-email-okukatla@codeaurora.org>
References: <1624015734-16778-1-git-send-email-okukatla@codeaurora.org> <1624015734-16778-4-git-send-email-okukatla@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 8 Jul 2021 23:04:51 +0000
Message-ID: <CAE-0n52XPJ7COZc7Zy=721-FGPX9D=vSFR_qccL86UXuABuy9Q@mail.gmail.com>
Subject: Re: [V4 3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect provider
To:     Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, evgreen@google.com,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Odelu Kukatla (2021-06-18 04:28:54)
> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SC7280
> SoCs.
>
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 38a7f55..7690d7e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1153,6 +1153,15 @@
>                         };
>                 };
>
> +               epss_l3: interconnect@18590000 {
> +                       compatible = "qcom,sc7280-epss-l3";
> +                       reg = <0 0x18590000 0 1000>, <0 0x18591000 0 0x100>,
> +                               <0 0x18592000 0 0x100>, <0 0x18593000 0 0x100>;
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
> +                       clock-names = "xo", "alternate";
> +                       #interconnect-cells = <1>;
> +               };

Is this inside the soc node? Because it should be but then the next node
is called 'interconnect' and has no address so that is probably outside
the soc node. Please put nodes with a reg property like this into the
soc node.

> +
>                 clk_virt: interconnect {
>                         compatible = "qcom,sc7280-clk-virt";
>                         #interconnect-cells = <2>;
