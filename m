Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A893DA9F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhG2RTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhG2RTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:19:37 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C8DC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:19:33 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso6591176otq.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=JcuPL2E0yGh3YMQ5Ryjgd8htxcjiWk/JLPxwWfyTTEI=;
        b=KLCY003udwzbwW5s6LyNduchb1uN48eo8fIMzMQLlYES2R18futSNL9RxxsZHwnYbd
         /b5ktnC/xdeo/sJ5ZpltOyfNxiFZiBjHJlGRUh7CFaOpRJGZeE42o5mq2Ex2oELSBlCN
         IGYOONXVZ2/HJiKfQ9cKd2unJKWBj40fZ1+3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=JcuPL2E0yGh3YMQ5Ryjgd8htxcjiWk/JLPxwWfyTTEI=;
        b=NIpD3v5c9btZP0RM8sXBdMXrO9A2JyiZUUvftBUm7oZdQn1Tv2kX5EgQ488O4pQlWo
         s6AEA5YX0LXBPFo5mvGhSFaCGPJd+o+xHBgfGwMG+I2AXLnCppS1MjmEyrHoe3yV4A4Y
         8BcO1rs78iyBjaRiO/JxajqniegjKHE92XVaQZWKj46qXAqLVdus99PtiDS7MxYP2J13
         kK+Bh43STE8b9WGNc5sfIhkhF0P11jGW8p2S133xFRUsPM1ivjF6GxFa6YcEpvr3/saf
         VYu4g9dQ5U//hiu3iyNsXRUIt2AXZYpbxhd8IQ6ciwCzIQKyFflYlzC+r5hAcqV8pcaL
         ejiA==
X-Gm-Message-State: AOAM532xOkYbhY8jVINvEqVfrOvKkhLL4/cXIb0FNRYGP3UF/9z4Xdij
        4gvuPxRPySaCCwim6n7frCcsl++ukiYjieuzUfN5DQ==
X-Google-Smtp-Source: ABdhPJxm3TNkTt83zHPFaTJ+JLOdxmNPIABd6fWr/eYibpJ0bq8EyQFF2n6jRlWgUra5oNFfYz42SdCYS/JjQAGbOPI=
X-Received: by 2002:a9d:650e:: with SMTP id i14mr4267279otl.233.1627579173391;
 Thu, 29 Jul 2021 10:19:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Jul 2021 12:19:33 -0500
MIME-Version: 1.0
In-Reply-To: <1627473242-35926-1-git-send-email-akhilpo@codeaurora.org>
References: <1627473242-35926-1-git-send-email-akhilpo@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 29 Jul 2021 12:19:32 -0500
Message-ID: <CAE-0n53xMHudWaL7gdnN7jEPE1uLmetZaxYiqToO1AzTZ2R0Mw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sc7280: Add gpu support
To:     Akhil P Oommen <akhilpo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Jordan Crouse <jordan@cosmicpenguin.net>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akhil P Oommen (2021-07-28 04:54:01)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 029723a..c88f366 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -592,6 +593,85 @@
>                         qcom,bcm-voters = <&apps_bcm_voter>;
>                 };
>
> +               gpu@3d00000 {
> +                       compatible = "qcom,adreno-635.0", "qcom,adreno";
> +                       #stream-id-cells = <16>;
> +                       reg = <0 0x03d00000 0 0x40000>,
> +                             <0 0x03d9e000 0 0x1000>,
> +                             <0 0x03d61000 0 0x800>;
> +                       reg-names = "kgsl_3d0_reg_memory",
> +                                   "cx_mem",
> +                                   "cx_dbgc";
> +                       interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +                       iommus = <&adreno_smmu 0 0x401>;
> +                       operating-points-v2 = <&gpu_opp_table>;
> +                       qcom,gmu = <&gmu>;
> +                       interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
> +                       interconnect-names = "gfx-mem";
> +
> +                       gpu_opp_table: opp-table {
> +                               compatible = "operating-points-v2";
> +
> +                               opp-550000000 {
> +                                       opp-hz = /bits/ 64 <550000000>;
> +                                       opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +                                       opp-peak-kBps = <6832000>;
> +                               };
> +
> +                               opp-450000000 {

Why is 450000000 after 550000000? Is it on purpose? If not intended
please sort by frequency.

> +                                       opp-hz = /bits/ 64 <450000000>;
> +                                       opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +                                       opp-peak-kBps = <4068000>;
> +                               };
> +
> +                               opp-315000000 {
> +                                       opp-hz = /bits/ 64 <315000000>;
> +                                       opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +                                       opp-peak-kBps = <1804000>;
> +                               };
> +                       };
> +               };
> +
