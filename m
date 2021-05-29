Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79FA394D1D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 18:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhE2Q0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 12:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhE2Q0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 12:26:49 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A84C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 09:25:12 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id y76so7562741oia.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jFAfU25Qj+cRqC0XFUI+YM1/RbEp8mIA/HiLs0SBEww=;
        b=g9Yqyl1WpDSv/0jO/8xVebd6wKxwc1+dm5MG4cr1gcfh4MVIFuW2eIp16PL+ioaq6b
         5L5ImayrkmN0Piha2bK33MCQU3H32blsZiLieEi1ooIigoVz+L6cfTU1HGSLnvcxtrHv
         v08QobuUW7y4BwxG3lspItWjIKotSoSKQQyQAOqiJ/4/y0PAXxzBosA0FMd3d6T6Dg1U
         Q0JeBHx1LmMoXg//RBbtD375VoYoI5ABs73doALxcRvCAFKoXvWLD/gsfON7XmFt52F1
         R1wxRFB5cLaFR8fnh9e+VBZYKGjaFuzlgwE6AX8eMdU1BLkzT+Hn0O574yFETWeYl7VQ
         x1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jFAfU25Qj+cRqC0XFUI+YM1/RbEp8mIA/HiLs0SBEww=;
        b=txx9OHMWpPtIiPhRKCbWJm6Q5Uf03pMZk0lB2hFzFccsvlhepeX5CtlZy01V2xuNPq
         DDD+vw/PXqR5wolFL2vS1BcyyoF48CAfNC48ufb82xCAsgRBnPSw8pbA03xrY+SCjmMi
         x+hKokzHJruP8MMXP0VzgzEgmJCk8y0JpeZkI/3lV31CDbMCQkkt0dkYiB0vwaE+0T6B
         q3+mcs2JS7hW+hi2JsXAAqwKgn0hVKXog8sFh8CrY6jiz6TdEavShm/pxsiVQ6GwnhU5
         Vamlyloimlsbp/NSeB94cfhEiKHPG8iq9gaboVVkbeAaP0eK/8qJnDQxFOSY/vtyVG7y
         MsTQ==
X-Gm-Message-State: AOAM530eaORHbFAzigk1V8Huz5o15AjnqvaToEnL+dLl1nJBdFJ5jOBS
        MGZ/wr5iKhqyeBWxxZGkw24O5A==
X-Google-Smtp-Source: ABdhPJzBeIa8BbBikxQvxrQptxn7sm9GORyImFhfYm4PvpYKjjqs0wQnZEDwWHVXmVQL8iJtsNq8vw==
X-Received: by 2002:aca:488f:: with SMTP id v137mr9350654oia.173.1622305511911;
        Sat, 29 May 2021 09:25:11 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e21sm1750706oii.23.2021.05.29.09.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 09:25:11 -0700 (PDT)
Date:   Sat, 29 May 2021 11:25:09 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vkoul@kernel.org, kishon@ti.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,qmp: Add binding for SDX55
 PCIe PHY
Message-ID: <YLJq5R4uMYRDppmv@builder.lan>
References: <20210427065400.18958-1-manivannan.sadhasivam@linaro.org>
 <20210427065400.18958-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427065400.18958-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27 Apr 01:53 CDT 2021, Manivannan Sadhasivam wrote:

> Add devicetree binding for PCIe PHY found in Qcom SDX55 platform.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index 626447fee092..d5162d58a479 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -43,6 +43,7 @@ properties:
>        - qcom,sm8350-qmp-ufs-phy
>        - qcom,sm8350-qmp-usb3-phy
>        - qcom,sm8350-qmp-usb3-uni-phy
> +      - qcom,sdx55-qmp-pcie-phy
>        - qcom,sdx55-qmp-usb3-uni-phy
>  
>    reg:
> @@ -301,6 +302,7 @@ allOf:
>              enum:
>                - qcom,sdm845-qhp-pcie-phy
>                - qcom,sdm845-qmp-pcie-phy
> +              - qcom,sdx55-qmp-pcie-phy
>                - qcom,sm8250-qmp-gen3x1-pcie-phy
>                - qcom,sm8250-qmp-gen3x2-pcie-phy
>                - qcom,sm8250-qmp-modem-pcie-phy
> -- 
> 2.25.1
> 
