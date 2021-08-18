Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371613F0C39
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhHRT66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbhHRT6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:58:31 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695F8C0617AE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:57:56 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so5620143oti.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=hMNsxaIVAKEhwUPAnI8A+Z1CyieSI/+ymj5IsPC0nx0=;
        b=BJ8XxKqZWNK+GA6AyndO/j7cjNxJpKMSCuYSPWjgJb/ckKsC2wqsaTcfweihlV2vWF
         xIWcJl8UHqrQrzoBABxdY/K72PeDLbRARVl/K7T6EH/q9oeNcAAet0rfK95TYcNtRI+e
         pF7Eborol02KyGyWnTPBNZLI+uTm7BaBQnejM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=hMNsxaIVAKEhwUPAnI8A+Z1CyieSI/+ymj5IsPC0nx0=;
        b=nsjydeyNDJfkWaJtP0Ez2C68VV9T7yMnm4WJ7X+X3f2UqDDjgkmH92lSWkgPdHvl5G
         4N3ivDtvcE37kqsysE3/EXdWX+iv7hZKqvGndBP2DOX9Ik6ED2FEGH0xpKZErFmJHFiw
         g+USdH5+HFGOPQ7E2znaVIZi9LixDTGZACqstf3FfwjAkpvzIe2oLimPgfV9WpVtbEfJ
         Phxw8BzcatmIxJsZk2vOex7fuk6zgSJwMsPgMVnuSKfAjlGFNzuMzpZPiHqfEgVCrEkp
         MWAN38fAXkrqVAKClLhY5KsWqkkeyhsNhEbKIBsXMDDl/GtgJ6mx+mnRBLlxIwlJO1xJ
         SOXg==
X-Gm-Message-State: AOAM530Se3DuJILrclq2IPDS4WTuGNZ9Hqes4e3/gIOhHQej8DHq1fvi
        pja6R+24mfwgtNGDdtJMCSsLJqZiqoDJT90hpbiirw==
X-Google-Smtp-Source: ABdhPJzmXOb8xBARc+WzsJ0z34O3SnwrY4WwT/K/Ap9nVOEzk1VWjsLwQPpXUxpXxSI8WfoySmqZymyZv1fYbWdVLZw=
X-Received: by 2002:a05:6830:2473:: with SMTP id x51mr1762198otr.34.1629316675810;
 Wed, 18 Aug 2021 12:57:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Aug 2021 12:57:55 -0700
MIME-Version: 1.0
In-Reply-To: <1629282424-4070-2-git-send-email-mkrishn@codeaurora.org>
References: <1629282424-4070-1-git-send-email-mkrishn@codeaurora.org> <1629282424-4070-2-git-send-email-mkrishn@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 18 Aug 2021 12:57:55 -0700
Message-ID: <CAE-0n50b=pX=1MFwGPDvDR=O03tUAkAgyMonGm2+SXBft=16KQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] arm64: dts: qcom: sc7280: add display dt nodes
To:     Krishna Manikandan <mkrishn@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kalyan_t@codeaurora.org, sbillaka@codeaurora.org,
        abhinavk@codeaurora.org, robdclark@gmail.com,
        bjorn.andersson@linaro.org, khsieh@codeaurora.org,
        rajeevny@codeaurora.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krishna Manikandan (2021-08-18 03:27:02)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 53a21d0..fd7ff1c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
>   */
>
> +#include <dt-bindings/clock/qcom,dispcc-sc7280.h>
>  #include <dt-bindings/clock/qcom,gcc-sc7280.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interconnect/qcom,sc7280.h>
> @@ -1424,6 +1425,90 @@
>                         #power-domain-cells = <1>;
>                 };
>
> +               mdss: mdss@ae00000 {

subsystem@ae00000

> +                       compatible = "qcom,sc7280-mdss";
> +                       reg = <0 0x0ae00000 0 0x1000>;
> +                       reg-names = "mdss";
> +
> +                       power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>;
> +
> +                       clocks = <&gcc GCC_DISP_AHB_CLK>,
> +                                <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +                               <&dispcc DISP_CC_MDSS_MDP_CLK>;
> +                       clock-names = "iface", "ahb", "core";
> +
> +                       assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
> +                       assigned-clock-rates = <300000000>;
> +
> +                       interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <1>;
> +
> +                       interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>;
> +                       interconnect-names = "mdp0-mem";
> +
> +                       iommus = <&apps_smmu 0x900 0x402>;
> +
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +
> +                       status = "disabled";
> +
> +                       mdp: mdp@ae01000 {

display-controller@ae01000

> +                               compatible = "qcom,sc7280-dpu";
> +                               reg = <0 0x0ae01000 0 0x8f030>,
> +                                       <0 0x0aeb0000 0 0x2008>;
> +                               reg-names = "mdp", "vbif";
> +
> +                               clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +                                       <&gcc GCC_DISP_SF_AXI_CLK>,
> +                                       <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +                                       <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
> +                                       <&dispcc DISP_CC_MDSS_MDP_CLK>,
> +                                       <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +                               clock-names = "bus", "nrt_bus", "iface", "lut", "core",
> +                                             "vsync";

One line per string please.

> +                               assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
> +                                               <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
> +                                               <&dispcc DISP_CC_MDSS_AHB_CLK>;
> +                               assigned-clock-rates = <300000000>,
> +                                                       <19200000>,
> +                                                       <19200000>;
> +                               operating-points-v2 = <&mdp_opp_table>;
> +                               power-domains = <&rpmhpd SC7280_CX>;
> +
> +                               interrupt-parent = <&mdss>;
> +                               interrupts = <0>;
> +
> +                               status = "disabled";
> +
> +                               mdp_opp_table: mdp-opp-table {

mdp_opp_table: opp-table {

> +                                       compatible = "operating-points-v2";
> +
> +                                       opp-200000000 {
> +                                               opp-hz = /bits/ 64 <200000000>;
> +                                               required-opps = <&rpmhpd_opp_low_svs>;
> +                                       };
> +
> +                                       opp-300000000 {
> +                                               opp-hz = /bits/ 64 <300000000>;
> +                                               required-opps = <&rpmhpd_opp_svs>;
> +                                       };
> +
> +                                       opp-380000000 {
> +                                               opp-hz = /bits/ 64 <380000000>;
> +                                               required-opps = <&rpmhpd_opp_svs_l1>;
> +                                       };
> +
> +                                       opp-506666667 {
> +                                               opp-hz = /bits/ 64 <506666667>;
> +                                               required-opps = <&rpmhpd_opp_nom>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
