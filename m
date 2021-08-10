Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C0B3E83CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 21:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhHJTdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 15:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhHJTdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:33:15 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0595C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 12:32:52 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d10-20020a9d4f0a0000b02904f51c5004e3so371213otl.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 12:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=j531J4VJF2l0Kh4ljw8/dlpQJP59IVQk3gF+OW3650Q=;
        b=CcEkvcXcFnnyPcI5CbTYskPB9EkPPCHczsmCcsoaEIMeIusfr9+ompOPHNJrwrgfcY
         lPilKAb7SU/Yy7oYBhRt2RoiEZAkio7DIlvFVLr9WP7kQkWpM9wvewa5rHNdVHedfzf/
         P8Ns3vjX7Ekd1ujfbTvObdi5Mlb5HKqDkschQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=j531J4VJF2l0Kh4ljw8/dlpQJP59IVQk3gF+OW3650Q=;
        b=G6R+ipFRVpVH3+ZS5/m34PCKz9vfjft0qfJfsjm8TrWI9dsKfZb6b2hkFxJLeLs6P7
         NIwPnUiMrMXfOaRO+jlcX/JPpriq9ZmXl9EeMaN76wDbl/sk9E8WNur5zsusgiNY3pCj
         1JKHPu5jH/rbKd84oPEFuHcqFgqMNeAXItyjPPfdOqB6iZngg5BVLCLVlhk+5sm7gqXe
         LgTY4b2ZOpqiUP5VdKIYzW9A23M3gjI09IxFuidwlx6vBWM+OblQ6U3+x7yJwZo3E0HV
         FKTSu/F07Ra2+bSwhr9sAk7vg/PfzuGeQLlHDspdIKRka6/K5cRe0hSnV8deTp6ncq/q
         ZQSw==
X-Gm-Message-State: AOAM531B1HmIKlYKgd/UA6oyMYffewhMwYzZ5ppuJHEJyZOqe84MUEoc
        41y2BZjT+o7BT7D1ay2SrHrbUixMwBxAqqsKrDIwow==
X-Google-Smtp-Source: ABdhPJwtPTIdZ8S8tQT09aQHjKyi0eeYa60Gfqe5WBu09FSeygcjl/ICenmwh6qYtOyBu83YeOMwhN2mm0aXzsUKSkA=
X-Received: by 2002:a05:6830:44a7:: with SMTP id r39mr22195806otv.25.1628623972221;
 Tue, 10 Aug 2021 12:32:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Aug 2021 12:32:51 -0700
MIME-Version: 1.0
In-Reply-To: <1628568516-24155-4-git-send-email-pmaliset@codeaurora.org>
References: <1628568516-24155-1-git-send-email-pmaliset@codeaurora.org> <1628568516-24155-4-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 10 Aug 2021 12:32:51 -0700
Message-ID: <CAE-0n53geUO13RhQQGjXF0Nj+r45KHb6JsxpoeFbRUaZFNxc1A@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board
To:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, svarbanov@mm-sol.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2021-08-09 21:08:35)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index 64fc22a..bb6d3d5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -61,6 +61,44 @@
>         modem-init;
>  };
>
> +&pcie1 {
> +       status = "okay";
> +
> +       vdda-supply = <&vreg_l10c_0p8>;
> +};
> +
> +&pcie1_phy {
> +       status = "okay";
> +
> +       vdda-phy-supply = <&vreg_l10c_0p8>;
> +       vdda-pll-supply = <&vreg_l6b_1p2>;
> +};
> +
> +&pcie1_default_state {
> +       clkreq {
> +               bias-pull-up;
> +       };
> +
> +       reset-n {
> +               pins = "gpio2";
> +               function = "gpio";
> +
> +               drive-strength = <16>;
> +               output-low;
> +               bias-disable;
> +       };
> +
> +       wake-n {
> +               drive-strength = <2>;
> +               bias-pull-up;
> +       };
> +
> +       nvme-n {
> +               pins = "gpio19";
> +               bias-pull-up;

function = "gpio"?

> +       };
> +};
> +
>  &pmk8350_vadc {
>         pmr735a_die_temp {
>                 reg = <PMR735A_ADC7_DIE_TEMP>;
