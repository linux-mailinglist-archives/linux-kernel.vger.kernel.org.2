Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5016419445
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhI0McO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhI0McM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:32:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2BBC061714
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:30:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k26so11109048pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8f4/mkuvOY8+rGJAhfbTZe+oZ+Vy38+/mmlJel9bTCg=;
        b=AXX7QOP2Q1nvRSGiamW6NPuaVbis6ad1FY2R1IvUfyzLRQfw5H4803mnONI0YGAezk
         AmJzdh6ytzxtzm1ZOM59WVbDyf8pTs70hWD9VGDyLFQHl+hZlG8M5RFWplYqBn7YkQAo
         ZnZ7gld/iTXdh6q9yEelauiOg7Qrj9sop0PiYSGmh9easDH0xWqyqhBfIA7zOpsz5EW7
         0oNeIBz5O3aJsMLRhF5SdiauxhaWySzi51Rqh4YNBOlDuw1ohR2LF70tl3JgDBq1tToF
         F2O7sxl1FPn1Sl1vZHK+5ZErQQis64cJpA5vg3UUrMrKITSFPU7QpVVET+eYfh8A9jig
         Kp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8f4/mkuvOY8+rGJAhfbTZe+oZ+Vy38+/mmlJel9bTCg=;
        b=0OO8FllomWYmApRUMgkSdP3/ajjb9gUXI6iML+hi4+9mFxHmCo9RFhMomUSMuLN+sT
         UT0UXm3WiKYZv1vnNbNmiSFf9x8K3fIMM5XMdWmr2um7J12KES1+Yip6PsgoFb4tQ68Y
         2IGgjyEEvkrFLUrgQlrkFwqEzWefg+pLvMiFl97LZnu4auGteOgi5mwzVUj6zigpQv10
         BowI4DAwB4gc8ZC+IwtMkBaeiaEZD4P9q68pgVz1GpizcQ6i21cN89qk5uTXaxoU/iI5
         PjGfWtoYKrqh95d4VD13RS7ka1D4ESvzhgIlW1z9q/t2KnWoDByCnXwoxnlBlFi+Hyjk
         GZ9Q==
X-Gm-Message-State: AOAM5308VBzwTasyZ18lWcfcGnEgv/PYXL+J0Fdh2LtmjxP+3/D5tHbl
        wYll1gSQP/kohUM5IeI8mIG1gg==
X-Google-Smtp-Source: ABdhPJz8hwwjXyEE+3UAgO2auOFQcmt/X+FhXQFqDRBK1CeNhUWk0j5jHZXuOBEPwkUjIzirW3Ns7w==
X-Received: by 2002:a65:6187:: with SMTP id c7mr16325588pgv.317.1632745834548;
        Mon, 27 Sep 2021 05:30:34 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id w1sm7208159pfj.147.2021.09.27.05.30.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Sep 2021 05:30:34 -0700 (PDT)
Date:   Mon, 27 Sep 2021 20:30:27 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jami Kettunen <jamipkettunen@gmail.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,qusb2: Add missing vdd-supply
Message-ID: <20210927123026.GG9901@dragon>
References: <20210927044824.30246-1-shawn.guo@linaro.org>
 <20210927044824.30246-2-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927044824.30246-2-shawn.guo@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 12:48:22PM +0800, Shawn Guo wrote:
> Besides vdda-pll and vdda-phy-dpdm, vdd-supply is a required supply for
> PHY digital circuit operation.  Add it for correctness and completeness.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> index 48ae604b2194..96e31f582fc9 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> @@ -51,6 +51,10 @@ properties:
>        - const: ref
>        - const: iface
>  
> +  vdda-supply:

Oops, it should be `vdd-supply`.  Will fix it in v2.

Shawn

> +    description:
> +      Phandle to 0.9V regulator supply to PHY digital circuit.
> +
>    vdda-pll-supply:
>      description:
>        Phandle to 1.8V regulator supply to PHY refclk pll block.
> @@ -157,6 +161,7 @@ required:
>    - "#phy-cells"
>    - clocks
>    - clock-names
> +  - vdd-supply
>    - vdda-pll-supply
>    - vdda-phy-dpdm-supply
>    - resets
> @@ -175,6 +180,7 @@ examples:
>                   <&gcc GCC_RX1_USB2_CLKREF_CLK>;
>          clock-names = "cfg_ahb", "ref";
>  
> +        vdd-supply = <&pm8994_l28>;
>          vdda-pll-supply = <&pm8994_l12>;
>          vdda-phy-dpdm-supply = <&pm8994_l24>;
>  
> -- 
> 2.17.1
> 
