Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADF5325564
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhBYSYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhBYSXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:23:53 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0C4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:23:13 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id l64so7012297oig.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3fwbXygeyIRtetl3DiiCp4YUNibdxC6uA+4PbTm8ew=;
        b=iFa/j1SpISBk8SXub5LbKDZPN1y0LW0+uOxFmZ6XWwz/fGZFn//8rKYRpWk2HOdpw9
         CUGvDRRDG+IRLZNpCBqP2Lzn4dv3Mgzx+3EvFFodEb9qD8B64OOpQ2taYkxeSueXJ2BE
         aBHZkEiP6O471okysrdPd1mwM/fmzy2oGdons=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3fwbXygeyIRtetl3DiiCp4YUNibdxC6uA+4PbTm8ew=;
        b=bS+op2Ywr+Z4BWmddkzcFHqtThbh8peMBxQ2STPVZX3SwIXzVPnkA+7lR/ab5qYZJP
         vJT0WJhENYruT2c2yPnSd6iHf/RAcJGvaLBiTqnp7yeH48u+Lb1ETPeWQ4ftzsWWoHdL
         POJdaYBUfkwF/pq1rewtFrLhqoSgBf6Uo549bV5QOdGWT6vfRVkxTlOz8MWSFF+7c9MU
         k6Wchg9xb444hiwUh6B4U/J0IIk2Gm5stTp/6pxOoxVt3mYhHeIumFJzhb09SBGanRc8
         MPEFjSAzUgR2+WfmzFv3nbC83TfB1NwHjzABZwXX8NNkFnj30CDFC0//I54kNShaOLdd
         +zng==
X-Gm-Message-State: AOAM532y9peAHEizGFfJ0Wau3YLSsXLeRr3D5yfu4UjB0Cz1rvq3jmeE
        ygLv2Ecvzp1zb8clDKM123dEqmzyafyg9w==
X-Google-Smtp-Source: ABdhPJyfwXHjH0XTgAMtvXlZRRE7nB92/uNyfYQ9OfaL2piv6k+/AQwNgAq5DvqDsByHbOmapbD4MA==
X-Received: by 2002:aca:484a:: with SMTP id v71mr2804219oia.84.1614277392429;
        Thu, 25 Feb 2021 10:23:12 -0800 (PST)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id l4sm1137491ooq.33.2021.02.25.10.23.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 10:23:12 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id e17so1601516oow.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:23:12 -0800 (PST)
X-Received: by 2002:a25:d3c5:: with SMTP id e188mr5897553ybf.345.1614276945234;
 Thu, 25 Feb 2021 10:15:45 -0800 (PST)
MIME-Version: 1.0
References: <1603831083-2025-1-git-send-email-sanm@codeaurora.org> <1603831083-2025-5-git-send-email-sanm@codeaurora.org>
In-Reply-To: <1603831083-2025-5-git-send-email-sanm@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Feb 2021 10:15:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VFtWkfP30bPZB9SO5KLX_OLVNw0Fv3efZMHEzRg7PtVQ@mail.gmail.com>
Message-ID: <CAD=FV=VFtWkfP30bPZB9SO5KLX_OLVNw0Fv3efZMHEzRg7PtVQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] arm64: dts: qcom: sc7180: Use pdc interrupts for
 USB instead of GIC interrupts
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 27, 2020 at 1:38 PM Sandeep Maheswaram <sanm@codeaurora.org> wrote:
>
> Using pdc interrupts for USB instead of GIC interrupts to
> support wake up in case of XO shutdown.
>
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index a02776c..a2c56528 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -2687,10 +2687,10 @@
>                                           <&gcc GCC_USB30_PRIM_MASTER_CLK>;
>                         assigned-clock-rates = <19200000>, <150000000>;
>
> -                       interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 8 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 9 IRQ_TYPE_LEVEL_HIGH>;

Is there any reason that this patch can't land?  I'm not sure what the
current status of everything is, but it should be fine to go through
the PDC anyway, right?

-Doug
