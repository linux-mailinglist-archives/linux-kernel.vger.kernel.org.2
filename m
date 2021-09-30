Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A23D41DEDA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350233AbhI3QYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 12:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349691AbhI3QYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:24:06 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A37C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:22:24 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id j15so7520295ila.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkiQmIwLuFMRcDD9Yeq1X9DcESJBsP3wYBYEi8uC+4k=;
        b=Ca6rOa24h1INBKG+hc0h+ZaX4+6n7C/dHIFg3nINR2DPSIJyTbY58t5FBd0hgg38S8
         i2uLx6NUeVvyf2txdx92dJ3p4CLxfLMD051AhXEoQnx+fbW+mTMSK+Hdy6Pb9CRdmO6c
         70IUn49vHNygI3jyehX64U/Je/IqwZ5q1CB0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkiQmIwLuFMRcDD9Yeq1X9DcESJBsP3wYBYEi8uC+4k=;
        b=3f3SX6MY8HVnEyD64DmxHy1Vf2m9QU0fHj7cF/bj+Txbt70t2j7UrOD6rpocjYkbFo
         0GX+muohEDNSYLzoGNj/6ieUdEM+SyFtmXBi8hbngpzSL6WDY6d85P6b01xF/7QAtlEx
         ZjmGS+Bxnz7zpJtegWhnZTCa8ZgDuBfIx0k23iVeWe1WpFmXonsXQHJ+nEv5ypOLKWx5
         bOLikSk3y75wXQ+qaLnSqgL+ytg8nXEMWOaQDLASeBsACVjaShAi+1dpQIC/T1gd9sUz
         RDwx3CmVNTQRa6KhRUZvNbEJV2Kachr10MGAR5zk0MdMUBo8U9mt4cMFa2HX3306r5x5
         cEEw==
X-Gm-Message-State: AOAM533sDHOV/tGrT0kQiPQLqG/Pm/4+snFhqSg/UpuKJH1i7v//6eLA
        ki6B6nk5pMMcx+ngn1P5R5e3RykHZTVYdQ==
X-Google-Smtp-Source: ABdhPJw7giQqhX9/FckTnP7xVTuy9j+63nKUwHCt6g6QdGIIZYSPiogRSGBLafRYYvEMKGYYVEgh/A==
X-Received: by 2002:a05:6e02:1a22:: with SMTP id g2mr4749374ile.135.1633018943397;
        Thu, 30 Sep 2021 09:22:23 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id l3sm1989453ilq.48.2021.09.30.09.22.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 09:22:21 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id e144so8318218iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:22:21 -0700 (PDT)
X-Received: by 2002:a6b:f915:: with SMTP id j21mr4613178iog.98.1633018940941;
 Thu, 30 Sep 2021 09:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210929173343.v2.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
In-Reply-To: <20210929173343.v2.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Sep 2021 09:22:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XP+mJCEG+=meCXDb06bmfPwze2SP9FaMuKZkSh25JCSg@mail.gmail.com>
Message-ID: <CAD=FV=XP+mJCEG+=meCXDb06bmfPwze2SP9FaMuKZkSh25JCSg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: sc7180: Factor out ti-sn65dsi86 support
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 29, 2021 at 5:35 PM Philip Chen <philipchen@chromium.org> wrote:
>
> Factor out ti-sn65dsi86 edp bridge as a separate dts fragment.
> This helps us introduce the second source edp bridge later.
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
>
> Changes in v2:
> - Move edp_brij_i2c completely out of sc7180-trogdor.dtsi to the
>   bridge dts fragment, so that we can cleanly assign different
>   edp bridge in every board rev.
>
>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  1 +
>  .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  1 +
>  .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  1 +
>  .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |  1 +
>  .../dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi | 90 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 86 ------------------
>  6 files changed, 94 insertions(+), 86 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> index a758e4d22612..1d13fba3bd2f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> @@ -11,6 +11,7 @@
>  ap_h1_spi: &spi0 {};
>
>  #include "sc7180-trogdor.dtsi"
> +#include "sc7180-trogdor-ti-sn65dsi86.dtsi"

It looks like you're missing homestar, aren't you? I'd expect that
after applying your change that:

git grep -A1 include.*sc7180-trogdor.dtsi

...should show your new include right after all includes of
sc7180-trogdor.dtsi, but I don't see it for homestar.

Other than that this looks good to me. Feel free to add my Reviewed-by.
