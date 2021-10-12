Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F011C42A32D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhJLL0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbhJLL0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:26:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AA8C06161C;
        Tue, 12 Oct 2021 04:24:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z11so77435417lfj.4;
        Tue, 12 Oct 2021 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XVOm5FGSYg3Wq94ChxX1Do2Ep5eV8n1vjTJF2QVl0/0=;
        b=BWZ+p8qDQDxGbNrPcN16gX5ktfYM5CuLC9Yl7J9QByxYXfR9WKt69BG9hhcogYnIB4
         ds+KDyyHEAaeP4dnmIxfDKyYfB5I3DpcyH4hxOamp8KzS79SQuKO8hFnUzGZM4C4YqS1
         wLK8yANYm2DetRPmP22pYyNOi61V1SagzxWblNXKTPkSrnu+YdgP1e8s2sjeIv/c7uGy
         gcJ5ZEZpkcQnomPsmexcxqb4peUv12VVCf6Hfb77i/czvGtUzGe+TVKuOCS3AacNsYdc
         p2aBWMKkn3NkzQlXUI8LZGWGBK2OFQSSWo4VlSFjNq+LP1Q8I+C1VIZHujCb9hyZYx72
         G0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVOm5FGSYg3Wq94ChxX1Do2Ep5eV8n1vjTJF2QVl0/0=;
        b=UkWVowkgfvcd0zkmiUqlBreHvDDXSWPoNDnxsSQJXf50UIsjP3tLEeHHz6WqLBq5aj
         hGaud38YqKuo0ScL9VPNkia9e8cmXfGpklSnZ7nElaLchn5qoTuGAxC97mfi8lKUeXQj
         VH5IN9H1UzDfuXl7UdnWLfaq930PJ4NeyjEUINa/1xuQlQq6+3r+9iGYfU/tk3CO5FkW
         Mx4YIEBaALlOOIfK9Ml6fgXIF3ZdyeaaSOqqcim+Pk//fflvPlo7V6lbnPknok+e/Xvu
         vW9FMdmzj4eCnn1/up/Bj7I3rbUBBRXXL7puvYuB0MgMTLwbrrEPJ88Dx8OornDUW1zw
         hBlA==
X-Gm-Message-State: AOAM531CkYhzhrL9amIJauxh/dSTGpbgAExYZ+an3YJMDTVt7gkg4W7Y
        Nn7zr3vMSum8pFBi0xLgVx8=
X-Google-Smtp-Source: ABdhPJzcjto+YCbFvFXmN/xZUnyBv5qEou5lZu159EZ2ncRvDB3X9yyFRAhPMnFi5b6nrSOvNQ9DYg==
X-Received: by 2002:a05:651c:1615:: with SMTP id f21mr28174162ljq.318.1634037870108;
        Tue, 12 Oct 2021 04:24:30 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o6sm157218lfr.19.2021.10.12.04.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 04:24:29 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        vkoul@kernel.org, michael.riesch@wolfvision.net,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v1 3/3] arm64: dts: rockchip: add naneng combo phy nodes for rk3568
Date:   Tue, 12 Oct 2021 13:24:27 +0200
Message-ID: <13667811.Il6DKqvvJ9@archbook>
In-Reply-To: <20210826123844.8464-4-yifeng.zhao@rock-chips.com>
References: <20210826123844.8464-1-yifeng.zhao@rock-chips.com> <20210826123844.8464-4-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 26. August 2021 14:38:44 CEST Yifeng Zhao wrote:
> Add the core dt-node for the rk3568's naneng combo phys.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 68 ++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> b/arch/arm64/boot/dts/rockchip/rk356x.dtsi index d89831bee1eb..b421e3d52412
> 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -214,11 +214,31 @@
>  		};
>  	};
> 
> [...]
> 
> +	combphy0_us: phy@fe820000 {
> +		compatible = "rockchip,rk3568-naneng-combphy";
> +		reg = <0x0 0xfe820000 0x0 0x100>;
> +		#phy-cells = <1>;
> +		clocks = <&pmucru CLK_PCIEPHY0_REF>, <&cru PCLK_PIPEPHY0>,
> +			 <&cru PCLK_PIPE>;
> +		clock-names = "ref", "apb", "pipe";
> +		assigned-clocks = <&pmucru CLK_PCIEPHY0_REF>;
> +		assigned-clock-rates = <100000000>;
> +		resets = <&cru SRST_P_PIPEPHY0>, <&cru SRST_PIPEPHY0>;
> +		reset-names = "combphy-apb", "combphy";
> +		rockchip,pipe-grf = <&pipegrf>;
> +		rockchip,pipe-phy-grf = <&pipe_phy_grf0>;
> +		status = "disabled";
> +	};

RK3566 doesn't have this PHY I believe so it shouldn't be in the
rk356x.dtsi file. It needs to be moved to rk3568.dtsi.

The other two combphy nodes are shared between the two SoCs so
they can stay here.

> +
> +	combphy1_usq: phy@fe830000 {
> +		compatible = "rockchip,rk3568-naneng-combphy";
> +		reg = <0x0 0xfe830000 0x0 0x100>;
> +		#phy-cells = <1>;
> +		clocks = <&pmucru CLK_PCIEPHY1_REF>, <&cru PCLK_PIPEPHY1>,
> +			 <&cru PCLK_PIPE>;
> +		clock-names = "ref", "apb", "pipe";
> +		assigned-clocks = <&pmucru CLK_PCIEPHY1_REF>;
> +		assigned-clock-rates = <100000000>;
> +		resets = <&cru SRST_P_PIPEPHY1>, <&cru SRST_PIPEPHY1>;
> +		reset-names = "combphy-apb", "combphy";
> +		rockchip,pipe-grf = <&pipegrf>;
> +		rockchip,pipe-phy-grf = <&pipe_phy_grf1>;
> +		status = "disabled";
> +	};
> +
> +	combphy2_psq: phy@fe840000 {
> +		compatible = "rockchip,rk3568-naneng-combphy";
> +		reg = <0x0 0xfe840000 0x0 0x100>;
> +		#phy-cells = <1>;
> +		clocks = <&pmucru CLK_PCIEPHY2_REF>, <&cru PCLK_PIPEPHY2>,
> +			 <&cru PCLK_PIPE>;
> +		clock-names = "ref", "apb", "pipe";
> +		assigned-clocks = <&pmucru CLK_PCIEPHY2_REF>;
> +		assigned-clock-rates = <100000000>;
> +		resets = <&cru SRST_P_PIPEPHY2>, <&cru SRST_PIPEPHY2>;
> +		reset-names = "combphy-apb", "combphy";
> +		rockchip,pipe-grf = <&pipegrf>;
> +		rockchip,pipe-phy-grf = <&pipe_phy_grf2>;
> +		status = "disabled";
> +	};
> +
>  	pinctrl: pinctrl {
>  		compatible = "rockchip,rk3568-pinctrl";
>  		rockchip,grf = <&grf>;


Regards,
Nicolas Frattaroli


