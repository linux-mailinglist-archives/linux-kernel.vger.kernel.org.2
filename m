Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898A93B2F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhFXMxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFXMxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:53:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD28BC061574;
        Thu, 24 Jun 2021 05:51:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id m14so8354316edp.9;
        Thu, 24 Jun 2021 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cXgs/H2Ss7ydk6tGIYig2RRn6vmV4/Hxg3x36YlAm54=;
        b=ZxcniuJy7lot2VHpSyOZzV7y6XNQvaSRuvfU28UXfIHieKG/b/wZ2lZCj/ose4T7Xp
         SeeKSqMzzGi8OyuGGAmCFUpIMftuIZzShLUpVU4mmqm77JrE/JdRWuTGdIbDKSLCcGhv
         YJF6n0CiCwNPBJn1FJ7V8OGcfzvD/MutGoyh8VJMiO0NmcZnIECcfbgiF6qsP1Ehvyhp
         9YOG76JyIkwQD/Vk+cff5sNvmrTwSf5B8xvJyUrHutduom93eE3+79iqXd+e1AnaFeh0
         TP3X/R2gU9mDsORzheQcg4vRyOtSnKUmI1VgpRRpr1ZEbl5Eay4Z3myvMJaU0+AIJZBc
         TmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cXgs/H2Ss7ydk6tGIYig2RRn6vmV4/Hxg3x36YlAm54=;
        b=KIOXRE+aIpkw1l/MQ4vr7bOXN6Ly6zOnUxjEKNxk6hGX0G4FsEevUaXr4knkJXDRUr
         RujR0NgbbJMb+mu/riSEtekAKUcdU0Twiz8ivI4U2gEs9jrLpiBn4Q6Cuo3Fjqp3Oiug
         M4Z+NmIAq1srN/x1lBy0Atg58ZJFoXN5rs8wAEAsz0Kr9onjsdYf8qXimv2ZDU+MfQdy
         TORcwUATYHqFJN/NDYgG/Qv66YuyZ3vVyey+plysGyRStvB419gQJcFMuUdpwoUhQr4/
         LXeP9HqgvKVLKFMWjjuZ4QI+ZyX4VvLjiop76ovtV6GNR54p9oTpcHCIsoPwy0gJbi9B
         og3A==
X-Gm-Message-State: AOAM530KXsjCLvtpuB/VctNps2kjoqvvs2UzEzuSS2lVR7JJ7SVr+d3q
        lAB3uzoPnJ3DMZ7tfROwTuR8UPI5N5zSFg==
X-Google-Smtp-Source: ABdhPJykhpQj5lvOAPdcQ7OJ1/EK64x9MCu3YbzDshBYruajktaU7PHjpIlvztdkaVbzv6DCSp4XlQ==
X-Received: by 2002:a05:6402:4242:: with SMTP id g2mr6921829edb.350.1624539078291;
        Thu, 24 Jun 2021 05:51:18 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n13sm1167281ejk.97.2021.06.24.05.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 05:51:17 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] arm64: dts: rockchip: add pmu and qos nodes for
 rk3568
To:     cl@rock-chips.com, heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org
References: <20210624114719.1685-1-cl@rock-chips.com>
 <20210624114719.1685-4-cl@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <f2a2a079-10e8-e8a5-87ea-245e315429f2@gmail.com>
Date:   Thu, 24 Jun 2021 14:51:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624114719.1685-4-cl@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

The nodes without 'reg' are sort alphabetically.
Nodes with 'reg' are sort on reg number.

pmu:     power-management@fdd90000 {}
sdmmc2:  mmc             @fe000000 {}
qos_gpu: qos             @fe128000 {}
[..]
sdmmc0:  mmc             @fe2b0000 {}

Johan

