Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F1043A687
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 00:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhJYW20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 18:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbhJYW2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 18:28:21 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFCAC061243
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 15:25:58 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id v77so17691885oie.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=WFDwbjLin57JuF/SW9mFY64wQd0e/2AHNQmaqQ+zAzw=;
        b=hfK9d+6sqAbG17oSuDhj5y6u9w8qLXtsFL/VMBOaea0q7mFEKscsmbf4qSERmi7GPR
         nMrTraKNOrwWzb5iGo8HeR1xfI4PGbHSlebDkK03yLardVyeDEeCKG/cccpWNIOK95Gm
         BCQW10Ucl0LWO1HxYgXe/Us9WYWmIbv83bHuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=WFDwbjLin57JuF/SW9mFY64wQd0e/2AHNQmaqQ+zAzw=;
        b=TKxtgmeMSLMd5o8ve6aLxpOnloUwUmBoz9l+8XyewMukRk4829/3imZjkbXvlaK7iH
         p3SuN83yT3kILNt1MeDnGvBPagfRy8r6wHGigyKu5t25rHG4n0eru0GOsYLmijkFOpsM
         dGNCYzh30Hl2zMzUC/4HemQ77AakeHWGucNptZU9x7RJrTd8hBuN+jWFb2IxVUp21htk
         K27dubMk8yN4o1Th+zV8Yr2JnjRC6TElrVRxm8fGwzPM16TSVWtp7BSTKtTOLlS4HwvR
         dvcbsRf2sYjEGTlbq/cm/WzGBGCS5yKyXGj6Y+B2NbtKG2MSD94vmZbS4hSwtn+LzYpN
         Fwag==
X-Gm-Message-State: AOAM531s6KS3pPPpUo+PUXzrcIz4muQjIQFPx0lTtzy/OP9v/iMsZ6YG
        XnspQyX/ZqxZGHV+veJhyPTTjPqwy/TwPvY4QZej5Q==
X-Google-Smtp-Source: ABdhPJzzpQ1i3ICHPwTO0aUU1Fwdimfo83m8s5VOlm3vJvVJnxPlnRUx6c+3XcLyUvD8Ng94h5nwNZISc3dIfkOouv8=
X-Received: by 2002:a05:6808:23c2:: with SMTP id bq2mr25563747oib.32.1635200757700;
 Mon, 25 Oct 2021 15:25:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Oct 2021 15:25:57 -0700
MIME-Version: 1.0
In-Reply-To: <1635152851-23660-4-git-send-email-quic_c_sanm@quicinc.com>
References: <1635152851-23660-1-git-send-email-quic_c_sanm@quicinc.com> <1635152851-23660-4-git-send-email-quic_c_sanm@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 25 Oct 2021 15:25:57 -0700
Message-ID: <CAE-0n52wGtyd7pUTHL4XtFGz1_41OETi3t8CVVL-yG06RYvsVA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc7280: Add cx power domain support
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2021-10-25 02:07:31)
> Add multi pd support to set performance state for cx domain
> to maintain minimum corner voltage for USB clocks.
>
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
> v2:
> Changed rpmhd_opp_svs to rmphd_opp_nom for cx domain.
>
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index d74a4c8..9e3b6ad 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2538,7 +2538,8 @@
>                         interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
>                                           "dm_hs_phy_irq", "ss_phy_irq";
>
> -                       power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
> +                       power-domains = <&rpmhpd SC7280_CX>, <&gcc GCC_USB30_PRIM_GDSC>;

Order matters and thus the order here can't be flipped.

> +                       required-opps = <&rpmhpd_opp_svs>, <>;
