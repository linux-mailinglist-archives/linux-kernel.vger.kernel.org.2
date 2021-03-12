Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E4B339707
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbhCLTBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbhCLTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:00:52 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F626C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:00:52 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id j7so4612282qtx.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kzGhrxmiJTrWBtL/l3WmBtmiZndy5MWWMYjOsxhm5KQ=;
        b=NmKexQDRgj4EznwkNii3VNVSipAhI1yEVxv5Di4HgAmXLQONw8eh1pW7tl1dR7JLtb
         Brut5GQWDXX99jtWsu0G2HCGjJkj7oioVGYF0FzU9c+2o5VVxbA2U15eSKou1kVS6rpo
         nOrN093sMPeJHxNEXztNGeEmJ9+6iBeO+y208vhvmslIRV4+xFvsTR1eZK7p2O+BP7dn
         WMaUilGn9xOhIBLgWlik24H/Afvh/vm4ayCfHNi/mhZARQz2JIZt+IIxJcMs2ikCs3TW
         Krrn+ccAeyWsKZjteUATH9t2sohEYseyE87qWn+AxLzy88ev5Bx+sU9/uSicJpoKa7wr
         kSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzGhrxmiJTrWBtL/l3WmBtmiZndy5MWWMYjOsxhm5KQ=;
        b=co+JepXH5LQm+FFWKrbQor1jI+GuGsMpR59HRiQ9MfeS17L2i/vRAsea4q9u51JfSJ
         s29yUOOp3TfCAhkbtO1OHM3Hbxi1HZiqO8oVn6hzjpEVCnyfQbyRTk/MPTo7tigCnyog
         3svT9rU8HDF5vNW6dhPq0WCY31j3MNOfp10jOaj9gDx/31uOUVIQP3eED+MX2kW17Dz3
         5XQtrkXK95PDGsPLdXd5hiB+2sCoF8MAwn4DCHRpjEGSSSCZM/EIq42GXzpAQbFreZ1E
         8NXrlJkz8uZav9GQgNyq6WAQM3elTnkjqHj9H8CKmCqJF4NihExXaeQuGJpFVVkTJJpZ
         mWYw==
X-Gm-Message-State: AOAM5321APVHueCkUx9IJyGkdIS51IXLIs3PyReBsuj4jAhKRNmhDFyW
        NooxksJ8oZ+75hqYJkxF1KKRWArQmmE1Zur2+PN6ErlHQzo=
X-Google-Smtp-Source: ABdhPJxYg5iTqvwta/uKIJP8aimqRge6tVRr84YyqgU7zzMsWNbFP6B1+lfmY0Ibhn0CUFWfCSGCujcMDH1XgZrA3VY=
X-Received: by 2002:ac8:690e:: with SMTP id e14mr12931103qtr.273.1615575651683;
 Fri, 12 Mar 2021 11:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20210312052737.3558801-1-vkoul@kernel.org>
In-Reply-To: <20210312052737.3558801-1-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 12 Mar 2021 22:00:40 +0300
Message-ID: <CAA8EJpoMeUJj_UmLWX+XTapofkPSKC3QODZ-YUq+wF-sywA+ZA@mail.gmail.com>
Subject: Re: [PATCH 0/8] arm64: dts: qcom: sm8350: Add PMICs
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

On Fri, 12 Mar 2021 at 08:28, Vinod Koul <vkoul@kernel.org> wrote:
>
> This adds the SPMI nodes for SM8350 followed by PMIC base file containing
> the GPIO nodes for these pmics (pmic compatibles have been picked by LinusW)
>
> SM8350-MTP includes PM8350, PM8350B, PM8350C, PMK8350, PMR735A AND PMR735B
> pmics.
>
> Vinod Koul (8):
>   arm64: dts: qcom: sm8350: Add spmi node
>   arm64: dts: qcom: pmk8350: Add base dts file
>   arm64: dts: qcom: pm8350: Add base dts file
>   arm64: dts: qcom: pm8350b: Add base dts file
>   arm64: dts: qcom: pm8350c: Add base dts file
>   arm64: dts: qcom: pmr735a: Add base dts file
>   arm64: dts: qcom: pmr735b: Add base dts file
>   arm64: dts: qcom: sm8350-mtp: Add PMICs
>
>  arch/arm64/boot/dts/qcom/pm8350.dtsi    | 25 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8350b.dtsi   | 25 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8350c.dtsi   | 25 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pmk8350.dtsi   | 25 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pmr735a.dtsi   | 25 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pmr735b.dtsi   | 25 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8350-mtp.dts |  6 ++++++
>  arch/arm64/boot/dts/qcom/sm8350.dtsi    | 18 ++++++++++++++++++
>  8 files changed, 174 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8350.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8350b.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8350c.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pmk8350.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pmr735a.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pmr735b.dtsi
>
> --
> 2.26.2
>


-- 
With best wishes
Dmitry
