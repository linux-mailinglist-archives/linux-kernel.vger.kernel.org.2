Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9637AD0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhEKRZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhEKRZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:25:14 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D250C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:24:07 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l6so19751546oii.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=XmrHR0LeLKDOvGPgiLH+kJ5EvGhX8fXlpAVkIlJfG5Y=;
        b=ATUh//YBW0Kw74D+sxRJrzheCmYrLCvVYSnudw0MzUBiWvifsoq65X0GohbI/FJmLc
         wHZlQB62/PKMGGjmqnh0EqEhctNqpE+hapeWnE4mZtFedRZAlgC1lsUoA0i5ZFcOJGtI
         QaJv6IHglbHVjBIDlTl58pUY6Tj3IYxDac1W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=XmrHR0LeLKDOvGPgiLH+kJ5EvGhX8fXlpAVkIlJfG5Y=;
        b=K/ONJcyHyUeuSAa4Mlnn+Cx536hjc6P+oaSPWfmtVZTq9WY3shLPb0z5k6tyr2qqcv
         vm+cM66tzK+mfKfHlaJnAOT85qVNmZpmSLKmOescEPkOwrX7iOwx6f9z0d0HXLpdUSer
         c4X4hRaAEtLyzRHVVP9Kg23ri0LcT7qMbETZ3KGc9OT75wth5riAq7sVMS19vjgF36mK
         xdvhN9L1+0wRPLYGtR+duKYVQ9sjIfRrsveARjac45utwiUL+JsLDhNvt9PWGaNgzkuv
         j2NGbBq5g7FCOb3eC87pTO9m4f+FnYYV5MIP/hqwyjM89m3eHDpk4VEgGnvn6VPFyNJ8
         HGhQ==
X-Gm-Message-State: AOAM533gdYzoFD+c7oBTuCGQD/O8J3AgeR7XAJmJjG8l7ZmWJ9HcuTr3
        fmIwOoq2Lrwrzud/KUq8YiTZNm5w9fq1D2cNs4tFXw==
X-Google-Smtp-Source: ABdhPJxusffkMJZCUwfXdGeGXpS0u/Ku8ZMHDBE3M2DepCZjKd6VqVmO6mnhU1hB5cse8s5416ajbmCkrUpyE24HNPk=
X-Received: by 2002:aca:654d:: with SMTP id j13mr4398347oiw.125.1620753846715;
 Tue, 11 May 2021 10:24:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 May 2021 10:24:06 -0700
MIME-Version: 1.0
In-Reply-To: <20210511041930.592483-1-bjorn.andersson@linaro.org>
References: <20210511041930.592483-1-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 11 May 2021 10:24:06 -0700
Message-ID: <CAE-0n53CxUfHerU68ShKiDPGRSfB-2Cwbt+aHrQsyF6XSMc=CA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Introduce Qualcomm eDP/DP PHY binding
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, sbillaka@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-05-10 21:19:29)
> diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> new file mode 100644
> index 000000000000..c258e4f7e332
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/qcom,edp-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm DP/eDP PHY
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description:
> +  The Qualcomm DP/eDP PHY is found in a number of Qualcomm platform and
> +  provides the physical interface for DisplayPort and Embedded Display Port.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sc8180x-dp-phy
> +      - qcom,sc8180x-edp-phy
> +
> +  reg:
> +    items:
> +      - description: PHY base register block
> +      - description: tx0 register block
> +      - description: tx1 register block
> +      - description: PLL register block
> +
> +  clocks:
> +    maxItems: 2

Can this be items: - const: again? I think having maxItems means you can
have one or two items, which wouldn't match the number of clock-names
then.

> +
> +  clock-names:
> +    items:
> +      - const: aux
> +      - const: cfg_ahb
> +