On 6/24/21 1:47 PM, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> Add the power-management and QoS nodes to the core rk3568 dtsi.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 229 +++++++++++++++++++++++
>  1 file changed, 229 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index d225e6a45d5c..2737f26775ff 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/power/rk3568-power.h>
>  #include <dt-bindings/soc/rockchip,boot-mode.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
> @@ -257,6 +258,234 @@
>  		status = "disabled";
>  	};
>  
> +	pmu: power-management@fdd90000 {
> +		compatible = "rockchip,rk3568-pmu", "syscon", "simple-mfd";
> +		reg = <0x0 0xfdd90000 0x0 0x1000>;
> +
> +		power: power-controller {
> +			compatible = "rockchip,rk3568-power-controller";
> +			#power-domain-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* These power domains are grouped by VD_GPU */
> +			power-domain@RK3568_PD_GPU {
> +				reg = <RK3568_PD_GPU>;
> +				clocks = <&cru ACLK_GPU_PRE>,
> +					 <&cru PCLK_GPU_PRE>;
> +				pm_qos = <&qos_gpu>;
> +				#power-domain-cells = <0>;
> +			};
> +
> +			/* These power domains are grouped by VD_LOGIC */
> +			power-domain@RK3568_PD_VI {
> +				reg = <RK3568_PD_VI>;
> +				clocks = <&cru HCLK_VI>,
> +					 <&cru PCLK_VI>;
> +				pm_qos = <&qos_isp>,
> +					 <&qos_vicap0>,
> +					 <&qos_vicap1>;
> +				#power-domain-cells = <0>;
> +			};
> +
> +			power-domain@RK3568_PD_VO {
> +				reg = <RK3568_PD_VO>;
> +				clocks = <&cru HCLK_VO>,
> +					 <&cru PCLK_VO>,
> +					 <&cru ACLK_VOP_PRE>;
> +				pm_qos = <&qos_hdcp>,
> +					 <&qos_vop_m0>,
> +					 <&qos_vop_m1>;
> +				#power-domain-cells = <0>;
> +			};
> +
> +			power-domain@RK3568_PD_RGA {
> +				reg = <RK3568_PD_RGA>;
> +				clocks = <&cru HCLK_RGA_PRE>,
> +					 <&cru PCLK_RGA_PRE>;
> +				pm_qos = <&qos_ebc>,
> +					 <&qos_iep>,
> +					 <&qos_jpeg_dec>,
> +					 <&qos_jpeg_enc>,
> +					 <&qos_rga_rd>,
> +					 <&qos_rga_wr>;
> +				#power-domain-cells = <0>;
> +			};
> +
> +			power-domain@RK3568_PD_VPU {
> +				reg = <RK3568_PD_VPU>;
> +				clocks = <&cru HCLK_VPU_PRE>;
> +				pm_qos = <&qos_vpu>;
> +				#power-domain-cells = <0>;
> +			};
> +
> +			power-domain@RK3568_PD_RKVDEC {
> +				clocks = <&cru HCLK_RKVDEC_PRE>;
> +				reg = <RK3568_PD_RKVDEC>;
> +				pm_qos = <&qos_rkvdec>;
> +				#power-domain-cells = <0>;
> +			};
> +
> +			power-domain@RK3568_PD_RKVENC {
> +				reg = <RK3568_PD_RKVENC>;
> +				clocks = <&cru HCLK_RKVENC_PRE>;
> +				pm_qos = <&qos_rkvenc_rd_m0>,
> +					 <&qos_rkvenc_rd_m1>,
> +					 <&qos_rkvenc_wr_m0>;
> +				#power-domain-cells = <0>;
> +			};
> +
> +			power-domain@RK3568_PD_PIPE {
> +				reg = <RK3568_PD_PIPE>;
> +				clocks = <&cru PCLK_PIPE>;
> +				pm_qos = <&qos_pcie2x1>,
> +					 <&qos_pcie3x1>,
> +					 <&qos_pcie3x2>,
> +					 <&qos_sata0>,
> +					 <&qos_sata1>,
> +					 <&qos_sata2>,
> +					 <&qos_usb3_0>,
> +					 <&qos_usb3_1>;
> +				#power-domain-cells = <0>;
> +			};
> +		};
> +	};
> +
> +	qos_gpu: qos@fe128000 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe128000 0x0 0x20>;
> +	};
> +
> +	qos_rkvenc_rd_m0: qos@fe138080 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe138080 0x0 0x20>;
> +	};
> +
> +	qos_rkvenc_rd_m1: qos@fe138100 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe138100 0x0 0x20>;
> +	};
> +
> +	qos_rkvenc_wr_m0: qos@fe138180 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe138180 0x0 0x20>;
> +	};
> +
> +	qos_isp: qos@fe148000 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe148000 0x0 0x20>;
> +	};
> +
> +	qos_vicap0: qos@fe148080 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe148080 0x0 0x20>;
> +	};
> +
> +	qos_vicap1: qos@fe148100 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe148100 0x0 0x20>;
> +	};
> +
> +	qos_vpu: qos@fe150000 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe150000 0x0 0x20>;
> +	};
> +
> +	qos_ebc: qos@fe158000 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe158000 0x0 0x20>;
> +	};
> +
> +	qos_iep: qos@fe158100 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe158100 0x0 0x20>;
> +	};
> +
> +	qos_jpeg_dec: qos@fe158180 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe158180 0x0 0x20>;
> +	};
> +
> +	qos_jpeg_enc: qos@fe158200 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe158200 0x0 0x20>;
> +	};
> +
> +	qos_rga_rd: qos@fe158280 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe158280 0x0 0x20>;
> +	};
> +
> +	qos_rga_wr: qos@fe158300 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe158300 0x0 0x20>;
> +	};
> +
> +	qos_npu: qos@fe180000 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe180000 0x0 0x20>;
> +	};
> +
> +	qos_pcie2x1: qos@fe190000 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe190000 0x0 0x20>;
> +	};
> +
> +	qos_pcie3x1: qos@fe190080 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe190080 0x0 0x20>;
> +	};
> +
> +	qos_pcie3x2: qos@fe190100 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe190100 0x0 0x20>;
> +	};
> +
> +	qos_sata0: qos@fe190200 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe190200 0x0 0x20>;
> +	};
> +
> +	qos_sata1: qos@fe190280 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe190280 0x0 0x20>;
> +	};
> +
> +	qos_sata2: qos@fe190300 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe190300 0x0 0x20>;
> +	};
> +
> +	qos_usb3_0: qos@fe190380 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe190380 0x0 0x20>;
> +	};
> +
> +	qos_usb3_1: qos@fe190400 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe190400 0x0 0x20>;
> +	};
> +
> +	qos_rkvdec: qos@fe198000 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe198000 0x0 0x20>;
> +	};
> +
> +	qos_hdcp: qos@fe1a8000 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe1a8000 0x0 0x20>;
> +	};
> +
> +	qos_vop_m0: qos@fe1a8080 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe1a8080 0x0 0x20>;
> +	};
> +
> +	qos_vop_m1: qos@fe1a8100 {
> +		compatible = "rockchip,rk3568-qos", "syscon";
> +		reg = <0x0 0xfe1a8100 0x0 0x20>;
> +	};
> +
>  	sdmmc2: mmc@fe000000 {
>  		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
>  		reg = <0x0 0xfe000000 0x0 0x4000>;
> 
