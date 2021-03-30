Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984D334DF4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhC3D3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhC3D17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:27:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF9BC061764
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 20:27:57 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so14295941ota.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 20:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8DbFJ3M1KptfbL7xxLrTG18whdlv0dnlNnoRLxaa9Tg=;
        b=G6bCnZEXEeDMrcEirVNwI79rVnOvK5cnEBznAA6jt7cWSs8Ywg/5KusLilOi8zv/tm
         yFeAuIlS4+JKUjKURUdTohpFARW+q5WVTCmwa2Z5FU7AIWSbmnZXgcDQf4OavpeYfOjh
         mytTXHHObIprDm+hNjuq79cNTcv45PKsIp6m7PlUtOg0YFJB5plkUplw4M9bzz6zmVmk
         yATQhT6QVqDI2KsaRUK9qdbUM2VFvJ2GKpQD/ew3PkDOb7MgfrnVRcybGOCAkWjFAQG6
         vLLdoHCSa0r2J0AWbHdheUtV5tSJmbogmBA0te2G0IvNuriakwvd8AqenxeL93NwAMOI
         ZuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8DbFJ3M1KptfbL7xxLrTG18whdlv0dnlNnoRLxaa9Tg=;
        b=NbNBessX6BSzD9HcPfx9KpZZFwtSrWmxVv60CSjdkUbGpVc6ZjVz9EyHMDHszvxmvg
         atBGQxC4783zXwEVXsYt/y4ZNbR2v4PsHqayPasNZz16T0Qe7gUSxM4BNaczkgZJ9WX5
         zcD9gR0HWldEj5GRKYfWUjIb4l37sabzci54N5q3BAhokyYDtDZCZFYRUirtwi8luUbY
         Hubbci0nSBGTLItF22rbpnTtPh2/tpA2gjA+sG9aD/7XafH/AnKUXGUI2zo737XWuny7
         6Ei4WFVjBJqfPc82NnZhqU5kINSmBkWX3GvCrDgLd0Daq+H2YDJ5DTaGmsIebG5Rt8I2
         PXYQ==
X-Gm-Message-State: AOAM532MI57VMJ4fmCh8PRRiawBIWOWRFsI/wyp9JWYABU5kNFsxsoMD
        2foWp2YrJoW0j32cCGZbDY3K3g==
X-Google-Smtp-Source: ABdhPJzkO+2sPQfxp3IkoZFiefo3ExhfKmCm6Rdil8CIyeiMiC/iYxryzL7zecU76P2w2kIdfV2xTA==
X-Received: by 2002:a9d:1c7:: with SMTP id e65mr25209471ote.259.1617074877280;
        Mon, 29 Mar 2021 20:27:57 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g13sm4820693otq.3.2021.03.29.20.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 20:27:56 -0700 (PDT)
Date:   Mon, 29 Mar 2021 22:27:54 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/7] dt-bindings: phy: qcom,qmp-usb3-dp-phy: move usb3
 compatibles back to qcom,qmp-phy.yaml
Message-ID: <YGKaumYvK4EI8haV@builder.lan>
References: <20210328205257.3348866-1-dmitry.baryshkov@linaro.org>
 <20210328205257.3348866-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328205257.3348866-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 28 Mar 15:52 CDT 2021, Dmitry Baryshkov wrote:

> The commit 724fabf5df13 ("dt-bindings: phy: qcom,qmp-usb3-dp: Add DP phy
> information") has support for DP part of USB3+DP combo PHYs. However
> this change is not backwards compatible, placing additional requirements
> onto qcom,sc7180-qmp-usb3-phy and qcom,sdm845-qmp-usb3-phy device nodes
> (to include separate DP part, etc). However the aforementioned nodes do
> not inclue DP part, they strictly follow the schema defined in the
> qcom,qmp-phy.yaml file. Move those compatibles, leaving
> qcom,qmp-usb3-dp-phy.yaml to describe only real "combo" USB3+DP device nodes.
> 
> Fixes: 724fabf5df13 ("dt-bindings: phy: qcom,qmp-usb3-dp: Add DP phy information")
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Sandeep Maheswaram <sanm@codeaurora.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml         | 2 ++
>  Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index 626447fee092..7808ec8bc712 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -25,11 +25,13 @@ properties:
>        - qcom,msm8998-qmp-pcie-phy
>        - qcom,msm8998-qmp-ufs-phy
>        - qcom,msm8998-qmp-usb3-phy
> +      - qcom,sc7180-qmp-usb3-phy
>        - qcom,sc8180x-qmp-ufs-phy
>        - qcom,sc8180x-qmp-usb3-phy
>        - qcom,sdm845-qhp-pcie-phy
>        - qcom,sdm845-qmp-pcie-phy
>        - qcom,sdm845-qmp-ufs-phy
> +      - qcom,sdm845-qmp-usb3-phy
>        - qcom,sdm845-qmp-usb3-uni-phy
>        - qcom,sm8150-qmp-ufs-phy
>        - qcom,sm8150-qmp-usb3-phy
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> index 33974ad10afe..62c0179d1765 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> @@ -14,9 +14,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,sc7180-qmp-usb3-dp-phy
> -      - qcom,sc7180-qmp-usb3-phy
>        - qcom,sdm845-qmp-usb3-dp-phy
> -      - qcom,sdm845-qmp-usb3-phy
>    reg:
>      items:
>        - description: Address and length of PHY's USB serdes block.
> -- 
> 2.30.2
> 
