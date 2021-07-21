Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEBB3D07DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 06:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhGUEFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 00:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhGUEEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 00:04:01 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA990C061767
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 21:44:10 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so1023696otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 21:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=BfXWWTIMOmQTzPgis5xFp0H4x6lMPAPeV1tP+oyedqc=;
        b=CcW6EzZRdtG0O1WjwIj+Cykmwt+KwmhaIQTKpaucBBNgxnOVSP/BRN7Zk7Xt8rfNMP
         IAtJgHI8pc/+2TJjyWTnaBqiA5mF5TqKotEbXZ2jt38L6gxvdElK8FThDNYspDXMz6l3
         VALP8V5tC1xdpko8EoFhDUfOf2/iZHzoFNsKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=BfXWWTIMOmQTzPgis5xFp0H4x6lMPAPeV1tP+oyedqc=;
        b=DDlUYETIyl0gKjX5FcTLXQ0KD3O0jLaEdBRvQM+cSpMqwwbEqdSTQcqM+zJdV3Pyu1
         QBjcO9w5Y72xh/Bk608akri+gXWY6jcb6ZOwLqlZspHQACOigbKn2lXVnUsG3bTXSdsR
         +1qWKYiTHwKz14vDMgrroDTRNQe+tPc3nw3ulKADnXRhuiDfFNi1EHxmBPnBE5iOdQC8
         OXacdNasfhPpwYs0Ag7OLQzrbnkISgFlulGzG1Ii1swwM5WYrcsccJj9ZPhjJLrQ7ffQ
         OGvdnzgTa2aqlEVR0CM4AvqnVbXdX8ww161tZAAP262Cae0wRZ+kU9s/jUVq4qeAH1H+
         3xXw==
X-Gm-Message-State: AOAM532VI+YWeg99kqLZmYfAecTyky6xDZt6pbThC7JLL7LYCZ77yF5X
        G3uuYrFR1vmGqD0bFIBLi58InBxMghCJ+CdcWzYmCw==
X-Google-Smtp-Source: ABdhPJzR0xoikXdoN5v4m795dYznxelFcJLueVWs3AhpcIznH0aRODcF2DfsA1T59fd8iC1L4ioYPfkhFRCtHUhXNPU=
X-Received: by 2002:a9d:1b6e:: with SMTP id l101mr9927059otl.34.1626842649804;
 Tue, 20 Jul 2021 21:44:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Jul 2021 04:44:09 +0000
MIME-Version: 1.0
In-Reply-To: <1601448168-18396-3-git-send-email-srivasam@codeaurora.org>
References: <1601448168-18396-1-git-send-email-srivasam@codeaurora.org> <1601448168-18396-3-git-send-email-srivasam@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 21 Jul 2021 04:44:09 +0000
Message-ID: <CAE-0n51LVG1zZvuT4Cv-3nCRhPtC46OQCSeBmncwaH_3TXk8=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sc7180-trogdor: Add lpass dai
 link for HDMI
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2020-09-29 23:42:48)
> From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
>
> Add dai link in sc7180-trogdor.dtsi for supporting audio over DP
>
> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 5724982..850b43e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -231,6 +231,7 @@
>
>                 audio-jack = <&alc5682>;
>
> +               #sound-dai-cells = <0>;
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -257,6 +258,17 @@
>                                 sound-dai = <&max98357a>;
>                         };
>                 };
> +               dai-link@2 {
> +                       link-name = "MultiMedia2";
> +                       reg = <2>;
> +                       cpu {
> +                               sound-dai = <&lpass_cpu 2>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&msm_dp>;

I see qcom maintainers have picked up the dp node now. Can you resend?
This would need to change to mdss_dp. Also incorporate my comments from
January this year please.
