Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FC1419FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 21:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhI0UAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbhI0UAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:00:45 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A87C061740
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:59:07 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so19094230otv.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Zu4vVZfjBvQG3c6lbaKUHBCzEAuiakqkbk50f2WpbsU=;
        b=AUyYGatR0L+ZAKRYrOlQa80vyKI4RtAEG94vt6NYNKIOWE0vptxcS8+qUX7Sz1357u
         qpszknbOqc9pLBVdgtyIF48d3cQmUmSaSCzlDuVJzvRytz/cGUZOITkkYWDoum4Ns3xf
         qAoNh30tgT2G3Y9Anl4BqRWEJGJG3AgH2h0Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Zu4vVZfjBvQG3c6lbaKUHBCzEAuiakqkbk50f2WpbsU=;
        b=ybDGzuQoF06mh6O+H/PDh9K8pQegJJ0tGELfMtARR/uTorWcLYAJqQv7A5MFEPiopb
         AKOv6owp7+cd5N6b8z92XYtPDar5Pde80WTLB/w7NOSPZOk3yNKqCtbbclNdr1sevryO
         32rebPzme1R/+3/VXAJIZlwc3UXNYMAv/XUQ76zuMysph/uABRzmqvr2iGazfEihNcM+
         VjlL9s2fbB0hoTGnIB9suqGSubI82lhblPdKfeRlr9J/TrgYMX5QtMeP4VDP1540qma/
         U8zdOfql3K2+rgl+50YdWLnuM1S1vVWTGbkp+JWwqcVazYVPsd3jAcjivUzuS4ytxL1D
         QmBg==
X-Gm-Message-State: AOAM532unQtO55ZglPCQcUMPMX29Jan2eeNRcbrQCJTYbOYu4aiFpmzu
        yHEgpGO+enLkULXU/7BBRuGNuv7VECirH1oTzwpL+b7H6WA=
X-Google-Smtp-Source: ABdhPJy55etq8fVl9RMOyOF/0w7JpQU+TZK4qTsk4iPj6m0oB6kxb3YiQ0adJRdVSHKh0ncjuHvTRXnwExL89xLGtTA=
X-Received: by 2002:a05:6830:708:: with SMTP id y8mr1581379ots.77.1632772746544;
 Mon, 27 Sep 2021 12:59:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Sep 2021 12:59:05 -0700
MIME-Version: 1.0
In-Reply-To: <20210924165322.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
References: <20210924165322.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 27 Sep 2021 12:59:05 -0700
Message-ID: <CAE-0n53uBf-qbPptg-=9TX3=FGG4PvtVARfipxriJRE6cdWt4A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sc7180: Factor out ti-sn65dsi86 support
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-09-24 16:54:13)
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
> new file mode 100644
> index 000000000000..7b1034a5a8e9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Trogdor dts fragment for the boards with TI sn65dsi86 edp bridge
> + *
> + * Copyright 2021 Google LLC.
> + */
> +
> +&dsi0_out {
> +       remote-endpoint = <&sn65dsi86_in>;
> +       data-lanes = <0 1 2 3>;
> +};
> +
> +&edp_brij_i2c {
> +       sn65dsi86_bridge: bridge@2d {
> +               compatible = "ti,sn65dsi86";
> +               reg = <0x2d>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&edp_brij_en>, <&edp_brij_irq>;

Why not move edp_brij_en as well? I think you want to reuse the node
name for the other bridge, but it doesn't make sense unless that other
patch is part of this series.

> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-parent = <&tlmm>;
> +               interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> +
> +               enable-gpios = <&tlmm 104 GPIO_ACTIVE_HIGH>;
