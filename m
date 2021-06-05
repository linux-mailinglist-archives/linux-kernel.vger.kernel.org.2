Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F4939C6D7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 10:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFEIgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 04:36:43 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:47048 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFEIgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 04:36:41 -0400
Received: by mail-ot1-f50.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso11413690otl.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 01:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xBV9HQE6LSgYnjZVgsIOmo2PRbMwZA/ckSgBtoYgAJM=;
        b=STGjXij3JqwF7wloVQRWY4phBR14Uf0yDtHOxJ/sYXc1OwcDp5c+IXfOtARdk1Frx4
         kXI0QW0NyKG/IaOry5E96m9X8EwovQ0CJgUP2D4z6VNpnb17GNGnPd1UormSjUCpc+sQ
         7cgJlSdp7ETsEe0TwYVsCRYs1nWwdDyQ/ptKDLpmJ74ZQVYcy2RAniy+IFMyxbbJQby+
         lX7BDN1VnEIUN3l58Dro+7xcHF5lw2YF7qxg7w+5oK4MPRQ+IOixFP2D1y2JPoqjqFST
         Q4A+/v1+tTi/cf/wMWXmBJTBMnPWhlaBuTZIF8Lk4aViocWjSPQvs2/Eb052iTYEHVX4
         mizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBV9HQE6LSgYnjZVgsIOmo2PRbMwZA/ckSgBtoYgAJM=;
        b=uYUimbN28YJSAvlB+Qrx8e/i2nam5ErXiO88fj7c4ABeXvcoW5KWNhPoop6u4Uhmrj
         xbldYXTkKajt7Pitaiz2EJaEwnq5ptG3PhphbA6B6ty1laUBk1Wj+VnUUuSKNz5nlR3r
         eN9XL+a+SA4laO9XXjgJ8uglCqBl1kLgMKYc7KUx0IyjP8566m/7ie81wApwIXF0mxKS
         BHeSA1M3jTo1G+jkioSMH5mZ0q6fNZEGxymN0KUh8HEaRZZNUJtYSIaSF6T9/sWKvCqc
         J0fLVU1Ryx7uKJi7Pi5WfoKZ//B+vSWqo4DiWtmBI7bHUDjgVTb6g0YGVlQjMX+gRRDq
         3ZTA==
X-Gm-Message-State: AOAM532XhvEhHC9i5CKLl+SeG5DXmTZbxwg1rjlsa9h/TR+C3PpfOfkT
        XPKPSS5S5g9m87r0sbv0nmPVBr9weBRcKZS4jYHO7Q==
X-Google-Smtp-Source: ABdhPJxRmPVU6f456kI2Kv4UtWeYtFvXR43WBVmOga1zilDIm/FcYb+VcXfmzAcsqPPxx3iIignQ0+Ff8kG68Gq8t0k=
X-Received: by 2002:a9d:6117:: with SMTP id i23mr6623646otj.28.1622882021804;
 Sat, 05 Jun 2021 01:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-9-bhupesh.sharma@linaro.org> <20210521014646.GA2472971@robh.at.kernel.org>
In-Reply-To: <20210521014646.GA2472971@robh.at.kernel.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sat, 5 Jun 2021 14:03:31 +0530
Message-ID: <CAH=2Ntw=d9bf44mHp=tHDNuo-3bK+mcBZ3WgLESF5UNCRXj2Lg@mail.gmail.com>
Subject: Re: [PATCH v3 08/17] dt-bindings: crypto : Add new compatible strings
 for qcom-qce
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 21 May 2021 at 07:16, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, May 19, 2021 at 08:06:51PM +0530, Bhupesh Sharma wrote:
> > Newer qcom chips support newer versions of the qce crypto IP, so add
> > soc specific compatible strings for qcom-qce instead of using crypto
> > IP version specific ones.
> >
> > Cc: Thara Gopinath <thara.gopinath@linaro.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: dmaengine@vger.kernel.org
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-crypto@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: bhupesh.linux@gmail.com
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> > index 4be9ce697123..7722ac9529bf 100644
> > --- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> > +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> > @@ -15,7 +15,12 @@ description: |
> >
> >  properties:
> >    compatible:
> > -    const: qcom,crypto-v5.1
>
> You can't get rid of the old one.

Ok, I will fix it in v4.

Thanks,
Bhupesh

> > +    enum:
> > +      - qcom,ipq6018-qce
> > +      - qcom,sdm845-qce
> > +      - qcom,sm8150-qce
> > +      - qcom,sm8250-qce
> > +      - qcom,sm8350-qce
> >
> >    reg:
> >      maxItems: 1
> > @@ -71,7 +76,7 @@ examples:
> >    - |
> >      #include <dt-bindings/clock/qcom,gcc-apq8084.h>
> >      crypto-engine@fd45a000 {
> > -        compatible = "qcom,crypto-v5.1";
> > +        compatible = "qcom,ipq6018-qce";
> >          reg = <0xfd45a000 0x6000>;
> >          clocks = <&gcc GCC_CE2_AHB_CLK>,
> >                   <&gcc GCC_CE2_AXI_CLK>,
> > --
> > 2.31.1
> >
