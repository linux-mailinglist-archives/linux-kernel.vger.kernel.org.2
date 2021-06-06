Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46B839CC40
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 04:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFFCV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 22:21:59 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38802 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhFFCV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 22:21:58 -0400
Received: by mail-ot1-f52.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so13188792otk.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 19:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zNbv9BC90PSJK3BiNVtXp/UlQ672WKw22htu3kgy/xM=;
        b=gXkbatGIEAUci3gDLrgIoLjjvULz58IuKuFxT4SXxR8pUL+uUfgpyyOszQAdBoZYEB
         sDDxMs9ainspWj83epDN0ouSPk5pqY3JkdigsULIszryyPv9jdYUyvC1p7ZYx1xTVXmi
         N+8l8PhCdbWRBDZOiKJTgKNt1T+xV3cY9qw/m2RcRnTM/UlFOKj/GgVNVMzdZn7TUN/B
         SwoY4cs2RaQqifbdQ5qysb31CH3Pxrp74KbwnoxfCEV5OL2qy9udGdrQ31jjgzjwQPTi
         bZpv2e4E6diBMNZavH29MJzPj/OrxfVhExmqbKttKOtW6PzkLvDhFhXYsAOhWx/xC21/
         vzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zNbv9BC90PSJK3BiNVtXp/UlQ672WKw22htu3kgy/xM=;
        b=Iv/s8dw82FPa0NCOS1Ie53pZ7PNJEutSNZ4D/POGMt9TRXfTojIqzTWrIa8tYn6AeB
         0nIMq7SETBQHbcytLMQmGE3lIZmt/dYaJ+U/lxDqTcca/GIlpOetUJ3PBZkAxClqPWx5
         YJ0u4KHZL55Z+k9S1Mfru/eLgKhCMFz7gev0ggpnKm42ceNC5Rea69uJ/laOc/MVxGwS
         oPpGRBDgkWzIwP04dL3IRqFAfLW9JsFG2PwFsvyE59/DfnGOI9TFOHZuuOHOunqgYfZC
         MKCd45M+HDmzdUJXEODbRRj8oB9gDLPpvh/erAYU2STJU2j4WBHwZJcKaZZ3NXRA4kZv
         5DCg==
X-Gm-Message-State: AOAM533j2MgPnXx6X1Ibjj7vcaxWD/utfxIaDHC9I2EmLu2rt2nWRB1p
        GRHuqkAvIwMP3R6kYbwr2xE3dA==
X-Google-Smtp-Source: ABdhPJxTktQPJ2z1NLgZoKM9jhvO1dJthPs9wgI4awNl/O4GyFHikQZtAp9jV330wRFlPKHe4KpiKw==
X-Received: by 2002:a05:6830:1e0d:: with SMTP id s13mr9231932otr.169.1622945949970;
        Sat, 05 Jun 2021 19:19:09 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n11sm1390698oom.1.2021.06.05.19.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 19:19:09 -0700 (PDT)
Date:   Sat, 5 Jun 2021 21:19:07 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     agross@kernel.org, bhelgaas@google.com, robh+dt@kernel.org,
        swboyd@chromium.org, lorenzo.pieralisi@arm.com,
        svarbanov@mm-sol.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        dianders@chromium.org, mka@chromium.org, sanm@codeaurora.org
Subject: Re: [PATCH v2 4/4] dt-bindings: pci: qcom: Document PCIe bindings
 for SC720
Message-ID: <YLwwm8UxDTSgBjy4@builder.lan>
References: <1622904059-21244-1-git-send-email-pmaliset@codeaurora.org>
 <1622904059-21244-5-git-send-email-pmaliset@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622904059-21244-5-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 05 Jun 09:40 CDT 2021, Prasad Malisetty wrote:

> Document the PCIe DT bindings for SC7280 SoC.The PCIe IP is similar
> to the one used on SM8250. Add the compatible for SC7280.
> 
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 25f4def..9c0908f 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -12,6 +12,7 @@
>  			- "qcom,pcie-ipq4019" for ipq4019
>  			- "qcom,pcie-ipq8074" for ipq8074
>  			- "qcom,pcie-qcs404" for qcs404
> +			- "qcom,pcie-sc7280" for sc7280
>  			- "qcom,pcie-sdm845" for sdm845
>  			- "qcom,pcie-sm8250" for sm8250
>  			- "qcom,pcie-ipq6018" for ipq6018
> @@ -144,6 +145,22 @@
>  			- "slave_bus"	AXI Slave clock
>  
>  - clock-names:
> +	Usage: required for sc7280
> +	Value type: <stringlist>
> +	Definition: Should contain the following entries
> +			- "aux"         Auxiliary clock
> +			- "cfg"         Configuration clock
> +			- "bus_master"  Master AXI clock
> +			- "bus_slave"   Slave AXI clock
> +			- "slave_q2a"   Slave Q2A clock
> +			- "tbu"         PCIe TBU clock
> +			- "ddrss_sf_tbu" PCIe SF TBU clock
> +			- "pipe"        PIPE clock
> +			- "pipe_src"    PIPE MUX

If you describe it as pipe _mux_, then name it pipe_mux.

> +			- "pipe_ext"    PIPE output clock

Better to name this in a way that indicates that it is the pipe clock
coming out of the phy, perhaps "phy_pipe".

But that said, as Stephen points out ensuring that the pipe_clk_src's
parent is the phy's clock can be done in DT directly.

Regards,
Bjorn

> +			- "ref"         REFERENCE clock
> +
> +- clock-names:
>  	Usage: required for sdm845
>  	Value type: <stringlist>
>  	Definition: Should contain the following entries
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
