Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2901241B8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242832AbhI1VAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbhI1VAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:00:00 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2339C061746
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:58:20 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so94745ota.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=JxCbOz9qgttDGSSzA1A+6uSJW6TvZefvlJJb7t5kz1o=;
        b=duC8iY3GkRQ5Nob6TY8qS1K8UBtaDRxsgpLtkJ0Yvh/yjxWmMoaKqrdC9Ny+iT0jeD
         +9BBeke8Ciy45JL2dmx6DioP1WSAZ/CsoO1fPDb7g/OMWcPbzk77sB/Ud0uR5tnDufJG
         PyCu+7w2tKMdXDXsvmm5/t8oQ+os+tLRfI1Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=JxCbOz9qgttDGSSzA1A+6uSJW6TvZefvlJJb7t5kz1o=;
        b=5ePb9MsOpZkAiyvEIAwJrBez7JdC5EBbLNxA4oTRyVR6C2OVlibQPbSh8nPQlmsduT
         3CcCKY1MF22fghBaVFFg6FWFzV57JwzCyCaDZG44/03BRb4ioJQPpCuH+Kto5Ob7d6fn
         idgwK3LIswDnyKsmVuU9cC08PDfi9Hp+V/L9CWnAENzh6WvBdxdOujRuBMU7XtQm1Gun
         WJIsSEUrZkQFWKgibaIlaNrLyeEOQsQ1t/U+W1aZUhT/SBEpMvuQivsOhPTDWRY5e9Bw
         wgbUowLpeO4fAN3plws03fOAjb8xHvCHRrFtgE8NNZeQVKrhxOG1S6SxU/zGhpypqQmR
         0ywg==
X-Gm-Message-State: AOAM530XaAI6OlwS0eE+CRXQsDyw2GG63+t4OAjJAeGWCKAFhTm+auom
        fD22gT6Mb2VLk8a+reFrFhl7xjtr+9tgX+I0QOEyMRTL58Q=
X-Google-Smtp-Source: ABdhPJyx8L7PGpIsF51ydfQYJSyJeg2xs9b0R4HUjdFcklP5svjYgwTs03pQUYw6ANvsHBi68B0ohEcyCtS45Xeg568=
X-Received: by 2002:a05:6830:358:: with SMTP id h24mr6688222ote.159.1632862699941;
 Tue, 28 Sep 2021 13:58:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Sep 2021 13:58:19 -0700
MIME-Version: 1.0
In-Reply-To: <20210927184858.2.I651eec59ce3cd1c4bdd64de31f9c3531f501b3a8@changeid>
References: <20210927184858.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
 <20210927184858.2.I651eec59ce3cd1c4bdd64de31f9c3531f501b3a8@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 28 Sep 2021 13:58:19 -0700
Message-ID: <CAE-0n51kTvv-UENH-jZPX-cJu-BCF8HGkCgVBUc3kkxrcUPy9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: sc7180: Support Parade ps8640 edp bridge
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

Quoting Philip Chen (2021-09-27 18:49:40)
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
> new file mode 100644
> index 000000000000..647afb3a7c6a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Trogdor dts fragment for the boards with Parade ps8640 edp bridge
> + *
> + * Copyright 2021 Google LLC.
> + */
> +
> +/ {
> +       pp3300_brij_ps8640: pp3300-brij-ps8640 {
> +               compatible = "regulator-fixed";
> +               status = "okay";
> +               regulator-name = "pp3300_brij_ps8640";
> +
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               gpio = <&tlmm 32 GPIO_ACTIVE_HIGH>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&en_pp3300_edp_brij_ps8640>;
> +
> +               vin-supply = <&pp3300_a>;
> +       };
> +};
> +
> +&dsi0_out {
> +       remote-endpoint = <&ps8640_in>;
> +};
> +
> +&i2c2 {
> +       ps8640_bridge: edp-bridge@8 {
> +               compatible = "parade,ps8640";
> +               reg = <0x8>;
> +
> +               powerdown-gpios = <&tlmm 104 GPIO_ACTIVE_LOW>;
> +               reset-gpios = <&tlmm 11 GPIO_ACTIVE_LOW>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&edp_brij_en>, <&edp_brij_ps8640_rst>;

Ah here it is. Ignore my concern on patch #1.

> +
> +               vdd12-supply = <&pp1200_brij>;
> +               vdd33-supply = <&pp3300_brij_ps8640>;
> +
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               reg = <0>;
> +                               ps8640_in: endpoint {
> +                                       remote-endpoint = <&dsi0_out>;
> +                               };
> +                       };
> +
> +                       port@1 {
> +                               reg = <1>;
> +                               ps8640_out: endpoint {
> +                                       remote-endpoint = <&panel_in_edp>;
> +                               };
> +                       };
> +               };
> +
> +               aux_bus: aux-bus {

The parade,ps8640 binding needs an update for aux-bus. Is that somewhere
in linux-next or on the list?

> +                       panel: panel {
> +                               /* Compatible will be filled in per-board */
> +                               power-supply = <&pp3300_dx_edp>;
> +                               backlight = <&backlight>;
> +
> +                               port {
> +                                       panel_in_edp: endpoint {
> +                                               remote-endpoint = <&ps8640_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +       };
> +};
