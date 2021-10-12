Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5129442AAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhJLR2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhJLR2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 13:28:21 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203A7C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 10:26:19 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so235244otr.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=oKDmzQVDInY69AvycwANzPpjx7ZqBlmMGOtvQZUkY1g=;
        b=n4LIj3RFradCq/gDR26Lu5B/Gfb5aZ9f7r1dV3vP3dhGNmXed1NJjOA5k8cqj+aAfS
         z5pxVkExHQBncNBEiB/aHM4WxnYR3mHM0HvocNXQSwr1pf6p9bDuNKeCoueyJoajXIvO
         PCosVZff1gFA4W7raa2mnIKVm0d5SDAayNxMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=oKDmzQVDInY69AvycwANzPpjx7ZqBlmMGOtvQZUkY1g=;
        b=kc8Qsnr9HhqkSULMvOAHtm31pqoIq5HXjEVs4Q4KGrLFlpqrsOpoyPaC/gRVgF9ZfF
         PMaQD8JRTZKEBwlisMc9SctUUnwYxJzcfu3ZNahf3+BLiZg1cot5W5IBCBQz2mtRnbBn
         rzSk92c/SroMS9jRvxbeslBubbq35quGezqXJe6TuTddBw8V047IEp7qWJqMZcRp5725
         oZhczRDkWcWDOr2Gkvt/ja4mmTqmV1AV6E3WJOodoQGTyIk12bnSTZ7hfwuW/7FLMe+C
         /pGix6iOjM0oi86QGPCrYeMazOcZ7ItDwH2zvcub64UJo5pFzXYA3uqpdGwru5jAl5M1
         kuIQ==
X-Gm-Message-State: AOAM530uUkOngeR1yyE/N7meGzXZoUh8Me/Qtv/XlM8EnyxXM4iEpfJ1
        e6qC9rTfFjk47QFDvLQAHpAWIF0DYnEZSFAv/J7U9A==
X-Google-Smtp-Source: ABdhPJwJQxOvbo8Om0Km5y9OimprxVmFNbKTVmhcm51VzSCNaU1txHP3887kZW6mEIAq0HbLNofDoxDVd0XpnjzN5Bg=
X-Received: by 2002:a05:6830:2317:: with SMTP id u23mr12829780ote.126.1634059578506;
 Tue, 12 Oct 2021 10:26:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Oct 2021 10:26:17 -0700
MIME-Version: 1.0
In-Reply-To: <1634042171-31461-1-git-send-email-pmaliset@codeaurora.org>
References: <1634042171-31461-1-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 12 Oct 2021 10:26:17 -0700
Message-ID: <CAE-0n53vBa5Tn4OEey1ZmBrM+kN5KbXv1Spoj-dtHY6jzN_bbA@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add pcie clock support
To:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org,
        sanm@codeaurora.org, vbadigan@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2021-10-12 05:36:11)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 39635da..78694c1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -569,9 +569,10 @@
>                         reg = <0 0x00100000 0 0x1f0000>;
>                         clocks = <&rpmhcc RPMH_CXO_CLK>,
>                                  <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>,
> -                                <0>, <0>, <0>, <0>, <0>, <0>;
> +                                <0>, <&pcie1_lane 0>,
> +                                <0>, <0>, <0>, <0>;
>                         clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk",
> -                                     "pcie_0_pipe_clk", "pcie_1_pipe-clk",
> +                                     "pcie_0_pipe_clk", "pcie_1_pipe_clk",

It looks like a fix because the name doesn't match the binding. Can you
add a Fixes tag?

>                                       "ufs_phy_rx_symbol_0_clk", "ufs_phy_rx_symbol_1_clk",
>                                       "ufs_phy_tx_symbol_0_clk",
>                                       "usb3_phy_wrapper_gcc_usb30_pipe_clk";
