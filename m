Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4D434DF56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhC3D3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhC3D2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:28:21 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5BC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 20:28:11 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so14296282ota.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 20:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dq+eBETJzh+IwQFdZNDvsn/tEJj1fNCRg9j0kkHOAYE=;
        b=rReCcxh3hA7evyrVAe1zbXwbgu+v0Snn6vsRNg0EFcJ3G8FdBdZ4G/YAv0GW5YU0MB
         Bt52tvTIGV4ZxPPAfpoApHHmfOM9BLD+BGKvRYYCbQuLQBVSGeHY9vi2r0AvbtXKyKNJ
         0MIaPrSuQdg3oTlO4QQk7ajuMuz0jS8c9Lz/4XVRcdMb0maf9mBMj/cYZ8JfFxAx7PG7
         AX8q9XqC+tJXv59bZCAiQFhJziMdhB8VOOwmdgcnQFDuCbT2UA4redni8jkAzD/uPQ2X
         1yEKrxRVfpuvwaiSrjOy9BYSriLPoA5/r2O93MSKZ2N6fXWwyNULctmCBxxdvrx5RoS4
         hCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dq+eBETJzh+IwQFdZNDvsn/tEJj1fNCRg9j0kkHOAYE=;
        b=pfZFe6aaIX9XGUmScqqj6MGqr/ZFaO0dyslTPm7mvWu3elL/29LeiUNLxmeJvfu3+A
         Eje7cBXyK38r/NW9KVNIxn7w8fDVM3pnJSHfl8pMybgz/FBtE7xOIIAL5yPvaxwSRE/T
         cg+av2n7Bsc+jIxvk/XDxvh6RuljgsbZW5QHuPkm52YEoFA0sGlEyIy07CH8Mq3z51VH
         4MG/aJLPYfWixbbn64p9ZwqnFye27pec9oTluEahJ5QVIAhk305ID2dbtAPpOqW6TCb9
         Q/zQ0hrRsqckenVXto+w1aNMu2IBSBGDKcnq5r0KpnIpLI4ZHVehLpaJWID1hWkFvoSC
         zjFw==
X-Gm-Message-State: AOAM533J8nQniZA7R63XOIHALZ9HzzVAd7lBCn3KvLHkUR/Y3BxNP5Mu
        4ujHmrQ4B5Fl5Al22KF9m8S4vQ==
X-Google-Smtp-Source: ABdhPJzeQGS1J4X9mtmDhNNTR7kvClVQ7XbPuKmlo5rvCfDCGuEiueLkO66dmZ8vT+z4tY7AlPJidQ==
X-Received: by 2002:a9d:458e:: with SMTP id x14mr26450187ote.231.1617074890477;
        Mon, 29 Mar 2021 20:28:10 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f8sm3879486oij.4.2021.03.29.20.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 20:28:10 -0700 (PDT)
Date:   Mon, 29 Mar 2021 22:28:08 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 2/7] dt-bindings: phy: qcom,qmp-usb3-dp: Add support
 for SM8250
Message-ID: <YGKayHJrS0rI9A6z@builder.lan>
References: <20210328205257.3348866-1-dmitry.baryshkov@linaro.org>
 <20210328205257.3348866-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328205257.3348866-3-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 28 Mar 15:52 CDT 2021, Dmitry Baryshkov wrote:

> Add compatible for SM8250 in QMP USB3 DP PHY bindings.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> index 62c0179d1765..217aa6c91893 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> @@ -15,6 +15,7 @@ properties:
>      enum:
>        - qcom,sc7180-qmp-usb3-dp-phy
>        - qcom,sdm845-qmp-usb3-dp-phy
> +      - qcom,sm8250-qmp-usb3-dp-phy
>    reg:
>      items:
>        - description: Address and length of PHY's USB serdes block.
> -- 
> 2.30.2
> 
