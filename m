Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E37377E40
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhEJIdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhEJIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:32:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342B3C061573
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 01:31:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so9871660pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gckp4CwIdREzc2XV63iEz0XEYATQJrhMFeE6Dl5feXY=;
        b=Me15DNcWLAPOAGCbTZQTwgdxPa2RW3B5nKy7JFkDKIJ5b6K3U//qtvqskBKA4/uLxK
         oG5pEED0n3F6IxPkHIEiuuKyJvQSnWnfnrPIfGPWHaOzLvdruiP9tFNmGkku89EO5Cu6
         ZBxtRnUD3bdJT0AYz9qh+4ZAYhRUzk342qpwM8F8jHNCTja5dYxg4cQaZbZd4KT9JNhL
         J/wWDm+38bXjBQ9BgqyNXrtB9zHT1UAHLIPP6zBgRtBCh6EC+fT9WTPabXRczkvZU05g
         ESHzzeApa0zQDz6lOujSqwnAj4t9x61mna27CsLSPYCtQQ8YF42snmyEwDTyDa4JkK6R
         OeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gckp4CwIdREzc2XV63iEz0XEYATQJrhMFeE6Dl5feXY=;
        b=NUaucQAt6fWxakVVxgLIeFC9Guidn6PGK9LK2INeyGQ4ztHJfBCvjUdhCsXoP1p2xn
         DOIOYDz/GsSvwlCbT5pNZtRWz+wDwyWpEFVEcNylP2K94MxfVFQ7mwPSnMI3A8ZBjlKf
         5m5hn1J/q5XpaFwzJ+dwXcXgLPzD8fGvW1sypysXWdt8p+WqzYB4/QMG1kdIRxnE1ZDJ
         Pivk0tUCkie7g9hfq3C+rNt8PbHESmCHyoaHxjxKNd/Hy8Z14cxgVpnIlRE7D1Ii4wpo
         LeRS6cGaZzN80ceMe/UgOFQrjzrzNnjrfJ7sxqoFXi862qVbh26C7pALl6tK5BsfafkX
         9IHQ==
X-Gm-Message-State: AOAM531Zy1dHXXVbkwAptSRL8OPqwyDk27Y2keUzWhf4ny1i2IQ01BQ3
        VjRO8ajo4RZ5c1rxfwYRwAYA6ZaUHrtZoJN4yvYIog==
X-Google-Smtp-Source: ABdhPJy3CFE2Nxrn+MAqigTDlVhEEg4UuArMR3muy2dMVaeEg7fjiVJpWKLYRCS3ODPR8gLHMLs6GMGLOvLhcl9Q/4c=
X-Received: by 2002:a17:90a:7e8f:: with SMTP id j15mr27073962pjl.19.1620635511729;
 Mon, 10 May 2021 01:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210510070532.3838598-1-vkoul@kernel.org>
In-Reply-To: <20210510070532.3838598-1-vkoul@kernel.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 10 May 2021 10:31:40 +0200
Message-ID: <CAG3jFyukM7tYMdQC_0HWGUBLZtafYu21yvk2LDLS0Ha_jJKm8g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8350: fix the node unit addresses
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Vinod,

Thanks for catching this.

On Mon, 10 May 2021 at 09:05, Vinod Koul <vkoul@kernel.org> wrote:
>
> Some node unit addresses were put wrongly in the dts, resulting in
> below warning when run with W=1
>
> arch/arm64/boot/dts/qcom/sm8350.dtsi:693.34-702.5: Warning (simple_bus_reg): /soc@0/thermal-sensor@c222000: simple-bus unit address format error, expected "c263000"
> arch/arm64/boot/dts/qcom/sm8350.dtsi:704.34-713.5: Warning (simple_bus_reg): /soc@0/thermal-sensor@c223000: simple-bus unit address format error, expected "c265000"
> arch/arm64/boot/dts/qcom/sm8350.dtsi:1180.32-1185.5: Warning (simple_bus_reg): /soc@0/interconnect@90e0000: simple-bus unit address format error, expected "90c0000"
>
> Fix by correcting to the correct address as given in reg node
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index a8cd224a2f31..d015a9ca95a5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-sm8350.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/interconnect/qcom,sm8350.h>
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>  #include <dt-bindings/power/qcom-aoss-qmp.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> @@ -689,7 +690,7 @@ pdc: interrupt-controller@b220000 {
>                         interrupt-controller;
>                 };
>
> -               tsens0: thermal-sensor@c222000 {
> +               tsens0: thermal-sensor@c263000 {
>                         compatible = "qcom,sm8350-tsens", "qcom,tsens-v2";
>                         reg = <0 0x0c263000 0 0x1ff>, /* TM */
>                               <0 0x0c222000 0 0x8>; /* SROT */
> @@ -700,7 +701,7 @@ tsens0: thermal-sensor@c222000 {
>                         #thermal-sensor-cells = <1>;
>                 };
>
> -               tsens1: thermal-sensor@c223000 {
> +               tsens1: thermal-sensor@c265000 {
>                         compatible = "qcom,sm8350-tsens", "qcom,tsens-v2";
>                         reg = <0 0x0c265000 0 0x1ff>, /* TM */
>                               <0 0x0c223000 0 0x8>; /* SROT */
> @@ -1176,7 +1177,7 @@ usb_2_ssphy: phy@88ebe00 {
>                         };
>                 };
>
> -               dc_noc: interconnect@90e0000 {
> +               dc_noc: interconnect@90c0000 {
>                         compatible = "qcom,sm8350-dc-noc";
>                         reg = <0 0x090c0000 0 0x4200>;
>                         #interconnect-cells = <1>;

Reviewed-by: Robert Foss <robert.foss@linaro.org>
