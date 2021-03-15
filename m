Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C832633C6B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhCOTTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbhCOTTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:19:47 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096CCC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:19:47 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id n79so32845671qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKrjR+1pYrczmPaO9FQh9Zsr6qSwWLm3vUCGHNN49NI=;
        b=uTOML8o9qaiakVrN3KS50dFQ2ofWZ8ACM4fJbTYPq3KdEgHn6U0NCp1hT1IX5C0C2v
         /MWH3pi+PF7P1Fgm/8cYo4l+WBqniEQpEDqGBEfqfXYqqm64W4Ykhtp2096wqWtukL1+
         m3a+A0SeR2oCz21mPtr46oRosWNOL/SUqhc2TsIKU2yt3kcf0V3u7GjECSGN4FA2U7v7
         A2RP2701s8sSr5q9fVp/HUYeQ8wZWTT1c1Z9GDQW2G7YI+ouoCqP3mtp2BqGhL/OKhXy
         lxjNk40LIZwbbW2a38efWwPGG3+tq8rk0w+K0U/q3PRBfuEwcy5dE1zsBFesYm6vUpP3
         ajWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKrjR+1pYrczmPaO9FQh9Zsr6qSwWLm3vUCGHNN49NI=;
        b=JB1YAmPt6ZprC4/iPs8IxL+zVG8wS8gmALUfyrLdG4Wh3Hez3Sz39Z2kQ2jCETTeSO
         X1n3/TYhMv7JC15Q1kvc+w67I5eBtCLUo+eW3TPcia2ufsf/Hi6pbhGMe1mc7Boc6mOM
         v+mceNwxq/Va/jlPO/APP0KKIyPlg8PzHo6rgCMvXbq3j3m2nfwhPhM17DOgcJjV38PA
         EF8ZxnGmLRe1aIHxvM6k2Xo+TWLdBGVhWiWoNgKkeIVCJiUvit1Cgwk8Vj14bS7y42sI
         plfkzQRUS5tzZggi6C5F4iT0UA5o8hpM92ZSwPwALjGRugoPeL3Y9me9rW/sxlXOvC2b
         3Arw==
X-Gm-Message-State: AOAM530XxxxtIQvsxOZ0/cpqFDE2XT2FaC9RbkZB2xyHrR1AzjHbjIKB
        tGUFKPYB6rMUxwZ70Yx93AydMWXNGqkAFFTqkHohqg==
X-Google-Smtp-Source: ABdhPJwnq1X5LRG08bl6RXWR/OZcwCg/kklS/64tewBuZyv9NrC5inYj1d03jwjrtj1M02hZK6rIuI/1IaZf/72eFWk=
X-Received: by 2002:a37:b6c4:: with SMTP id g187mr27563612qkf.162.1615835986271;
 Mon, 15 Mar 2021 12:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210315103836.1.I9a97120319d43b42353aeac4d348624d60687df7@changeid>
In-Reply-To: <20210315103836.1.I9a97120319d43b42353aeac4d348624d60687df7@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 15 Mar 2021 22:19:35 +0300
Message-ID: <CAA8EJpqsYR+uCmBH8i6H_YyBfcmziiCq9dAZkAqJUEEvHZ3AUg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Fix sc7180-qmp-usb3-dp-phy reg sizes
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 at 20:39, Douglas Anderson <dianders@chromium.org> wrote:
>
> As per Dmitry Baryshkov [1]:
> a) The 2nd "reg" should be 0x3c because "Offset 0x38 is
>    USB3_DP_COM_REVISION_ID3 (not used by the current driver though)."
> b) The 3rd "reg" "is a serdes region and qmp_v3_dp_serdes_tbl contains
>    registers 0x148 and 0x154."
>
> I think because the 3rd "reg" is a serdes region we should just use
> the same size as the 1st "reg"?

Yes, this looks logical to me.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> [1] https://lore.kernel.org/r/ee5695bb-a603-0dd5-7a7f-695e919b1af1@linaro.org
>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
> Cc: Chandan Uddaraju <chandanu@codeaurora.org>
> Cc: Vara Reddy <varar@codeaurora.org>
> Cc: Tanmay Shah <tanmay@codeaurora.org>
> Cc: Rob Clark <robdclark@chromium.org>
> Fixes: 58fd7ae621e7 ("arm64: dts: qcom: sc7180: Update dts for DP phy inside QMP phy")
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 83fbb481cae5..61732e5efe62 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -2754,8 +2754,8 @@ usb_1_hsphy: phy@88e3000 {
>                 usb_1_qmpphy: phy-wrapper@88e9000 {
>                         compatible = "qcom,sc7180-qmp-usb3-dp-phy";
>                         reg = <0 0x088e9000 0 0x18c>,
> -                             <0 0x088e8000 0 0x38>,
> -                             <0 0x088ea000 0 0x40>;
> +                             <0 0x088e8000 0 0x3c>,
> +                             <0 0x088ea000 0 0x18c>;
>                         status = "disabled";
>                         #address-cells = <2>;
>                         #size-cells = <2>;

-- 
With best wishes
Dmitry
