Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE8A4205BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhJDGQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhJDGP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:15:58 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18C8C061788
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 23:14:08 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r201so9619825pgr.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 23:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l1url66F0t/sCmMZqx5y0fYEDd1yfCg2fr6WFfRQ3Fw=;
        b=sEc2mG/IcBMiant54vsDVEnr8ub9YZTmeOslKiDh2u/Y77UCVeiXyrf1pwXLdAOTpg
         KTsglb+CAiSbLenzU3T/Us7uAipU7l+BKt7fjNtHDptylOtGdJ7kG4cAuXwaVov+q6bk
         deNIPO9tPs+4kvzxr1eSqduYV4/aFuuf7keyx4w0icaYHiO3+PKHkx8wuje8P+bZ54Rl
         Tdk3rXUAZEx86R8oViottUEtZK04mxPhhlClibA+mGNtqfNuiS5W1AbDKwDQ1+0aivOQ
         SmHNIfqZ58LSEqLn7bmZ6W9hYAOlOsjE4ESgYgVPS0LwLI33X/wD6KwLTpbX2L7KQRjC
         44aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l1url66F0t/sCmMZqx5y0fYEDd1yfCg2fr6WFfRQ3Fw=;
        b=A3QtQWjQQu1O6zBELNRTpb4ldh4e1irvFAWk8P7GS5Imo7dUV8c69JvBQJWoXMEmZg
         cxXWGHVF4a9iElHXVdne2T9YlCFEUUJo98LmfoHWFZtbzJuxTQ630nTotGgRs1Mfddo1
         N2kWaK62XErZHwtO9CLZ5xdp+rR01Z9E+nP5SmdqvzM1bQ1rykWzlsMeU6vz+1I84a9Z
         d8narry5Di2Uk7D+dqK//0gB9ftrrupfeUd4JMIrjCP5EHV8Iq4vcUlLhyIyzrq5R9Jf
         t/lgHAmV203qQyVVMTTznIVWrpl+XOIppfEaEsP/Ri2AnqPOgxpEw0NBCURBy/7HqdTp
         g3EA==
X-Gm-Message-State: AOAM530Xcj8MZ8mYQj6+yPiB3e0Gaxa708x3FI+rBRnUwJLeVLMCvLyB
        HB7bwlCwSYGRH/GYeeppNZaq/1N/p1+hJg==
X-Google-Smtp-Source: ABdhPJxW9fa52UROhfFkyQi74ZWZotCpSVB8zQ3pXKHnyqZiheRubcZmxJTYmBrc6vPNc0b49P1zeA==
X-Received: by 2002:a62:5185:0:b0:43e:79c:6b6 with SMTP id f127-20020a625185000000b0043e079c06b6mr23361454pfb.79.1633328048527;
        Sun, 03 Oct 2021 23:14:08 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id q27sm6004041pfg.125.2021.10.03.23.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 23:14:08 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:44:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: spear13xx: Drop malformed 'interrupt-map' on
 PCI nodes
Message-ID: <20211004061406.tyhldt4f26zilaaw@vireshk-i7>
References: <20210928192143.1841497-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928192143.1841497-1-robh@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-09-21, 14:21, Rob Herring wrote:
> The spear13xx PCI 'interrupt-map' property is not parse-able.
> '#interrupt-cells' is missing and there are 3 #address-cells. Based on the
> driver, the only supported interrupt is for MSI. Therefore, 'interrupt-map'
> is not needed.
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/boot/dts/spear1310.dtsi | 6 ------
>  arch/arm/boot/dts/spear1340.dtsi | 2 --
>  2 files changed, 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
> index c4b49baf9804..2f746a9428a7 100644
> --- a/arch/arm/boot/dts/spear1310.dtsi
> +++ b/arch/arm/boot/dts/spear1310.dtsi
> @@ -82,8 +82,6 @@ pcie0: pcie@b1000000 {
>  			reg = <0xb1000000 0x4000>, <0x80000000 0x20000>;
>  			reg-names = "dbi", "config";
>  			interrupts = <0 68 0x4>;
> -			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0x0 0 &gic 0 68 0x4>;
>  			num-lanes = <1>;
>  			phys = <&miphy0 1>;
>  			phy-names = "pcie-phy";
> @@ -101,8 +99,6 @@ pcie1: pcie@b1800000 {
>  			reg = <0xb1800000 0x4000>, <0x90000000 0x20000>;
>  			reg-names = "dbi", "config";
>  			interrupts = <0 69 0x4>;
> -			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0x0 0 &gic 0 69 0x4>;
>  			num-lanes = <1>;
>  			phys = <&miphy1 1>;
>  			phy-names = "pcie-phy";
> @@ -120,8 +116,6 @@ pcie2: pcie@b4000000 {
>  			reg = <0xb4000000 0x4000>, <0xc0000000 0x20000>;
>  			reg-names = "dbi", "config";
>  			interrupts = <0 70 0x4>;
> -			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0x0 0 &gic 0 70 0x4>;
>  			num-lanes = <1>;
>  			phys = <&miphy2 1>;
>  			phy-names = "pcie-phy";
> diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
> index 1a8f5e8b10e3..827e887afbda 100644
> --- a/arch/arm/boot/dts/spear1340.dtsi
> +++ b/arch/arm/boot/dts/spear1340.dtsi
> @@ -47,8 +47,6 @@ pcie0: pcie@b1000000 {
>  			reg = <0xb1000000 0x4000>, <0x80000000 0x20000>;
>  			reg-names = "dbi", "config";
>  			interrupts = <0 68 0x4>;
> -			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0x0 0 &gic 0 68 0x4>;
>  			num-lanes = <1>;
>  			phys = <&miphy0 1>;
>  			phy-names = "pcie-phy";

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
